Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BEDC64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 03:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9350A206D5
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 03:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgLBD6U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 22:58:20 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59158 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727078AbgLBD6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 22:58:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHHiNul_1606881455;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHHiNul_1606881455)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Dec 2020 11:57:36 +0800
Subject: Re: [PATCH] dm: use gcd() to fix chunk_sectors limit stacking
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     snitzer@redhat.com
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
 <20201202033855.60882-2-jefflexu@linux.alibaba.com>
Message-ID: <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
Date:   Wed, 2 Dec 2020 11:57:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202033855.60882-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Actually in terms of this issue, I think the dilemma here is that,
@chunk_sectors of dm device is mainly from two source.

One is that from the underlying devices, which is calculated into one
composed one in blk_stack_limits().

> commit 22ada802ede8 ("block: use lcm_not_zero() when stacking
> chunk_sectors") broke chunk_sectors limit stacking. chunk_sectors must
> reflect the most limited of all devices in the IO stack.
> 
> Otherwise malformed IO may result. E.g.: prior to this fix,
> ->chunk_sectors = lcm_not_zero(8, 128) would result in
> blk_max_size_offset() splitting IO at 128 sectors rather than the
> required more restrictive 8 sectors.

For this part, technically I can't agree that 'chunk_sectors must
reflect the most limited of all devices in the IO stack'. Even if the dm
device advertises chunk_sectors of 128K when the limits of two
underlying devices are 8K and 128K, and thus splitting is not done in dm
device phase, the underlying devices will split by themselves.

> @@ -547,7 +547,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  
>  	t->io_min = max(t->io_min, b->io_min);
>  	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> -	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
> +
> +	/* Set non-power-of-2 compatible chunk_sectors boundary */
> +	if (b->chunk_sectors)
> +		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);

This may introduces a regression. Suppose the @chunk_sectors limits of
two underlying devices are 8K and 128K, then @chunk_sectors of dm device
is 8K after the fix. So even when a 128K sized bio is actually
redirecting to the underlying device with 128K @chunk_sectors limit,
this 128K sized bio will actually split into 16 split bios, each 8K
sized。Obviously it is excessive split. And I think this is actually why
lcm_not_zero(a, b) is used originally.


The other one source is dm device itself. DM device can set @max_io_len
through ->io_hint(), and then set @chunk_sectors from @max_io_len.

This part is actually where 'chunk_sectors must reflect the most limited
of all devices in the IO stack' is true, and we have to apply the most
strict limitation here. This is actually what the following patch does.



On 12/2/20 11:38 AM, Jeffle Xu wrote:
> As it said in commit 7e7986f9d3ba ("block: use gcd() to fix
> chunk_sectors limit stacking"), chunk_sectors should reflect the most
> limited of all devices in the IO stack.
> 
> The previous commit only fixes block/blk-settings.c:blk_stack_limits(),
> while leaving dm.c:dm_calculate_queue_limits() unfixed.
> 
> Fixes: 882ec4e609c1 ("dm table: stack 'chunk_sectors' limit to account for target-specific splitting")
> cc: stable@vger.kernel.org
> Reported-by: John Dorminy <jdorminy@redhat.com>
> Reported-by: Bruce Johnston <bjohnsto@redhat.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  drivers/md/dm-table.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index ce543b761be7..dcc0a27355d7 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -22,6 +22,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/mount.h>
>  #include <linux/dax.h>
> +#include <linux/gcd.h>
>  
>  #define DM_MSG_PREFIX "table"
>  
> @@ -1457,7 +1458,7 @@ int dm_calculate_queue_limits(struct dm_table *table,
>  
>  		/* Stack chunk_sectors if target-specific splitting is required */
>  		if (ti->max_io_len)
> -			ti_limits.chunk_sectors = lcm_not_zero(ti->max_io_len,
> +			ti_limits.chunk_sectors = gcd(ti->max_io_len,
>  							       ti_limits.chunk_sectors);
>  		/* Set I/O hints portion of queue limits */
>  		if (ti->type->io_hints)
> 

-- 
Thanks,
Jeffle
