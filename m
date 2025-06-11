Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC881ACA
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605653; cv=none; b=LP1Gf3Q7HrDBpE7rBDKlBJSqL+QRFZsY0lqj2C4TV6tdArEm1QxVIz2OK+QgFLdwn9IJ5GLFlFHnunX22yjTts0zXaVFbL9qspC3hx1F+bb9++N4ztN89kss71EdNgNFSHAmQRdWkc9jXe5pnIflJgMgcbS5DcRAJcpkTeEhdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605653; c=relaxed/simple;
	bh=bOYBWLABH0VsjKkB7selDvRvvXWY/JnnFCimAT0UQrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3zIwurm9GI4zcO+9xUtmCDvKQf3d0o8gYHwSOl8BCb4a2+gidHkgtlExNeOqYSLE3u6mBa8KQ3jdtIhok7SyHv5rBVOvvTK6vrTDGrDRq3j4Ph770Z/Eqi4ILDV2MqnB++D78Q1WiuB8BraNRQ/3w6z10wEudhRkiR7XDRnnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es1dPOwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es1dPOwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F8EC4CEED;
	Wed, 11 Jun 2025 01:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749605652;
	bh=bOYBWLABH0VsjKkB7selDvRvvXWY/JnnFCimAT0UQrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=es1dPOwfvmaOPCqZwnuQstrJtLHkKtqpagGR7MqYuVXv63n54oPOMQkagEYJ+BOM8
	 UnQPrVSDCtmnsMlhewLccfOgg1DqSAfODq/qBB7eRKyH58oY1eUAugU3metR7ShpL5
	 sU3ChE/tI3DwdSn2StTX5/OiaPHUf5HduRlEmSyhwkes3zsbUPpJXN47EqIo+Sn47B
	 RS5iOFrB8YZzfOHbaBqt3txMCIdgeRUO96xTWIDdt13b+nJQrpG0I0h0RnSyL8IpYC
	 /Nkh5TPG25x5xU3RtM2hih67eqeDqyJYK76QQCMyWr5HnIrapUSnLoHTwYvDVJxBwZ
	 hfweQatInR/qw==
Date: Tue, 10 Jun 2025 19:34:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <aEjdEbPnBK_YuGqz@kbusch-mbp>
References: <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org>
 <aEi9KxqQr-pWNJHs@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEi9KxqQr-pWNJHs@kbusch-mbp>

On Tue, Jun 10, 2025 at 05:18:03PM -0600, Keith Busch wrote:
> @@ -124,9 +124,10 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
>  		trace_block_split(split, bio->bi_iter.bi_sector);
>  		WARN_ON_ONCE(bio_zone_write_plugging(bio));
>  		submit_bio_noacct(bio);
> -		return split;
> +		bio = split;
>  	}
>  
> +	blk_crypto_bio_prep(&bio);

Eh, this part needs to handle the error condition:

+	if (!blk_crypto_bio_prep(&bio))
+		return NULL;

Happy to make a formal patch out of this if this approach is promising.
I think it aligns with the spirit of what Christoph was suggesting, at
least.
