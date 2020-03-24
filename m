Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98812C4332B
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EC02076A
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 07:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCXHRF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:17:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgCXHRE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 03:17:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5258CACA1;
        Tue, 24 Mar 2020 07:17:02 +0000 (UTC)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Tokunori Ikegami <ikegami.t@gmail.com>, linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org
References: <20200323182324.3243-1-ikegami.t@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2293733b-77d7-6fbb-a81a-b68c10656757@suse.de>
Date:   Tue, 24 Mar 2020 08:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323182324.3243-1-ikegami.t@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/20 7:23 PM, Tokunori Ikegami wrote:
> Currently data length can be specified as UINT_MAX but failed.
> This is caused by the max segments parameter limit set as USHRT_MAX.
> To resolve this issue change to increase the value limit range.
> 
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> Cc: linux-block@vger.kernel.org
> Cc: linux-nvme@lists.infradead.org
> ---
>   block/blk-settings.c     | 2 +-
>   drivers/nvme/host/core.c | 2 +-
>   include/linux/blkdev.h   | 7 ++++---
>   3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c8eda2e7b91e..ed40bda573c2 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -266,7 +266,7 @@ EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
>    *    Enables a low level driver to set an upper limit on the number of
>    *    hw data segments in a request.
>    **/
> -void blk_queue_max_segments(struct request_queue *q, unsigned short max_segments)
> +void blk_queue_max_segments(struct request_queue *q, unsigned int max_segments)
>   {
>   	if (!max_segments) {
>   		max_segments = 1;
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a4d8c90ee7cc..2b48aab0969e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2193,7 +2193,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>   
>   		max_segments = min_not_zero(max_segments, ctrl->max_segments);
>   		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> -		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
> +		blk_queue_max_segments(q, min_t(u32, max_segments, UINT_MAX));
>   	}
>   	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
>   	    is_power_of_2(ctrl->max_hw_sectors))
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f629d40c645c..4f4224e20c28 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -338,8 +338,8 @@ struct queue_limits {
>   	unsigned int		max_write_zeroes_sectors;
>   	unsigned int		discard_granularity;
>   	unsigned int		discard_alignment;
> +	unsigned int		max_segments;
>   
> -	unsigned short		max_segments;
>   	unsigned short		max_integrity_segments;
>   	unsigned short		max_discard_segments;
>   
> @@ -1067,7 +1067,8 @@ extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
>   extern void blk_queue_bounce_limit(struct request_queue *, u64);
>   extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
>   extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
> -extern void blk_queue_max_segments(struct request_queue *, unsigned short);
> +extern void blk_queue_max_segments(struct request_queue *q,
> +				   unsigned int max_segments);
>   extern void blk_queue_max_discard_segments(struct request_queue *,
>   		unsigned short);
>   extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
> @@ -1276,7 +1277,7 @@ static inline unsigned int queue_max_hw_sectors(const struct request_queue *q)
>   	return q->limits.max_hw_sectors;
>   }
>   
> -static inline unsigned short queue_max_segments(const struct request_queue *q)
> +static inline unsigned int queue_max_segments(const struct request_queue *q)
>   {
>   	return q->limits.max_segments;
>   }
> 
One would assume that the same reasoning goes for max_integrity_segment, no?

Otherwise looks good.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
