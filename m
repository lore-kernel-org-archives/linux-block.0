Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F25207A3A
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684015; cv=none; b=brLCGJtT5Z+fyk2090ve6XPga1UQrgyXbjpPpdUMbA801RvFuFL7bRMKVkUp+jlgTjahz7uGISBuipMIW1Fnu9brfaGBMyJwL27ken06Zi/5gLNpqXYFzo6tC/p3eLoehvHtPFFN79h3TUHXNAoZYhAd7cSAogBfo4Z/homLn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684015; c=relaxed/simple;
	bh=qZJQIOwX0WCaQmCFm1s6QWLRoOUoMui/y7xXS7JvbSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaZEY7l6qDkE3rAQlcVN3BZMPYyxPfRBMcVzdRCe6EbMGMiXDRR8CChQS4K97jigB5SozvUYPHjlEmMcvM2n3iyddeCKsp7yVW3xerHM24HKHsGtD5fAMpXb8InWwUYynUf6YC7PlXG0ggsD8y8RQpFZVedde2mxTWeEWE+mCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dc5Y2G1t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc5Y2G1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744684009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ay/bC5wtlL5C89KNjsD+vS68Fh+RSS6ruxrIaqeVaD8=;
	b=dc5Y2G1tgTUgSctOqY0YAMRc6BJvnhTk/4LoxkwXvbBkrYGaby4RgRuSfs7EvRmCqVi/Se
	i6oaJ73tRuLgPgkr1/IAesAeAzoYvMwOICXNO8Uofu+vGylIUm++GJY2Nz5+A1iyUCcLuh
	3e0rvrJID43THSVb2aDVuNz3eAis9Qc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-i68JFbYkPcC89FW6wjE5wg-1; Mon,
 14 Apr 2025 22:26:37 -0400
X-MC-Unique: i68JFbYkPcC89FW6wjE5wg-1
X-Mimecast-MFC-AGG-ID: i68JFbYkPcC89FW6wjE5wg_1744683993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CD96180034D;
	Tue, 15 Apr 2025 02:26:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51D3D3001D0F;
	Tue, 15 Apr 2025 02:26:28 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:26:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 07/15] block: move blk_unregister_queue() & device_del()
 after freeze wait
Message-ID: <Z_3D0PZWolXUdXnK@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-8-ming.lei@redhat.com>
 <20250414061910.GA6673@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414061910.GA6673@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Apr 14, 2025 at 08:19:10AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 09:30:19PM +0800, Ming Lei wrote:
> > Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> > for unifying elevator switch.
> > 
> > This way is just fine, since bdev has been unhashed at the beginning of
> > del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> > with kobject & debugfs thing only.
> 
> While I believe this is the right thing to do, moving the freeze wait
> caused issues in the past, so be careful.  Take a look at:
> 
> commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Sep 19 16:40:49 2022 +0200
> 
>     Revert "block: freeze the queue earlier in del_gendisk"

Yeah, I know this story.

If it is triggered again with this patch, I will help to root cause.

The last thing we still can do is to just moving blk_unregister_queue()
after queue is frozen, or even elevator tear down. It is allowed to delete
children kobjects after their parent is removed. Just the KOBJ_REMOVE
event need to be ordered.


Thanks,
Ming

