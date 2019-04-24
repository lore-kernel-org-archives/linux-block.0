Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70615C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF58208E4
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TCRzRYSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfDXQJc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:09:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43100 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfDXQJc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:09:32 -0400
Received: by mail-io1-f67.google.com with SMTP id v9so488659iol.10
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O98UJomSDgIlYcyh6l8JBTRST6j97BzelxIjUjS3xe0=;
        b=TCRzRYShVTdxpCbUSAfnPfdVcsa6H6VPhZSZhhzQ6xyS5jywChBd25xzuCAtwlkSMK
         FNhyQO7pTa7wXt5nUqiUYbmAFFbyFOFR15yrOvkrBsi0xF4cRT4L8EMEzbnYGHlE51Yy
         lQvs11COjpREuUM8GElgHQHiIv3kmDV797IEUi15KZLIlW2tJ8uCWT+5pGDsrzOEf5j2
         B51fRd8llHGrqzQ86rTmvxrDk8IHu22jUAvJyH8WJqf5HFxeEn42AyRG/6JyvKJ+tZ+u
         +xGfvg4KRWlKYvqOitemy8gbM0ge0N8rVENJm54rUCmAXrfm3nGU6sc6OhaL0DIZB303
         yDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O98UJomSDgIlYcyh6l8JBTRST6j97BzelxIjUjS3xe0=;
        b=HVixqPRIq4IJYyp88eVrIMn4QmwMaWE/JAkTu9nyE/LkQjJfrWY9ipIAHNQWBzfaF8
         XQWCbRPKAdb7B07HchdUXJ8cZ8L2Uw3C46UDSxgBWdVEPxObmzvitvNiA4GpQYHXTtgW
         L9sTPDC/q7XWs8n1hfByJ/Z+P7IZEUCG6Cm6DzfNdn3rkF9gv/cKrrVzoBRe/48ZgEbm
         K41Y6Qf3ASsZIZ4bhj4aun6o/DcklH7Y/7qlUjIBsKiChrOjQ69kT6Ikjehf0mNlHJ9+
         RjJOBfBYiO+8vFoSnsnVuGM0D+W3tQ0X0TUu9zHKY6B6vIoQoMF31021ixvLpCbvKy4Z
         /deA==
X-Gm-Message-State: APjAAAWH8u1qnJsXSLZn6jlCn+wwflnDwGTvERxqGZvDvpPb4KjLtc+f
        v1ZCdBvZCW3/JQjH24bJw2Rfug==
X-Google-Smtp-Source: APXvYqxy5Rj8hvqEDTfdUEXMw0deKdT3wSYy6yeNA1SENBYvWqmW/+gMbpd/VgBAD6asqb5f/nBOzA==
X-Received: by 2002:a5e:9b17:: with SMTP id j23mr22734977iok.60.1556122171600;
        Wed, 24 Apr 2019 09:09:31 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 64sm8819024ite.42.2019.04.24.09.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 09:09:30 -0700 (PDT)
Subject: Re: io_uring: not good enough for release
From:   Jens Axboe <axboe@kernel.dk>
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
Message-ID: <740192f8-1d64-9e64-0aea-a73e5d6d4d46@kernel.dk>
Date:   Wed, 24 Apr 2019 10:09:28 -0600
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

On 4/23/19 4:07 PM, Jens Axboe wrote:
>>> (Also RWF_NOWAIT doesn't work in io_uring right now: IOCB_NOWAIT is
>>> always removed in the workqueue context, and I don't see an early EAGAIN
>>> completion).
>>
>> That's a case I didn't consider, that you'd want to see EAGAIN after
>> it's been punted. Once punted, we're not going to return EAGAIN since
>> we can now block. Not sure how you'd want to handle that any better...
> 
> I think I grok this one too now - what you're saying is that if the
> caller has RWF_NOWAIT set, then the EAGAIN should be returned instead of
> being punted to the workqueue? I totally agree with that, that's a bug.

This should do it for the EAGAIN part, if the user has set RWF_NOWAIT
in the sqe, then we don't do the automatic punt to workqueue. We just
return the EAGAIN instead.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 58ec6e449fd8..6c0d49c3736b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -822,7 +822,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
 	if (unlikely(ret))
 		return ret;
-	if (force_nonblock) {
+	if (force_nonblock && !(kiocb->ki_flags & IOCB_NOWAIT)) {
 		kiocb->ki_flags |= IOCB_NOWAIT;
 		req->flags |= REQ_F_FORCE_NONBLOCK;
 	}
@@ -1828,7 +1828,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	}
 
 	ret = __io_submit_sqe(ctx, req, s, true);
-	if (ret == -EAGAIN) {
+	if (ret == -EAGAIN && (req->flags & REQ_F_FORCE_NONBLOCK)) {
 		struct io_uring_sqe *sqe_copy;
 
 		sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);

-- 
Jens Axboe

