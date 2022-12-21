Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA04C4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 19:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiLUTQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 14:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiLUTQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 14:16:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC282651
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 11:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671650165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oziG1chFC2ZM07+R9uNqeu7rPi/qIDF9DD7uMEf+XEc=;
        b=Gk2i+C+UEpmi7IYJ3q5OkY5LuaeqqzYELOGrqRgB1nb4MU5IouTV0huyZmgIfpuLwXOdg9
        JyIs+x3FPKfX0nP85YxNluckHcUnDSgS8J06RNbA4HBnm/1sqXMdhbhoUDVaXjlkTW4LDV
        lq8ayAOWsDLAi8MuoZuMVgJBCWDUMBc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-160-dl5A2mF5OQioxyYWp0KFQg-1; Wed, 21 Dec 2022 14:16:03 -0500
X-MC-Unique: dl5A2mF5OQioxyYWp0KFQg-1
Received: by mail-ed1-f72.google.com with SMTP id w20-20020a056402269400b004700a51c202so12030644edd.13
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 11:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oziG1chFC2ZM07+R9uNqeu7rPi/qIDF9DD7uMEf+XEc=;
        b=sFarb46AwpCladXpU4ZikIQhrqXTEBY/hZKd5Gzryozka9FS2Z0GSX0hsfDaxW9Z+L
         chcz+6fmK5OEXpfA/2fxmHwn/iBlr8t1W9+dbihsHiGD87e7+sGWZVorbVS8y6j/RUAd
         Oso9k37vq5AHSndWDuO9ll/B8RUdtOo9QWGgdGR9d2v2ghLHZBDsJtXZKQ0jeh02j8QM
         fSVoTcA4073vyZCTYjeRV31oHVZOcl+2PoiTIv6UEO+KtPKGk40SBjVPHrKzO6bW8kot
         jYVdVMk9oIdDB2t4Aftw20dBuWtz4KHiqGCsTkkCNl9QeZ12AaUk/mlpNlIfCODt/55V
         I6cA==
X-Gm-Message-State: AFqh2kolpITpXcwT0OPaPjo4yhY39o3Nb87+pTNJNSZBP8/jdL7qza6a
        Eae6Tl5nXPwywInGssUqPJrP2O5Hxztn063u/vuPrnfJDFlgt6LiGGO4vGqenAWzOXVhI1evQ8i
        X9gkC1couiUtxhrfoDCrGw2A=
X-Received: by 2002:a17:906:2b16:b0:81b:f931:cb08 with SMTP id a22-20020a1709062b1600b0081bf931cb08mr6654972ejg.47.1671650162802;
        Wed, 21 Dec 2022 11:16:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtYgpQRoajpgpg88+32ygzHFWgzyaQ5djHehL3dJahxgz4ZK1NR86JbdFjj+nGQkHTx6xrXhg==
X-Received: by 2002:a17:906:2b16:b0:81b:f931:cb08 with SMTP id a22-20020a1709062b1600b0081bf931cb08mr6654959ejg.47.1671650162588;
        Wed, 21 Dec 2022 11:16:02 -0800 (PST)
Received: from redhat.com ([2.55.175.215])
        by smtp.gmail.com with ESMTPSA id mh11-20020a170906eb8b00b007ad69e9d34dsm7460122ejb.54.2022.12.21.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:16:01 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:15:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-block@vger.kernel.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] virtio-blk: avoid kernel panic on VIRTIO_BLK_F_ZONED
 check
Message-ID: <20221221141451-mutt-send-email-mst@kernel.org>
References: <20221221145433.254805-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221145433.254805-1-lstoakes@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 21, 2022 at 02:54:33PM +0000, Lorenzo Stoakes wrote:
> virtio zoned block device support is added by commit 0562d7bf1604
> ("virtio-blk: add support for zoned block devices") which adds
> VIRTIO_BLK_F_ZONED to the features array in virtio_blk.c but makes it
> conditional on CONFIG_BLK_DEV_ZONED.
> 
> In it virtblk_probe() calls virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)
> unconditionally, which invokes virtio_check_driver_offered_feature().
> This function checks whether virtio_blk.feature_table (assigned to
> the static features array) contains the specified feature enum, and if not
> _causes a kernel panic_ via BUG().
> 
> This therefore means that failing to enable CONFIG_BLK_DEV_ZONED while
> using virtio is a guaranteed kernel panic. Fix the issue by making the
> feature test also conditional on CONFIG_BLK_DEV_ZONED.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

I think this was fixed by
Message-ID: <20221220112340.518841-1-mst@redhat.com>


> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ff49052e26f7..94d210b10ebb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1580,7 +1580,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
>  		err = virtblk_probe_zoned_device(vdev, vblk, q);
>  		if (err)
>  			goto out_cleanup_disk;
> -- 
> 2.39.0

