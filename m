Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA8EEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 20:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjG0U1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjG0U1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 16:27:53 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5925E2D71
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:27:22 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so868894b3a.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690489569; x=1691094369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xJzUgKrN9MvGtgNhxuFzT7GY4BxHPqBw/mUX/0thAQ=;
        b=UE/oA3h6S4MDORrKnCS93bvgcJAt0qXzvVBL+jZtqBty6vJMhz7Gqy9+i3BOwtA2ri
         Q4E3Ay3zMErGVMEyM6S+N4NcwTTfg0Z+2l8d6z17rihQzMFTQkhYoRDNrQvju5SLxY3L
         yPmMuzeGVdGLIJeIL23P3Vqjvn2+LDKbfNZw+/TSP/mFQMJHEeZo8ZuFb4Z3cIHbMsdz
         ILG1j0TQeCyUeD2lAc+CKhDLFl/rp2bx5hS5KugBV/Gu3PHzeUFX6/gaXaPUoEX2FJ+x
         Zvg7YmzDDSFsYCTDcXWDouBD4jHr/G0w6kN4DXG90oe2ygQ8vSLxjnGysyW17uW6UV1h
         LYFQ==
X-Gm-Message-State: ABy/qLZSvhvXBUo2fX+JRFPmGOMcWoAsjqP2MTLmJ8z4l10YIF1/JxwJ
        2Erj6fzatxWDDodKsOpoVLk=
X-Google-Smtp-Source: APBJJlE+XaoL6OsYi/yO8n6HgonH09shNpszrxTz4rzCSDaRaz/3fRGmtM8IqSFo4aGjPr+QIHZNEQ==
X-Received: by 2002:a05:6a20:4425:b0:133:38cb:2b93 with SMTP id ce37-20020a056a20442500b0013338cb2b93mr549859pzb.9.1690489569151;
        Thu, 27 Jul 2023 13:26:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:607:27ba:91cb:68ee? ([2620:15c:211:201:607:27ba:91cb:68ee])
        by smtp.gmail.com with ESMTPSA id f20-20020aa782d4000000b0066f37665a6asm1858939pfn.117.2023.07.27.13.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 13:26:08 -0700 (PDT)
Message-ID: <dc61d570-4957-c6c4-0328-1358419212b0@acm.org>
Date:   Thu, 27 Jul 2023 13:26:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/7] block/null_blk: Support disabling zone write
 locking
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-5-bvanassche@acm.org>
 <0d4e873c-199f-3c47-7c27-3ebd5624fee6@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0d4e873c-199f-3c47-7c27-3ebd5624fee6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 17:36, Chaitanya Kulkarni wrote:
> On 7/26/2023 12:34 PM, Bart Van Assche wrote:
>> Add a new configfs attribute for disabling zone write locking. Tests
>> show a performance of 250 K IOPS with no I/O scheduler, 6 K IOPS with
>> mq-deadline and write locking enabled and 123 K IOPS with mq-deadline
>> and write locking disabled. This shows that disabling write locking
>> results in about 20 times more IOPS for this particular test case.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
> 
> This patch looks good to me, perhaps a blktests would be nice in zbd
> category ?
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Hi Chaitanya,

I will work on adding a blktest test that runs with zone write locking 
disabled.

Thanks,

Bart.

