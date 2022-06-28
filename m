Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C2CC43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 03:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiF1DQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 23:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiF1DQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 23:16:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D819027
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 20:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46FB9B8182F
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 03:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F649C34115;
        Tue, 28 Jun 2022 03:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656386173;
        bh=qnyMj83V+/XET9RIXuqI4AcB/fg8yaYq1VuklGYX+Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H29TE9RpeDAZQspBR3AP5ZLqiBRTiNpmruCMlk+LNX1Qm8gFST7K7KP0JtRzocXFW
         BdeipdU5aB1gI7KektTGVR470s1Y4SJ53SsVmHOpTBLp94fxmTKnSAw38KLd/P58Xt
         Ewd9Zq+5qJ2BTChDr/Bgoe5LxQTLRHQgxwqNXOMe6F0RfYpLcCkI+Y65ZoKwC+/mKe
         W82v0Z8sHQauFgPnM69XvfOQrs3SffGG4nro9Agx0Kk5LAUSkkMSpx1JUdokXIcTLO
         JvzlHD2AHEeBsQGDNRdVtI37TR0SE8oYf/DRYzSfo5g+Lyoelp8ztzVlErbp4q/hBh
         8GJWoKs3u1jHg==
Date:   Mon, 27 Jun 2022 21:16:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Message-ID: <YrpyeemonjF3Lv/z@kbusch-mbp.dhcp.thefacebook.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627234335.1714393-9-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 27, 2022 at 04:43:35PM -0700, Bart Van Assche wrote:
> @@ -854,6 +854,12 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  	if (req->cmd_flags & REQ_RAHEAD)
>  		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>  
> +	if (blk_queue_pipeline_zoned_writes(req->q) &&
> +	    blk_rq_is_seq_zone_write(req))
> +		nvme_req(req)->max_retries =
> +			min(0UL + type_max(typeof(nvme_req(req)->max_retries)),
> +			    nvme_req(req)->max_retries + req->q->nr_requests);

I can't make much sense of what the above is trying to accomplish. This
reevaluates max_retries every time the request is retried, and the new
max_retries is based on the previous max_retries?
