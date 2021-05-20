Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F2C433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D41610CC
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETF4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 01:56:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETF4E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 01:56:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBCB6AF95;
        Thu, 20 May 2021 05:54:42 +0000 (UTC)
Subject: Re: [PATCH v2 06/11] dm: move zone related code to dm-zone.c
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-7-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <00de9606-1ce2-0258-e376-2e3e29438c9d@suse.de>
Date:   Thu, 20 May 2021 07:54:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520042228.974083-7-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 6:22 AM, Damien Le Moal wrote:
> Move core and table code used for zoned targets and conditionally
> defined with #ifdef CONFIG_BLK_DEV_ZONED to the new file dm-zone.c.
> This file is conditionally compiled depending on CONFIG_BLK_DEV_ZONED.
> The small helper dm_set_zones_restrictions() is introduced to
> initialize a mapped device request queue zone attributes in
> dm_table_set_restrictions().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   drivers/md/Makefile   |   4 ++
>   drivers/md/dm-table.c |  14 ++----
>   drivers/md/dm-zone.c  | 102 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/md/dm.c       |  78 --------------------------------
>   drivers/md/dm.h       |  11 +++++
>   5 files changed, 120 insertions(+), 89 deletions(-)
>   create mode 100644 drivers/md/dm-zone.c
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
