Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBB7C433DF
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 06:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367D120772
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 06:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgFWGVr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:21:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:45942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbgFWGVr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 02:21:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC7B7AC2D;
        Tue, 23 Jun 2020 06:21:45 +0000 (UTC)
Subject: Re: [PATCHv3 4/5] nvme: support for multi-command set effects
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Keith Busch <keith.busch@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-5-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4b4ccbc6-30ad-73f4-d7ac-27a477497a6b@suse.de>
Date:   Tue, 23 Jun 2020 08:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-5-kbusch@kernel.org>
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
> The Commands Supported and Effects log page was extended with a CSI
> field that enables the host to query the log page for each command set
> supported. Retrieve this log page for each command set that an attached
> namespace supports, and save a pointer to that log in the namespace head.
> 
> Reviewed-by: Javier González <javier.gonz@samsung.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Keith Busch <keith.busch@wdc.com>
> ---
>   drivers/nvme/host/core.c      | 79 ++++++++++++++++++++++++++---------
>   drivers/nvme/host/hwmon.c     |  2 +-
>   drivers/nvme/host/lightnvm.c  |  4 +-
>   drivers/nvme/host/multipath.c |  2 +-
>   drivers/nvme/host/nvme.h      | 10 ++++-
>   include/linux/nvme.h          |  4 +-
>   6 files changed, 76 insertions(+), 25 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
