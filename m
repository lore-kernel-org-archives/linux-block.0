Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D184CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ED421655
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U6JqMPlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439867AbfJXRJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:09:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38296 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439855AbfJXRJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 13:09:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so14608431pgt.5
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 10:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LPZHfV6Ecgh8l8uYCmzRkuNNA1QwXC5MESARP9/H9Dg=;
        b=U6JqMPlbCutklCCFKwLFKt1vfN+wLjsLngAErts7LyfzdkR5JMJX5ZyYy4o6AxlWhr
         Dtb6MTp/V2DD9xjIsszcIWU8rJ0d/Z8PaH9BIfqWgrOOBlnRFEpP2BclKwPux7cpA0Tf
         XGn4ezoMt5Yk5UmFTxNl2+vzk4PTOA/LOIe3+44MjbkP1nwydhMyt/ZAWj/dRgO1gEc9
         1b9BJDG5u6jHXC5eEyZrPmdAuT6s6O//YKgDWl0vIcAoR/r/rs09yAU3HT06jRIxT0Fr
         eBY8HODcwP93R+lZBBKwr5HD1y0gT7Dq81rmJUKNbkpkuj9V6j3qQ4jP8j9zBLLFGQxx
         Hs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LPZHfV6Ecgh8l8uYCmzRkuNNA1QwXC5MESARP9/H9Dg=;
        b=FUxMymGeHRxS8hsj2ahxl+w/gZDVO01p3G7Y1tuvOpqaZtjfuBBgh7ruim0Yyrn8HY
         QN+6EqIQNtjAb/pjgoQHnOAHArG9YMjs49fkILo59WunZ12efd5nj+5Ir6gipPyKGqQt
         aF6DMmuUzZAv6QCdt9D2XaPPxIYDjdsVP1+PrdaTXupptCX7iXLHxP+T/UJU3MYG1wVD
         Ir0dQseJg+sD+wm184O/p3Boua2HoNNzTgmAq4fhm5UXzXQsC8lSzL8/kgaYJfTOhsxe
         HzNhyA5oyCivcmN1PBrVc66pRKUs+TUyZNiLBiHDMlzAWoCsE5RI12ZT1V5IzEBzKC2c
         wvwA==
X-Gm-Message-State: APjAAAUkFeOMKEEaFlZrLm7/s7d/wd/iumy1ncLURRqzWXj0v+N/r7+Y
        rE8q4QEFI7Q7QwasKDmD6FWTzYbn4SS1ow==
X-Google-Smtp-Source: APXvYqx1UFkKhBKLmRROgEp/ZsF2R7lfcksCJUlESfCsZq/qVceVqwdPGxprrWw5ZqMWkEsF4Uaz7w==
X-Received: by 2002:a17:90a:be09:: with SMTP id a9mr8660239pjs.5.1571936968480;
        Thu, 24 Oct 2019 10:09:28 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1131::1161? ([2620:10d:c090:180::f93b])
        by smtp.gmail.com with ESMTPSA id f5sm2395818pjq.24.2019.10.24.10.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:09:27 -0700 (PDT)
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22fc1057-237b-a9b8-5a57-b7c53166a609@kernel.dk>
Date:   Thu, 24 Oct 2019 11:09:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
> Running an fio test consistenly crashes the kernel with the trace included
> below.  The root cause seems to be the code in __io_submit_sqe() that
> checks the result of a request for -EAGAIN in polled mode, without
> ensuring first that the request has completed:
> 
> 	if (ctx->flags & IORING_SETUP_IOPOLL) {
> 		if (req->result == -EAGAIN)
> 			return -EAGAIN;

I'm a little confused, because we should be holding the submission
reference to the request still at this point. So how is it going away?
I must be missing something...

> The request will be immediately resubmitted in io_sq_wq_submit_work(),
> potentially before the the fisrt submission has completed.  This creates
> a race where the original completion may set REQ_F_IOPOLL_COMPLETED in
> a freed submission request, overwriting the poisoned bits, casusing the
> panic below.
> 
> 	do {
> 		ret = __io_submit_sqe(ctx, req, s, false);
> 		/*
> 		 * We can get EAGAIN for polled IO even though
> 		 * we're forcing a sync submission from here,
> 		 * since we can't wait for request slots on the
> 		 * block side.
> 		 */
> 		if (ret != -EAGAIN)
> 			break;
> 		cond_resched();
> 	} while (1);
> 
> The suggested fix is to move a submitted request to the poll list
> unconditionally in polled mode.  The request can then be retried if
> necessary once the original submission has indeed completed.
>
> This bug raises an issue however since REQ_F_IOPOLL_COMPLETED is set
> in io_complete_rw_iopoll() from interrupt context.  NVMe polled queues
> however are not supposed to generate interrupts so it is not clear what
> is the reason for this apparent inconsitency.

It's because you're not running with poll queues for NVMe, hence you're
throwing a lot of performance away. Load nvme with poll_queues=X (or boot
with nvme.poll_queues=X, if built in) to have a set of separate queues
for polling. These don't have IRQs enabled, and it'll work much faster
for you.

-- 
Jens Axboe

