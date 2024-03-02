Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E91754F
	for <linux-block@vger.kernel.org>; Sat,  2 Mar 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709397444; cv=none; b=Gm6i9m8Zp3UdK4hVqkn1304w6qgDNcrHeAwJQEp4ROvAPGfID4v2p4wN6SFAq/ofYDbYEoUVMyqFx/M7EYVZTpXTfpGaXqw6OGZkPLw59Fq0foeQ2XC7WwrbY3B9mdeQIrpyIfwjmU6N/WmH6ywbauuU/UDUlccMl3uMTQbU2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709397444; c=relaxed/simple;
	bh=9IC3fMEoEfXo3NNBOsCfC/33CDE0noCZBrsTmZNyk4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzDvQpev3uHsW6bba0U35NFDiwFNgDvYI9kywWEqXF/LfwgbSDO6tv+UL2/gHDLItP111TiP0hDOAaSp3sp3jwU/ApEe3moH3V0BENbRMhPoRKIw4au+/cCc/qXeNmIvlPeumXNwhJe8DqcxgGK+R+jou05ssFaahdcXuhflJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6869233d472so15187586d6.2
        for <linux-block@vger.kernel.org>; Sat, 02 Mar 2024 08:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709397441; x=1710002241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bU93HGrxoKEjIsJ9NGLvb4RDQbkWY7Y2iFs9PS//8I=;
        b=AjjAouX0QBuGGMKxY/svFlUt0zD1jgGqMggPAeovv0BJmuJR3yrZki4UN83NFdupOh
         jqVM9O1X4zDP1MHmEnes4n4SQDPyX/MmWkg/ogBBhty5nNIml1Rwzg0NdObwRIbjpwXy
         rSmFQV5nuq5OF2wFiBReWeVfpUXkZWEukWPtybnqMXEhql45S/1dwhUFydDFTp615EuQ
         7uZdAyWPSxjmLCcAmLIalVf6cEaMVWpB94lIthNlL2ggZ5nClcI9KQzAAMFdG3qj+qSN
         A1e+p3zZutYBIhZgHYyzrn1+eA44RbRlg/o/BWXxD0D+1aT7clCuLVBd70AinQ9nOJl2
         FUCA==
X-Forwarded-Encrypted: i=1; AJvYcCXpfIO6MDa6vJOMGU0Bob8Cca8XMn28i90aH0qDtzw88tgzm4AFDPCRzGXTJ8i2KkNU+0JeYmVFOF3U2ZCz0eE6GrcAWU9h+FmJ074=
X-Gm-Message-State: AOJu0YwGUbWKN7Wk/yPxvU1kAW9DwZxVaOAUTFPX3yLgKm1A680ge62+
	/nZS1A0r1d6ROjqb17Xc5JvtTjKu5pDSBjygric0D4HCvgc2tX+b/DWhnRRDjA==
X-Google-Smtp-Source: AGHT+IGWfJd4hsp4cquzrMgFaq/8ztZK/NQH0jQErvnt6KcdvzJSodCboJ3PnepuNNUxb0g3iW3fHA==
X-Received: by 2002:a0c:f885:0:b0:690:4916:4de9 with SMTP id u5-20020a0cf885000000b0069049164de9mr4614368qvn.34.1709397441567;
        Sat, 02 Mar 2024 08:37:21 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id ks30-20020a056214311e00b0068ffde5efb0sm3123189qvb.49.2024.03.02.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:37:21 -0800 (PST)
Date: Sat, 2 Mar 2024 11:37:20 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
	axboe@kernel.dk, agk@redhat.com, eparis@redhat.com,
	paul@paul-moore.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [RFC PATCH v13 14/20] dm verity: consume root hash digest and
 signature data via LSM hook
Message-ID: <ZeNVwBkbw2HlMRfa@redhat.com>
References: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
 <1709168102-7677-15-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709168102-7677-15-git-send-email-wufan@linux.microsoft.com>

On Wed, Feb 28 2024 at  7:54P -0500,
Fan Wu <wufan@linux.microsoft.com> wrote:

> From: Deven Bowers <deven.desai@linux.microsoft.com>
> 
> dm-verity provides a strong guarantee of a block device's integrity. As
> a generic way to check the integrity of a block device, it provides
> those integrity guarantees to its higher layers, including the filesystem
> level.
> 
> An LSM that control access to a resource on the system based on the
> available integrity claims can use this transitive property of
> dm-verity, by querying the underlying block_device of a particular
> file.
> 
> The digest and signature information need to be stored in the block
> device to fulfill the next requirement of authorization via LSM policy.
> This will enable the LSM to perform revocation of devices that are still
> mounted, prohibiting execution of files that are no longer authorized
> by the LSM in question.
> 
> This patch added two security hook calls in dm-verity to save the
> dm-verity roothash and the roothash signature to the block device's
> LSM blobs. The hook calls are depended on CONFIG_IPE_PROP_DM_VERITY,
> which will be introduced in the next commit.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   + No Changes
> 
> v3:
>   + No changes
> 
> v4:
>   + No changes
> 
> v5:
>   + No changes
> 
> v6:
>   + Fix an improper cleanup that can result in
>     a leak
> 
> v7:
>   + Squash patch 08/12, 10/12 to [11/16]
>   + Use part0 for block_device, to retrieve the block_device, when
>     calling security_bdev_setsecurity
> 
> v8:
>   + Undo squash of 08/12, 10/12 - separating drivers/md/ from
>     security/ & block/
>   + Use common-audit function for dmverity_signature.
>   + Change implementation for storing the dm-verity digest to use the
>     newly introduced dm_verity_digest structure introduced in patch
>     14/20.
>   + Create new structure, dm_verity_digest, containing digest algorithm,
>     size, and digest itself to pass to the LSM layer. V7 was missing the
>     algorithm.
>   + Create an associated public header containing this new structure and
>     the key values for the LSM hook, specific to dm-verity.
>   + Additional information added to commit, discussing the layering of
>     the changes and how the information passed will be used.
> 
> v9:
>   + No changes
> 
> v10:
>   + No changes
> 
> v11:
>   + Add an optional field to save signature
>   + Move the security hook call to the new finalize hook
> 
> v12:
>   + No changes
> 
> v13:
>   + No changes
> ---
>  drivers/md/dm-verity-target.c | 71 +++++++++++++++++++++++++++++++++++
>  drivers/md/dm-verity.h        |  6 +++
>  include/linux/dm-verity.h     | 19 ++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 include/linux/dm-verity.h
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index a99ef30e45ca..e7bc6afae708 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -13,6 +13,7 @@
>   * access behavior.
>   */
>  
> +#include "dm-core.h"
>  #include "dm-verity.h"
>  #include "dm-verity-fec.h"
>  #include "dm-verity-verify-sig.h"

Why are you including dm-core.h? (DM targets really shouldn't need it).

And from that header:

/*
 * DM core internal structures used directly by dm.c, dm-rq.c and dm-table.c.
 * DM targets must _not_ deference a mapped_device or dm_table to directly
 * access their members!
 */

> @@ -22,6 +23,9 @@
>  #include <linux/scatterlist.h>
>  #include <linux/string.h>
>  #include <linux/jump_label.h>
> +#include <linux/security.h>
> +#include <linux/dm-verity.h>
> +#include <crypto/hash_info.h>
>  
>  #define DM_MSG_PREFIX			"verity"
>  
> @@ -990,6 +994,17 @@ static void verity_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  	blk_limits_io_min(limits, limits->logical_block_size);
>  }
>  
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +static void verity_free_sig(struct dm_verity *v)
> +{
> +	kfree(v->root_digest_sig);
> +}
> +#else
> +static inline void verity_free_sig(struct dm_verity *v)
> +{
> +}
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> +
>  static void verity_dtr(struct dm_target *ti)
>  {
>  	struct dm_verity *v = ti->private;
> @@ -1008,6 +1023,7 @@ static void verity_dtr(struct dm_target *ti)
>  	kfree(v->salt);
>  	kfree(v->root_digest);
>  	kfree(v->zero_digest);
> +	verity_free_sig(v);
>  
>  	if (v->tfm)
>  		crypto_free_ahash(v->tfm);
> @@ -1199,6 +1215,25 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
>  	return r;
>  }
>  
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +static int verity_init_sig(struct dm_verity *v, const void *sig,
> +			   size_t sig_size)
> +{
> +	v->sig_size = sig_size;
> +	v->root_digest_sig = kmalloc(v->sig_size, GFP_KERNEL);
> +	if (!v->root_digest)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +#else
> +static inline int verity_init_sig(struct dm_verity *v, const void *sig,
> +				  size_t sig_size)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> +
>  /*
>   * Target parameters:
>   *	<version>	The current format is version 1.
> @@ -1407,6 +1442,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  		ti->error = "Root hash verification failed";
>  		goto bad;
>  	}
> +
> +	r = verity_init_sig(v, verify_args.sig, verify_args.sig_size);
> +	if (r < 0) {
> +		ti->error = "Cannot allocate root digest signature";
> +		goto bad;
> +	}
> +
>  	v->hash_per_block_bits =
>  		__fls((1 << v->hash_dev_block_bits) / v->digest_size);
>  
> @@ -1557,6 +1599,32 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
>  	return 0;
>  }
>  
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +static int verity_finalize(struct dm_target *ti)
> +{
> +	struct block_device *bdev;
> +	struct dm_verity_digest root_digest;
> +	struct dm_verity *v;
> +	int r;
> +
> +	v = ti->private;
> +	bdev = dm_table_get_md(ti->table)->disk->part0;

Must be for dereferencing mapped_device struct here ^

Please remove the dm-core.h include and use this instead:

struct gendisk *disk = dm_disk(dm_table_get_md(ti->table));

Mike

> +	root_digest.digest = v->root_digest;
> +	root_digest.digest_len = v->digest_size;
> +	root_digest.alg = v->alg_name;
> +
> +	r = security_bdev_setsecurity(bdev, DM_VERITY_ROOTHASH_SEC_NAME, &root_digest,
> +				      sizeof(root_digest));
> +	if (r)
> +		return r;
> +
> +	return security_bdev_setsecurity(bdev,
> +					 DM_VERITY_SIGNATURE_SEC_NAME,
> +					 v->root_digest_sig,
> +					 v->sig_size);
> +}
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> +
>  static struct target_type verity_target = {
>  	.name		= "verity",
>  	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
