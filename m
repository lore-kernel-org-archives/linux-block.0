Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A1EB64DA
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 14:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGROZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGROZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 10:25:13 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106A123
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 07:25:13 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-666edfc50deso3574559b3a.0
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 07:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690313; x=1692282313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uabr8qn/OI3ZUPYBMNbKYHaxrGP3u3n5gl5kTIATcIU=;
        b=LQ/5BYO1iOyQ7bdJ6n1WmCoBpNpSxe16DOh1JqzGSN0gu1u1Ett46FFE5Uh0dN6e74
         U7UaDGCbGgslijxCEeE+lgLwmS5Cx/+xgtva7hh8Nyf+MKVoKjHlUI84UnxWunMrbPqo
         YEd35B9oWSJklqlfIM8w9lVtO/YLFn1g5O2aBOpsQYMyJIS+qd6dwdhb0Bpsf2OFNqkw
         8UVbsXmn5G4DBP13YvjRXl5z3yImzswDmtKfA3VV4wNOqMA5Dqbpa8KL4C4Jw9KKGGjG
         FEadh7CV+0cNUQyGtDpfGWW3uqh6YVRpH9GlXWymyVUJE63qh5nSPWEkCKNcSRcR4NNU
         t1cA==
X-Gm-Message-State: ABy/qLYcQyOkvJQA2ncAxYaxdKA3ywZkNC31zWXnpFxrsBkaU8uf4obq
        AljRfG0AoUvo3EkntkB5+tU=
X-Google-Smtp-Source: APBJJlEfb2v3Fuk2aF0iKrw+1nJ+kVg9LLjUOCIxtadKEaUh14a2Y0QWT7fEZdgRtddjsFiugL7f3w==
X-Received: by 2002:a05:6a00:8ce:b0:681:919f:bf69 with SMTP id s14-20020a056a0008ce00b00681919fbf69mr17649402pfu.0.1689690312585;
        Tue, 18 Jul 2023 07:25:12 -0700 (PDT)
Received: from ?IPV6:2601:642:4c05:546a:1fd9:c19f:bd9a:ab8e? ([2601:642:4c05:546a:1fd9:c19f:bd9a:ab8e])
        by smtp.gmail.com with ESMTPSA id a22-20020aa78656000000b006828ee9fdaesm1601650pfo.127.2023.07.18.07.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:25:12 -0700 (PDT)
Message-ID: <3d459260-724f-810b-b94a-9e8da28a1085@acm.org>
Date:   Tue, 18 Jul 2023 07:25:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] block: Improve performance for BLK_MQ_F_BLOCKING
 drivers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230717205216.2024545-1-bvanassche@acm.org>
 <20230717205216.2024545-4-bvanassche@acm.org> <20230718045439.GA8781@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230718045439.GA8781@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/17/23 21:54, Christoph Hellwig wrote:
> On Mon, Jul 17, 2023 at 01:52:15PM -0700, Bart Van Assche wrote:
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -329,6 +329,9 @@ static void scsi_single_lun_run(struct scsi_device *current_sdev)
>>   	starget->starget_sdev_user = NULL;
>>   	spin_unlock_irqrestore(shost->host_lock, flags);
>>   
>> +	/* Combining BLIST_SINGLELUN with BLK_MQ_F_BLOCKING is not supported. */
>> +	WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);
> 
> .. but it must work.  BLIST_SINGLELUN is set for specific targets
> based on the identification string while BLK_MQ_F_BLOCKING is set by
> the LLDD.  Also the blist flags can be set from userspace through
> /proc/scsi/device_info.

Hi Christoph,

I think that support for BLIST_SINGLELUN devices can be realized with the
change shown below. I had not yet looked into this because my understanding
is that BLIST_SINGLELUN devices are all CD-ROM devices that are probably
rare these days.

Bart.

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 197942db8016..84fb0feb047f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -329,16 +329,14 @@ static void scsi_single_lun_run(struct scsi_device *current_sdev)
  	starget->starget_sdev_user = NULL;
  	spin_unlock_irqrestore(shost->host_lock, flags);

-	/* Combining BLIST_SINGLELUN with BLK_MQ_F_BLOCKING is not supported. */
-	WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);
-
  	/*
  	 * Call blk_run_queue for all LUNs on the target, starting with
  	 * current_sdev. We race with others (to set starget_sdev_user),
  	 * but in most cases, we will be first. Ideally, each LU on the
  	 * target would get some limited time or requests on the target.
  	 */
-	blk_mq_run_hw_queues(current_sdev->request_queue, false);
+	blk_mq_run_hw_queues(current_sdev->request_queue,
+			     shost->queuecommand_may_block);

  	spin_lock_irqsave(shost->host_lock, flags);
  	if (!starget->starget_sdev_user)

