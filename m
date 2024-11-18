Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242131B6CFC
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945906; cv=none; b=W36TfNlF8JPO5d27uCgVZlpc1NbJxf8iCgDMRTuwTaXurkrniUamF2GN1HqxAEQHdskOHNFonq5G48BEWI+e1tasxVeEpfn+c7UI28RbqtsURf0qHDVA9lNdL0xI++bJ2NL6mRCq0NIthBzSg2nZsI5CsE10L1nLzcSHgSKJCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945906; c=relaxed/simple;
	bh=5ctaaMiUW7UjccVsGGRpDLLFWn0ROHh72dZOHur0JbQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+0nP0cjeJqo5WD3rBozOB0g1uDSLF/AHw8YeIn04mNaKadwnRHnbcwZXCn8/Zr16ud6qz7StKUuyvZN/fpfjgcqau20yYLU3pzP1YG39tBKczrbrjq/BAqlvpppeyS6n1AJOgE84+OzRGL4kE8NJHZC2COH1ouMfzZBfxtNFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHR6JQ5Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHR6JQ5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731945904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Dmzb4+cxeMVzEsNyz6tayZ5fsd2SQQrSivWHjLxk98=;
	b=GHR6JQ5ZXODoM5kaA/WCITeEf2rN/s0zc+WulHLJEOPb/+z5M2v4RfDIHjdocyA5y41PkW
	zNlVtW2lCKSag+affpUVP0tExk05JNW1L3p4j5tgPXsb8m78QzKZbIEWQxu/UO5KA6oowi
	TXDSkCy2KZro3muqi+YZ/0fVisZQH1E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-9j1azjOPN-G_rCgil3L2kQ-1; Mon,
 18 Nov 2024 11:05:00 -0500
X-MC-Unique: 9j1azjOPN-G_rCgil3L2kQ-1
X-Mimecast-MFC-AGG-ID: 9j1azjOPN-G_rCgil3L2kQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7C651955EA7;
	Mon, 18 Nov 2024 16:04:59 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C36853003B7E;
	Mon, 18 Nov 2024 16:04:57 +0000 (UTC)
Date: Mon, 18 Nov 2024 10:04:55 -0600
From: Eric Blake <eblake@redhat.com>
To: linux-block@vger.kernel.org, nbd@other.debian.org, 
	Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: question on NBD idempotency
Message-ID: <idugnvijxhmiybvyggxzeyxccbuom3pjblwhbye5fnbmp27rpj@k3lhml2c6zsh>
References: <2i75j4d6tt6aben6au4a3s63burx3kvtywhb3ecbh3w2eoallm@ye34afaah6ih>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2i75j4d6tt6aben6au4a3s63burx3kvtywhb3ecbh3w2eoallm@ye34afaah6ih>
User-Agent: NeoMutt/20241002
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Nov 15, 2024 at 09:43:24AM -0600, Eric Blake wrote:
> Is there an existing set of ioctls where the creation of an NBD device
> could associate a user-space tag with the device, and I can then later
> query the device to get the tag back?  A finite-length string would be
> awesome (I could store "nbd://$ip:$port/$export" as the tag on
> creation, to know precisely which server the device is talking to),
> but even an integer tag (32- or 64-bit) might be enough (it's easier
> to choose an integer tag in the full 2^64 namespace that is unlikely
> to cause collisions with other processes on the system, than it is to
> avoid collisions in the limited first few $N of the /dev/nbd$N device
> names chosen to pick the lowest unused integer first).  If not, would
> it be worth adding such ioctls for the NBD driver?

Aha - Stefan pointed me to NBD_ATTR_BACKEND_IDENTIFIER, in use in
places such as

https://github.com/vitalif/vitastor/blob/156d0054129c43cc26262663ff2c1cbb5b206513/src/client/nbd_proxy.cpp#L164
https://github.com/xdavidwu/ceph/blob/2f1768caeb96425877d3f5cbfa779c590a23e938/src/tools/rbd_nbd/rbd-nbd.cc#L1394

which looks like I can associate a given string directly with the
netlink creation, then later modification via netlink insists that the
same backend string be present, and where sysfs can be used to grab
the contents of nbd->backend as stored in the kernel.  The only
problem: nbd-client does not (yet) set this netlink parameter.  Looks
like I get to patch nbd-client, as that netlink field sounds exactly
like what I want.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org

