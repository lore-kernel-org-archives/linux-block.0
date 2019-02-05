Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DFC282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA94B217D6
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 16:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uYNVDsLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBEQ6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:58:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37619 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfBEQ6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 11:58:34 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so9963388iti.2
        for <linux-block@vger.kernel.org>; Tue, 05 Feb 2019 08:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=leqbKu04F2Xa9IapZUJaIiIQt1XWbxHM2HvXI90h3KY=;
        b=uYNVDsLm3mI971FKsW0b8O08O7bYyWArAtNlhOYrhI4mhj9GLHtf0AA/d1xRCab2b3
         A2zbZPOrboIVkgp1Y3mcfYXuh9USwZ5YoS/DO8jgOhnWDd9FL/MOh5lmMvAB3nKN4uOQ
         DGYLvYP3+OMdwphwxubQmpSoLJJQDdVynzaZGplVVcwN6ub6MGVHiv11uxH0LhMWh33C
         t+jn617p276MpuB2iKKY95OM+w++HcvXvz/AQ9Pgm9CgF6OjzO8xziRX3dW12zNW819/
         eD9JcvmzFSZ40hUjbFER0ZyMKaeLFgxasPNc+St6UPUaXxqDn65sCEFez4EqH9FY6UQ4
         DsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=leqbKu04F2Xa9IapZUJaIiIQt1XWbxHM2HvXI90h3KY=;
        b=KtEB+AcspcLZvv/ss9DYQ3WrZamMocgHB7ic30NpyAY8i2BWPKfUdOh3bs4xN9B2T4
         qDutl3lxs+PnRUsig4LsTQqn2xdWkWWJs0ii3o18hlrSLZSpCd0lb3y0SjFefjWMIe6z
         SV7vPBYQCtBD16z+VL75eRFjRwhcLrZYBHzQWGnTQjUjYFHM9s/KEu49YrX/nHRd1jWB
         jVJJ8QOFCTRMLptaFJdYiCsseFlRMx7kPvbIHI4hIKcP/rNXmRtQ1aoFx0fYfV2NBFal
         sq+sDPIZjliwWaNVTZXKdg5TH+ZKLNfR3FLLkpsya+iFCOFpM2sI7jUm4uxiNx8tokHD
         9ZHw==
X-Gm-Message-State: AHQUAuY4mQHDHWmQ0fupfRIc1EfuofhklY/PcVVTYELSkcmPDmOttOah
        s5b9JCOiwCs3FoocTrf7ZYQ88g==
X-Google-Smtp-Source: AHgI3IaXLyUUFKs53v3QzrjeahNN8wk4qY6KV2ICclkm/Dlhpz2qxzmZrvgjBRCmOd7+3LyulN/ssw==
X-Received: by 2002:a24:2f08:: with SMTP id j8mr3562954itj.42.1549385913080;
        Tue, 05 Feb 2019 08:58:33 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u22sm1794510iof.65.2019.02.05.08.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 08:58:31 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com
References: <20190201152414.23296-1-axboe@kernel.dk>
 <20190201152414.23296-6-axboe@kernel.dk>
 <871s4r8j5i.fsf@oldenburg2.str.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f67d5190-1431-b554-77a7-125bc1a70c32@kernel.dk>
Date:   Tue, 5 Feb 2019 09:58:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <871s4r8j5i.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/19 11:20 AM, Florian Weimer wrote:
> * Jens Axboe:
> 
>> +/*
>> + * Filled with the offset for mmap(2)
>> + */
>> +struct io_sqring_offsets {
>> +	__u32 head;
>> +	__u32 tail;
>> +	__u32 ring_mask;
>> +	__u32 ring_entries;
>> +	__u32 flags;
>> +	__u32 dropped;
>> +	__u32 array;
>> +	__u32 resv[3];
>> +};
>> +
>> +struct io_cqring_offsets {
>> +	__u32 head;
>> +	__u32 tail;
>> +	__u32 ring_mask;
>> +	__u32 ring_entries;
>> +	__u32 overflow;
>> +	__u32 cqes;
>> +	__u32 resv[4];
>> +};
>> +
>> +/*
>> + * io_uring_enter(2) flags
>> + */
>> +#define IORING_ENTER_GETEVENTS	(1U << 0)
>> +
>> +/*
>> + * Passed in for io_uring_setup(2). Copied back with updated info on success
>> + */
>> +struct io_uring_params {
>> +	__u32 sq_entries;
>> +	__u32 cq_entries;
>> +	__u32 flags;
>> +	__u32 resv[7];
>> +	struct io_sqring_offsets sq_off;
>> +	struct io_cqring_offsets cq_off;
>> +};
> 
> I still think it might be a good idea to have one reserved __u64 field
> for alignment purposes.

Sure, I can do that.

-- 
Jens Axboe

