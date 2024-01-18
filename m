Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69952C127
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566082; cv=none; b=JBODjuB1Pr4VDFar7TvylxpfhM6qELMRRwXoWt8BF31GSaTdV2Hg16xty7cHSh+rEpokb2X797OxHmbhXLvUwRDgfth9kCq3ZNtBb0ic5f19llO/8L9yoP9EwtkhT9K2CuO8MeSdClWQmwoJz/nKQjBqa/EymP4bNPLxdeAYBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566082; c=relaxed/simple;
	bh=qsEVQwBjugQ1vPS6kz1w+aAKQkLix6t05nctAwQ2INE=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By; b=Q+7+PqzpDnfOxGXWUTggz4qwZGLBeOdIlhGIb+W+h28Hex58AJfH4ugH24f0tBVEmIhK13rmTrBdcTJDVmCxn80mynfbYlZFwH9h00YzxfdeUXTpXQFCvPEvmOQpGwGCqPegu/YcKEgAvSRPHw0dyuV+a5tdQkvCG0KifEF8ZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbqebJG4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbqebJG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705566080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkFDv/eNX9aWpWWkgiq2ThZ0JtGxjcDcXpuszzedJAM=;
	b=SbqebJG4hfhjiCUmG9bt2g0FCLLDJljOulwHF6dChAlSKEXpewrQq1ntwnNhCfCyi8KR2Z
	9yrv4ERw7dAD8euaJW9R0q5M8pbyhcfR5h09BBxvuFsBoMxoPkQflHHV0srQTP1CsOCHm4
	6wqFkhMmfx//GRbFAJV/Ab3+xIHXEKE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-PenXo_UnNvKvIe7t9OpnfA-1; Thu,
 18 Jan 2024 03:21:18 -0500
X-MC-Unique: PenXo_UnNvKvIe7t9OpnfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72D011C29EB3;
	Thu, 18 Jan 2024 08:21:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A4FDC158BD;
	Thu, 18 Jan 2024 08:21:15 +0000 (UTC)
Date: Thu, 18 Jan 2024 16:21:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: fix the the direct I/O support check when used on
 top of block devices
Message-ID: <Zajfd6ee6/ej0IRU@fedora>
References: <20240117175901.871796-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117175901.871796-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Jan 17, 2024 at 06:59:01PM +0100, Christoph Hellwig wrote:
> __loop_update_dio only checks the alignment requirement for block backed
> file systems, but misses them for the case where the loop device is
> created directly on top of another block device.  Due to this creating
> a loop device with default option plus the direct I/O flag on a > 512 byte
> sector size file system will lead to incorrect I/O being submitted to the
> lower block device and a lot of error from the lock layer.  This can
> be seen with xfstests generic/563.
> 
> Fix the code in __loop_update_dio by factoring the alignment check into
> a helper, and calling that also for the struct block_device of a block
> device inode.
> 
> Also remove the TODO comment talking about dynamically switching between
> buffered and direct I/O, which is a would be a recipe for horrible
> performance and occasional data loss.
> 
> Fixes: 2e5ab5f379f9 ("block: loop: prepare for supporing direct IO")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks one nice cleanup & fix:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

