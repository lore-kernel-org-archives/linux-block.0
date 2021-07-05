Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7832FC07E9C
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596276196A
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 18:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGES0W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 14:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhGES0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 14:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625509422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCWQjAFUA2BpSsozjj9zvvBC2+nor9udd0yMEx7PyTM=;
        b=BVu46fB++aju2c9VQIauRaHY7Ejjw5dpg+VTxvd2OPj9TLuSTvZEqoV07/IKh+CaoTYENF
        SQrwrHTAu4rcCFtob15FPXPybrjzpTGXP7My2sivmu3jCSlROwwWPPqWAIh2Adx0rPgLQH
        Oc/scEj6BuHxqFS79EO5uhdjh0N2kCY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-cA5SI2XPMHCL6EPNpZ-rkw-1; Mon, 05 Jul 2021 14:23:41 -0400
X-MC-Unique: cA5SI2XPMHCL6EPNpZ-rkw-1
Received: by mail-ed1-f70.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so9449568edu.17
        for <linux-block@vger.kernel.org>; Mon, 05 Jul 2021 11:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCWQjAFUA2BpSsozjj9zvvBC2+nor9udd0yMEx7PyTM=;
        b=KvtuBFjrOqt/Dv8gIotH4x97KORe9+xbyjwNou6Sdw7WsPNuFaSX0OaehwzTJ8/5JE
         F1AiTuVUET3AvHRmA2cDn3rwDE5Dlx0wPGUJXEOz0AcB9Dm9asw7uCRGO2nkWwMobu8H
         iDqiOZEOMw3p78PjorTa7Y691S6P01neZUuW84SolGhw712NUx79E3xq1Y2wChY1zpD0
         DsnhO9EzKlcUeHMxX9YkgxEy5Rru3VuC8Sdlw3j57vGLIahVruziTpnHvZ+fQCLaxTV4
         y9SU9BoeryoSJQRzNtHBPw3e/Dl8ddMvE8tscKVmFv9RpTDNo2pUD87PbMSY7AFi98D7
         PzBg==
X-Gm-Message-State: AOAM531NWAvZeLOUkqk4R0J1xl/aNbwXtFz9NUp6MVy2aUpAtu9AwztZ
        M5WMVo7S83UBpIfYdn0F7cFzCgxPc/ZrBoPkyWHkqgx+DeysU58LkqBX+mkSMcVBQGpTDH18JQV
        Yhf3jsdcvmBbS0rH9icLTIPE=
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr14311597eji.47.1625509419374;
        Mon, 05 Jul 2021 11:23:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQS4wuLCqaKViLE93+pqaz97jm1sQ2e86PaWYpUSAAiXhdUO+usQj5ixIO1UPy4slH/t7QDA==
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr14311583eji.47.1625509419191;
        Mon, 05 Jul 2021 11:23:39 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
        by smtp.gmail.com with ESMTPSA id z10sm5701020edc.28.2021.07.05.11.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 11:23:38 -0700 (PDT)
Date:   Mon, 5 Jul 2021 14:23:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, jasowang@redhat.com,
        axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210705141023-mutt-send-email-mst@kernel.org>
References: <20210617051004.146-1-xieyongji@bytedance.com>
 <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 11:11:06AM +0100, Stefan Hajnoczi wrote:
> On Thu, Jun 17, 2021 at 01:10:04PM +0800, Xie Yongji wrote:
> > This ensures that we will not use an invalid block size
> > in config space (might come from an untrusted device).
> > 
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/block/virtio_blk.c | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index b9fa3ef5b57c..bbdae989f1ea 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -696,6 +696,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >  
> > +static int virtblk_validate(struct virtio_device *vdev)
> > +{
> > +	u32 blk_size;
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > +		return 0;
> > +
> > +	blk_size = virtio_cread32(vdev,
> > +			offsetof(struct virtio_blk_config, blk_size));
> > +
> > +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > +
> > +	return 0;
> > +}
> 
> I saw Michael asked for .validate() in v2. I would prefer to keep
> everything in virtblk_probe() instead of adding .validate() because:
> 
> - There is a race condition that an untrusted device can exploit since
>   virtblk_probe() fetches the value again.
> 
> - It's more complex now that .validate() takes a first shot at blk_size
>   and then virtblk_probe() deals with it again later on.

This is a valid concern.
But, silently ignoring what hypervisor told us to do is also ungood.
Let's save it somewhere then.
And there are more examples like this, e.g. the virtio net mtu.

So if we worry about this stuff, let's do something along the lines of

(note: incomplete, won't build: you need to update all drivers).
----


virtio: allow passing config data from validate callback

To avoid time of check to time of use races on config changes,
pass config data from validate callback to probe.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..d3657a0127d7 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -211,6 +211,7 @@ static int virtio_dev_probe(struct device *_d)
 	u64 device_features;
 	u64 driver_features;
 	u64 driver_features_legacy;
+	void *config = NULL;
 
 	/* We have a driver! */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
@@ -249,18 +250,20 @@ static int virtio_dev_probe(struct device *_d)
 			__virtio_set_bit(dev, i);
 
 	if (drv->validate) {
-		err = drv->validate(dev);
-		if (err)
+		config = drv->validate(dev);
+		if (IS_ERR(config)) {
+			err = PTR_ERR(config);
 			goto err;
+		}
 	}
 
 	err = virtio_finalize_features(dev);
 	if (err)
 		goto err;
 
-	err = drv->probe(dev);
+	err = drv->probe(dev, config);
 	if (err)
-		goto err;
+		goto probe;
 
 	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
 	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
@@ -269,9 +272,12 @@ static int virtio_dev_probe(struct device *_d)
 	if (drv->scan)
 		drv->scan(dev);
 
+	kfree(config);
 	virtio_config_enable(dev);
 
 	return 0;
+probe:
+	kfree(config);
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return err;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b1894e0323fa..90750567c0cc 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -151,6 +151,8 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
  * @feature_table_size: number of entries in the feature table array.
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
+ * @validate: the function to validate feature bits and config.
+ * 		 Returns a valid config or NULL to be passed to probe or ERR_PTR(-errno).
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @scan: optional function to call after successful probe; intended
  *    for virtio-scsi to invoke a scan.
@@ -167,8 +169,8 @@ struct virtio_driver {
 	unsigned int feature_table_size;
 	const unsigned int *feature_table_legacy;
 	unsigned int feature_table_size_legacy;
-	int (*validate)(struct virtio_device *dev);
-	int (*probe)(struct virtio_device *dev);
+	void *(*validate)(struct virtio_device *dev);
+	int (*probe)(struct virtio_device *dev, void *config);
 	void (*scan)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
 	void (*config_changed)(struct virtio_device *dev);
-- 
MST

