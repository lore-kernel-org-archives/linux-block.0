Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C866C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA79218AF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t/rIdCWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfAXSJq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:09:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51606 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfAXSJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 13:09:46 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so6462755ite.1
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 10:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TRGUm+EfjN52xeP+DATmClAm8sw0OQ55PTGtubkovws=;
        b=t/rIdCWlm4/d2upHpCETOhem50T0slrN6iPM9alh6PcyvDaILwfJ++d3jlZFHzCY9X
         U/LExLKJy4oR+l46U6fem0HXs7ne8MxOZslMSAwIqh9/EJXdUnMxAMgC1ZlWRHA6Rdb+
         BgdJFV72EUu4bT0znrsYt4QMsLmfLivqYgMPFPOZbwRRLKPuYGhi5ZLBouXgj1/R5yO3
         /UOB7B+wvBt+bVETPtOY/9EeVHFLMoEA705rMwLHs/Rc4OW1bv3CaqunkzDwS3f6HxYS
         EaO6D/dSzI+SvoKP7x2kEhCt4PDlJXhWhcL9fWQv43VXeje431VHnf2EPUgomdXutA86
         zphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TRGUm+EfjN52xeP+DATmClAm8sw0OQ55PTGtubkovws=;
        b=ZA41KJwPX0CHZVeKsInvkTg8U5UgYh1739q41ZkePmr8ftw5H7bq2oqUqJMDcKBkNf
         TD2oTpftv3Yh9b+r0eIBQrekLzI0c+memqQ42MBuI0V8aZM/wDxxpzDYHA8mliJfKpsW
         PpeqTUii9y3LppPjfwW1zkrQ2+IkTxBuoHu0cKWF1Kh+srF5j88Ph8CGRrDP4CPYJNon
         6bnTfNaoU+jGv2N2gAttO6a/WcyMhvKhkXYsEPgI0vazHnMoYEcjPtUgubLoERBg4TH0
         72BQ9zvo7BXwX3Hj37ffy/qVEoG6rUkAPHjrCmyZIoqvsHT6w+JmrQ+nvMyqn4Yz22VF
         kl4g==
X-Gm-Message-State: AJcUukeQgw6pE7rD8FtOUr5oJ7kuhZs7f623E2wIddqtkVGC5ra39k9i
        ptckG0SXUoDCZRloUWZZocgEyA==
X-Google-Smtp-Source: ALg8bN78DB1K2+MDhRMAxYn8/9YNNYGvbmH2KFRVKSj6h6wHklrT94sxxquFF+zwQmyCSjQEhzsCKg==
X-Received: by 2002:a24:9b87:: with SMTP id o129mr2195276itd.128.1548353385435;
        Thu, 24 Jan 2019 10:09:45 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q9sm8828129ioh.32.2019.01.24.10.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:09:44 -0800 (PST)
Subject: Re: [PATCH] blk-wbt: Declare local functions static
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190123190557.118894-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <118da5e6-b977-6cb4-71ce-c7370a962025@kernel.dk>
Date:   Thu, 24 Jan 2019 11:09:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123190557.118894-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/19 12:05 PM, Bart Van Assche wrote:
> This patch avoids that sparse reports the following warnings:
> 
>   CHECK   block/blk-wbt.c
> block/blk-wbt.c:600:6: warning: symbol 'wbt_issue' was not declared. Should it be static?
> block/blk-wbt.c:620:6: warning: symbol 'wbt_requeue' was not declared. Should it be static?
>   CC      block/blk-wbt.o
> block/blk-wbt.c:600:6: warning: no previous prototype for wbt_issue [-Wmissing-prototypes]
>  void wbt_issue(struct rq_qos *rqos, struct request *rq)
>       ^~~~~~~~~
> block/blk-wbt.c:620:6: warning: no previous prototype for wbt_requeue [-Wmissing-prototypes]
>  void wbt_requeue(struct rq_qos *rqos, struct request *rq)

Thanks Bart, applied.

-- 
Jens Axboe

