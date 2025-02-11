Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201A204873
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276017; cv=none; b=CJ581bClsZfxqJI8Lj3fWhWwz9Lm3O6p19Pv23HqS61nRAxbJyMp4xWA2JQOL0IonSreCKPdIU+Z9KSoiqI/zIQMpXsF67OXAhc8/KNcJFWzACJhweu9cEKpiDOa9EWWHNcO01Kt1mh3BKO+u765P2Zk1MlKDNAQT++/3TqAXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276017; c=relaxed/simple;
	bh=0CMol3dl5VEgIDyrygG7P6OfEDjxzAfqkE1R+LK6mkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE90NIvmGzwGF5hM7kTJS9N8FL/VLyVTi8MdgARvArV1Fgc1v5CbrdvrYTlfE1czR8ikrD31WueyzYlpDZmfUApG3//Ld9d71Y6aiivApSSUnHT65fz/GySStAPTqA88WUJK8Cj+S/lv27drf/eSORQRg6vQYOKVmx+8T0NmbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBB/fzf1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBB/fzf1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739276013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hUTOu5Ft6YZ3biihCM61glg7g7lFv8vP514riVhR/g=;
	b=DBB/fzf1RWe0gItCMKyKKQyQ0ZjXc+bGqk6aQCTRxsCKyBep9y7gLVXpm7sU+Yhc6i2eYt
	Qt9TpyVo3PusF/gkTBKFsi1TZmZsdSoJLjo3u/0xvH1BVy2HVALKJv1SJaH4IkkXLCJ4wD
	rJfOAut16i9ZWNOEGEvfwh7q44DkfMk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-aWmoS4RCPJOYQzr-FvGBCw-1; Tue,
 11 Feb 2025 07:13:27 -0500
X-MC-Unique: aWmoS4RCPJOYQzr-FvGBCw-1
X-Mimecast-MFC-AGG-ID: aWmoS4RCPJOYQzr-FvGBCw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B2C91955D82;
	Tue, 11 Feb 2025 12:13:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 978A030001AB;
	Tue, 11 Feb 2025 12:13:21 +0000 (UTC)
Date: Tue, 11 Feb 2025 20:13:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Cheyenne Wills <cheyenne.wills@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: BUG: NULL pointer dereferenced within __blk_rq_map_sg
Message-ID: <Z6s-3LndN-Gt5sZB@fedora>
References: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Feb 07, 2025 at 07:09:39PM -0700, Cheyenne Wills wrote:
> While I was setting up to test with linux 6.14-rc1 (under Xen), I ran
> into a consistent NULL ptr dereference within __blk_rq_map_sg when
> booting the system.
> 
> Using git bisect I was able to narrow down the "bad" commit to:
> 
> block: add a dma mapping iterator (b7175e24d6acf79d9f3af9ce9d3d50de1fa748ec)
> 
> Building a kernel with the parent commit
> (2caca8fc7aad9ea9a6ea3ed26ed146b1e5f06fab) using the same .config does
> not fail.
> 
> Following is the console log showing the error as well as the Xen
> (libvirt) configuration for the guest that I'm using.
> 
> Please let me know if there is any additional information that I can provide.

Can you test the following patch?


diff --git a/block/blk-merge.c b/block/blk-merge.c
index b55c52a42303..1eabde8383fb 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -493,7 +493,7 @@ static bool blk_map_iter_next(struct request *req,
 		return true;
 	}
 
-	if (!iter->iter.bi_size)
+	if (!iter->bio || !iter->iter.bi_size)
 		return false;
 
 	bv = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
@@ -514,7 +514,8 @@ static bool blk_map_iter_next(struct request *req,
 			if (!iter->bio->bi_next)
 				break;
 			iter->bio = iter->bio->bi_next;
-			iter->iter = iter->bio->bi_iter;
+			if (iter->bio)
+				iter->iter = iter->bio->bi_iter;
 		}
 
 		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);


Thanks,
Ming

