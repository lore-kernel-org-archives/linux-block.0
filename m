Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19920C33CAF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FF72075B
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bzRpxJtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgAPEek (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:34:40 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35590 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgAPEej (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 23:34:39 -0500
Received: by mail-pj1-f66.google.com with SMTP id s7so960121pjc.0
        for <linux-block@vger.kernel.org>; Wed, 15 Jan 2020 20:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dTBX8cxcESWm6y7iCVSfboHeI14bak0BbHUBJ00uw40=;
        b=bzRpxJtAhLpiZEbwUpJL8R2rqw0pG1GdeHOaV3JP1tgm9RzSCnxnD1YxFenLvHcYTb
         aPy5P6sMOCzCjLc97NMv+DN75ZUz479fcnAj7+A2RyWsOKtOaNWdQMTBT4B0lnbF+BSX
         5yAdYtiYMM21be3pNFYjchaY979TffbPkP3CYAgohe8KWXySJBGGd06lqwqlGpC/Qzsj
         kEKB/ewwaR/I6RgZ+wYfwCKrPLYKR7PoZt1BAVv0pweiQRaoCdxakojmfgvZIE22t+dK
         9HtmhJEjHu0WLVzNnb52U8o7xPP6jWfaYwSz1BBHtoHCCBmngclwQZu2HiUZXDACZXlE
         eTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dTBX8cxcESWm6y7iCVSfboHeI14bak0BbHUBJ00uw40=;
        b=TsnVuWH70R8r5Qo7tPowOr/H2d94gJJ1jLniwSgG9wX/fgEXb9kqspHco340ZQoMW7
         IbzyNRA/6eZvXKwl4Q4ns5l7AbVtfpOLC3TU2rkTg1UAc+8D78aE82WYVFdlKun+MxnK
         Na5W8DMFa32mGJNhblrtPx/TPKPrFbu3JxqmKELj2BonhMZmZ4U4YBj5sfJb0lhouqjH
         xS29xbOLjdO1dcI9vt4lbFQb/T3zbQDDSh9CAtxxIbM+/9xMZgJWh/WQC0FrHUWOknr4
         YpC6+AqmGAOQBi4bcpALDraivdrBcBVRcCFx8bmIZ4WbQrCD09PtMS+yuVBXAzLY4DDe
         nIsw==
X-Gm-Message-State: APjAAAXlF04CiEChWJtWR8YU805GCcq8bneQw5MzgeoQz1jillgQs0rE
        SrzS4OPmDEUybxToNqdqRwRfgx0R5iQ=
X-Google-Smtp-Source: APXvYqwGnXS8o7mx7B6lRvG5dT6ZG2BKvq8LIApP0a6jEh+GLzFyxyWLSpta63zjRLHqTz/T2nUJ4w==
X-Received: by 2002:a17:902:b102:: with SMTP id q2mr21457342plr.247.1579149279116;
        Wed, 15 Jan 2020 20:34:39 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d14sm1434226pjz.12.2020.01.15.20.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 20:34:38 -0800 (PST)
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
Date:   Wed, 15 Jan 2020 21:34:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
> so acquire ctx->uring_lock beforehand similar to other instances of
> calling io_issue_sqe().

Is the below not enough?

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f9709a3a673c..900e86189ce7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4272,10 +4272,18 @@ static int io_issue_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		return ret;
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		const bool in_async = req->in_async;
+
 		if (req->result == -EAGAIN)
 			return -EAGAIN;
 
+		if (in_async)
+			mutex_lock(&ctx->uring_lock);
+
 		io_iopoll_req_issued(req);
+
+		if (in_async)
+			mutex_unlock(&ctx->uring_lock);
 	}
 
 	return 0;

-- 
Jens Axboe

