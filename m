Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438A3D1AA0;
	Tue,  2 Jun 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393363; cv=none; b=EEipHemI2eg/LNfH240L6lczFiN0qG2hw2FZIKJrcyRbjZi5wGwPFQthfogJ+9iYGO0Lu0YePqaMQSK1wQy24G9n2BFPdNtihCj7/FvG17ekUFwvwTS5fVIzv2iTbmvqBQ8pDFuPOgJdH4NFPPTIWYcRFseBzYBso1ppEtVmtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393363; c=relaxed/simple;
	bh=h2KZe2EmYRBf5jakX+ffYVY0B/63VVQcW+dzSu28EAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeLr+3zrCzpz1z0lq/H9tKYvw2PfnC7kC0mMQuL6yN2LtxJUSwr4uHDmG4D10G1VWKPz2qCdOw++En6W6mCQeuHmoX68jH8OQJikj4HGmJO1T47VPxg1hWb+Ovl1aSS6oiFgp38827MA2q3nAWq5blZpyJNn2m5l7eSeIA3abI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVD+mg+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVD+mg+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616C71F00893;
	Tue,  2 Jun 2026 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780393361;
	bh=tQYJrVMLZWh9yIT7btTVUgpKt7qkNI8vd7jCerpn1yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CVD+mg+CESoolImg1Imn7In3BgToyvXQdkwaN6Fc3LpVLmjodUVI51+Juv8gAghmo
	 jjMIAIFLZc2M/BMqhcEbYAluSF0M96tWWJs2djlqnyX5M7/GkXr0/FaQNyF0DXD+bH
	 A1HUD9XyNPGwLIRci+szwn4jZEZWT7/x9XzkLWiPFKLOpDL+CD2me2gaspMzBlgQu1
	 ToJHfxh7NymTEH6PxGxCuezyRUzpG0sowq3GTP4ZSszHYohXe9VxspvORrfMfETw+T
	 lUZakefMNzQ5pHR1FFjAWnr9qtV6G6j2IiQs1W6efOf0s2w2M8Om9D6KyzMlio4kTU
	 em0JW45AkWgRQ==
Date: Tue, 2 Jun 2026 10:42:35 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 8/9] block: add configurable error injection
Message-ID: <ah6li1JOGrpXor9W@kbusch-mbp>
References: <20260602054615.3788425-1-hch@lst.de>
 <20260602054615.3788425-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602054615.3788425-9-hch@lst.de>

On Tue, Jun 03, 2026 at 07:45:40AM +0200, Christoph Hellwig wrote:
> +static int error_inject_add(struct gendisk *disk, enum req_op op,
> +		sector_t start, u64 nr_sectors, blk_status_t status,
> +		unsigned int chance)
> +{
> +	struct blk_error_inject *inj;
> +
> +	if (op == REQ_OP_LAST)
> +		return -EINVAL;
> +	if (status == BLK_STS_OK)
> +		return -EINVAL;
> +	if (U64_MAX - nr_sectors < start)
> +		return -EINVAL;
> +
> +	if (!nr_sectors)
> +		nr_sectors = U64_MAX;
> +

...

> +
> +	inj->op = op;
> +	inj->start = start;
> +	inj->end = start + nr_sectors - 1;

When nr_sectors is 0, it is reset to U64_MAX so overflows if start > 1.
I think you want to remove overriding nr_sectors to U64_MAX and do:

	if (!nr_sectors)
		inj->end = U64_MAX;
	else if (U64_MAX - nr_sectors < start )
		return -EINVAL;
	else
		inj->end = start + nr_sectors - 1;

> +	inj->status = status;
> +	inj->chance = chance;
> +
> +	/*
> +	 * Add to the front of the list so that newer entries can partially
> +	 * override other entries.  This also intentional allows duplicate
> +	 * entries as there is no real reason to reject them.
> +	 */
> +	mutex_lock(&disk->error_injection_lock);
> +	if (!disk_live(disk)) {
> +		mutex_unlock(&disk->error_injection_lock);
> +		return -EINVAL;

I think we've leaked 'inj' in this error case.

> +	}
> +	list_add(&inj->entry, &disk->error_injection_list);

The __blk_error_inject interates this list with
"list_for_each_entry_rcu", so shouldn't this be list_add_rcu to match?

> +	mutex_unlock(&disk->error_injection_lock);
> +
> +	bdev_set_flag(disk->part0, BD_MAKE_IT_FAIL);
> +	return 0;
> +}

<snip>

> +static const match_table_t opt_tokens = {
> +	{ Opt_add,			"add",			},
> +	{ Opt_removeall,		"removeall",		},
> +	{ Opt_op,			"op=%s",		},
> +	{ Opt_start,			"start=%u"		},
> +	{ Opt_nr_sectors,		"nr_sectors=%u"		},

Shouldn't start and nr_sectors use %llu?

> +static ssize_t blk_error_injection_write(struct file *file,
> +		const char __user *ubuf, size_t count, loff_t *pos)
> +{

...

> +	options = memdup_user_nul(ubuf, count);
> +	if (!options)
> +		return -ENOMEM;
> +

On failure, memdup_user_nul returns an ERR_PTR rather than NULL.

	if (IS_ERR(options))
		return PTR_ERR(options);

> +	case Removeall:
> +		if (option_mask & ~Opt_removeall)
> +			return -EINVAL;

Leaking "options"? Should this be:

		if (option_mask & ~Opt_removeall) {
			ret = -EINVAL;
			goto out_free_options;
		}

?

> +		error_inject_removall(disk);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	if (!ret)
> +		ret = count;
> +out_free_options:
> +	kfree(options);
> +	return ret;
> +}
