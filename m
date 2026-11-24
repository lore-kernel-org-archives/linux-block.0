Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508278;
	b=W3/Yb9+8fB6/plIJvB3rr0fVVOKphXW5bx2RxEt+f1dpAOg5pimS9gRPCyVIl6M901VB
	 HDpztgTuhrUIK5yPh5YSKk4rPcFDNBYmp6MjBkzaDmvjDJL8hqonDjusUOW3I2QHnIPoT
	 Seg1m2YgKWGpwQM4u6egGs/8kMeWbcbSBHfyi75hvk3VTwkPtnxeH9FwDLP3x9RI7UkMq
	 IVfd2p8Wu6du0UU48nmaWLB3BDAGfMisRpGRMez5QQ22nw8A+PTzihTUpRp6ntfHWhQUp
	 TIZmwHEg7KnK/KBTlodAPK8TTv/W+A3u+keWQ6TG9ERAlhWQcoL6E5q2yY6OPvfbl4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508278;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9dJiNk8gxdRuYrKL3H6plyyjDPGqi0RGZ08vcQ1VGC8=;
	b=1ifH1XrDyNNion3j7hnr1G/OMctdjtpmjveWfw+sOuShy232dvoH1ZKTiAfZYSIL2r1w
	 se2W0E6NNNosJYY0MgoMiRnRlT5cmVN2yu5Xz3MMlbVkyCSLw9BV6WTZvZZueK0MliaYN
	 ym/kEqv+54gu3Egqg7qF1jgPKteEJRnY/o+XGrlrpZEzBgl5p5OnJgzPqYT7ciTeUXE/m
	 W6+Ux8owLPlqOOrUGxNvhlGfFpZKpYEwO9GaDyKNExdh/TRAQoF5JRIMP8XBNGjApVnqB
	 tckXjtr+qOnOQ15c/qHVIXIpfdE6zceCLHPv4MHJOttlk4OLMRXXnlkTNxzxdVyIwwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2sQHwin;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30960606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2sQHwin
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280411F000C0;
	Tue, 24 Nov 2026 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795508277;
	bh=9dJiNk8gxdRuYrKL3H6plyyjDPGqi0RGZ08vcQ1VGC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K2sQHwinjyApRatHYRR13pmekrbmf6s8NRiWDdTTxqfLMIc18Raxpq94OUQ+2neUJ
	 G+sJ0zN/NFpC1/q5DwB18GLb4RpLJZamkWzuppVuiUh/mrEFpXiSyybtNmB5HXB2DW
	 4y0oSH6s7J+yU30rh5GYYFGGXDfPaMvKGPEastwkpEXHRVbObJc24/XCCE9ZFxIxjC
	 OjOxkt1jCIPjqlQLJedQj/d5967nU/fr3sTc3Cm4WjGgYayWjMAvVr/Vt+YZFk09t1
	 ZR/+6rbGYsuBKwel/7ER8HVa0pU1OIB45ncJRZHDMboX3oL1Q7AKEy4gi+IJ0D6Rye
	 56zvsU5rI83Sw==
Message-ID: <75e48a8b-c128-4218-9d76-50e7256e00e4@kernel.org>
Date: Tue, 24 Nov 2026 17:17:55 +0900
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
Subject: Re: [PATCH v2] block: don't wait for all RCU callbacks when freeing
 zone write plugs
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20261124-feat-blk-zoned-rcu-barrier-v2-1-6d2212a48c5c@linux.dev>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261124-feat-blk-zoned-rcu-barrier-v2-1-6d2212a48c5c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 16:04, Qiliang Yuan wrote:
> Zone write plugs are allocated from a per-disk mempool and freed with
> call_rcu(). Before destroying the mempool, which happens every time a
> zoned disk is released, disk_destroy_zone_wplugs_hash_table() calls
> rcu_barrier() so that no zone write plug is still waiting to be returned
> to it.
> 
> rcu_barrier() waits for the RCU callbacks queued on every CPU by anyone,
> which usually takes a grace period or more, even when the disk had no
> zone write plug left to free. Removing many zoned disks, such as the SMR
> drives of a storage node taken offline, pays this once per disk.
> 
> Count the zone write plugs of the disk that wait for their RCU callback,
> and wait only for that count to drop to zero.
> 
> Removing 32 zoned null_blk or scsi_debug devices, base and patched
> kernels alternating over 2 rounds of 3 runs, median of the 6 runs and
> range in parentheses; "with plugs" leaves four partially written zones,
> and so four zone write plugs, on each null_blk device:
> 
>   devices                      before (ms)      after (ms)   change
>   null_blk                   820 (805-885)   438 (424-454)     -47%
>   null_blk, with plugs       876 (852-883)   844 (805-877)      -4%
>   scsi_debug, host-managed   958 (945-991)   642 (630-652)     -33%
> 
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Looking at this again, the new atomic is never initialized with atomic_set(). I
think we should add that to disk_init_zone_resources().


-- 
Damien Le Moal
Western Digital Research
