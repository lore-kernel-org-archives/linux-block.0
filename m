Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB9C10F03
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 20:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114A221773
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 20:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="erayjt2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfDWUby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:31:54 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:51471 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWUby (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 16:31:54 -0400
Received: by mail-it1-f171.google.com with SMTP id s3so2468158itk.1
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2019 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EQ9692s3JYTnkUeunJyaNyyNGAE59fxpj8h7CPQcJ5Q=;
        b=erayjt2WBMxH2wAhanGGmDiOfPHjHqaCLN1CJl7zs46ybLTAJ7Mxip0Gw/Grdq646u
         HCRcYHkePty55KGTD3gTG3pCKM1k3w17gjHHeRZIFU6FiW5XdvLuTeuxOnHE9D9E4nxG
         dxmFLpO7R0D+mUJE5CNCK30674L7+8+JfhjsN/+mxevNhA4K2DyoUndxehJONSM2ow3g
         Lv6HFjmq3QTk+mCuJq1PSEEi0+jjYlaOYTJw/8SgCWtXJelFm6EirsQH3JuODl6XHPyh
         j39qbctYo/cA/TFi9fYLkD19r2oOLmiBfZqLK4nXirI8er52sFDutkFM2O9B6+hhgbS0
         +y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQ9692s3JYTnkUeunJyaNyyNGAE59fxpj8h7CPQcJ5Q=;
        b=bVgevTFXOIEX8EsMyj5XaXPYpIVCmvLq6Lep0n7CKWYdZPKgntNyhxfetSlqcEVkX2
         Hj5U0sXwX5t+nULt8Pah6OndB73uBzCa9Wvi2NvsVg6vMaorSWTBRd31oLw25fk0TTTg
         pT7xnM2hGCUzQadPKzPTou7HubeqaqUsWfQI4+PYA1fGhzV6CTgvtaIhtPUi4nKHLJdL
         Jv3exKEp8fgOeogkNSR20QQTFirJD5K4xIhrlYHMVNOQpcDLy8u8ezUY+YI2tteLOiCh
         X7O+rU4xTiQeHmJ7z0lmW75/y3y4fhAG5FYEAYpuWQPxVzoil13sbUiXX8F+El7gnNpb
         ZXZQ==
X-Gm-Message-State: APjAAAUBm1IA4mld+MW15wYTqiNqKw9OPzrHC7Vfv55VsmcPQYOemVqs
        m74WaXd19uj2wYcamdTTWOEJNA==
X-Google-Smtp-Source: APXvYqwZpyOZqTFu8GfyhzHcV8cOKS/576q5CL8fyCqHguCeQosZS7fKcwQCIsgmvAjTpOEl4HypHA==
X-Received: by 2002:a02:950a:: with SMTP id y10mr19954756jah.26.1556051513015;
        Tue, 23 Apr 2019 13:31:53 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s7sm1692489ioo.17.2019.04.23.13.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:31:52 -0700 (PDT)
Subject: Re: io_uring: not good enough for release
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
Date:   Tue, 23 Apr 2019 14:31:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/23/19 1:06 PM, Stefan Bühler wrote:
> Hi,
> 
> now that I've got some of my rust code running with io_uring I don't
> think io_uring is ready.
> 
> If marking it as EXPERIMENTAL (and not "default y") is considered a
> clear flag for "API might still change" I'd recommend going for that.

That might be an option, but I don't think we need to do that. We've
still got a least a few weeks, and the only issue mentioned below that's
really a change that would warrant something like that is easily doable
now. All it needs is agreement.

> Here is my current issue list:
> 
> ---
> 
> 1. An error for a submission should be returned as completion for that
> submission.  Please don't break my main event loop with strange error
> codes just because a single operation is broken/not supported/...

So that's the case I was referring to above. We can just make that change,
there's absolutely no reason to have errors passed back through a different
channel.

> 2. {read,write}_iter and FMODE_NOWAIT / IOCB_NOWAIT is broken at the vfs
> layer: vfs_{read,write} should set IOCB_NOWAIT if O_NONBLOCK is set when
> they call {read,write}_iter (i.e. init_sync_kiocb/iocb_flags needs to
> convert the flag).
> 
> And all {read,write}_iter should check IOCB_NOWAIT instead of O_NONBLOCK
> (hi there pipe.c!), and set FMODE_NOWAIT if they support IOCB_NOWAIT.
> 
> {read,write}_iter should only queue the IOCB though if is_sync_kiocb()
> returns false (i.e. if ki_callback is set).

That's a trivial fix. I agree that it should be done.

> Because right now an IORING_OP_READV on a blocking pipe *blocks*
> io_uring_enter, and on a non-blocking pipe completes with EAGAIN all the
> time.
> 
> So io_uring (readv) doesn't even work on a pipe!  (At least
> IORING_OP_POLL_ADD is working...)

It works, but it blocks. That can be argued as broken, and I agree that
it is, but it's important to make the distinction!

> As another side note: timerfd doesn't have read_iter, so needs
> IORING_OP_POLL_ADD too... :(
> 
> (Also RWF_NOWAIT doesn't work in io_uring right now: IOCB_NOWAIT is
> always removed in the workqueue context, and I don't see an early EAGAIN
> completion).

That's a case I didn't consider, that you'd want to see EAGAIN after
it's been punted. Once punted, we're not going to return EAGAIN since
we can now block. Not sure how you'd want to handle that any better...

> 3. io_file_supports_async should check for FMODE_NOWAIT instead of using
> some hard-coded magic checks.

We probably just need to err on the side of caution there, and suffer
the extra async punts.

> 4. io_prep_rw shouldn't disable force_nonblock if FMODE_NOWAIT isn't
> available; it should return EAGAIN instead and let the workqueue handle it.

Agree

> I'm guessing especially 2. has something to do with why aio never took
> off - so maybe it's time to fix the underlying issues first.

It only really works for a subset of it, but we should ensure that it's
caught and always punted so we don't end up with io_uring_enter() blocking.
That should be the key goal. For regular file writes, should be easy
enough to do. But it should end up being an optimization to what we have,
getting rid of an unecessary async indirection, instead of having cases
where io_uring_enter() blocks.

> I'd be happy to contribute a few patches to those issues if there is an
> agreement what the result should look like :)

Pretty sure folks would be happy to see that :-)

> I have one other question: is there any way to cancel an IO read/write
> operation? I don't think closing io_uring has any effect, what about
> closing the files I'm reading/writing?  (Adding cancelation to kiocb
> sounds like a non-trivial task; and I don't think it already supports it.)

There is no way to do that. If you look at existing aio, nobody supports
that either. Hence io_uring doesn't export any sort of cancellation outside
of the poll case where we can handle it internally to io_uring.

If you look at storage, then generally IO doesn't wait around in the stack,
it's issued. Most hardware only supports queue abort like cancellation,
which isn't useful at all.

So I don't think that will ever happen.

> So cleanup in general seems hard to me: do I have to wait for all
> read/write operations to complete so I can safely free all buffers
> before I close the event loop?

The ring exit waits for IO to complete already.

-- 
Jens Axboe

