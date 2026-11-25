Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643971;
	b=kP4bpM2w0J9H7SfuyPuNjEhnhyKdrUHZwZOgLOJ5+St63bulMwKr9vwoTkiB4mCahO0G
	 e3eDo52jGwmtVN41U/3bBRTfxLfPXdmzbD6L3niBQg9WJXH8E3MK5Qwb7JYtEKbAZN+25
	 V87VoUwZ7wcjuWsU1p7OGzoqvmjnJdICiQdkrPQTpG0GS78zuUm07Us1/vegH4cD2ph9H
	 0BKUM094Rr5zM2H+aaFKR/ETXNdZxwpn06bcC5nZDm0+3ZcVtD0fQA8coKr+6naq56Gdp
	 kUoZfnggMwAdOZEBDUSEF5bXNry3p5S6G3sKRNm9F7mmbIyJ6VgniA8h+emK8MoHFXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643971;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GZ2+2BPQh15PjWtNEO0Ke2+kPJKNayePNFi/VzWA8cc=;
	b=HDvRS+/0OFgAPfHW/F4NT1+oetQEo7hKEFWqqqVwqt/MFY8LQ2Rbj4UnTXeSPkC/P9IO
	 SLgzuuMjIIa9KHT02u2Zr1siULvidONIDRUsD7DSXTramn09SPqpHbHZwSD9cutQy4OLD
	 HfAJ2hXNHKzFrumFVxeiCeo7L5C05RvHf5BGSgUmRKQ1dUj6tQFl4GLD7Vc3Ah+iDdccm
	 aMhPuYcWyDEOSPkH1pfW2rk3IYTFjEPd8lpLDNRo2xCsW04allAcW3R9pqbHDIPIYsn0u
	 ofoI4taMznIR20OtBxztBvDl9QVgTfJQvWzOLv+PdmQeTGwbBcvdwKD03VV3Pml2ubQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMPYjd9r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B0606A332
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMPYjd9r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79D61F000D8;
	Wed, 25 Nov 2026 21:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643971;
	bh=GZ2+2BPQh15PjWtNEO0Ke2+kPJKNayePNFi/VzWA8cc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PMPYjd9rwc/8fjWoMdSeiJSCS+nd+YyLdMQHhx8XC5Lm8xOZat1dNveLOHLGjoWia
	 gRn/9N8/92nM1a43/Xnjdj3X3vIGHx8N4llxkBKgMy0R8DTI8fXBGB0/FUz9JzMqtf
	 1y1gYtCFR/PFdAQBJYYQYOVmwgEDssK+W/alSUZKiD/7epteJ4YTOMjsNLbQmdfLVL
	 mvCdqZndvvJaRrjh+f4slMH9TFGNnUX/tSSGPeKdzikuNmh6GCXKZMatSQbz7BK9BR
	 krqYFFV9cWOCeB/6SvGEEcqdqBH+AAPnaAd+wg6a+fYEHxAhDVj1NyL0VB+I21ECgo
	 rWfOk7mrtOT7Q==
Message-ID: <a4eca17c-3d44-47f8-96ff-135671c2354a@kernel.org>
Date: Thu, 26 Nov 2026 06:59:29 +0900
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
Subject: Re: [PATCH v3] block: don't wait for all RCU callbacks when freeing
 zone write plugs
To: Bart Van Assche <bvanassche@acm.org>,
 Qiliang Yuan <qiliang.yuan@linux.dev>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20261125-feat-blk-zoned-rcu-barrier-v3-1-707f65bae05a@linux.dev>
 <4149778a-99ac-4193-b06d-b032184953f9@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4149778a-99ac-4193-b06d-b032184953f9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 02:00, Bart Van Assche wrote:
> On 11/25/26 00:41, Qiliang Yuan wrote:
>  > Removing 32 zoned null_blk or scsi_debug devices, base and patched
>  > kernels alternating over 2 rounds of 3 runs, median of the 6 runs and
>  > range in parentheses; "with plugs" leaves four partially written zones,
>  > and so four zone write plugs, on each null_blk device:
>  >
>  >   devices                      before (ms)      after (ms)   change
>  >   null_blk                   820 (805-885)   438 (424-454)     -47%
>  >   null_blk, with plugs       876 (852-883)   844 (805-877)      -4%
>  >   scsi_debug, host-managed   958 (945-991)   642 (630-652)     -33%
> 
> Real zoned drives taken offline on a storage node typically have
> partially written zones and therefore still have active zone write plugs
> in disk->zone_wplugs_hash at teardown time. The reason "null_blk, with
> plugs" only improves by 4% is that disk_destroy_zone_wplugs_hash_table()
> frees those remaining plugs via disk_mark_zone_wplug_dead() ->
> disk_free_zone_wplug() -> call_rcu(), which still forces an RCU grace
> period wait for every disk that had at least one active plug.
> 
> By the time disk_destroy_zone_wplugs_hash_table() runs from
> disk_release(), no RCU readers can still be accessing
> disk->zone_wplugs_hash (the function already iterates the hash table
> without zone_wplugs_hash_lock, assumes every plug has ref == 1, and
> frees disk->zone_wplugs_hash synchronously with kfree()). Nor is
> updating disk->zones_state needed, as disk_release_zone_resources()
> clears it immediately afterward.

That is indeed a good point. Thanks Bart.

> Have you considered unhashing and freeing the plugs still in
> disk->zone_wplugs_hash directly with mempool_free() (keeping the
> WARN_ON_ONCE() checks) instead of going through call_rcu()? Then
> nr_zone_wplugs_freeing would only wait for plugs that were already
> queued for RCU freeing shortly before disk_release(), and the "with
> plugs" case would skip the RCU wait as well.

Yes, that should speeds things up significantly, since under normal
circumstances, calls to disk_release() are done with the drive already idle for
some time, and so no zone write plugs rcu free should be pending, most of the time.

-- 
Damien Le Moal
Western Digital Research
