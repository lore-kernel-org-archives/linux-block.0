Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBEC04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E652D20851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E652D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLLHT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:19:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44165 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLHT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:19:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so7900684pgr.11;
        Tue, 11 Dec 2018 23:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=71AsmyidfRNMJCqqzytW+Jmdjzd6LRgmB2VQ+K+xoVk=;
        b=GEYI84UjyoGTnVa0Hv5O7p0ZlywJA+CUAmckIAzNM4ak7XXbQ/YmN42usfLfxl6kwI
         Pbe7szmi/ccqibWgrS3Ov/bN8BiMXqtZGi2PAajm4MvrwMUZUQYo0VT1AnwFE5tewN4h
         KowN5aLLIo0kNccEnwlnvqQgJ+rghazH5KgZx7BgAVqu+Gba1w5ZgSF0WQGS+yEzitGH
         ms6i3emWmXx8iPBzwfXpnIpYX3j93f0ojiBmsssYJJ95fA5+Kph0vzStlJJxvu7qdqKd
         Y6qUwx40akZ7uOR/wOsDo/I7xk5Jt936FbwmctzNVhS3MJiEen1ilsxzhxooZ0F0Cv/C
         zcjw==
X-Gm-Message-State: AA+aEWandw99Mm3F/Zw3oxeXkdkVAOLoOkrMMzZAatB4WOPnaeeLUAz7
        1lDQxcRnPB6x5L+jdo1PGJ8=
X-Google-Smtp-Source: AFSGD/U6LcrEO96wBYp5YlV7eolpGU1SU76rXdVDtWLd4ogi3c6OI/wfZGexxS51oheFS2qhxIXAQQ==
X-Received: by 2002:a62:4b4d:: with SMTP id y74mr19069450pfa.186.1544599165294;
        Tue, 11 Dec 2018 23:19:25 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id g2sm20080089pfi.95.2018.12.11.23.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 23:19:24 -0800 (PST)
Subject: Re: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Keith Busch <keith.busch@intel.com>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-5-sagi@grimberg.me> <20181212071140.GD28461@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>
Date:   Tue, 11 Dec 2018 23:19:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212071140.GD28461@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> [adding Jens]
> 
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1547,6 +1547,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>>   	if (ns->head->disk) {
>>   		nvme_update_disk_info(ns->head->disk, ns, id);
>>   		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
>> +		/* XXX: multipath device does not support polling for now... */
>> +		blk_queue_flag_clear(QUEUE_FLAG_POLL, ns->queue);
> 
> I'd drop the XXX.  But I think we actually have a block layer problem
> here.  Currently stacking devices will just pass through REQ_HIPRI,
> despite none of them supporting any polling for it.

Yea... forgot there are other stack devices...

> So we need to make sure in the block layer or I/O submitter that
> REQ_HIPRI is only set if QUEUE_FLAG_POLL is supported.  I think it would
> also help if we rename it to REQ_POLL to make this more obvious.

It used to check for it, but was changed to look at nr_maps instead...
So I think this is a regression...
