Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C5252917
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064891; cv=none; b=mWAiHHDmvYLa84g0RG0QOxaPgFTAmGpdpSPNy6l8GESrJSa/ceUre583j8Gv49uq8fnrkGdR9oYNeTre9hxkMRL5RdiaLEG6zowx5myt9IydtKY/2AiUMM+/JWGSkYcih3ywaAsp5MFAgeiD+j4sAJEG0EYbs5+s8wntEVFAth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064891; c=relaxed/simple;
	bh=EEOTlo86A7ZfBDzwp1r8PpCOvEmtkfd/bbw+Elh5c74=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=luf+K53YqLFi+b05HsETria0FMZMJjH9khjkdZrPQMI7fQdtifLYuoaHDPVyJreT8B/gXALRt7Cl6N3TV0hMAUnz3Fr+jxxqEgiiFfv+UFHDAvdMpWjmnEXqxlRspjVaIDTGitUVQWTCoiHV5P9eZNvZLVPP4ATq8dbuxC0afnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnqlLt3I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnqlLt3I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773064888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gAFp5NffJ90d8jxyKdfFgqhADKMayxhkc4+zwPm9YPY=;
	b=YnqlLt3IHGrn9mr/ea/Vo8lZOmp0UR/EHbRG/pY+yU9nfvu/ZDDU/MrheADSSk14rRZzhl
	73UwifIS76QQQ1Ca0ME/qsawipeFXMqEYT180tiA7zgcdhlBxCY5ZsfsVNkBiWTwPuYCfM
	vO2vUcv3i7qmPnJ2GZBkexSxS9jBwlY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-xEKTaFEcNoKp-_nIPIXWeQ-1; Mon,
 09 Mar 2026 10:01:26 -0400
X-MC-Unique: xEKTaFEcNoKp-_nIPIXWeQ-1
X-Mimecast-MFC-AGG-ID: xEKTaFEcNoKp-_nIPIXWeQ_1773064884
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5709419560BC;
	Mon,  9 Mar 2026 14:01:24 +0000 (UTC)
Received: from [10.44.32.29] (unknown [10.44.32.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6F8B19560A6;
	Mon,  9 Mar 2026 14:01:21 +0000 (UTC)
Date: Mon, 9 Mar 2026 15:01:18 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org, Linlin Zhang <linlin.zhang@oss.qualcomm.com>, 
    ebiggers@kernel.org, linux-kernel@vger.kernel.org, adrianvovk@gmail.com, 
    dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, gmazyland@gmail.com, 
    israelr@nvidia.com
Subject: Re: [PATCH v1 1/3] block: export blk-crypto symbols required by
 dm-inlinecrypt
In-Reply-To: <20260304121729.1532469-2-linlin.zhang@oss.qualcomm.com>
Message-ID: <4fe2e556-2190-0cc1-08b3-96046432d48d@redhat.com>
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com> <20260304121729.1532469-2-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Jens

Would you please ack this block layer patch, so that I can add it to the 
device mapper tree?

Mikulas


On Wed, 4 Mar 2026, Linlin Zhang wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> bio_crypt_set_ctx(), blk_crypto_init_key(), and
> blk_crypto_start_using_key() are needed to use inline encryption; see
> Documentation/block/inline-encryption.rst.  Export them so that
> dm-inlinecrypt can use them.  The only reason these weren't exported
> before was that inline encryption was previously used only by fs/crypto/
> which is built-in code.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/blk-crypto.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 856d3c5b1fa0..40a99a859748 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -116,6 +116,7 @@ void bio_crypt_set_ctx(struct bio *bio, const struct blk_crypto_key *key,
>  
>  	bio->bi_crypt_context = bc;
>  }
> +EXPORT_SYMBOL_GPL(bio_crypt_set_ctx);
>  
>  void __bio_crypt_free_ctx(struct bio *bio)
>  {
> @@ -349,6 +350,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(blk_crypto_init_key);
>  
>  bool blk_crypto_config_supported_natively(struct block_device *bdev,
>  					  const struct blk_crypto_config *cfg)
> @@ -399,6 +401,7 @@ int blk_crypto_start_using_key(struct block_device *bdev,
>  	}
>  	return blk_crypto_fallback_start_using_mode(key->crypto_cfg.crypto_mode);
>  }
> +EXPORT_SYMBOL_GPL(blk_crypto_start_using_key);
>  
>  /**
>   * blk_crypto_evict_key() - Evict a blk_crypto_key from a block_device
> -- 
> 2.34.1
> 

