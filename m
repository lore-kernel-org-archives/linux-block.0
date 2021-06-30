Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E02C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 18:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493CC61436
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 18:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhF3TBT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:01:19 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:50918 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhF3TBT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 15:01:19 -0400
Received: by mail-pj1-f51.google.com with SMTP id ie21so699848pjb.0
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 11:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pAxmYwWjjUNWwuxJKS+gb8WM247UFByinkjRrhSt9y0=;
        b=dysjDKrmckeNc1thHEc6IygANjw34mdENoghewMfh6x5FJzp6IK4jllNgLuSnuVfbi
         xzADkT3kLg/Cn2YXHIC30d28jzJ42Pu1jBM/fV/RR/NXpDjEjNpwR0n+xUczU55YVQ0Y
         PddwlzlTGglvfMNyl2YH4S0ptX+pRTewlziv526kODw5kN7uAXbZfCjAYdgPyxlONh9n
         G+RPkQxAs/I3CBCCauDrR3HNNeTuCNHBIWQAMdzzDfvdBKg6xAC0snWW87gIxaURyHhh
         F5bloXuCOq/EFBEzKj9dL4HWsCSqL3pWSKX/UOVA1danNzEQDkMlyC+jaL8Fj4DWtSMg
         74Qg==
X-Gm-Message-State: AOAM531FumIIbZqF83ncTO6b0OH9ftn71PTvn74C6/eP91CRpmH6BB9B
        25QfDiWp9LDsT3x53qmt/08=
X-Google-Smtp-Source: ABdhPJxPv9woprMTy8UdcPtmWSzvNrEWD+trqYefbyKXifMQvZrxSPP0TGQR4Ipgz1xG1AtzZSl5tQ==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr5811588pjs.207.1625079529184;
        Wed, 30 Jun 2021 11:58:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8e5:b428:30c3:f97b? ([2601:647:4802:9070:8e5:b428:30c3:f97b])
        by smtp.gmail.com with ESMTPSA id w6sm329136pgh.56.2021.06.30.11.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 11:58:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0f8be11b-c6de-1c2b-323b-1e059c2ac4f8@grimberg.me>
Date:   Wed, 30 Jun 2021 11:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index 21140132a30d..600c5dd1a069 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -403,6 +403,7 @@ enum {
>>   	 */
>>   	BLK_MQ_F_STACKING	= 1 << 2,
>>   	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
>> +	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,
> 
> My 2 cents: BLK_MQ_F_NO_MANAGED_IRQ may be a better/shorter name.

Maybe BLK_MQ_F_UNMANAGED_IRQ?
