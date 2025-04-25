Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F221257AF9
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592224; cv=none; b=Jmuh8bZNcyGkpMPkenlMi3LnUEY4mNy6JRh1WYQxnC1FKP5NAqDoTo1UinOV0mVq6Tip2+SQrOrrXbF15VSEF6XrQdstQYtqQulBQt2HZoNJD8Ea1AcrFe149b6/Ib6zioL6Wg2lQWStuL8+Qy+0isGknmcBnudhYx1aSe21A14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592224; c=relaxed/simple;
	bh=EdHm9ED/UHwI8Ik7GqQ/5G7FGvMYnMvCAclIZjENd20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1IcPNi7iz6Ks0JasTym4QRycCWMaZFPY0iTSzFvpuYAAi86r3tPlLsJ50Z1WOEpWAbJ2q4+8UsOjxXMUYv6di/hRyCQlXNe50r26Bt+suZXaCZY3gUXXU5xV7e0eJC4p79FvjMCFoQqdJUv3lBwC9EDYCliND86eUmeE8J2bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 822DC68B05; Fri, 25 Apr 2025 16:43:36 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:43:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250425144336.GA12179@lst.de>
References: <20250425103319.1185884-1-nilay@linux.ibm.com> <20250425103319.1185884-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425103319.1185884-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 25, 2025 at 04:03:08PM +0530, Nilay Shroff wrote:
> @@ -4007,10 +4008,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	mutex_lock(&ns->ctrl->subsys->lock);
>  	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list)) {
> -		list_del_init(&ns->head->entry);
> -		last_path = true;
> -	}
>  	mutex_unlock(&ns->ctrl->subsys->lock);
>  
>  	/* guarantee not available in head->list */
> @@ -4028,8 +4025,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	mutex_unlock(&ns->ctrl->namespaces_lock);
>  	synchronize_srcu(&ns->ctrl->srcu);
>  
> -	if (last_path)
> -		nvme_mpath_shutdown_disk(ns->head);
> +	nvme_mpath_shutdown_disk(ns->head);

This now removes the head list deletion from the first critical
section into nvme_mpath_shutdown_disk.  I remember we had to do it
the way it currently is done because we were running into issues
otherwise, the commit history might help a bit with what the issues
were.

> +	if (a == &dev_attr_delayed_removal_secs.attr) {
> +		struct nvme_ns_head *head = dev_to_ns_head(dev);
> +		struct gendisk *disk = dev_to_disk(dev);
> +
> +		/*
> +		 * This attribute is only valid for head node and non-fabric
> +		 * setup.
> +		 */
> +		if (!nvme_disk_is_ns_head(disk) ||
> +				test_bit(NVME_NSHEAD_FABRICS, &head->flags))
> +			return 0;
> +	}

Didn't we say we also want to allow fabrics to use it if explicitly
configured?

