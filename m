Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80DC433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 19:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiGETxj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 15:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiGETxi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 15:53:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22011A17
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 12:53:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r6so5226189edd.7
        for <linux-block@vger.kernel.org>; Tue, 05 Jul 2022 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0xAwEaStkU+axb2ZdBUdBf3ykJLZb84i5B5Tkao/8pg=;
        b=uza4t9IUXqMnw3lsyjPrEcSGOgarBIw06ULNZfkTt/dn+f0ghmQJiYDn1B4kpklGg9
         nMlhE6BtCVuMdofiEnrcp4NaGzbrCovri4BBmwQuqx4DNJVpubF54J12voVkITjDCrpQ
         2ENmWI+4YUtqEBQVGX7XYB9H+pAqUBg32BpSa7geMtL4wU5/KtBM6RikxMikEfJY4bz8
         jae/4rXI+NwU6uX4oAgTl0bHxbl3gj9lacRWOkN34dvUdewbhYqjk8Mz89yUHqKGSe/+
         VpoKe4ir79Qx1CwbgTcQLylK3GmWUfPVsBEPoZz3JXpAvGBGzg1N0PGoGZEp6O7T9LLE
         Pwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0xAwEaStkU+axb2ZdBUdBf3ykJLZb84i5B5Tkao/8pg=;
        b=gfrIhKkX6VcuiW3RfSrJd+sDaTNbY2/Mi53sdzkgFOtqctCVbTZ/6uqq94dWKnMNxI
         aQ6T7CZNguErGC8jAbwmzYVw4A+NiYZy4f+noTHIEFgG8pV71qaeuDxErgS94k+CBlhY
         KKocmyiOAD1C50Vl8tGuLk8tAzd/GKWPJoseNaJ05cx2n/x/HasOx87W8M0UCYcxR2/3
         ORZ4FBwVfzySne439goWzvXPGFYDq+fl5c7owvg1UwTZ1Jeyg2v4JlKe2NVGtJCF6UyY
         y+vSg7z6q3g54quCMkPlFGvz6darEB8sWl68pycpiqL9DSlAB1HP1SMW+2lK1JueLEcU
         AxAQ==
X-Gm-Message-State: AJIora8TkzxNSWUa2saVyj53rdi36SLlMLWwA4erMBQGebTFkNrcILmh
        qMrm3UPgLR0/8YM24cFPb6ycwN0kH8jwUHmrJCs=
X-Google-Smtp-Source: AGRyM1ut0FwMD2EXaPaqyur8FO9eqqXfuxuGcHHkGcNn4ecBsIRCzddclnJwttgmYYzJV+ViRRtf5Q==
X-Received: by 2002:a05:6402:1e92:b0:43a:7cd0:6bed with SMTP id f18-20020a0564021e9200b0043a7cd06bedmr4535575edf.423.1657050814772;
        Tue, 05 Jul 2022 12:53:34 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id en20-20020a056402529400b0043a6a7048absm4589196edb.95.2022.07.05.12.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 12:53:34 -0700 (PDT)
Message-ID: <e542e153-76bd-1c6a-23c1-2640ddecc491@linbit.com>
Date:   Tue, 5 Jul 2022 21:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 14/63] block/drbd: Combine two
 drbd_submit_peer_request() arguments
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-15-bvanassche@acm.org>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220629233145.2779494-15-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 30.06.22 um 01:30 schrieb Bart Van Assche:
> Combine the drbd_submit_peer_request() 'op' and 'op_flags' arguments
> into a single argument. This patch does not change any functionality.
> 
> Cc: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/drbd/drbd_int.h      |  3 +--
>  drivers/block/drbd/drbd_receiver.c | 15 +++++++--------
>  drivers/block/drbd/drbd_worker.c   |  2 +-
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index ecb2ecd8d67d..f15f2f041596 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -1547,8 +1547,7 @@ extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
>  extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
>  		bool throttle_if_app_is_waiting);
>  extern int drbd_submit_peer_request(struct drbd_device *,
> -				    struct drbd_peer_request *, enum req_op,
> -				    blk_opf_t, int);
> +				    struct drbd_peer_request *, blk_opf_t, int);
>  extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
>  extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *, u64,
>  						     sector_t, unsigned int,
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index caf646dd91ba..af4c7d65490b 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -1621,8 +1621,7 @@ static void drbd_issue_peer_discard_or_zero_out(struct drbd_device *device, stru
>  /* TODO allocate from our own bio_set. */
>  int drbd_submit_peer_request(struct drbd_device *device,
>  			     struct drbd_peer_request *peer_req,
> -			     const enum req_op op, const blk_opf_t op_flags,
> -			     const int fault_type)
> +			     const blk_opf_t opf, const int fault_type)
>  {
>  	struct bio *bios = NULL;
>  	struct bio *bio;
> @@ -1668,8 +1667,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
>  	 * generated bio, but a bio allocated on behalf of the peer.
>  	 */
>  next_bio:
> -	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, op | op_flags,
> -			GFP_NOIO);
> +	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, opf, GFP_NOIO);
>  	/* > peer_req->i.sector, unless this is the first bio */
>  	bio->bi_iter.bi_sector = sector;
>  	bio->bi_private = peer_req;
> @@ -2060,7 +2058,7 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
>  	spin_unlock_irq(&device->resource->req_lock);
>  
>  	atomic_add(pi->size >> 9, &device->rs_sect_ev);
> -	if (drbd_submit_peer_request(device, peer_req, REQ_OP_WRITE, 0,
> +	if (drbd_submit_peer_request(device, peer_req, REQ_OP_WRITE,
>  				     DRBD_FAULT_RS_WR) == 0)
>  		return 0;
>  
> @@ -2682,7 +2680,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
>  		peer_req->flags |= EE_CALL_AL_COMPLETE_IO;
>  	}
>  
> -	err = drbd_submit_peer_request(device, peer_req, op, op_flags,
> +	err = drbd_submit_peer_request(device, peer_req, op | op_flags,
>  				       DRBD_FAULT_DT_WR);
>  	if (!err)
>  		return 0;
> @@ -2980,7 +2978,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
>  submit:
>  	update_receiver_timing_details(connection, drbd_submit_peer_request);
>  	inc_unacked(device);
> -	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ, 0,
> +	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ,
>  				     fault_type) == 0)
>  		return 0;
>  
> @@ -4970,7 +4968,8 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
>  		spin_unlock_irq(&device->resource->req_lock);
>  
>  		atomic_add(pi->size >> 9, &device->rs_sect_ev);
> -		err = drbd_submit_peer_request(device, peer_req, op, 0, DRBD_FAULT_RS_WR);
> +		err = drbd_submit_peer_request(device, peer_req, op,
> +					       DRBD_FAULT_RS_WR);
>  
>  		if (err) {
>  			spin_lock_irq(&device->resource->req_lock);
> diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
> index af3051dd8912..0bb1a900c2d5 100644
> --- a/drivers/block/drbd/drbd_worker.c
> +++ b/drivers/block/drbd/drbd_worker.c
> @@ -405,7 +405,7 @@ static int read_for_csum(struct drbd_peer_device *peer_device, sector_t sector,
>  	spin_unlock_irq(&device->resource->req_lock);
>  
>  	atomic_add(size >> 9, &device->rs_sect_ev);
> -	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ, 0,
> +	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ,
>  				     DRBD_FAULT_RS_RD) == 0)
>  		return 0;
>  

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Thanks!

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
