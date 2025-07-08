Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FAC1DB54C
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938044; cv=none; b=rxmn4ifYvnR1y3xVo8ZWtoWeS9n2c0o2+tMq97ZNit2iW/IT7GdIkEHre6Q1K5PJZxSCUVM8KxmXzx7M0pbCzSl+ZzSCKj/kfoy3mz59q4GD5B1XgRve/dddXjxXb+FkAvOvzayb5RiRlRalXlzffqFWFmU5S4kwrnoswyvtlsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938044; c=relaxed/simple;
	bh=MT4H1nbSE38RD7bzCrjXJ5Soq8AyeKrptUDN1HXU40Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxOBN3o9JCF1w/gUxi1bRfT6lTBZQEkY8ZbArtV9H1AIrYEFRRKSesNu6yzBajzE7FoPzde5tWjGUt7dhpbr59oYJkJSAGxQ9wqSh/mUARhcoOt/narNxVhwxiueEb+9QIOscfAIxLsEZ1VlhLOKJjBjv7qkeRJIsCttcZ42zAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OafbUt1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OafbUt1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751938041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxRWAschZwxjZ/NDyPK1WTeZlS6Oh3VBdv4rI2QJkPY=;
	b=OafbUt1ut4pLHV7fES8ezD0sUGXqeg0Gb7ygw6YaO5iFUVFcotUhinNOqpltHyhSlqacvX
	2gW4HmHep64TSOp6amQaSr24VhTfRtjo7Kwxr1TbGeJYwid10FyKriHP6UFM/q2KMMM9ak
	kbwL1cCft6bOgfr7GvbY72dUzb2e7oE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-z9yWvXEnNweP8hSVYutr7g-1; Mon,
 07 Jul 2025 21:27:18 -0400
X-MC-Unique: z9yWvXEnNweP8hSVYutr7g-1
X-Mimecast-MFC-AGG-ID: z9yWvXEnNweP8hSVYutr7g_1751938037
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93F8F1955F38;
	Tue,  8 Jul 2025 01:27:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D3B30001B1;
	Tue,  8 Jul 2025 01:27:10 +0000 (UTC)
Date: Tue, 8 Jul 2025 09:27:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGxz6s9oUp2FkbyX@fedora>
References: <20250707141834.GA30198@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141834.GA30198@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> 
> As a short reminder the main issues are:
> 
>  1) there is no flag on a command to request atomic (aka non-torn)
>     behavior, instead writes adhering to the atomicy requirements will
>     never be torn, and writes not adhering them can be torn any time.
>     This differs from SCSI where atomic writes have to be be explicitly
>     requested and fail when they can't be satisfied
>  2) the original way to indicate the main atomicy limit is the AWUPF
>     field, which is in Identify Controller, but specified in logical
>     blocks which only exist at a namespace layer.  This a) lead to

If controller-wide AWUPF is a must property, the length has to be aligned
with block size.

>     various problems because the limit is a mess when namespace have
>     different logical block sizes, and it b) also causes additional
>     issues because NVMe allows it to be different for different
>     controllers in the same subsystem.

The spec mentioned clearly that controller AWUPF should be supported by
any namespace format:

```
Atomic Write Unit Power Fail (AWUPF): This field indicates the size of the write
operation guaranteed to be written atomically to the NVM across all namespaces
with any supported namespace format during a power fail or error condition.
```

So I am wondering why nvme driver can't validate NAWUN against AWUPF?


Thanks, 
Ming

