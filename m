Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02ADC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53E1223C8
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2MuA1Xh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53E1223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeKNMgw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:36:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36907 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNMgw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 07:36:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so6638768pge.4
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 18:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s07AIUNZ/+ef0gRDKSExt5oHPz538foRirX1HNC6QHY=;
        b=2MuA1Xh9kkSjnLEUJn+l/tCP6dhOKPFKxUr2fqmVFFtFgvglP4+pXqh+8UL7cSRXy1
         V88SFTc5QQAr/EZYmMw9z78dRkgJttXiVdPPBBnfsRZGaBKOZS+K+alHO0nxpfp3COIr
         0uKOQTiqyObe9vpQPgkeUAiP/kpI7EvBCkmm96Y3mTKKS3ru92l/SZHVmVPTtOBuLiP7
         bLOa6dA/vpUZIiv68I6RgVG2Z10pe779U6vdF1TrV/pF73o/+F22tXANJo+uyAGNzbMM
         kEVOFhKRwD/06jz64BIN1d6X2iMrAUKtaMZyOAlgOLLj1JG4Ns9RUe+2ubCh93PaFChQ
         VjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s07AIUNZ/+ef0gRDKSExt5oHPz538foRirX1HNC6QHY=;
        b=dZuCv3HJ/xPLsO0/k3QzZL2I6PsLsfCRUt/lZKfugfCrqtowVOmFpbT3TYSxyFQx4U
         AR27zIG2kJBSA0hwj9HSRXJy28Ie3zIChdXrvN0WuWh4NfLvW7UlNpDiLCoCbN1D3EWA
         XazlwY4jqFbnl41HQTAQC1RPN4Y1O+rvpfPvB1NAFaNqYIC+6JmnpEidHi6NULfrJebz
         KVaJh2Nh70DxbjWzjdbLwKEpplfHOuvub229xhWd1Lk52cn79kOw0RafSusNcyYj2Q++
         QXNVV6aQ6mQfxqOZSDfazuEb2HoHmDR1f0CWJ8Hb5luRRVqMj5WzSq06YCxRTrtybrkT
         WyCg==
X-Gm-Message-State: AGRZ1gKJ2nGbqfLvwOX8BacLSfMJYl4SyjKMpp/ZLJt8RLs4mPAMKK36
        c7fS9vJwUMsHjFXP8khY2TTNnWbaIn4=
X-Google-Smtp-Source: AJdET5faDcEKZeFKD1O4kUz7soKXV+7wub5SZ1xBgBrOHqvRtoV8S5gQqGVF3fmhSTcECRo7i/Bpgw==
X-Received: by 2002:a62:65c3:: with SMTP id z186-v6mr114264pfb.206.1542162943219;
        Tue, 13 Nov 2018 18:35:43 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1134::122f? ([2620:10d:c090:180::1:2c26])
        by smtp.gmail.com with ESMTPSA id w2-v6sm25669292pfn.89.2018.11.13.18.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 18:35:42 -0800 (PST)
Subject: Re: [PATCH 05/11] block: avoid ordered task state change for polled
 IO
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        linux-block@vger.kernel.org
References: <20181113154233.15256-1-axboe@kernel.dk>
 <20181113154233.15256-6-axboe@kernel.dk>
 <cc187e6f-dd59-8986-057a-99fbc247efd5@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7d16853c-dbeb-45bb-3902-faa5aefad9bb@kernel.dk>
Date:   Tue, 13 Nov 2018 19:35:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cc187e6f-dd59-8986-057a-99fbc247efd5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/18 7:29 PM, jianchao.wang wrote:
> Hi Jens
> 
> On 11/13/18 11:42 PM, Jens Axboe wrote:
>> @@ -181,6 +181,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>>  	struct task_struct *waiter = bio->bi_private;
>>  
>>  	WRITE_ONCE(bio->bi_private, NULL);
>> +	smp_wmb();
>>  	wake_up_process(waiter);
>>  }
> 
> 
> The wake up path has contained a full memory barrier with the raw_spin_lock
> and following smp_mb__after_spinlock
> 
> Please refer to:
> 
> wake_up_process
>   -> try_to_wake_up
> 
> 	raw_spin_lock_irqsave(&p->pi_lock, flags);
> 	smp_mb__after_spinlock();
> 
> So the smp_wmb here is not necessary.

And I guess we don't need it for the next patch either, since the path
that doesn't take wake_up_process() is local.

I'll update them (again), thanks!

-- 
Jens Axboe

