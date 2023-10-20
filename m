Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCECDB474
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 17:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjJTRzE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 13:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJTRzE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 13:55:04 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39053C0
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 10:55:02 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6b497c8575aso1065159b3a.1
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 10:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824501; x=1698429301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylY+bJGG5Ey2eG8FY3rQXRDGg7XNSSsULfXkE7y+nzg=;
        b=VyH0W7gDVFJq6L5z2SmbPaDrwnT54J0URJgOVNrqFIlC78kF1ztO7Q4OWy+axRppNl
         v40I0hoyzpnby4aOXrqm+f2S+zk4RR+nLV04au5xnhaqAhGrJMoWAO1SjqXlhz4FZMr3
         K9ke3lP2gxLXG2EjCTEMkXunDrtUoObZBb4QAqyeuAxVL/KooQEgd33NN3lmBzdp2IoK
         6vgU15eeEwQqmfuRxHL19LhcGi35LXgmz2SExEWcGy2wyZ4BGGvm3y6H2n+MsTG79xuH
         2CSRpUWKabzunUwXpec4jCBm5H+gIafuL5Uu3kyK/qZcyIhsMXO2uenrReNdSvzrrbu6
         MTJw==
X-Gm-Message-State: AOJu0Yxf1f7Tpio0fR/fKr8Fpc/ieny6DyBBk0coB232AmxxBlBAcvJm
        1q6mlF606K8aqdMP7yyHk/o=
X-Google-Smtp-Source: AGHT+IFtQJ40MDThgVfRKXIHPBEGFJygrtt2xtTNIR4mOZ9ewZYGui0701YZ/TITmZG5O3MU/9+0Ww==
X-Received: by 2002:a05:6a20:3950:b0:17c:d4f0:87e0 with SMTP id r16-20020a056a20395000b0017cd4f087e0mr268913pzg.53.1697824501481;
        Fri, 20 Oct 2023 10:55:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:72ba:c99b:d191:901c? ([2620:15c:211:201:72ba:c99b:d191:901c])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00688965c5227sm1804666pfh.120.2023.10.20.10.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:55:01 -0700 (PDT)
Message-ID: <dbdc6dbe-5e2a-4414-bea6-1d2160ffdfdd@acm.org>
Date:   Fri, 20 Oct 2023 10:54:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve shared tag set performance
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <20231020044159.GB11984@lst.de>
 <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org> <ZTKqAzSPNcBp4db0@kbusch-mbp>
 <f2728de6-ff3c-4693-b51f-58c3d46d0fbf@acm.org> <ZTK0NcqB4lIQ_zHQ@kbusch-mbp>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZTK0NcqB4lIQ_zHQ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/20/23 10:09, Keith Busch wrote:
> On Fri, Oct 20, 2023 at 09:45:53AM -0700, Bart Van Assche wrote:
>>
>> On 10/20/23 09:25, Keith Busch wrote:
>>> The legacy block request layer didn't have a tag resource shared among
>>> multiple request queues. Each queue had their own mempool for allocating
>>> requests. The mempool, I think, would always guarantee everyone could
>>> get at least one request.
>>
>> I think that the above is irrelevant in this context. As an example, SCSI
>> devices have always shared a pool of tags across multiple logical
>> units. This behavior has not been changed by the conversion of the
>> SCSI core from the legacy block layer to blk-mq.
>>
>> For other (hardware) block devices it didn't matter either that there
>> was no upper limit to the number of requests the legacy block layer
>> could allocate. All hardware block devices I know support fixed size
>> queues for queuing requests to the block device.
> 
> I am not sure I understand your point. Those lower layers always were
> able to get at least one request per request_queue. They can do whatever
> they want with it after that. This change removes that guarantee for
> blk-mq in some cases, right? I just don't think you can readily conclude
> that is "safe" by appealing to the legacy behavior, that's all.

Hi Keith,

How requests were allocated in the legacy block layer is irrelevant in
this context. The patch I posted affects the tag allocation strategy.
Tag allocation happened in the legacy block layer by calling
blk_queue_start_tag(). From Linux kernel v4.20:

/**
  * blk_queue_start_tag - find a free tag and assign it
  * @q:  the request queue for the device
  * @rq:  the block request that needs tagging
  * [ ... ]
  **/

That function supports sharing tags between request queues but did not
attempt to be fair at all. This is how the SCSI core in Linux kernel 
v4.20 sets up tag sharing between request queues (from 
drivers/scsi/scsi_scan.c):

	if (!shost_use_blk_mq(sdev->host)) {
		blk_queue_init_tags(sdev->request_queue,
				    sdev->host->cmd_per_lun, shost->bqt,
				    shost->hostt->tag_alloc_policy);
	}

blk-mq has always had a fairness algorithm in case a tag set is shared
across request queues. If a tag set is shared across request queues, the
number of tags per request queue is restricted to the total number of
tags divided by the number of users (ignoring rounding). From
block/blk-mq.c in the latest kernel:

	depth = max((bt->sb.depth + users - 1) / users, 4U);

What my patch does is to remove this fairness guarantee. There was no
equivalent of this fairness guarantee in the legacy block layer.

Thanks,

Bart.
