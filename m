Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A17C433DF
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 06:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AB4206E2
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 06:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgFWGX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:23:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:46406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbgFWGX4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 02:23:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEFF2AAF1;
        Tue, 23 Jun 2020 06:23:53 +0000 (UTC)
Subject: Re: [PATCHv3 5/5] nvme: support for zoned namespaces
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Keith Busch <keith.busch@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-6-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2d6a9208-944c-efff-718b-e2ff616dd649@suse.de>
Date:   Tue, 23 Jun 2020 08:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-6-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/20 6:25 PM, Keith Busch wrote:
> From: Keith Busch <keith.busch@wdc.com>
> 
> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
> in NVM Express TP4053. Zoned namespaces are discovered based on their
> Command Set Identifier reported in the namespaces Namespace
> Identification Descriptor list. A successfully discovered Zoned
> Namespace will be registered with the block layer as a host managed
> zoned block device with Zone Append command support. A namespace that
> does not support append is not supported by the driver.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Keith Busch <keith.busch@wdc.com>
> ---
>   block/Kconfig              |   5 +-
>   drivers/nvme/host/Makefile |   1 +
>   drivers/nvme/host/core.c   |  91 ++++++++++++--
>   drivers/nvme/host/nvme.h   |  39 ++++++
>   drivers/nvme/host/zns.c    | 245 +++++++++++++++++++++++++++++++++++++
>   include/linux/nvme.h       | 114 ++++++++++++++++-
>   6 files changed, 480 insertions(+), 15 deletions(-)
>   create mode 100644 drivers/nvme/host/zns.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
