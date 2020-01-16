Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39DAC33CB1
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766EC20748
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 04:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bGkDp6+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgAPEm2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 23:42:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37407 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgAPEm2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 23:42:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so7798826plz.4
        for <linux-block@vger.kernel.org>; Wed, 15 Jan 2020 20:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xipnalrq0OU4degfJBjGIJ927VLjRVVTYviHU6YSMSQ=;
        b=bGkDp6+e0r+R7CoK7bRfBkgnMMuhpNPb1M2ipaUW1F6L5bnxmpcHiCY6i7hlSrmbTu
         8dM9PYxzWfrvXrvJ/dhpMR+u5XYQuuDrqVdVwhh0cuycZVzuEGXYkVTj5Y77umTC4NYB
         SW3WFNoqIPhoT0XoQhMG5eRYLBQAp2khATAZ+byaEOigywUvPrsZbX+Vn8Xb0i08c4Hn
         kc8/pT3veLnfuMD3R+wh7w7aELfa42vNTJu8Fedw8W080bzOkbBuZFm6K50ctn4w2DfV
         Y7yf1r5R4YOnUSmdteBCcLxIK8v2USMSWFVVy15U9hGC9D0pwwZJU4xTTHH4mdAcBlBH
         F/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xipnalrq0OU4degfJBjGIJ927VLjRVVTYviHU6YSMSQ=;
        b=osw/mxPkCNNBXl9VYdKr4d0qYw65S3GBwHz+qMEjFnAc+z+TQTM2KueMwtZcj8zf6h
         SRebdUfCUPxDI2yaZq/K5gOT4j8yG1bmm5tj3l2f9MG0MgHXVpBeLHajCjkWpnP2oUP+
         bzll7kBZXJxNn7W2Koq8KTxkGDKDihIxO+TptkfSb5nEIH/WeLaekXl28leOnvowmNBx
         kXma2QBSHRp+cz4SQ6h3noWkwJfp9SNAcEsMRNQ0qCt4UKn6AT1mX74OoIboT0FsQ0PV
         VRAWvVtjwtW9pReun3mfqBjsZWxqTKIV5GILp4aE4v56jVokclK5nl0o/3WPlfkopBsi
         ffAQ==
X-Gm-Message-State: APjAAAV3poojntZzbVPGaMpPd5smL6/9C8sFwMTeRJ4VzeOREWR+0+5y
        VUPO+TVKBl6krW3PlgLhNQtqvozRIsU=
X-Google-Smtp-Source: APXvYqwMtYxxuzf7jvIoJIBuOINNrBfvekIQtdAnnofGvrFRUk2AJVT8RqDV8H/yYyuDn6grFpx2YA==
X-Received: by 2002:a17:902:8ec6:: with SMTP id x6mr9450855plo.179.1579149747474;
        Wed, 15 Jan 2020 20:42:27 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id k1sm22734560pgk.90.2020.01.15.20.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 20:42:27 -0800 (PST)
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
From:   Jens Axboe <axboe@kernel.dk>
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
 <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
Message-ID: <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
Date:   Wed, 15 Jan 2020 21:42:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/20 9:34 PM, Jens Axboe wrote:
> On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
>> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
>> so acquire ctx->uring_lock beforehand similar to other instances of
>> calling io_issue_sqe().
> 
> Is the below not enough?

This should be better, we have two that set ->in_async, and only one
doesn't hold the mutex.

If this works for you, can you resend patch 2 with that? Also add a:

Fixes: 8a4955ff1cca ("io_uring: sqthread should grab ctx->uring_lock for submissions")

to it as well. Thanks!

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3130ed16456e..52e5764540e4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3286,10 +3286,19 @@ static int io_issue_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		return ret;
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		const bool in_async = io_wq_current_is_worker();
+
 		if (req->result == -EAGAIN)
 			return -EAGAIN;
 
+		/* workqueue context doesn't hold uring_lock, grab it now */
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

