Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE18CC25B0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 21:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiHPVOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 17:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiHPVOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 17:14:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F2792F0;
        Tue, 16 Aug 2022 14:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB9BEB81AF5;
        Tue, 16 Aug 2022 21:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416BFC433D6;
        Tue, 16 Aug 2022 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660684482;
        bh=m0n9HY+gqxmJTWtx8pVWHb4MyNuPPxntKDcT0U/yHjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNvpog6Ne0DR3YdxWE9freAnZ7a2ReiwVLY1m4s5+zot9uAgmDME/NRiby+5oJOAD
         xzLoKSbrGeG+66XxwECTjXfQRZQOahXKh4KuXGfa8jyHRYf0bL2bIZAl1uL7ehpHqf
         tvXiK+xqK0OmYOlowdq6ZKR5zPxWbAfJzCVG4z3NTzpD/MYv0cdkCKIGc4b80N29iR
         naZME4/PnOZ9ioia8+1c+a64iK74vcAX2tv0A12Sg1dMYr28pky3mv5FI8PtHLWw7b
         ktQ/952RKdm6J2LIsUrK1UXpm7Ju0epIjKmgeN0lAVRcUKZ/7pnD0DYiF4+v2iFK8k
         1UbsVnRZsNfJg==
Date:   Tue, 16 Aug 2022 15:14:38 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
        matias.bjorling@wdc.com, hare@suse.de, gost.dev@samsung.com,
        linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
        pankydev8@gmail.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v10 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Message-ID: <YvwIvrToFYMDwQoj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220811143043.126029-1-p.raghav@samsung.com>
 <CGME20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9@eucas1p1.samsung.com>
 <20220811143043.126029-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811143043.126029-6-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 11, 2022 at 04:30:35PM +0200, Pankaj Raghav wrote:
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	}
>  
>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}

We used to bail out early if the format wasn't supported, which wouldn't create
the namespace.

Now you are relying on blk_revalidate_disk_zones() to report an error for
invalid format, but the handling for an error there is different: the namespace
still gets created. I'm not sure if that's a problem, but it's different.
