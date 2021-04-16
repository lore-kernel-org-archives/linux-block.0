Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AD6C433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 05:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D001C6117A
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 05:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhDPF6m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 01:58:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238932AbhDPF6l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 01:58:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23572AFEA;
        Fri, 16 Apr 2021 05:58:16 +0000 (UTC)
Subject: Re: nvme: Return BLK_STS_TARGET if the DNR bit is set
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210415231126.8746-1-snitzer@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <c715a982-4a75-d30f-e6f6-15ad125e7b89@suse.de>
Date:   Fri, 16 Apr 2021 07:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415231126.8746-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 1:11 AM, Mike Snitzer wrote:
> BZ: 1948690
> Upstream Status: RHEL-only
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> 
> rhel-8.git commit ef4ab90c12db5e0e50800ec323736b95be7a6ff5
> Author: Mike Snitzer <snitzer@redhat.com>
> Date:   Tue Aug 25 21:52:45 2020 -0400
> 
>     [nvme] nvme: Return BLK_STS_TARGET if the DNR bit is set
>     
>     Message-id: <20200825215248.2291-8-snitzer@redhat.com>
>     Patchwork-id: 325178
>     Patchwork-instance: patchwork
>     O-Subject: [RHEL8.3 PATCH 07/10] nvme: Return BLK_STS_TARGET if the DNR bit is set
>     Bugzilla: 1843515
>     RH-Acked-by: David Milburn <dmilburn@redhat.com>
>     RH-Acked-by: Gopal Tiwari <gtiwari@redhat.com>
>     RH-Acked-by: Ewan Milne <emilne@redhat.com>
>     
>     BZ: 1843515
>     Upstream Status: RHEL-only
>     
>     If the DNR bit is set we should not retry the command, even if
>     the standard status evaluation indicates so.
>     
>     SUSE is carrying this patch in their kernel:
>     https://lwn.net/Articles/800370/
>     
>     Based on patch posted for upstream inclusion but rejected:
>     v1: https://lore.kernel.org/linux-nvme/20190806111036.113233-1-hare@suse.de/
>     v2: https://lore.kernel.org/linux-nvme/20190807071208.101882-1-hare@suse.de/
>     v2-keith: https://lore.kernel.org/linux-nvme/20190807144725.GB25621@localhost.localdomain/
>     v3: https://lore.kernel.org/linux-nvme/20190812075147.79598-1-hare@suse.de/
>     v3-keith: https://lore.kernel.org/linux-nvme/20190813141510.GB32686@localhost.localdomain/
>     
>     This commit's change is basically "v3-keith".
>     
>     Signed-off-by: Mike Snitzer <snitzer@redhat.com>
>     Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>
> 
> ---
>  drivers/nvme/host/core.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-rhel9/drivers/nvme/host/core.c
> ===================================================================
> --- linux-rhel9.orig/drivers/nvme/host/core.c
> +++ linux-rhel9/drivers/nvme/host/core.c
> @@ -237,6 +237,9 @@ static void nvme_delete_ctrl_sync(struct
>  
>  static blk_status_t nvme_error_status(u16 status)
>  {
> +	if (unlikely(status & NVME_SC_DNR))
> +		return BLK_STS_TARGET;
> +
>  	switch (status & 0x7ff) {
>  	case NVME_SC_SUCCESS:
>  		return BLK_STS_OK;
> 
No; this is most likely wrong for quite some machines.
At this time we don't have a fixed mapping for the DNR bit;
some BLK_STS_XX codes can be retried, some might, others should not; we
never went so far as to formally code that.

But mapping it to BLK_STS_TARGET is not the correct way here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
