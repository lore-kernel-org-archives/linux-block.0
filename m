Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951132264DD
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171966; cv=none; b=Z/lO9n/14iv86VsmWaqqC0Ds/xrmOERchHrdINJpH/DYLqQ6rW5f2QBGKnln2LmNWzRoMSDh/CTRFd0be1RRS5Vq3cwHC3R4Hb32vvFQafiKZi9M5cQje99QJE0RNwNwuNSpt5BrUN0qBrq5YjuRYsj9uDf+08c48RXCu1lMlmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171966; c=relaxed/simple;
	bh=WmMJ+ixRmie8yjUE1MRpUAfQGEdZNKHIonN185I1UZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMgJ69faXbCrjxd7qd0DtiYJNe8RFokCi+bPAf2BIa+T3RxaiYddZiXaCNgkjxr0hi/qMR3pX4YiVSTO/1n7/DhVBwgY+N9YMfG0h11wI/A25kZgLXXRTya7JCdI7kmYNEd0Gr4jOjPOXL/nRzLMRaFJ0nP+3hRyPdHA9rNNQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMT+0ov0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMT+0ov0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750171963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fE/BBbfpYHB5HPWq53NgigLF7rrsQUImJD2RdASf3DM=;
	b=bMT+0ov0GA4zOxOzWpJetCna42EUsNTUKyWpIzTxDfokqh4iZXBRfC/f7XcjbcmmtAN62h
	OWkRZSdHDpsT9c5+gAyTTrzoNc+QdeyRux64veeksgekheJ2MTIg2gkg8A4kNo5Wj0EgxM
	cnktz1cquO+PttA79hrUDq8gK0hFSrg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-fQcCNXvCP-SEiQTFCd8bHg-1; Tue,
 17 Jun 2025 10:52:38 -0400
X-MC-Unique: fQcCNXvCP-SEiQTFCd8bHg-1
X-Mimecast-MFC-AGG-ID: fQcCNXvCP-SEiQTFCd8bHg_1750171957
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6984F195609F;
	Tue, 17 Jun 2025 14:52:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F036918002B5;
	Tue, 17 Jun 2025 14:52:30 +0000 (UTC)
Date: Tue, 17 Jun 2025 22:52:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <aFGBJwK-doBF6fBz@fedora>
References: <20250617063430.668899-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617063430.668899-1-dlemoal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jun 17, 2025 at 03:34:30PM +0900, Damien Le Moal wrote:
> Back in 2015, commit d2be537c3ba3 ("block: bump BLK_DEF_MAX_SECTORS to
> 2560") increased the default maximum size of a block device I/O to 2560
> sectors (1280 KiB) to "accommodate a 10-data-disk stripe write with
> chunk size 128k". This choice is rather arbitrary and since then,
> improvements to the block layer have software RAID drivers correctly
> advertize their stripe width through chunk_sectors and abuses of
> BLK_DEF_MAX_SECTORS_CAP by drivers (to set the HW limit rather than the
> default user controlled maximum I/O size) have been fixed.
> 
> Since many block devices can benefit from a larger value of
> BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value to
> be 4MiB, or 8192 sectors.
> 
> Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  include/linux/blkdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 85aab8bc96e7..7c35b2462048 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1238,7 +1238,7 @@ enum blk_default_limits {
>   * Not to be confused with the max_hw_sector limit that is entirely
>   * controlled by the driver, usually based on hardware limits.
>   */
> -#define BLK_DEF_MAX_SECTORS_CAP	2560u
> +#define BLK_DEF_MAX_SECTORS_CAP	8192u

The change itself looks good, but the definition should belong to block
layer internal, so why not move it into internal header?


thanks,
Ming

