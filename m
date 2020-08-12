Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A635C433DF
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 02:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F412076C
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 02:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgHLCHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:07:18 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:58993 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726235AbgHLCHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 22:07:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U5VxwX6_1597198026;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U5VxwX6_1597198026)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Aug 2020 10:07:06 +0800
Date:   Wed, 12 Aug 2020 10:07:06 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V2 2/3] block: virtio_blk: fix handling single range
 discard request
Message-ID: <20200812020706.GA69794@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20200811234420.2297137-1-ming.lei@redhat.com>
 <20200811234420.2297137-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811234420.2297137-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Wed, Aug 12, 2020 at 07:44:19AM +0800, Ming Lei wrote:
> 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> to support multi-range discard for virtio-blk. However, the virtio-blk
> disk may report max discard segment as 1, at least that is exactly what
> qemu is doing.
> 
> So far, block layer switches to normal request merge if max discard segment
> limit is 1, and multiple bios can be merged to single segment. This way may
> cause memory corruption in virtblk_setup_discard_write_zeroes().
> 
> Fix the issue by handling single max discard segment in straightforward
> way.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Changpeng Liu <changpeng.liu@intel.com>
> Cc: Daniel Verkamp <dverkamp@chromium.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 63b213e00b37..b2e48dac1ebd 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -126,16 +126,31 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
>  	if (!range)
>  		return -ENOMEM;
>  
> -	__rq_for_each_bio(bio, req) {
> -		u64 sector = bio->bi_iter.bi_sector;
> -		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> -
> -		range[n].flags = cpu_to_le32(flags);
> -		range[n].num_sectors = cpu_to_le32(num_sectors);
> -		range[n].sector = cpu_to_le64(sector);
> -		n++;
> +	/*
> +	 * Single max discard segment means multi-range discard isn't
> +	 * supported, and block layer only runs contiguity merge like
> +	 * normal RW request. So we can't reply on bio for retrieving
> +	 * each range info.
> +	 */
> +	if (queue_max_discard_segments(req->q) == 1) {
> +		range[0].flags = cpu_to_le32(flags);
> +		range[0].num_sectors = cpu_to_le32(blk_rq_sectors(req));
> +		range[0].sector = cpu_to_le64(blk_rq_pos(req));
> +		n = 1;
> +	} else {
> +		__rq_for_each_bio(bio, req) {
> +			u64 sector = bio->bi_iter.bi_sector;
> +			u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +			range[n].flags = cpu_to_le32(flags);
> +			range[n].num_sectors = cpu_to_le32(num_sectors);
> +			range[n].sector = cpu_to_le64(sector);
> +			n++;
> +		}
>  	}
>  
> +	WARN_ON_ONCE(n != segments);

I wonder should we return an error if the discard segments are
incorrect like NVMe did[1]? In case the DMA may do some serious
damages in this case.

[1]
https://elixir.bootlin.com/linux/v5.8-rc7/source/drivers/nvme/host/core.c#L638

> +
>  	req->special_vec.bv_page = virt_to_page(range);
>  	req->special_vec.bv_offset = offset_in_page(range);
>  	req->special_vec.bv_len = sizeof(*range) * segments;
> -- 
> 2.25.2
