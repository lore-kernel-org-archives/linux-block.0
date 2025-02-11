Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AE253341
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287747; cv=none; b=PxyeCNM/ORXL6/UU9QOgVBckd9HVNRa0p5nzuMiNeESq2Oj5InkAiY2gX2PreR/mRg+E5hZoVNh1CqL9fh+7jvr3B5I9shKTLeP0LZhpnyuWJ1l+Kj4UWMKeEviPuo8LADZ/QL3QjLOt01ggt30yaDSwlA9TY3kNck80e1LlbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287747; c=relaxed/simple;
	bh=RRujV9c54RXt9MhwuuOTuvvTmxLfU6UUjrSbtZPo4Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4bs6XVhFb8YtIVbPAJKEuSyWl2h75CreXgmiOyzjDuIJFwLSZrlFfNye4letEZ+wZIsZmL4xwFpSt7lUbTyY7HLGa/aR433pwRXq+kjP/JONl3I3FLm9W3moCw1IxwvF4F85pZec4bAOh4NFZDjfflj/kMDAbXAdlWH34WV7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bip/R9uH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bip/R9uH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739287745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xv1w1DlKbEasrVT1CCHnLjrP7d84p83c/hF32ietdcc=;
	b=bip/R9uHBVc3QBIs6eRIfqXWZAiMNWQTruCTy5x4VcvwVYa0o2fK7WZ8FZx/bGd37t2v/N
	bR0KWQljgiUp54+HKyE0A7bMLtopZSM6TofP+dMqgjtO9HyLZIdNVyaG/Jeu20+5eUO53X
	KRGmAcUNjzNifn5snQAVgOPxjv4U0bg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-7ofXKyztMeiMV23G0rzo3A-1; Tue,
 11 Feb 2025 10:29:01 -0500
X-MC-Unique: 7ofXKyztMeiMV23G0rzo3A-1
X-Mimecast-MFC-AGG-ID: 7ofXKyztMeiMV23G0rzo3A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88C6519560BC;
	Tue, 11 Feb 2025 15:29:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 459B33001D18;
	Tue, 11 Feb 2025 15:28:56 +0000 (UTC)
Date: Tue, 11 Feb 2025 23:28:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Cheyenne Wills <cheyenne.wills@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: BUG: NULL pointer dereferenced within __blk_rq_map_sg
Message-ID: <Z6tss9YS98AEIwQy@fedora>
References: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com>
 <Z6s-3LndN-Gt5sZB@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6s-3LndN-Gt5sZB@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Feb 11, 2025 at 08:13:16PM +0800, Ming Lei wrote:
> On Fri, Feb 07, 2025 at 07:09:39PM -0700, Cheyenne Wills wrote:
> > While I was setting up to test with linux 6.14-rc1 (under Xen), I ran
> > into a consistent NULL ptr dereference within __blk_rq_map_sg when
> > booting the system.
> > 
> > Using git bisect I was able to narrow down the "bad" commit to:
> > 
> > block: add a dma mapping iterator (b7175e24d6acf79d9f3af9ce9d3d50de1fa748ec)
> > 
> > Building a kernel with the parent commit
> > (2caca8fc7aad9ea9a6ea3ed26ed146b1e5f06fab) using the same .config does
> > not fail.
> > 
> > Following is the console log showing the error as well as the Xen
> > (libvirt) configuration for the guest that I'm using.
> > 
> > Please let me know if there is any additional information that I can provide.
> 
> Can you test the following patch?
> 

Please try the revised one:


diff --git a/block/blk-merge.c b/block/blk-merge.c
index 15cd231d560c..a66d087a6b55 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -493,7 +493,7 @@ static bool blk_map_iter_next(struct request *req,
 		return true;
 	}
 
-	if (!iter->iter.bi_size)
+	if (!iter->bio || !iter->iter.bi_size)
 		return false;
 
 	bv = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
@@ -514,6 +514,8 @@ static bool blk_map_iter_next(struct request *req,
 			if (!iter->bio->bi_next)
 				break;
 			iter->bio = iter->bio->bi_next;
+			if (!iter->bio)
+				break;
 			iter->iter = iter->bio->bi_iter;
 		}
 



Thanks,
Ming

