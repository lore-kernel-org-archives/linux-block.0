Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB04C43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AA32077B
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="FWJpPcZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbfD0PuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:50:16 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:56202 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0PuQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 11:50:16 -0400
Received: from [192.168.0.213] (HSI-KBW-109-193-203-011.hsi7.kabel-badenwuerttemberg.de [109.193.203.11])
        by mail.stbuehler.de (Postfix) with ESMTPSA id ADCCAC00AD7;
        Sat, 27 Apr 2019 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556380214;
        bh=btyp9WbpEpY36bU+YvRbntHgOodGrR44s6oQNdrldB0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FWJpPcZM2VW/lpqTQvgVwa+RG3qWaEsL0SkMP9B2y+YpqZ1HRQ+W2FX1VX7/J0F5Z
         u2GfjfKCDrp42wo4F3RnN2paIktv9G9phT18kKYtip1dSlFFCcx3lN1T7E+6tdCTt3
         oHJtdQkC23Qvey+FS8P3wAFbK3UUmBeUzQCh0Slo=
Subject: Re: io_uring: submission error handling
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Message-ID: <66fb4ed7-a267-1b0b-d609-af34d9e1aa54@stbuehler.de>
Date:   Sat, 27 Apr 2019 17:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 24.04.19 00:07, Jens Axboe wrote:
> On 4/23/19 2:31 PM, Jens Axboe wrote:
>>> 1. An error for a submission should be returned as completion for that
>>> submission.  Please don't break my main event loop with strange error
>>> codes just because a single operation is broken/not supported/...
>>
>> So that's the case I was referring to above. We can just make that change,
>> there's absolutely no reason to have errors passed back through a different
>> channel.
> 
> Thinking about this a bit more, and I think the current approach is the
> best one. The issue is that only submission side events tied to an sqe
> can return an cqe, the rest have to be returned through the system call
> value. So I think it's cleaner to keep it as-is, honestly.

Not sure we're talking about the same.

I'm talking about the errors returned by io_submit_sqe: io_submit_sqes
(called by the SQ thread) calls io_cqring_add_event if there was an
error, but io_ring_submit (called by io_uring_enter) doesn't: instead,
if there were successfully submitted entries before, it will just return
those (and "undo" the current SQE), otherwise it will return the error,
which will then be returned by io_uring_enter.

But if I get an error from io_uring_enter I have no idea whether it was
some generic error (say EINVAL for broken flags or EBADF for a
non-io-uring filedescriptor) or an error related to a single submission.

I think io_ring_submit should call io_cqring_add_event on errors too
(like io_submit_sqes), and not stop handling submissions (and never
return an error).

Maybe io_cqring_add_event could then even be moved to io_submit_sqe and
just return whether the job is already done or not (io_submit_sqes
returns the new "inflight" jobs, and io_ring_submit the total number of
submitted jobs).

cheers,
Stefan
