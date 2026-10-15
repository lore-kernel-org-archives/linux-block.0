Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE9595726;
	Thu, 15 Oct 2026 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096012; cv=none; b=B2GrSxkXGKhH15LJzx3WOem3nDiiNB4/Zmobc4Fl8itpUAwRjB6OzktH6Hf0GH8trYaG5gU0CKqHc11BpfiPllTKqpl5UICJewcVjsuUAQRjq8GmrIE+FDuMZBrDAUc9NH9omJ6KC4nCB351OLj6keFRTe3kV+YvBXy6cGouwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096012; c=relaxed/simple;
	bh=E7Fv6ywQrgDjUslqsRvtfwPAj5PC8aBG+CjXR5SO+3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSwZbjux8kKFg3Era8K7mA8D9Y1d6nMQOeWPBwIvhQggKkupPmZPnyGcqzTM8EjhrbN/4AI1nC6/0+LYw4aHGkPvii+yLoA010b5/3w4PFWf8tK+NERfqKR9dmVh5jgP8OFtR9gdEavdbZtCPFLaZn8hBtOMybLBaiYJziZl8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+HLQ7e1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+HLQ7e1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C18A1F000C5;
	Thu, 15 Oct 2026 20:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792096006;
	bh=0krRJ91DC1JqaPy8p2BdLjkFZFB7uv6gz8otZz1lamA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N+HLQ7e1/GmU6TH/sE5snhDqVs0LO1RDZRPntxffBQMKi04UqKufzmuLAlkNPh72J
	 OAruwhzav97R+HmhSGt3eVBMD7LK8UohREB88Awf7tXwUqiWzSh2P+ohmzYQTW3XBS
	 k17ihrL+LD8u1Ny2SoWsuX7mtYGNIK4HAdPLaMhohFrjZjAg056/nQxZ8mDZrXbR0q
	 kDfmv04b4VZlHe5/KhwnwCYHqpmMyaMa0i4F3pPxFQMQ7KHipk1wnHQDuTnjJjy/65
	 UcFRaRMdXvCBSNhKGeA0/RF7yEkTc/heJJdwdaxn98ekWuPDlivbjWEDPgNgtCBGgR
	 5M1crv539nYqA==
Date: Thu, 15 Oct 2026 20:26:44 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk,
	stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] virtio_blk: add inline encryption support
Message-ID: <20261015202644.GA2317081@google.com>
References: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
 <20261009041727.3170811-3-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009041727.3170811-3-linlin.zhang@oss.qualcomm.com>

On Thu, Oct 08, 2026 at 09:17:14PM -0700, Linlin Zhang wrote:
> +config VIRTIO_BLK_INLINE_ENCRYPTION
> +	tristate "Virtio block inline encryption support"
> +	depends on VIRTIO_BLK && BLK_INLINE_ENCRYPTION
> +	help
> +	  Say 'Y or M' here will allow the virtio block driver to route crypto
> +	  requests to a different operating system in a virtualized
> +	  environment. This is useful to encrypt the data stored in the storage
> +	  by using storage inline crypto engine. The control queue feature bit
> +	  must be negotiated to enable this functionality.
> +
> +	  If unsure, say N.

This should be a bool, not a tristate.  (Since it controls the inclusion
of a feature in a module, rather than the inclusion of a module.)

> +#if IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION)
> +static int virtblk_get_crypto_modes(struct virtio_blk *vblk,
> +				    unsigned int *crypto_modes_supported)
> +{
> +	unsigned int nr_modes = VIRTIO_BLK_CRYPTO_MODE_MAX + 1;
> +	struct scatterlist type_sg, resp_sg, status_sg, *sgs[3];
> +	struct virtblk_ctrl_request *creq;
> +	unsigned int i;
> +	int err;
> +
> +	creq = kzalloc_obj(*creq, GFP_KERNEL);
> +	if (!creq)
> +		return -ENOMEM;
> +
> +	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_CRYPTO_MODES);
> +
> +	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
> +	sg_init_one(&resp_sg, &creq->in_resp.modes, sizeof(creq->in_resp.modes));
> +	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
> +	sgs[0] = &type_sg;
> +	sgs[1] = &resp_sg;
> +	sgs[2] = &status_sg;
> +
> +	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 1, 2);

What happens if the host follows a future version of the spec and wants
to return more than VIRTIO_BLK_CRYPTO_MODE_MAX modes?

> +static int virtblk_crypto_keyslot_program(struct blk_crypto_profile *profile,
> +					   const struct blk_crypto_key *key,
> +					   unsigned int slot)
> +{
> +	struct virtio_blk *vblk = virtblk_from_profile(profile);
> +	struct scatterlist type_sg, out_req_sg, status_sg, *sgs[3];
> +	struct virtblk_ctrl_request *creq;
> +	int err;
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +	if (!vblk->vdev) {
> +		err = -ENXIO;
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * GFP_NOIO: this callback runs on the bio-submission path, which
> +	 * memory reclaim can reach while writing back dirty pages to this
> +	 * same device; GFP_KERNEL here could recurse into that same reclaim
> +	 * and self-deadlock.
> +	 */
> +	creq = kzalloc_obj(*creq, GFP_NOIO);
> +	if (!creq) {
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM);
> +
> +	err = set_virtblk_crypto_key_desc(vblk->vdev, creq, key, slot);
> +	if (err)
> +		goto out_free;
> +
> +	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
> +	sg_init_one(&out_req_sg, &creq->out_req.key_desc, sizeof(creq->out_req.key_desc));
> +	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
> +	sgs[0] = &type_sg;
> +	sgs[1] = &out_req_sg;
> +	sgs[2] = &status_sg;
> +
> +	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 1);
> +	if (err == -ETIMEDOUT)
> +		goto out_unlock;

Is the -ETIMEDOUT handling really correct?  This basically turns this
into an asynchronous operation; the host might still complete it later.

> +/* Must be >= BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in include/linux/blk-crypto.h */
> +#define VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE		128

Does this value really need to be exposed in a UAPI header?  As
documented in the comment above BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE, it's
supposed to be possible to increase it if ever needed.  This change
takes away that flexibility by making the current (somewhat arbitrarily
chosen) value part of the UAPI.

- Eric
