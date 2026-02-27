Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52E3859ED
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219123; cv=none; b=s7Mj9O1hFSDyAIIlmuL3NoDOnM5ZpNUfDRld9XRxf1QIZRE/bT30CgCn44tI4oidV/n4CfpMqm+z2I/QmvjJ7Zd4/lPAsBHaBfVsfAIC4pbxD7k3T1KB5effMunlFbIS0tGOzonTwZb9txheGYR7cumrRqNy3rjUmXF0DXrm8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219123; c=relaxed/simple;
	bh=YjzBD2yv2GVDOfY/BKkn8IXk657SWzaiGqYjVTbICcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXIcmIQhm2fAuoUYkihE3A2csXMp9T0p/sezfa9yeGDpQugNA9S2Yu4izRo5kMQOP7wIfPutq5fb8LiwU2wyPX86cqFNzPdAtYR8R7UpS7yCHHldi/RINFOWJrliD/n61mUJuxLVHAdjLw4Lv1QJjBNYvL2KHr9nrn7hIWQx2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMCv/lmd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMCv/lmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772219119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlsUkhGkLfHAu3CbQ0GtlZOIBXBxqT8Jxs7n/ibGimA=;
	b=AMCv/lmdcztNUiOlJ8Ghxx6zkm+n5ypLCZRkW75tn3qaQHIUqDxC/uvpAEGESS99ycIM1l
	RTuHr1RT/wY/BPDMChRSdzJQculTLtFEBaqmazeMtd2byrpfEw5f0oEEeoAbPLf29QpP1q
	5ngLeonza7zsU3AJ9nW7DGYwG6hC5Zo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-g8S7khIRMOiLV6tCmxm0Og-1; Fri,
 27 Feb 2026 14:05:13 -0500
X-MC-Unique: g8S7khIRMOiLV6tCmxm0Og-1
X-Mimecast-MFC-AGG-ID: g8S7khIRMOiLV6tCmxm0Og_1772219111
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 860361956061;
	Fri, 27 Feb 2026 19:05:10 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87C7E1800666;
	Fri, 27 Feb 2026 19:05:09 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 61RJ58qL1742192
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 14:05:08 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 61RJ58XE1742191;
	Fri, 27 Feb 2026 14:05:08 -0500
Date: Fri, 27 Feb 2026 14:05:08 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] libmultipath: Add sysfs helpers
Message-ID: <aaHq5EjVVYODGxjA@redhat.com>
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225153225.1031169-9-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Feb 25, 2026 at 03:32:20PM +0000, John Garry wrote:
> Add helpers for driver sysfs code for the following functionality:
> - get/set iopolicy with mpath_iopolicy_store() and mpath_iopolicy_show()
> - show device path per NUMA node
> - "multipath" attribute group, equivalent to nvme_ns_mpath_attr_group
> - device groups attribute array, similar to nvme_ns_attr_groups but not
>   containing NVMe members.
> 
> Note that mpath_iopolicy_store() has a update callback to allow same
> functionality as nvme_subsys_iopolicy_update() be run for clearing paths.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
>
> diff --git a/lib/multipath.c b/lib/multipath.c
> index 1ce57b9b14d2e..c05b4d25ca223 100644
> --- a/lib/multipath.c
> +++ b/lib/multipath.c
> @@ -745,6 +745,116 @@ void mpath_device_set_live(struct mpath_disk *mpath_disk,
>  }
>  EXPORT_SYMBOL_GPL(mpath_device_set_live);
>  
> +static struct attribute dummy_attr = {
> +	.name = "dummy",
> +};
> +
> +static struct attribute *mpath_attrs[] = {
> +	&dummy_attr,
> +	NULL
> +};
> +
> +static bool multipath_sysfs_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct gendisk *disk = dev_to_disk(dev);
> +
> +	return is_mpath_head(disk);
> +}
> +
> +static bool multipath_sysfs_attr_visible(struct kobject *kobj,
> +		struct attribute *attr, int n)
> +{
> +	return false;
> +}
> +
> +DEFINE_SYSFS_GROUP_VISIBLE(multipath_sysfs)

nitpick: this could use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE instead.

> +
> +const struct attribute_group mpath_attr_group = {
> +	.name           = "multipath",
> +	.attrs		= mpath_attrs,
> +	.is_visible     = SYSFS_GROUP_VISIBLE(multipath_sysfs),
> +};
> +EXPORT_SYMBOL_GPL(mpath_attr_group);
> +
> +const struct attribute_group *mpath_device_groups[] = {
> +	&mpath_attr_group,
> +	NULL
> +};
> +EXPORT_SYMBOL_GPL(mpath_device_groups);
> +
> +ssize_t mpath_iopolicy_show(struct mpath_iopolicy *mpath_iopolicy, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n",
> +		mpath_iopolicy_names[mpath_read_iopolicy(mpath_iopolicy)]);
> +}
> +EXPORT_SYMBOL_GPL(mpath_iopolicy_show);
> +
> +static void mpath_iopolicy_update(struct mpath_iopolicy *mpath_iopolicy,
> +		int iopolicy, void (*update)(void *), void *data)
> +{
> +	int old_iopolicy = READ_ONCE(mpath_iopolicy->iopolicy);
> +
> +	if (old_iopolicy == iopolicy)
> +		return;
> +
> +	WRITE_ONCE(mpath_iopolicy->iopolicy, iopolicy);
> +
> +	/*
> +	 * iopolicy changes clear the mpath by design, which @update
> +	 * must do.
> +	 */
> +	update(data);
> +
> +	pr_err("iopolicy changed from %s to %s\n",
> +		mpath_iopolicy_names[old_iopolicy],
> +		mpath_iopolicy_names[iopolicy]);

I not sure this warrants a pr_err().

-Ben

