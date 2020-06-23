Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D063C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 06:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3519020772
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 06:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgFWGQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:16:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbgFWGQO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 02:16:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEDDFAAF1;
        Tue, 23 Jun 2020 06:16:12 +0000 (UTC)
Subject: Re: [PATCHv3 2/5] null_blk: introduce zone capacity for zoned device
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Aravind Ramesh <aravind.ramesh@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-3-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ceca490a-6163-e591-b3fd-323e1af6de66@suse.de>
Date:   Tue, 23 Jun 2020 08:16:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-3-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/20 6:25 PM, Keith Busch wrote:
> From: Aravind Ramesh <aravind.ramesh@wdc.com>
> 
> Allow emulation of a zoned device with a per zone capacity smaller than
> the zone size as as defined in the Zoned Namespace (ZNS) Command Set
> specification. The zone capacity defaults to the zone size if not
> specified and must be smaller than the zone size otherwise.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> ---
>   drivers/block/null_blk.h       |  1 +
>   drivers/block/null_blk_main.c  | 10 +++++++++-
>   drivers/block/null_blk_zoned.c | 16 ++++++++++++++--
>   3 files changed, 24 insertions(+), 3 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
