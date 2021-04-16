Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A0EC433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CB361152
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 13:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbhDPNwA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:52:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:38118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240498AbhDPNwA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 09:52:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88BDFB12D;
        Fri, 16 Apr 2021 13:51:34 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit
 is set
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-2-snitzer@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <afeb4a15-eed3-9544-439e-f69b9eff5ad7@suse.de>
Date:   Fri, 16 Apr 2021 15:51:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415231530.95464-2-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 1:15 AM, Mike Snitzer wrote:
> If the DNR bit is set we should not retry the command.
> 
> We care about the retryable vs not retryable distinction at the block
> layer so propagate the equivalent of the DNR bit by introducing
> BLK_STS_DO_NOT_RETRY. Update blk_path_error() to _not_ retry if it
> is set.
> 
> This change runs with the suggestion made here:
> https://lore.kernel.org/linux-nvme/20190813170144.GA10269@lst.de/
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/nvme/host/core.c  | 3 +++
>  include/linux/blk_types.h | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0896e21642be..540d6fd8ffef 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -237,6 +237,9 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
>  
>  static blk_status_t nvme_error_status(u16 status)
>  {
> +	if (unlikely(status & NVME_SC_DNR))
> +		return BLK_STS_DO_NOT_RETRY;
> +
>  	switch (status & 0x7ff) {
>  	case NVME_SC_SUCCESS:
>  		return BLK_STS_OK;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index db026b6ec15a..1ca724948c56 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -142,6 +142,13 @@ typedef u8 __bitwise blk_status_t;
>   */
>  #define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
>  
> +/*
> + * BLK_STS_DO_NOT_RETRY is returned from the driver in the completion path
> + * if the device returns a status indicating that if the same command is
> + * re-submitted it is expected to fail.
> + */
> +#define BLK_STS_DO_NOT_RETRY	((__force blk_status_t)17)
> +
>  /**
>   * blk_path_error - returns true if error may be path related
>   * @error: status the request was completed with
> @@ -157,6 +164,7 @@ typedef u8 __bitwise blk_status_t;
>  static inline bool blk_path_error(blk_status_t error)
>  {
>  	switch (error) {
> +	case BLK_STS_DO_NOT_RETRY:
>  	case BLK_STS_NOTSUPP:
>  	case BLK_STS_NOSPC:
>  	case BLK_STS_TARGET:
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
