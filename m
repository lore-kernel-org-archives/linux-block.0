Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA48C83004
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 15:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D1D20575
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 15:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kSmIxl4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD2PPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgD2PPh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 11:15:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88EAC03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 08:15:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so1163065pgg.2
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wi2X5fnXrc4Wem14O3belNCCyMD4pJ4fZWx90xq7ka4=;
        b=kSmIxl4X/dJxK/z2UQLo2Hq5FhW/TKDijpZa7DWc5fccjpxDOV3kq4/pAnS1NP6zKH
         TXUlkJ1bApW51fdlSrOFq2TrGcOjqMzzfp7MneoPzTD5xaWxMx5ZSFm/0YbXTjV2H3yO
         f48HurW1rTpolXUVU3G3vgdFwymfaO0yRjasuw5WuPb8AUdAiLbtSd0qla4DJtZmNLhE
         HFGzDzzTy7x8fD27jWgFc02/4y81TkZ5hpF764hVAeDUG8BEd7Sle+Ql0Emi/1K4FMuk
         61VHhQTXPwu/3xzuJMt9XY/QrUG+7vp7PbFwpqcnWpjPlQXBXiJGMHMiD0hvUfOpIMAm
         VBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wi2X5fnXrc4Wem14O3belNCCyMD4pJ4fZWx90xq7ka4=;
        b=hsCPjWHJFCjmqzqYRcZ9dwPRWE+tPGvYPivUKOAZSN3GADzdNHqNKtXVQMsHw9in8L
         Hnb2ZlXbR9oJclNa+IulMlyWseBO9OlTx0Sd9mb65OnaF0TSZMIzkeqOB9puphDMC4O4
         mXe6mmgx1afvXqE/wHWq6rARLfZ5mnzyewzpcsIZVfL3GjJ44RtNkzOCNzmNo7CU/tyt
         JwWobJoE//wysEDM0H82hY+Gb6BGipXllq8mWutj8I9HT/YMaLZqeQ/60Sm6JxykDB0d
         2njvkpTD2f4TMUIGHVTbwEC4QzXiHKCakeSXb9hK5RevmS+LUoobLNeaBFeYAmenPb7N
         KHaw==
X-Gm-Message-State: AGi0Pubj7GYa1StQZF3LrtUMwsM9FR6wViJkJcB4JjMADFQj4VwS+Rxx
        h4kb2ZI/+O9qVWJV3K8Jiqkigg==
X-Google-Smtp-Source: APiQypL0qbIC75IqB+ONdHFexvFnzR5IPi+nQf4tC8bk0rPdUEhb+MBUjAJ/nafl7kJNhy0177F6vQ==
X-Received: by 2002:a62:9211:: with SMTP id o17mr9340840pfd.234.1588173337126;
        Wed, 29 Apr 2020 08:15:37 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 140sm1345450pfw.96.2020.04.29.08.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 08:15:36 -0700 (PDT)
Subject: Re: [PATCH -next] blk-mq: Use BUG_ON() instead of BUG()
To:     Christoph Hellwig <hch@infradead.org>, Zou Wei <zou_wei@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588126224-47877-1-git-send-email-zou_wei@huawei.com>
 <20200429072629.GE11410@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca070e04-5de6-8f31-571b-70a67be62281@kernel.dk>
Date:   Wed, 29 Apr 2020 09:15:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429072629.GE11410@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/20 1:26 AM, Christoph Hellwig wrote:
> On Wed, Apr 29, 2020 at 10:10:24AM +0800, Zou Wei wrote:
>> Fixes coccicheck warning:
>>
>>  block/blk-mq.c:546:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
>>
>> Fixes: 63151a449eba ("blk-mq: allow drivers to hook into I/O completion")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>> ---
>>  block/blk-mq.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index bcc3a23..49a227e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -542,8 +542,7 @@ EXPORT_SYMBOL(__blk_mq_end_request);
>>  
>>  void blk_mq_end_request(struct request *rq, blk_status_t error)
>>  {
>> -	if (blk_update_request(rq, error, blk_rq_bytes(rq)))
>> -		BUG();
>> +	BUG_ON(blk_update_request(rq, error, blk_rq_bytes(rq)));
> 
> I don't think hiding something that actually does do the work in a
> BUG_ON ever is a good style.

Agree, it's a lot less readable. And, not that we've ever done that, but
also fragile in a lot of code bases where a non-debug build would turn
off the BUG_ON() equivalent, and hence never call blk_update_request().
So not a good practice anywhere for statements that have side effects.

-- 
Jens Axboe

