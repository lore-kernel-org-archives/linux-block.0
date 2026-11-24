Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494247;
	b=wjxFKqGOGdfNitVtpB+KC5qs0DYJabDP/iXPCg7pM5yMA0u6tQB+owRi3gEz5Sp5Yhf8
	 JLKoZQlSwGpOSSN/RwJMf/pHFKyuEBBJaOKBAYPYu33HkZW4keu/K74NfCXTFOvzkg3UA
	 384NL4J9QQ66PGri+f/VOP2H12Ecjv9pr8NyImtAcBNdgiSak0ZfvsGOdaZKaTyPIlBX8
	 KHt8g+vGbwNi0GQhbPng0N4CzZRY6KwdHBTRfH/eW0c9wlacY1ul/E/AZCwLsJ3YCYS89
	 jbf5W2skZENuMd1ttuMab3Kr6Obm1HKPbaM1Uk86a304lKPHQdJotHVJJ6+5uQAVB/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494247;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wu7oYu1QU8RKO4ur/IdqUy3c4lN9Be7wq85QvUBYaOs=;
	b=jwUbq2gVzBYFO9iFzfsAGrYRnhBPdQfqSezPmP8Ozk1vrklGQUXS6o9VoGS3y6SDarjU
	 moNcNg1xUBKuqBUtWN28IQLc0oONF3dMjOH5HRXUwXIc8GGh7WteJe6LgtRmvuF8dYlw/
	 8QGjKF7Hym7zRKrf97+lljOF9/Qv+QnKmROcH6inHnKp9kpaggK26DhwIrHnbfMm/fUZI
	 rGbn0N1usj5e8mSA5DUWgmye0vfPp25jrpoIwH3J08QbRtLIcm1HAakhENhCMQLD0lliY
	 fgFQiDbLLPRv4JBA8TAzREoCR4zzxIedY2N7oPcG5DE9ZL2iB8aUpT3qU79xSyjBHjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ggRy/zhn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEA606A31E;
	Tue, 24 Nov 2026 04:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggRy/zhn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B831F000C0;
	Tue, 24 Nov 2026 04:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795494247;
	bh=wu7oYu1QU8RKO4ur/IdqUy3c4lN9Be7wq85QvUBYaOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ggRy/zhnd+V8PBLNd3Z0cN8h3gGNHymguOTvVTVS6muBuKysOkkbAWcCwZHD/8eaz
	 gBwJCcsqdKt90m2g88yFUzZFp2m9D7gO0mvhal5+JHKCls7Zj7QnqDC2qKyyK1nXUm
	 o+k063D5yKG/6xmSfAXcKS49f/opJZ2z4O3ifzdq6xn+oFlUnXz3D6BFwZPdBBG1UY
	 BN2gNOmZUT41muKu3fxb0QyA3pYwyIKxXTJ41RDvOkaMtIyQsRqG3s4MKqp2VBMmpk
	 O7DnNrttXPnHl9mNqfWB7EEqmDE4t3TnExNKCs+yzTYU+LTBnSH2rnrrPj1gn+TBan
	 2ieOrcJ/jrvng==
Message-ID: <dc7e8985-733c-4e64-88fe-88323735263b@kernel.org>
Date: Tue, 24 Nov 2026 13:24:04 +0900
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_blk: validate zone append sector from device
To: Annie Kim <pulpannie@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261123084701.2616027-1-pulpannie@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261123084701.2616027-1-pulpannie@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 17:46, Annie Kim wrote:
> From: Hyokyung Kim <pulpannie@gmail.com>
> 
> The device reports the starting sector for REQ_OP_ZONE_APPEND completions,
> and virtio_blk copies it into req->__sector without checking that it
> still refers to the requested zone. A buggy or malicious device can
> therefore make upper layers believe the append landed at an arbitrary
> location.
> 
> Validate successful zone append completions before updating
> req->__sector. The returned sector must not precede the request start
> and the entire request must fit within the zone writable capacity.
> Reject invalid completions with BLK_STS_IOERR.
> 
> The polling path may batch successful completions, and a batch can only
> be completed as successful. Perform the same validation in
> virtblk_poll() before admitting a request to the batch, so that invalid
> zone append completions are not batched and are completed with an error
> instead. Move the request completion into __virtblk_request_done(),
> which takes the status from its caller, so that a polled completion that
> is not batched is not validated a second time.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Hyokyung Kim <pulpannie@gmail.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
