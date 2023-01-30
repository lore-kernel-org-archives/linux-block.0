Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA55C61DA4
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 15:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjA3PTd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbjA3PT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 10:19:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9FF367EF
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 07:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675091889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=URESPY8B3rO6+zudqQ9a2I8Kc4P4ekxUO74igKr3Ygk=;
        b=gpcV+JebEH3FdRHLGZWy6Wnr/wRuhAKB5C59rq8LzM1KiYSyOCND0GwPcz3t5CHsfSUStx
        Ou3wh23NrsG/ayl8KD0tfbYKQTpEQRLUUu1BENsfbsS4R/BOlJc8zmfsPTzmqjHCbpOtU5
        fSBXg7PyyMJczwvorlyUE4iWEwJkOsU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-psD7d1IjNj2P42ktF2JvFw-1; Mon, 30 Jan 2023 10:18:07 -0500
X-MC-Unique: psD7d1IjNj2P42ktF2JvFw-1
Received: by mail-wm1-f72.google.com with SMTP id e38-20020a05600c4ba600b003dc434dabbdso4960569wmp.6
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 07:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URESPY8B3rO6+zudqQ9a2I8Kc4P4ekxUO74igKr3Ygk=;
        b=HfqyG5LBd6OgzVc5rnvmTMNn/SinzPvf0tgLn6rLF0HLsYIbBnOrIyfb/Wh8h1qp1J
         Rqwe8HrtQfgV80J2015embLXs66m9rTCYOfRzYkDQOJTpG7OfSb7+ECnFP16XNGrodTh
         ILT9w1V35JmZYdOtMlLMmEb4Kmv+IPiyTdUMV+cgnwGtzaho4hb1TRyP3QImgWGD4T7k
         X5sDfVI1VT4F/yzDITzmy5/RQ3TeSDJrKtgM5UEZO66WK0rk1bfMTjhKA+3W1BStdgWy
         KoFEmvf0K8so29FEA8G2WPQ3OnsRFEIAPlR1Ut6D+kUKHEDOxvekSlsY1OgSfzyuKLjV
         tDNA==
X-Gm-Message-State: AO0yUKV5AhxiFhEQzN2leQFTErCB9GKT0DzyYKRkt7erXPhh5fILFrUR
        71XsvSosGCVhvAjHRuszwUopxyYRAS+Iz96ZRaJc13F+SDffnP/8Um5vtoaq/33BQQ1888goSYj
        QTj8JhomRX39vbYTn0NPE/6c=
X-Received: by 2002:a05:6000:1105:b0:2bf:b77c:df72 with SMTP id z5-20020a056000110500b002bfb77cdf72mr16512197wrw.25.1675091885643;
        Mon, 30 Jan 2023 07:18:05 -0800 (PST)
X-Google-Smtp-Source: AK7set9hHGYe0bnBQdwa2LZ/rAVCRbopEtGk+crtv3OHnMIQTfwimU+PtBLrc1/FzlqOKTq9Gtug2w==
X-Received: by 2002:a05:6000:1105:b0:2bf:b77c:df72 with SMTP id z5-20020a056000110500b002bfb77cdf72mr16512171wrw.25.1675091885371;
        Mon, 30 Jan 2023 07:18:05 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b002bfc0558ecdsm11985935wrs.113.2023.01.30.07.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:18:04 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:17:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/23] virtio_blk: use bvec_set_virt to initialize
 special_vec
Message-ID: <20230130101747-mutt-send-email-mst@kernel.org>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130092157.1759539-10-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 30, 2023 at 10:21:43AM +0100, Christoph Hellwig wrote:
> Use the bvec_set_virt helper to initialize the special_vec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/block/virtio_blk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6a77fa91742880..dc6e9b989910b0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -170,9 +170,7 @@ static int virtblk_setup_discard_write_zeroes_erase(struct request *req, bool un
>  
>  	WARN_ON_ONCE(n != segments);
>  
> -	req->special_vec.bv_page = virt_to_page(range);
> -	req->special_vec.bv_offset = offset_in_page(range);
> -	req->special_vec.bv_len = sizeof(*range) * segments;
> +	bvec_set_virt(&req->special_vec, range, sizeof(*range) * segments);
>  	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
>  
>  	return 0;
> -- 
> 2.39.0

