Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCFB18D63C
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706982; cv=none; b=EsqdUVMtQcQdQ5IzoKAwGOzRmca7NHQGo5io4r8MmUynxsx/L78YoXt1vKIbSMVygrBdjmCvlXrCqDoM6bxLDfGkOaqBWIgLAELTY3KsJPdc6x+E7ytbL84jjl9CgAxTyQsQrFyS/jPWFpslyXBJzfGTcNoMBqbfotzdcp/9mD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706982; c=relaxed/simple;
	bh=gFBvkETcq1C2Hh1KIu33EYtpV7rnobbQjt5TLAHwPWw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJANWWy6YKywjmQf7cvSPf5PAhdsxmnivKerlxj91HAMQ9J7o508WfRQRiW4cVzy1tTlhvx7JztTcE0oyqz0hNvlQ2B5GjtbdVLbLrJl1phQIALVZohVB0CLMMAx55WuLPC8D3/xxvA4cH6I4KsKTCfjmxV0NOkBZTKwk1cZqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HthLkFBK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HthLkFBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731706979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHagnFmNZrlzR8g5EzKTblNn1Sf23bKvns6e7SOdPzo=;
	b=HthLkFBKPDfKmv5SJOX/rI0uvZB2wVqZNWe/RKZ3IEhddorSHz2RC3c6+JRMZoJeKGfc3u
	u1fhpJp+sMvOVfe4uan24KHiec7yI/OUgzrrGHgO31xOpYECpywpTRp9L8PmkjLNtXlHEG
	hPa7VPSxYExZeK05+6oci/ncWBNNRY8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-frwPzo_BMC-uEFlahijKoA-1; Fri,
 15 Nov 2024 16:42:58 -0500
X-MC-Unique: frwPzo_BMC-uEFlahijKoA-1
X-Mimecast-MFC-AGG-ID: frwPzo_BMC-uEFlahijKoA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B31A19560B1;
	Fri, 15 Nov 2024 21:42:57 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 566FF19560A3;
	Fri, 15 Nov 2024 21:42:55 +0000 (UTC)
Date: Fri, 15 Nov 2024 15:42:51 -0600
From: Eric Blake <eblake@redhat.com>
To: linux-block@vger.kernel.org, nbd@other.debian.org, 
	Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: question on NBD idempotency
Message-ID: <t6rjk7bxcyi23vg27ga3jr5qnrqyt66gxxaglbytcgsgunxrpx@rlyn24bt33r5>
References: <2i75j4d6tt6aben6au4a3s63burx3kvtywhb3ecbh3w2eoallm@ye34afaah6ih>
 <zhoxmjoys5ikhg4uqelexincgyx5ehgowg3fretnlpquhzdevo@6rwmb7y5zvtz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zhoxmjoys5ikhg4uqelexincgyx5ehgowg3fretnlpquhzdevo@6rwmb7y5zvtz>
User-Agent: NeoMutt/20241002
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Nov 15, 2024 at 10:29:48AM -0600, Eric Blake wrote:
> On Fri, Nov 15, 2024 at 09:43:29AM -0600, Eric Blake wrote:
> > 
> > But if there are no such ioctls (and no desire to accept a patch to
> > add them), then it looks like I _have_ to use /dev/nbd$N as the tag
> > that I map back to server details, and just be extremely careful in my
> > bookkeeping that I'm not racing in such a way that creates leaked
> > devices or which closes unintended devices, regardless of whether
> > there are secondary failures in trying to do the k8s bookkeeping to
> > track the mappings.  Ideas on how I can make this more robust would be
> > appreciated (for example, maybe it is more reliable to use symlinks in
> > the filesystem as my data store of mapped tags, than to try and
> > directly rely on k8s CR updates to synchronize).
> 
> I wonder if xattr might be what I want for associating a user-space
> tag with the device.

Nope, it looks like setxattr(2) used on /dev/nbd0 (as seen in a
setfattr(1) strace) fails with EPERM when attempting to assign
attributes to anything in /dev; ie. devtmpfs does not appear to
support extended attributes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org

