Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD9C31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DDC20665
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 16:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RnEDrGWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfHLQDT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:03:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35041 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLQDT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 12:03:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id g17so9780264otl.2
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2019 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y2vC5MASi0neUbnDo7XSWsxJ0q98nBk3UrdR+dIcZtA=;
        b=RnEDrGWzjAn/f3aQRxaVDqOwZHyKXULAlS6mvSyYbl0Dz6KNCrj9HhycvI4boX95M+
         guluq7bkf9xfhp9YNLAT6nb7gklSAQ729NHV7yGeBFrNWo4X3q9bR0HfUz+3vORrTo/4
         l2bjvVPNVtM9r+O3Y6L0op8lyvDix4662p1OiuAwLap0YtnI95VxAIrY77IH5PLcVsV9
         veNDRb05aES2ftgfUsynEIdCINVJMLPF/6DUfHyD+JQxU4kkd0qBiBDRCBthSAlW26Ol
         WRz75Qo9N2azRNTYSG7RcZ1LVLXel6gBORned6DeIDQbD3MPuQKiMeEdxkyEV3fi6Mmo
         kC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y2vC5MASi0neUbnDo7XSWsxJ0q98nBk3UrdR+dIcZtA=;
        b=uDDFXa5iBLQ3oEpRSkQxBJ/oeqFIy1nIHUxuF1p9oksGSHn6ti3oZn2xicvFIAqj30
         d1U15ud2udsLQjuyrAZ3AJdmMgniXOuLOmIw4rK6MRJ4xGt0nY1kFb27TIUHGkvzD9WW
         1jU0K4UHUPWxzPlyOp+ANFWpf0uqNrDiJFr9iYdo0YP/6K68h9FJ6r2clxJ8SOsZMOjv
         TXkkZFp+fJJDBZrm8xeJFLxzkPTzVO+PpDkdSOB6qiVgOj7kA5CcsmSoE8X36fdYelnw
         YKjU6e+ArUGPJqQrO8daehvKZhZotVkOHGWuJ+WVMOZiA9Fqr7kuJrtNTUZF1+DEBhfc
         AB3Q==
X-Gm-Message-State: APjAAAUTr7jHNxOAKVmtsGqVN5iLnmurvkoCYv6amx6RdrixeSVip3CS
        +j2X5jbDyWN7IzvclOxUx7INQJiEa9q09Q==
X-Google-Smtp-Source: APXvYqywlwoe3JQh7ZmfdQLqNhkxuQ/rP+bz36b0eEFcUMsxpGnlbKLfZ1PIW8PYCOU+aq83ocbG9Q==
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr11107648ioc.232.1565625798858;
        Mon, 12 Aug 2019 09:03:18 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o3sm17282188ioo.74.2019.08.12.09.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 09:03:17 -0700 (PDT)
Subject: Re: [PATCH] liburing/barrier.h: Add prefix io_uring to barriers
To:     Bart Van Assche <bvanassche@acm.org>,
        Julia Suvorova <jusual@redhat.com>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>
References: <20190812123933.24814-1-jusual@redhat.com>
 <592fe38c-1fa2-9ba5-cd6c-da69c95edb33@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75c89da5-2ec1-9725-62c8-f6abd3a24202@kernel.dk>
Date:   Mon, 12 Aug 2019 10:03:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <592fe38c-1fa2-9ba5-cd6c-da69c95edb33@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/19 7:55 AM, Bart Van Assche wrote:
> On 8/12/19 5:39 AM, Julia Suvorova wrote:
>> -#define mb()	asm volatile("mfence" ::: "memory")
>> -#define rmb()	asm volatile("lfence" ::: "memory")
>> -#define wmb()	asm volatile("sfence" ::: "memory")
>> -#define smp_rmb() barrier()
>> -#define smp_wmb() barrier()
>> +#define io_uring_mb()		asm volatile("mfence" ::: "memory")
>> +#define io_uring_rmb()		asm volatile("lfence" ::: "memory")
>> +#define io_uring_wmb()		asm volatile("sfence" ::: "memory")
>> +#define io_uring_smp_rmb()	io_uring_barrier()
>> +#define io_uring_smp_wmb()	io_uring_barrier()
> 
> Do users of liburing need these macros? If not, have you considered to
> move these macros to a new header file that is only used inside liburing
> and such that these macros are no longer visible to liburing users?

The exposed API should not need any explicit barriers from the user,
so this suggestion makes a lot of sense to me.

-- 
Jens Axboe

