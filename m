Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1870C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 05:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiFXFAn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFXFAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:00:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8889847AEB
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:00:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so867115wme.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dE7giFeyhHNkLOYJReNIHevUqjR40Z4ByEmstmyJYc8=;
        b=JIyNlzMa6pfsukyHHO2zc6YQhlBU4YaJpA5e1XBG4yU3zg8esjf6L3IWPbvQ1N0ZcY
         xyODKN0fYXQEy/G83cVqijou6xy0nnzBfVqU53NFRyHDU01LpMQIK4XTj2MMcmHzuel7
         ZMQDsiKo0ieLZwuhdkss16LgqqVavoPXgt/MYPrz33mphLevM8tJspJn5350I8y0GXpU
         J/GhTvuSwtfa4d7Wm78zCDJN6zqw14qkfeLuV0UEwzT295bMNNOTxMxc1q03w7liOn5K
         F5Yrhw23U5CcZnVKGPE6liX4cH2cgLDm9cfMZwUe9IgYb0OB/nmHTb/amETuiAUsl+Bw
         0yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dE7giFeyhHNkLOYJReNIHevUqjR40Z4ByEmstmyJYc8=;
        b=v+Q4GUc60CYXhlo2cxug/NzUCglbWoQ4vDlwggxgcXSgcviE7iRHXTVEsagugIGvbt
         FSt89dNihTAgX0Jh0T0Z9A1AuBOKYxl4yjwYZzA89Y8NjCWxoYzaZgImKhXPyWz/OPLp
         SZLghvS4xvfTO61x2BmqdpIIZTwk1LCHkj7WTqDXj7bYIzH9kldKpZKOyMdU+mCwkwkB
         E7MShkhaXcs4mNoCAestjiRUdRE4KAmJ5VyU6KblmKGYY5yocaRZRjJwCDXcTJ5bdmX4
         vMwH+JloRz5gICgs2AnyCcnNcoiZuNj2nrDJ/DiQoMBEM4h/ACubn5zUEQ6fITjrQWF7
         eeXg==
X-Gm-Message-State: AJIora+jerSte7dIMTtOP35xSE91nM72J7nxJSlpVQZImuJc30AULEf6
        xllnx0E5nCh0Ueu4oDdcF6UYATiCSoWRmSxTnTA=
X-Google-Smtp-Source: AGRyM1tN03T2qt8QeoIF/qm/bUO3MHUSLS+PMOOfG3YSPoSZmhQBAIIPYmP5qw14oUrtVylR0boXAA==
X-Received: by 2002:a05:600c:2194:b0:39c:419c:1a24 with SMTP id e20-20020a05600c219400b0039c419c1a24mr1489867wme.186.1656046840038;
        Thu, 23 Jun 2022 22:00:40 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c268b00b003a03a8475bfsm1208311wmt.16.2022.06.23.22.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 22:00:39 -0700 (PDT)
Message-ID: <7ada3553-b4a5-5f15-66d5-141a5d5cde83@linbit.com>
Date:   Fri, 24 Jun 2022 07:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 10/51] block/drbd: Use the enum req_op and blk_opf_t types
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-11-bvanassche@acm.org>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220623180528.3595304-11-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 23.06.22 um 20:04 schrieb Bart Van Assche:
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags.
> 
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/drbd/drbd_actlog.c   |  9 +++++----
>  drivers/block/drbd/drbd_bitmap.c   |  3 ++-
>  drivers/block/drbd/drbd_int.h      |  6 +++---
>  drivers/block/drbd/drbd_receiver.c | 11 ++++++-----
>  4 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
> index f5bcded3640d..e27478ae579c 100644
> --- a/drivers/block/drbd/drbd_actlog.c
> +++ b/drivers/block/drbd/drbd_actlog.c
> @@ -124,12 +124,13 @@ void wait_until_done_or_force_detached(struct drbd_device *device, struct drbd_b
>  
>  static int _drbd_md_sync_page_io(struct drbd_device *device,
>  				 struct drbd_backing_dev *bdev,
> -				 sector_t sector, int op)
> +				 sector_t sector, enum req_op op)
>  {
>  	struct bio *bio;
>  	/* we do all our meta data IO in aligned 4k blocks. */
>  	const int size = 4096;
> -	int err, op_flags = 0;
> +	int err;
> +	blk_opf_t op_flags = 0;
>  
>  	device->md_io.done = 0;
>  	device->md_io.error = -ENODEV;
> @@ -174,7 +175,7 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
>  }
>  
>  int drbd_md_sync_page_io(struct drbd_device *device, struct drbd_backing_dev *bdev,
> -			 sector_t sector, int op)
> +			 sector_t sector, enum req_op op)
>  {
>  	int err;
>  	D_ASSERT(device, atomic_read(&device->md_io.in_use) == 1);
> @@ -385,7 +386,7 @@ static int __al_write_transaction(struct drbd_device *device, struct al_transact
>  		write_al_updates = rcu_dereference(device->ldev->disk_conf)->al_updates;
>  		rcu_read_unlock();
>  		if (write_al_updates) {
> -			if (drbd_md_sync_page_io(device, device->ldev, sector, WRITE)) {
> +			if (drbd_md_sync_page_io(device, device->ldev, sector, REQ_OP_WRITE)) {
>  				err = -EIO;
>  				drbd_chk_io_error(device, 1, DRBD_META_IO_ERROR);
>  			} else {
> diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
> index bd2133ef6e0a..0845f28a48a7 100644
> --- a/drivers/block/drbd/drbd_bitmap.c
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -990,7 +990,8 @@ static inline sector_t drbd_md_last_bitmap_sector(struct drbd_backing_dev *bdev)
>  static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
>  {
>  	struct drbd_device *device = ctx->device;
> -	unsigned int op = (ctx->flags & BM_AIO_READ) ? REQ_OP_READ : REQ_OP_WRITE;
> +	const enum req_op op = ctx->flags & BM_AIO_READ ? REQ_OP_READ :
> +		REQ_OP_WRITE;
>  	struct drbd_bitmap *b = device->bitmap;
>  	struct bio *bio;
>  	struct page *page;
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index 4d3efaa20b7b..ecb2ecd8d67d 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -1495,7 +1495,7 @@ extern int drbd_resync_finished(struct drbd_device *device);
>  extern void *drbd_md_get_buffer(struct drbd_device *device, const char *intent);
>  extern void drbd_md_put_buffer(struct drbd_device *device);
>  extern int drbd_md_sync_page_io(struct drbd_device *device,
> -		struct drbd_backing_dev *bdev, sector_t sector, int op);
> +		struct drbd_backing_dev *bdev, sector_t sector, enum req_op op);
>  extern void drbd_ov_out_of_sync_found(struct drbd_device *, sector_t, int);
>  extern void wait_until_done_or_force_detached(struct drbd_device *device,
>  		struct drbd_backing_dev *bdev, unsigned int *done);
> @@ -1547,8 +1547,8 @@ extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
>  extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
>  		bool throttle_if_app_is_waiting);
>  extern int drbd_submit_peer_request(struct drbd_device *,
> -				    struct drbd_peer_request *, const unsigned,
> -				    const unsigned, const int);
> +				    struct drbd_peer_request *, enum req_op,
> +				    blk_opf_t, int);
>  extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
>  extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *, u64,
>  						     sector_t, unsigned int,
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 6762be53f409..caf646dd91ba 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -1621,7 +1621,7 @@ static void drbd_issue_peer_discard_or_zero_out(struct drbd_device *device, stru
>  /* TODO allocate from our own bio_set. */
>  int drbd_submit_peer_request(struct drbd_device *device,
>  			     struct drbd_peer_request *peer_req,
> -			     const unsigned op, const unsigned op_flags,
> +			     const enum req_op op, const blk_opf_t op_flags,
>  			     const int fault_type)
>  {
>  	struct bio *bios = NULL;
> @@ -2383,14 +2383,14 @@ static int wait_for_and_update_peer_seq(struct drbd_peer_device *peer_device, co
>  /* see also bio_flags_to_wire()
>   * DRBD_REQ_*, because we need to semantically map the flags to data packet
>   * flags and back. We may replicate to other kernel versions. */
> -static unsigned long wire_flags_to_bio_flags(u32 dpf)
> +static blk_opf_t wire_flags_to_bio_flags(u32 dpf)
>  {
>  	return  (dpf & DP_RW_SYNC ? REQ_SYNC : 0) |
>  		(dpf & DP_FUA ? REQ_FUA : 0) |
>  		(dpf & DP_FLUSH ? REQ_PREFLUSH : 0);
>  }
>  
> -static unsigned long wire_flags_to_bio_op(u32 dpf)
> +static enum req_op wire_flags_to_bio_op(u32 dpf)
>  {
>  	if (dpf & DP_ZEROES)
>  		return REQ_OP_WRITE_ZEROES;
> @@ -2543,7 +2543,8 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
>  	struct drbd_peer_request *peer_req;
>  	struct p_data *p = pi->data;
>  	u32 peer_seq = be32_to_cpu(p->seq_num);
> -	int op, op_flags;
> +	enum req_op op;
> +	blk_opf_t op_flags;
>  	u32 dp_flags;
>  	int err, tp;
>  
> @@ -4951,7 +4952,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
>  
>  	if (get_ldev(device)) {
>  		struct drbd_peer_request *peer_req;
> -		const int op = REQ_OP_WRITE_ZEROES;
> +		const enum req_op op = REQ_OP_WRITE_ZEROES;
>  
>  		peer_req = drbd_alloc_peer_req(peer_device, ID_SYNCER, sector,
>  					       size, 0, GFP_NOIO);

LGTM, thanks.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
