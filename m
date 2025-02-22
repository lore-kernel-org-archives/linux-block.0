Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D478C9C
	for <linux-block@vger.kernel.org>; Sat, 22 Feb 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228308; cv=none; b=X6mOQ4eSaDQHsjMCl9SExZtJs3MObBKQFpfZRqn6h+JBsKIEZ6mTDoMpCJDrng+R3d7NTZXhasCyBTS2hTFwdp+XbroNXMj4uYdRpz2pJ4ZEkDbgto0kRzTMKW0gyr8eWJ4p6rXtHw9nqbYxz/TnY1OL6C9rCrW4gEt5nxU/MKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228308; c=relaxed/simple;
	bh=Dx7yp/rNQ38Z+V/ZBxefsFQ/MTZ7Xu7yAJDZTVi1yeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmnTfVX9I5sVjbO2Y+JSkp0b4fmto1ALgkodlUUpR0OPPN+BCb68gbvQqK13PpgxXc4sIslnAY2Ily1IIM23DnTQRHBK2Yuu5QlvzK/2n9e8R2ypTQwzo7cfZWZS6RYoIPkhW+++4sPGPeNhv4dERWTOpYDGLU/6mwKn6ugmHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZWyFUHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZWyFUHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740228305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sU9hi3cvrdgxjUf/3Vi3KlGWZzJxxUq8virCLsEtTFg=;
	b=KZWyFUHuoljPjR2FGZ9yzGAdhVqY2auF5ZBEfuHObd6+Nj6aCwBOrQwFEfqfLGU2EgKGou
	F2MFgyaEJImA4J80hPPK93sguyxBKBBWWt8EJowAWS+tRTf4J+zmR+fp9JYJlxovVvhX0A
	9CWOdUJm86zb0X2eZo85gZkoVTQgMtA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-t_zzaIjLNWuPNs5v4Swpkw-1; Sat,
 22 Feb 2025 07:45:03 -0500
X-MC-Unique: t_zzaIjLNWuPNs5v4Swpkw-1
X-Mimecast-MFC-AGG-ID: t_zzaIjLNWuPNs5v4Swpkw_1740228302
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70E2319560BC;
	Sat, 22 Feb 2025 12:45:02 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E49D1800943;
	Sat, 22 Feb 2025 12:44:56 +0000 (UTC)
Date: Sat, 22 Feb 2025 20:44:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <Z7nGw_PJfAld8fAz@fedora>
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com>
 <20250218084622.GA11405@lst.de>
 <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com>
 <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Feb 21, 2025 at 07:32:52PM +0530, Nilay Shroff wrote:
> 
> Hi Christoph, Ming and others,
> 
> On 2/18/25 4:56 PM, Nilay Shroff wrote:
> > 
> > 
> > On 2/18/25 2:16 PM, Christoph Hellwig wrote:
> >> On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
> >>> There're few sysfs attributes in block layer which don't really need
> >>> acquiring q->sysfs_lock while accessing it. The reason being, writing
> >>> a value to such attributes are either atomic or could be easily
> >>> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
> >>> are inherently protected with sysfs/kernfs internal locking.
> >>>
> >>> So this change help segregate all existing sysfs attributes for which 
> >>> we could avoid acquiring q->sysfs_lock. We group all such attributes,
> >>> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
> >>> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store 
> >>> method (show_nolock/store_nolock) is assigned to attributes using these 
> >>> new macros. The show_nolock/store_nolock run without holding q->sysfs_
> >>> lock.
> >>
> >> Can you add the analys why they don't need sysfs_lock to this commit
> >> message please?
> > Sure will do it in next patchset.
> >>
> >> With that:
> >>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>
> > 
> I think we discussed about all attributes which don't require locking,
> however there's one which I was looking at "nr_zones" which we haven't
> discussed. This is read-only attribute and currently protected with 
> q->sysfs_lock.
> 
> Write to this attribute (nr_zones) mostly happens in the driver probe
> method (except nvme) before disk is added and outside of q->sysfs_lock
> or any other lock. But in case of nvme it could be updated from disk 
> scan.   
> nvme_validate_ns
>   -> nvme_update_ns_info_block
>     -> blk_revalidate_disk_zones
>       -> disk_update_zone_resources
> 
> The update to disk->nr_zones is done outside of queue freeze or any 
> other lock today. So do you agree if we could use READ_ONCE/WRITE_ONCE
> to protect this attribute and remove q->sysfs_lock? I think, it'd be 
> great if we could agree upon this one before I send the next patchset.

IMO, it is fine to read it lockless without READ_ONCE/WRITE_ONCE because
disk->nr_zones is defined as 'unsigned int', which won't return garbage
value anytime.

But I don't object if you want to change to READ_ONCE/WRITE_ONCE.


Thanks,
Ming

