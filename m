Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AE6C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 19:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjDDT3G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 15:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjDDT3F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 15:29:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7183C14
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 12:29:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso37222930pjb.3
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2023 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680636541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elpRMODiaw//U5pfL2czX7ve3QK/cpuxObmTPi8rtBE=;
        b=X8runZPsrfmCt/Esjj2ZbUqJRzQ5kpFs3/0vCTDM4sAF7eTwNCQO+G7YrESkQAAkWe
         1JD18ei2ndrUS1AX5MwKpsFLzOboONwYd/X0ZEswKv3MT7aYW2Rdqlld4egECrx0qv+0
         DfgpZg5wH7N/4UuhpvJ9QCT2YmwIKrLRgD0fLWfvja0KkLX250LqpRAapdIy93X7fE0c
         990U+XO1Lz2gS3PdNQXEyKIUx4w7EiqIZ4tpDGmPlYFb2Hl71E2219oQhkrS0wVwg1w4
         YYqU629qe0kl7kh9nqzTjlVT57Dx6uNd+TCjN6WcWHr0tjBYYsrO36uddx0OkjyUCCIr
         N4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680636541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elpRMODiaw//U5pfL2czX7ve3QK/cpuxObmTPi8rtBE=;
        b=eoawZcgDrctUdWv/wy91g/Gz1lR9gwzz/Q4Fg88Q8rz2yOgNQ1w9EvA5NOSOojyKoS
         R9BOCytyFSIqsbAUCv8RD3t25gCj8HID8YavxEj6NMDDw7amUd32GJJhjD4FGpLWnmhr
         QLVGd33s7fGC650yWlLBC3ltXrDlDhm5Ngk+WSJ5dk0txxAtmOHHbdK6relhyTLupaMW
         7UinGV/ZHYHTD0vp+GTJW9vGpDW83dmJQ6dTvZHuRsaERXpzLRFg3T6SEeLVRxm7gXVK
         Yvy1n9agAcyG1l2N+zAJw/i2T/2Iyj6TrDM3CKG05SJxs/ICXgE2gTWMIie7zBFZmo6g
         Rv1A==
X-Gm-Message-State: AAQBX9eVO4P70VTDHyKbKRb0G3xQ8SYiQURXLjgxSeKqgWcHIjUKJjk0
        bVJOVD8cKQ/mm6STK7vwi0aKGQ==
X-Google-Smtp-Source: AKy350bk08eI+rHYkJfIA4GXwHzROnMEnEzKVfVKfThUMmynQeM/qAq9cwH/sCzAHs6kxN51+vX+uQ==
X-Received: by 2002:a05:6a20:b288:b0:d8:d18d:60ae with SMTP id ei8-20020a056a20b28800b000d8d18d60aemr2850551pzb.7.1680636540626;
        Tue, 04 Apr 2023 12:29:00 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:13:94bc:ca55:a3c9:ef36])
        by smtp.gmail.com with ESMTPSA id c13-20020aa78e0d000000b0062603aec060sm9113803pfr.184.2023.04.04.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:28:59 -0700 (PDT)
Date:   Tue, 4 Apr 2023 12:28:55 -0700
From:   Igor Pylypiv <ipylypiv@google.com>
To:     Niklas Cassel <nks@flawful.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v5 09/19] scsi: allow enabling and disabling command
 duration limits
Message-ID: <ZCx6dzyEfWYNaF6r@google.com>
References: <20230404182428.715140-1-nks@flawful.org>
 <20230404182428.715140-10-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404182428.715140-10-nks@flawful.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 04, 2023 at 08:24:14PM +0200, Niklas Cassel wrote:
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> Add the sysfs scsi device attribute cdl_enable to allow a user to turn
> enable or disable a device command duration limits feature. CDL is
> disabled by default. This feature must be explicitly enabled by a user by
> setting the cdl_enable attribute to 1.
> 
> The new function scsi_cdl_enable() does not do anything beside setting
> the cdl_enable field of struct scsi_device in the case of a (real) scsi
> device (e.g. a SAS HDD). For ATA devices, the command duration limits
> feature needs to be enabled/disabled using the ATA feature sub-page of
> the control mode page. To do so, the scsi_cdl_enable() function checks
> if this mode page is supported using scsi_mode_sense(). If it is,
> scsi_mode_select() is used to enable and disable CDL.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Co-developed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  Documentation/ABI/testing/sysfs-block-device | 13 ++++
>  drivers/scsi/scsi.c                          | 62 ++++++++++++++++++++
>  drivers/scsi/scsi_sysfs.c                    | 31 ++++++++++
>  include/scsi/scsi_device.h                   |  2 +
>  4 files changed, 108 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
> index ee3610a25845..626d48ac504b 100644
> --- a/Documentation/ABI/testing/sysfs-block-device
> +++ b/Documentation/ABI/testing/sysfs-block-device
> @@ -104,3 +104,16 @@ Contact:	linux-scsi@vger.kernel.org
>  Description:
>  		(RO) Indicates if the device supports the command duration
>  		limits feature found in some ATA and SCSI devices.
> +
> +
> +What:		/sys/block/*/device/cdl_enable
> +Date:		Mar, 2023
> +KernelVersion:	v6.4
> +Contact:	linux-scsi@vger.kernel.org
> +Description:
> +		(RW) For a device supporting the command duration limits
> +		feature, write to the file to turn on or off the feature.
> +		By default this feature is turned off.
> +		Writing "1" to this file enables the use of command duration
> +		limits for read and write commands in the kernel and turns on
> +		the feature on the device. Writing "0" disables the feature.
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index c03814ce23ca..c4bf99a842f3 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -651,6 +651,68 @@ void scsi_cdl_check(struct scsi_device *sdev)
>  	kfree(buf);
>  }
>  
> +/**
> + * scsi_cdl_enable - Enable or disable a SCSI device supports for Command
> + *                   Duration Limits
> + * @sdev: The target device
> + * @enable: the target state
> + */
> +int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
> +{
> +	struct scsi_mode_data data;
> +	struct scsi_sense_hdr sshdr;
> +	struct scsi_vpd *vpd;
> +	bool is_ata = false;
> +	char buf[64];
> +	int ret;
> +
> +	if (!sdev->cdl_supported)
> +		return -EOPNOTSUPP;
> +
> +	rcu_read_lock();
> +	vpd = rcu_dereference(sdev->vpd_pg89);
> +	if (vpd)
> +		is_ata = true;
> +	rcu_read_unlock();
> +
> +	/*
> +	 * For ATA devices, CDL needs to be enabled with a SET FEATURES command.
> +	 */
> +	if (is_ata) {
> +		char *buf_data;
> +		int len;
> +
> +		ret = scsi_mode_sense(sdev, 0x08, 0x0a, 0xf2, buf, sizeof(buf),
> +				      5 * HZ, 3, &data, NULL);
> +		if (ret)
> +			return -EINVAL;
> +
> +		/* Enable CDL using the ATA feature page */
> +		len = min_t(size_t, sizeof(buf),
> +			    data.length - data.header_length -
> +			    data.block_descriptor_length);
> +		buf_data = buf + data.header_length +
> +			data.block_descriptor_length;
> +		if (enable)
> +			buf_data[4] = 0x02;
> +		else
> +			buf_data[4] = 0;
> +
> +		ret = scsi_mode_select(sdev, 1, 0, buf_data, len, 5 * HZ, 3,
> +				       &data, &sshdr);
> +		if (ret) {
> +			if (scsi_sense_valid(&sshdr))
> +				scsi_print_sense_hdr(sdev,
> +					dev_name(&sdev->sdev_gendev), &sshdr);
> +			return ret;
> +		}
> +	}
> +
> +	sdev->cdl_enable = enable;
> +
> +	return 0;
> +}
> +
>  /**
>   * scsi_device_get  -  get an additional reference to a scsi_device
>   * @sdev:	device to get a reference to
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 4994148e685b..9a54b2c0fee7 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1222,6 +1222,36 @@ static DEVICE_ATTR(queue_ramp_up_period, S_IRUGO | S_IWUSR,
>  		   sdev_show_queue_ramp_up_period,
>  		   sdev_store_queue_ramp_up_period);
>  
> +static ssize_t sdev_show_cdl_enable(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +
> +	return sysfs_emit(buf, "%d\n", (int)sdev->cdl_enable);
> +}
> +
> +static ssize_t sdev_store_cdl_enable(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	int ret;
> +	bool v;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
CAP_SYS_ADMIN seems be too restrictive. NCQ PRIO (ncq_prio_enable) does not 
require CAP_SYS_ADMIN. Since NCQ PRIO and CDL are mutually exclusive a user
should be able to toggle both features.

Thanks,
Igor
> +
> +	if (kstrtobool(buf, &v))
> +		return -EINVAL;
> +
> +	ret = scsi_cdl_enable(to_scsi_device(dev), v);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR(cdl_enable, S_IRUGO | S_IWUSR,
> +		   sdev_show_cdl_enable, sdev_store_cdl_enable);
> +
>  static umode_t scsi_sdev_attr_is_visible(struct kobject *kobj,
>  					 struct attribute *attr, int i)
>  {
> @@ -1302,6 +1332,7 @@ static struct attribute *scsi_sdev_attrs[] = {
>  #endif
>  	&dev_attr_queue_ramp_up_period.attr,
>  	&dev_attr_cdl_supported.attr,
> +	&dev_attr_cdl_enable.attr,
>  	REF_EVT(media_change),
>  	REF_EVT(inquiry_change_reported),
>  	REF_EVT(capacity_change_reported),
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 6b8df9e253a0..b2cdb078b7bd 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -219,6 +219,7 @@ struct scsi_device {
>  	unsigned no_vpd_size:1;		/* No VPD size reported in header */
>  
>  	unsigned cdl_supported:1;	/* Command duration limits supported */
> +	unsigned cdl_enable:1;		/* Enable/disable Command duration limits */
>  
>  	unsigned int queue_stopped;	/* request queue is quiesced */
>  	bool offline_already;		/* Device offline message logged */
> @@ -367,6 +368,7 @@ extern void scsi_remove_device(struct scsi_device *);
>  extern int scsi_unregister_device_handler(struct scsi_device_handler *scsi_dh);
>  void scsi_attach_vpd(struct scsi_device *sdev);
>  void scsi_cdl_check(struct scsi_device *sdev);
> +int scsi_cdl_enable(struct scsi_device *sdev, bool enable);
>  
>  extern struct scsi_device *scsi_device_from_queue(struct request_queue *q);
>  extern int __must_check scsi_device_get(struct scsi_device *);
> -- 
> 2.39.2
> 
