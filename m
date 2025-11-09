Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE92EBDDE
	for <linux-block@vger.kernel.org>; Sun,  9 Nov 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690809; cv=none; b=svWNfrEz9PhGoPbe9oyg19eB4VLEOsAbn+H3um5EJbX3VoqnpzXnD/1NmZpkuXcb90DHoitvuRK4d/rBwAQnkahU63nCWp2sZ05zAPXgqTNwDBdndp0OWQtu6NSUHqEBoPbUWWqLgVCn7E4h23NoEXfbJ1w8/wqDQq1uV8MNtP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690809; c=relaxed/simple;
	bh=BtwNUYyMtkKVBobof0xuLKkDSYk5rO6NJeNX4AhfYyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou+5ODD6IdUGgcdgk4x6ad3y9w4e2jlUu7C6pS/iJEfnUb9DxhxfdP2vrjc9DZnuJ1+3qehElpk5OyU+Y1yPilVNX6TKpoGQidTGZSxvNvUtXNvydRPdnlKnNvKipxoeCjMfxug/KC5BvH5vcA4UuM1r6auVCRw0KC1Xrzdyn/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjDO+rh0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjDO+rh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762690806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0ZU+iBTTUw5olZrRzf+qb/pbO+mX7P5xruykc73XyI=;
	b=IjDO+rh0PurbQMtTk1Qvp1SgOFLJbTRconpv45e0fncwXoDy9lNj3dVaTJJsvbib7cAs4t
	gj4U4I69gwWpFIvGSeWw5dwMIEvVALrAutxi5w0NlQpgV5L1oGtRsDRnRwRO/kZV07VB+S
	yFi3FqJcA6XiNQAm2YaABe33t7Wp8lA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-XC4XW8GHM_mpPycP9NT0kA-1; Sun,
 09 Nov 2025 07:19:59 -0500
X-MC-Unique: XC4XW8GHM_mpPycP9NT0kA-1
X-Mimecast-MFC-AGG-ID: XC4XW8GHM_mpPycP9NT0kA_1762690798
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCE7D1956088;
	Sun,  9 Nov 2025 12:19:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B18B530001B9;
	Sun,  9 Nov 2025 12:19:50 +0000 (UTC)
Date: Sun, 9 Nov 2025 20:19:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Message-ID: <aRCG3OUThPCys92r@fedora>
References: <20251108230101.4187106-1-csander@purestorage.com>
 <20251108230101.4187106-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108230101.4187106-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Nov 08, 2025 at 04:01:00PM -0700, Caleb Sander Mateos wrote:
> The number of bvecs can be obtained directly from struct request's
> nr_phys_segments field via blk_rq_nr_phys_segments(), so use that
> instead of iterating over the bvecs an extra time.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/loop.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 13ce229d450c..8096478fad45 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -346,16 +346,13 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	struct request *rq = blk_mq_rq_from_pdu(cmd);
>  	struct bio *bio = rq->bio;
>  	struct file *file = lo->lo_backing_file;
>  	struct bio_vec tmp;
>  	unsigned int offset;
> -	int nr_bvec = 0;
> +	unsigned short nr_bvec = blk_rq_nr_phys_segments(rq);
>  	int ret;
>  
> -	rq_for_each_bvec(tmp, rq, rq_iter)
> -		nr_bvec++;
> -

The two may not be same, since one bvec can be splitted into multiple segments.

Thanks,
Ming

