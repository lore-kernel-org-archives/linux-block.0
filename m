Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FCFC10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 11:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A32074B
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 11:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCMLKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:10:23 -0400
Received: from verein.lst.de ([213.95.11.211]:42016 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgCMLKX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 07:10:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9937A68C4E; Fri, 13 Mar 2020 12:10:20 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:10:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, hch@lst.de
Subject: Re: [PATCH v3 2/5] virtio_blk.c: Convert to use
 set_capacity_revalidate_and_notify
Message-ID: <20200313111020.GB8264@lst.de>
References: <20200313053009.19866-1-sblbir@amazon.com> <20200313053009.19866-3-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313053009.19866-3-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 13, 2020 at 05:30:06AM +0000, Balbir Singh wrote:
> block/genhd provides set_capacity_revalidate_and_notify() for sending RESIZE
> notifications via uevents.
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> ---
>  drivers/block/virtio_blk.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 0736248999b0..f9b1e70f1b31 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -388,18 +388,15 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
>  		   cap_str_10,
>  		   cap_str_2);
>  
> -	set_capacity(vblk->disk, capacity);
> +	set_capacity_revalidate_and_notify(vblk->disk, capacity, true);

Shouldn't the last argument be set to the resize argument passed to this
function?
