Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E71C19F2D
	for <linux-block@archiver.kernel.org>; Tue,  9 Aug 2022 13:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbiHINC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbiHINC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 09:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BACB859
        for <linux-block@vger.kernel.org>; Tue,  9 Aug 2022 06:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B1B61117
        for <linux-block@vger.kernel.org>; Tue,  9 Aug 2022 13:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65FAC433C1;
        Tue,  9 Aug 2022 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660050145;
        bh=Yw4Di37FqyNkoY1xqNQsXPHIJtZc4RDqI2knJ5ioIA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liUEHt+dRBhvA2N+lhx1ztMhnU7nAHzEao9LmeohkH6HOiNJTYvpvCrRNsZ9xM19v
         And5wID18tCsliR4ggtetVZzm/Rjd8BhLIT0XlmFHL52el56tQkovIHLJD5tiDWDgb
         Bu5KcYcVifWx4BxEoDuEsdpHGsqdPhcspnqSylzruX4wJ8ifPBXzijQaVOn88RPVHL
         IJR2sb8OU0lichKoFZyEDG20k4osLWRIPxgXlW1oxa6LA73mpk4ABxxLWar1xOPi89
         6J9iEYzWNnfwGDLOOaP/+Sie0gkx4GYwHnK1Gqc1smEpr6CZWgTX/Rw80eXkFMO64g
         ZQsFmr6oPBgQA==
Date:   Tue, 9 Aug 2022 15:02:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     luca.boccassi@gmail.com
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        sbauer@plzdonthack.me, Jonathan.Derrick@solidigmtechnology.com,
        dougmill@linux.vnet.ibm.com, gmazyland@gmail.com
Subject: Re: [PATCH v4] block: sed-opal: Add ioctl to return device status
Message-ID: <20220809130220.64a5npyiaa6zahd5@wittgenstein>
References: <20220805225522.124199-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805225522.124199-1-luca.boccassi@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 05, 2022 at 11:55:22PM +0100, luca.boccassi@gmail.com wrote:
> From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> 
> Provide a mechanism to retrieve basic status information about
> the device, including the "supported" flag indicating whether
> SED-OPAL is supported. The information returned is from the various
> feature descriptors received during the discovery0 step, and so
> this ioctl does nothing more than perform the discovery0 step
> and then save the information received. See "struct opal_status"
> and OPAL_FL_* bits for the status information currently returned.
> 
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> ---

No expert in this area but I think this looks straightforward overall.
But could you expand on the use-case a bit in the commit message.
I have a tiny suggestion/questions below other than that seems like
useful info to expose.

> v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> v3: resend on request, after rebasing and testing on my machine
>     https://patchwork.kernel.org/project/linux-block/patch/20220125215248.6489-1-luca.boccassi@gmail.com/
> v4: it's been more than 7 months and no alternative approach has appeared.
>     we really need to be able to identify and query the status of a sed-opal
>     device, so rebased and resending.
> 
>  block/opal_proto.h            |  5 ++
>  block/sed-opal.c              | 90 ++++++++++++++++++++++++++++++-----
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h | 12 +++++
>  4 files changed, 96 insertions(+), 12 deletions(-)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index b486b3ec7dc4..7152aa1f1a49 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -39,7 +39,12 @@ enum opal_response_token {
>  #define FIRST_TPER_SESSION_NUM	4096
>  
>  #define TPER_SYNC_SUPPORTED 0x01
> +/* FC_LOCKING features */
> +#define LOCKING_SUPPORTED_MASK 0x01
> +#define LOCKING_ENABLED_MASK 0x02
> +#define LOCKED_MASK 0x04
>  #define MBR_ENABLED_MASK 0x10
> +#define MBR_DONE_MASK 0x20
>  
>  #define TINY_ATOM_DATA_MASK 0x3F
>  #define TINY_ATOM_SIGNED 0x40
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 9700197000f2..2e86a5c37eb6 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -74,8 +74,7 @@ struct parsed_resp {
>  };
>  
>  struct opal_dev {
> -	bool supported;
> -	bool mbr_enabled;
> +	u32 flags;
>  
>  	void *data;
>  	sec_send_recv *send_recv;
> @@ -280,6 +279,30 @@ static bool check_tper(const void *data)
>  	return true;
>  }
>  
> +static bool check_lcksuppt(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKING_SUPPORTED_MASK);
> +}
> +
> +static bool check_lckenabled(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKING_ENABLED_MASK);
> +}
> +
> +static bool check_locked(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKED_MASK);
> +}
> +
>  static bool check_mbrenabled(const void *data)
>  {
>  	const struct d0_locking_features *lfeat = data;
> @@ -288,6 +311,14 @@ static bool check_mbrenabled(const void *data)
>  	return !!(sup_feat & MBR_ENABLED_MASK);
>  }
>  
> +static bool check_mbrdone(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & MBR_DONE_MASK);
> +}
> +
>  static bool check_sum(const void *data)
>  {
>  	const struct d0_single_user_mode *sum = data;
> @@ -435,7 +466,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
>  	u32 hlen = be32_to_cpu(hdr->length);
>  
>  	print_buffer(dev->resp, hlen);
> -	dev->mbr_enabled = false;
> +	dev->flags &= OPAL_FL_SUPPORTED;
>  
>  	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
>  		pr_debug("Discovery length overflows buffer (%zu+%u)/%u\n",
> @@ -461,7 +492,16 @@ static int opal_discovery0_end(struct opal_dev *dev)
>  			check_geometry(dev, body);
>  			break;
>  		case FC_LOCKING:
> -			dev->mbr_enabled = check_mbrenabled(body->features);
> +			if (check_lcksuppt(body->features))
> +				dev->flags |= OPAL_FL_LOCKING_SUPPORTED;
> +			if (check_lckenabled(body->features))
> +				dev->flags |= OPAL_FL_LOCKING_ENABLED;
> +			if (check_locked(body->features))
> +				dev->flags |= OPAL_FL_LOCKED;
> +			if (check_mbrenabled(body->features))
> +				dev->flags |= OPAL_FL_MBR_ENABLED;
> +			if (check_mbrdone(body->features))
> +				dev->flags |= OPAL_FL_MBR_DONE;
>  			break;
>  		case FC_ENTERPRISE:
>  		case FC_DATASTORE:
> @@ -2109,7 +2149,8 @@ static int check_opal_support(struct opal_dev *dev)
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
>  	ret = opal_discovery0_step(dev);
> -	dev->supported = !ret;
> +	if (!ret)
> +		dev->flags |= OPAL_FL_SUPPORTED;
>  	mutex_unlock(&dev->dev_lock);
>  
>  	return ret;
> @@ -2148,6 +2189,7 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
>  
>  	INIT_LIST_HEAD(&dev->unlk_lst);
>  	mutex_init(&dev->dev_lock);
> +	dev->flags = 0;
>  	dev->data = data;
>  	dev->send_recv = send_recv;
>  	if (check_opal_support(dev) != 0) {
> @@ -2528,7 +2570,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>  	if (!dev)
>  		return false;
>  
> -	if (!dev->supported)
> +	if (!(dev->flags & OPAL_FL_SUPPORTED))
>  		return false;
>  
>  	mutex_lock(&dev->dev_lock);
> @@ -2546,7 +2588,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>  			was_failure = true;
>  		}
>  
> -		if (dev->mbr_enabled) {
> +		if (dev->flags & OPAL_FL_MBR_ENABLED) {
>  			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
>  			if (ret)
>  				pr_debug("Failed to set MBR Done in S3 resume\n");
> @@ -2620,6 +2662,24 @@ static int opal_generic_read_write_table(struct opal_dev *dev,
>  	return ret;
>  }
>  
> +static int opal_get_status(struct opal_dev *dev, void __user *data)
> +{
> +	struct opal_status sts = {0};
> +
> +	/*
> +	 * check_opal_support() error is not fatal,
> +	 * !dev->supported is a valid condition
> +	 */
> +	if (!check_opal_support(dev)) {
> +		sts.flags = dev->flags;
> +	}
> +	if (copy_to_user(data, &sts, sizeof(sts))) {
> +		pr_debug("Error copying status to userspace\n");
> +		return -EFAULT;
> +	}
> +	return 0;
> +}
> +
>  int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  {
>  	void *p;
> @@ -2629,12 +2689,14 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  		return -EACCES;
>  	if (!dev)
>  		return -ENOTSUPP;
> -	if (!dev->supported)
> +	if (!(dev->flags & OPAL_FL_SUPPORTED))
>  		return -ENOTSUPP;
>  
> -	p = memdup_user(arg, _IOC_SIZE(cmd));
> -	if (IS_ERR(p))
> -		return PTR_ERR(p);
> +	if (cmd & IOC_IN) {
> +		p = memdup_user(arg, _IOC_SIZE(cmd));
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
> +	}
>  
>  	switch (cmd) {
>  	case IOC_OPAL_SAVE:
> @@ -2685,11 +2747,15 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  	case IOC_OPAL_GENERIC_TABLE_RW:
>  		ret = opal_generic_read_write_table(dev, p);
>  		break;
> +	case IOC_OPAL_GET_STATUS:
> +		ret = opal_get_status(dev, arg);
> +		break;
>  	default:
>  		break;
>  	}
>  
> -	kfree(p);
> +	if (cmd & IOC_IN)
> +		kfree(p);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sed_ioctl);
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 1ac0d712a9c3..6f837bb6c715 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>  	case IOC_OPAL_MBR_DONE:
>  	case IOC_OPAL_WRITE_SHADOW_MBR:
>  	case IOC_OPAL_GENERIC_TABLE_RW:
> +	case IOC_OPAL_GET_STATUS:
>  		return true;
>  	}
>  	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 6f5af1a84213..c55bc79e3128 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -132,6 +132,17 @@ struct opal_read_write_table {
>  	__u64 priv;
>  };
>  
> +#define OPAL_FL_SUPPORTED		0x00000001
> +#define OPAL_FL_LOCKING_SUPPORTED	0x00000002
> +#define OPAL_FL_LOCKING_ENABLED		0x00000004
> +#define OPAL_FL_LOCKED			0x00000008
> +#define OPAL_FL_MBR_ENABLED		0x00000010
> +#define OPAL_FL_MBR_DONE		0x00000020
> +
> +struct opal_status {
> +	__u32 flags;
> +};

You expect this struct to reasonably grow additional members? If not you
might just pass a single __u64?

In case that the struct makes more sense: I don't know what's common in
this subsystem but for other parts of the kernel we try to align all
structs to 64 bits. So it wouldn't hurt to do that here too. Either by
turning that into __u64 flags or by adding a __u32 reserved member.

> +
>  #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
>  #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
>  #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
> @@ -148,5 +159,6 @@ struct opal_read_write_table {
>  #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
>  #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
>  #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
> +#define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
>  
>  #endif /* _UAPI_SED_OPAL_H */
> -- 
> 2.35.1
> 
