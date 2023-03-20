Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF3C7618A
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 17:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjCTR2A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjCTR1b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 13:27:31 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79666E86
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 10:23:11 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id w4so5147107plg.9
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 10:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZtieyj9/NorLn2x8/1KY5tUmRUM52dzBsNkEOJtyrY=;
        b=1oLnAZ2XffjqPJaKDsS9OGe+Nt9KMrRNWScDqDnMN0MdLxTGRw/lmGpzlxAMHpmfdR
         hE62AiCgvI6JpYbXt+cpq8XzDFf8FgLqX2yJgPPaaETAjVpwmQr1wt5Igfx8w0LFAHIu
         MPXZH3wmDMdM3a8RwfdHE7PR1E5LYtlfjNGlIioZOeSh/JI+b/GIUsFXgctfj6jHMH4D
         ZIOsQQTceugPmhYH8fEtO1hf25pkR7TVb8jkmrqPCNbC2USbjnAUZonWiiFTnbnwJiO1
         Lu3h8CUqcXR4VoGiDeC1rNGs455tvCWA+Yr9hShwVEffTKM+pz4aLVQbbd1gJlzGHUYN
         LU7Q==
X-Gm-Message-State: AO0yUKWmg2LL2L2PH9iKPZtw3+Ch7JWcWvTsFPzGQSeqaxRzOMQ+U5uI
        CAgaEH82Twd0g3cGA4TzcnI=
X-Google-Smtp-Source: AK7set/3r5k6h9zm2zDc7gpfrvs2PU90Iq0H1GqNoqC8UV4HKJiMrgf3I1shrdyOL6b/QO313nQf1w==
X-Received: by 2002:a17:902:ecc5:b0:19e:872b:e844 with SMTP id a5-20020a170902ecc500b0019e872be844mr21810601plh.40.1679332964286;
        Mon, 20 Mar 2023 10:22:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ad26:bef0:6406:d659? ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id x13-20020a1709027c0d00b001a06677948dsm6962163pll.293.2023.03.20.10.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:22:43 -0700 (PDT)
Message-ID: <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org>
Date:   Mon, 20 Mar 2023 10:22:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230318062909.GB24880@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230318062909.GB24880@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/23 23:29, Christoph Hellwig wrote:
> On Fri, Mar 17, 2023 at 12:59:36PM -0700, Bart Van Assche wrote:
>> For zoned storage it is essential that split bios are submitted in LBA order.
>> This patch series realizes this by modifying __bio_split_to_limits() such that
>> it submits the first bio fragment and returns the remainder instead of
>> submitting the remainder and returning the first bio fragment. Please consider
>> this patch series for the next merge window.
> 
> Why are you sending large writes using REQ_OP_WRITE and not
> using REQ_OP_ZONE_APPEND which side steps all these issues?

Hi Christoph,

How to achieve optimal performance with REQ_OP_ZONE_APPEND for SCSI 
devices? My understanding of how REQ_OP_ZONE_APPEND works for SCSI 
devices is as follows:
* ATA devices cannot support this operation directly because there are
   not enough bits in the ATA sense data to report where appended data
   has been written.
* T10 has not yet started with standardizing a zone append operation.
* The code that emulates REQ_OP_ZONE_APPEND for SCSI devices (in
   sd_zbc.c) serializes REQ_OP_ZONE_APPEND operations (QD=1).
* To achieve optimal performance, QD > 1 is required.

Thanks,

Bart.
