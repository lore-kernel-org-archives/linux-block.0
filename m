Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E2C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C73C2084C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C73C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKXLY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:11:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34500 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKXLY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:11:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so13541777oig.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 15:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g5ek+Q+eBAadra4vlXygtJtdWiLmrY47B5TOWdTWPb4=;
        b=Y4yTtOJ5SpYC5IDB4C/VmPUq7uMHziQqz9HvPRfuxw+wHl75FP03RuEh9zdpvuKQ0M
         0HYBp7RiT2C1CPGiYw+MdzmCI95Xo5XRzjIjOfN9PBRLEi/VhwKym1K0jZ94FmK+TczY
         IBhH/a1T0OuOJZ91O843aBidY35puplAPiqdycHboDetnsM+wLAG/8TbqrdK2buYjKsi
         OtNvAjBfMHmLYVETwo3mfT+I/PI5/1BGfxze0P5WiMKO78qnuGPNzBAibwri6lWnIAnt
         jAu9qPhP2Dbb+ThQvfosIwB/1Ix1zWOc8Y2XJFvQEy9J1TDDUPmdn4qep3ntg07+dXDY
         8QUw==
X-Gm-Message-State: AA+aEWbtzEsR2MolGpvxdp7nkJTMNsedFgIR0y3GnNlYuf+Kvj+OC7Qx
        AShb6zdkhc3oYKqrL2NlgAc=
X-Google-Smtp-Source: AFSGD/WeoARtp4Mqjydc4TG8enmz1zw4F7tVIz8xtpwPBUKfeaVUeCNGb3QXux01A19rzkIE7SNyzA==
X-Received: by 2002:aca:1e08:: with SMTP id m8mr2302936oic.347.1544569883488;
        Tue, 11 Dec 2018 15:11:23 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a66sm8147335oib.42.2018.12.11.15.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:11:22 -0800 (PST)
Subject: Re: [PATCH 4/5] nvme-tcp: support separate queue maps for read and
 write
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20181211104936.25333-1-sagi@grimberg.me>
 <20181211104936.25333-5-sagi@grimberg.me> <20181211134135.GD20614@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b392933-9cdd-bfba-ea14-cdabc31a1dcb@grimberg.me>
Date:   Tue, 11 Dec 2018 15:11:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211134135.GD20614@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
>> +{
>> +	struct nvme_tcp_ctrl *ctrl = set->driver_data;
>> +	struct blk_mq_queue_map *map;
>> +
>> +	if (ctrl->ctrl.opts->nr_write_queues) {
>> +		/* separate read/write queues */
>> +		map = &set->map[HCTX_TYPE_DEFAULT];
>> +		map->queue_offset = 0;
>> +		map->nr_queues = ctrl->ctrl.opts->nr_write_queues;
>> +		blk_mq_map_queues(map);
> 
> Shouldn't this use nr_io_queues?

The intent is that HCTX_TYPE_READ will always use nr_io_queues and
HCTX_TYPE_DEFAULT will use nr_write_queues.. I'll document that
in the change log.

> Also I find the reused local map variable a little odd and not helpful
> for readability.  What about something like:
> 
> static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
> {
> 	struct nvme_tcp_ctrl *ctrl = set->driver_data;
> 
> 	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> 	set->map[HCTX_TYPE_DEFAULT].nr_queues = ctrl->ctrl.opts->nr_io_queues;
> 	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> 
> 	if (ctrl->ctrl.opts->nr_write_queues) {
> 		/* separate read/write queues */
> 		set->map[HCTX_TYPE_READ].queue_offset =
> 				ctrl->ctrl.opts->nr_io_queues;
> 		set->map[HCTX_TYPE_READ].nr_queues =
> 				ctrl->ctrl.opts->nr_write_queues;
> 	} else {
> 		/* mixed read/write queues */
> 		set->map[HCTX_TYPE_READ].queue_offset = 0;
> 		set->map[HCTX_TYPE_READ].nr_queues =
> 				ctrl->ctrl.opts->nr_io_queues;
> 	}
> 	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> 	return 0;
> }

That's better.. I'll update the patch with a change according to my
note above..
