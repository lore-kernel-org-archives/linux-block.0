Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABF4C282E1
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 19:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B65821850
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 19:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="Hm1ab9Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfDWTGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:06:46 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:53934 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWTGm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 15:06:42 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 1655AC02D85;
        Tue, 23 Apr 2019 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556046400;
        bh=sJOizSUEutsyCmvKKTB382y8SkDBPCoP+pbtGBu5STE=;
        h=To:From:Subject:Date:From;
        b=Hm1ab9Qb6zrA1+pWo5x0DkcWpv5JN5Gs9Ml8jtpIpEpmOMJR7tL9XKnBDAOX+raUz
         h1W3mZVPoLIdX0k85rGlRE6q3mTS5y4Te021pk0soIgm1VWPzcr4lwWdlJEg3MwRb5
         o+cvF11686WVUBN5G6uEhMFbriC7HM9B246CTrgc=
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Subject: io_uring: not good enough for release
Message-ID: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
Date:   Tue, 23 Apr 2019 21:06:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

now that I've got some of my rust code running with io_uring I don't
think io_uring is ready.

If marking it as EXPERIMENTAL (and not "default y") is considered a
clear flag for "API might still change" I'd recommend going for that.

Here is my current issue list:

---

1. An error for a submission should be returned as completion for that
submission.  Please don't break my main event loop with strange error
codes just because a single operation is broken/not supported/...


2. {read,write}_iter and FMODE_NOWAIT / IOCB_NOWAIT is broken at the vfs
layer: vfs_{read,write} should set IOCB_NOWAIT if O_NONBLOCK is set when
they call {read,write}_iter (i.e. init_sync_kiocb/iocb_flags needs to
convert the flag).

And all {read,write}_iter should check IOCB_NOWAIT instead of O_NONBLOCK
(hi there pipe.c!), and set FMODE_NOWAIT if they support IOCB_NOWAIT.

{read,write}_iter should only queue the IOCB though if is_sync_kiocb()
returns false (i.e. if ki_callback is set).


Because right now an IORING_OP_READV on a blocking pipe *blocks*
io_uring_enter, and on a non-blocking pipe completes with EAGAIN all the
time.

So io_uring (readv) doesn't even work on a pipe!  (At least
IORING_OP_POLL_ADD is working...)

As another side note: timerfd doesn't have read_iter, so needs
IORING_OP_POLL_ADD too... :(

(Also RWF_NOWAIT doesn't work in io_uring right now: IOCB_NOWAIT is
always removed in the workqueue context, and I don't see an early EAGAIN
completion).


3. io_file_supports_async should check for FMODE_NOWAIT instead of using
some hard-coded magic checks.


4. io_prep_rw shouldn't disable force_nonblock if FMODE_NOWAIT isn't
available; it should return EAGAIN instead and let the workqueue handle it.

Because otherwise the event loop is blocking again.

---

I'm guessing especially 2. has something to do with why aio never took
off - so maybe it's time to fix the underlying issues first.

I'd be happy to contribute a few patches to those issues if there is an
agreement what the result should look like :)


I have one other question: is there any way to cancel an IO read/write
operation? I don't think closing io_uring has any effect, what about
closing the files I'm reading/writing?  (Adding cancelation to kiocb
sounds like a non-trivial task; and I don't think it already supports it.)

So cleanup in general seems hard to me: do I have to wait for all
read/write operations to complete so I can safely free all buffers
before I close the event loop?


cheers,
Stefan
