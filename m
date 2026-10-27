Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123394;
	b=rQ8C/eAb+T2od3uLkw66xwKcLgg3UrL8t2rzjq79OnR5k0zZPJ8p7kU2AWMmrzLqiRfJ
	 OtVEKvezDxy37Wk0jdOhqpjF3B8BFfVBBiXe+lO9ofa6+3NBJi/anuxXkJYeJExGc5G0M
	 +dYb9NrWUHY+oHERR+Yp55U1X6rS5bTRExtzW9S/9WceGasTpdp0A3xtJrwuZ70rRVOHO
	 EGALGCH9rgt0e+meOJO9Bk7lYRj0XT/8R4llh4S0vZBKoou6S7ocYbgb6+F/F4KKyvsjg
	 fvbyvqNlrFixoEUzkp+WdG7RzX1cdyjTr7kCc1P3kmJ1MLFNdC4H23VDsGwKXf4B9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pmxuATz6Q0v8YZq9eZB17JiD7ofsK6hYGMgJE7NMLyA=;
	b=vQbe+Ei7Zr4ChmFEr6kR9zG9/96izaXRfwZyOL7cIsc9aHnpj+tUQ3lV3GvRXvYzM1US
	 vW3ZQAJhlBLuWA0Llw4YS/3SzU/rxn2dKDa74w3PBUSs7qX6KNp7JcKXrWc7kjgKe1j9v
	 ysRtETlVctO2q3y2KWD3MSeJbzKiDTMIyjoXlW5iWijfxL2ZIxY7IlEsYpyP0WMkUayBH
	 z+ZoO22vSH8+k1zjiomZpokLm0MdScfzc9LOkk8FQF6qotDpB6+8DZL22f/yakEQuGk2N
	 AOVxb7YYlP1T+r0rk+xGdDEKnpuKUps27dgvvrXzz0kBAoQ+5aTHJ5arwIlfUD/EhYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lJFDpZaU;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D8606A31E
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 17:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D54D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lJFDpZaU
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8253bc5a613so86749a34.0
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793123392; x=1793728192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmxuATz6Q0v8YZq9eZB17JiD7ofsK6hYGMgJE7NMLyA=;
        b=lJFDpZaUNnVFoxOeOhYAlbKxKkRmNwhX+/qrpc3NMkWeVGlys9iyAqdiaYS3VIroyz
         zrpV1Mb+cHjD8GY2AA7gOAcrckqldtzEMppf+0/BjEvBMHYfAv7RYEj516GWVuelkydN
         D4Y4RH0K325tgAL8opvxSn7ACfdSAyYsHInbzzm0f3skwOecG1YdmUrTRNSpFk+ZNCtF
         KxAyTNMaqLlyZe3QtMXli18t7lh0iOAzTLvhB+g/38vry3XWlZOsZ9jcHZ+UtqKAgXmI
         aZwcHwEJepNxxTa+i8VqO/+UVIHDlqDTRrihoCZaU6dlq0GVIeCM3JepforsoHe+cT0f
         SDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123392; x=1793728192;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmxuATz6Q0v8YZq9eZB17JiD7ofsK6hYGMgJE7NMLyA=;
        b=QXs9uhOlNqm8aNLkf8S6Eq+j5fwa/gkJbZ/Syu8A6l4Zwp36/55MuUDnr8ahjwhloX
         iVg/lGhHNeHhfVHy+MOmJr1l59PI6VPjovUBk7zRgXZ3wOxVpm4U7H8OHkMrVPso2w7t
         ZDKDjUKPywbedLyXDftdz58TguFV8/dja4NgAXdEb3tVai3OMOcKuDhXggCBaFz1Swmz
         6Aj0/IJbTC9BjUzPYRy44/iwf2XzGRsPibvNss8K+qzLHU8mWBTUD0z8J5jmxp8n7SDr
         LiJt3C4PuLLj0s1xktzLTkY1hsbYnnOKm1tQh1ashHS56C77tKIAwmzoWsMGmLDIkQAl
         zjWA==
X-Forwarded-Encrypted: i=1; AKwUvBzSCz8WWedCceMp7Sd+s0Hl3wBp6y9dpIc+0hq++3ZYNMHfUJZTV2/1QlIGFfN3n2MaMa2ogDavEylMog==@vger.kernel.org
X-Gm-Message-State: AFq9FYK4wCYPH8EYnVpOhqYWagRkLGii+nngo/HmPaVcPqGWpX4fZyB/
	bdjwBRWu4MuFuZCLU5dVNk6xYxffypvcQ9rlG1Y8zOPsUihenqZRC3N34PbcQZWcgP0=
X-Gm-Gg: AYBFou0oNWYLOnEQBHpEifCLlxBHGQgH/esRSeQuLPCpIRXdX7tqLeQ2pRL8aDwxfYT
	ChFk6VQoz++MWmhRk01ImF2LEl9x5Vl+kKp12chquf9FwRFJQq5eqQrFOBT7Io9EtoKxD1P/I62
	ssg+HIvQpIJOJ1YGPflShUwKcx7glo61MGQTZ87z0tGxsq6/B4RKaL8NEKbUYszLmJWX/Z6svqK
	qbMNBhSSY9XGjGmtPey3T/miWmT/kWntwrEcsUb90txVV3Qm7yqbqBqWggKY5gGZwAcSSKQtxef
	Tasdt3Ee+oNFJu6EzK4gbBBxP95N4UE6qs6zPj3GX6Oct7afbQeyFEpX+dI5aPIjNCl3hGXwjSk
	f5+25OIoDYoH7zcj2wc6kMmLcBSO50JPBbI57uTrTnReVdElJkaftZy3N29Z7N81kg0CyYBLtqt
	6oCm6w8BWjdQIf4/5OHmicxcL3b/L3PDG6aNCS+C9dFn3ZteKS5MRNdMJjwSNTvQyuJTo9R68ez
	bS4f4c7vJAUEQmHvaniJocosWzXpw7Vnr6Vp25CKgQ7/xqLnvq+TUHZjgsmhtB14zF+225eVNzs
	O62gRPKwuFGP8sF5Xoxy/Oo3WjLtfK0rSMFYjWM23IYd7+gsE5X5zYdqHg==
X-Received: by 2002:a05:6830:4110:b0:843:98dd:84e4 with SMTP id 46e09a7af769-85ab4e21711mr351411a34.3.1793123391741;
        Tue, 27 Oct 2026 10:49:51 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458a4asm11484186a34.3.2026.10.27.10.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:49:50 -0700 (PDT)
Message-ID: <fceefe1d-c513-4cc2-97be-ee2919601f88@kernel.dk>
Date: Tue, 27 Oct 2026 11:49:49 -0600
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
Subject: Re: [GIT PULL] io_uring dma-buf support for 7.4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b97140d2-df87-4cdf-9f0b-d5ca404d50da@kernel.dk>
 <CAHk-=whLg-od86aV4HU6yC8EKh6zsVWyyvWVOcrVshvxoQ9dAw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whLg-od86aV4HU6yC8EKh6zsVWyyvWVOcrVshvxoQ9dAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 11:45 AM, Linus Torvalds wrote:
> On Sun, 25 Oct 2026 at 03:30, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This adds native dma-buf support to the I/O path
> 
> So while doing the trivial resolution, and looking at the code, I note
> that blkdev_buffered_write() grew a
> 
>     inode_lock_shared
>     ..
>     inode_unlock_shared
> 
> in it. But looking at the two call sites (in blkdev_write_iter()),
> _one_ of them already has that inode_lock_shared() on what seems to be
> the exact same inode (bdev_file_inode(iocb->ki_filp))
> 
> These all went through you in the original block pull:
> 
>   1b1be9ea4e34 block: take the inode lock for buffered write fallback
>   2fec4fd97cc3 block: take i_rwsem for the direct I/O write fallback
> 
> am I missing something? That nested locking looks not just
> unnecessary, it looks like deadlock city. I'm surprised lockdep hasn't
> complained, but I'm assuming hardly anybody actually uses this path.

Someone did actually report it recently, after it had been in
for-next for a long time. There is a fix queued up for it:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/commit/?h=block-7.4&id=21b88cc8bafceee6c6c82503e3b2cc6f1d0c78bf

since this morning! It'll go out later this week, pre -rc1.

-- 
Jens Axboe

