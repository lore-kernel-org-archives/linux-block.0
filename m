Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D506C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 05:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1BB2231F
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 05:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbhARF1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 00:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbhARF1Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 00:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610947557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpA/2lzEvO8o3CZnJ/P9NlQ95nOpAYmzv3dugnKebyQ=;
        b=cMZsimiEr4Nrtb4d/7yAokDVS3xy69BQEAkKMIWjU8PPQXflCukA7K686+bYfGRHWtceRs
        XgXMtAf52EqiRXxRgdxQ5Wjo5VHqrP/DfQX8tHoGxSk9g0pkNhiMCVfrYYS924eMwD6MkO
        hNrrIcBkPefQT2l3YcbL38KulE8hYhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-ANpXt0OaPciHHPNmoIbdLw-1; Mon, 18 Jan 2021 00:25:53 -0500
X-MC-Unique: ANpXt0OaPciHHPNmoIbdLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C710A180A098;
        Mon, 18 Jan 2021 05:25:51 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B84C5D72E;
        Mon, 18 Jan 2021 05:25:46 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
Date:   Mon, 18 Jan 2021 13:25:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2021/1/18 上午11:58, Joseph Qi wrote:
> module parameter 'virtblk_queue_depth' was firstly introduced for
> testing/benchmarking purposes described in commit fc4324b4597c
> ("virtio-blk: base queue-depth on virtqueue ringsize or module param").
> Since we have different virtio-blk devices which have different
> capabilities, it requires that we support per-device queue depth instead
> of per-module. So defaultly use vq free elements if module parameter
> 'virtblk_queue_depth' is not set.


I wonder if it's better to use sysfs instead (or whether it has already 
had something like this in the blocker layer).

Thanks


>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>   drivers/block/virtio_blk.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 145606d..f83a417 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -705,6 +705,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	u32 v, blk_size, max_size, sg_elems, opt_io_size;
>   	u16 min_io_size;
>   	u8 physical_block_exp, alignment_offset;
> +	unsigned int queue_depth;
>   
>   	if (!vdev->config->get) {
>   		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> @@ -755,17 +756,18 @@ static int virtblk_probe(struct virtio_device *vdev)
>   		goto out_free_vq;
>   	}
>   
> -	/* Default queue sizing is to fill the ring. */
> -	if (!virtblk_queue_depth) {
> -		virtblk_queue_depth = vblk->vqs[0].vq->num_free;
> +	if (likely(!virtblk_queue_depth)) {
> +		queue_depth = vblk->vqs[0].vq->num_free;
>   		/* ... but without indirect descs, we use 2 descs per req */
>   		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
> -			virtblk_queue_depth /= 2;
> +			queue_depth /= 2;
> +	} else {
> +		queue_depth = virtblk_queue_depth;
>   	}
>   
>   	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
>   	vblk->tag_set.ops = &virtio_mq_ops;
> -	vblk->tag_set.queue_depth = virtblk_queue_depth;
> +	vblk->tag_set.queue_depth = queue_depth;
>   	vblk->tag_set.numa_node = NUMA_NO_NODE;
>   	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>   	vblk->tag_set.cmd_size =

