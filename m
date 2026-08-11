Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79902352C28
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414009; cv=none; b=fU26n6tGoimqQwI5//1x3/MH1i90JNRPZzcCdkda7NfdeWb7Ix/2J6jHfbZebxJhh6tXQ+p3Ickmv3gqBLHEqyN850/kNWWcJ1xsWhlYfguQ3be9Y3m1tPNtmEza0oYZmHy3NF8WC65SD5m+JvcXRzRDEsMjdMGjbZdXulp6YZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414009; c=relaxed/simple;
	bh=NPkKek9tVbr2Alb7M6x4U7WeXxJD1FMWAbkqHKuzxYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvEyEQ1mllVueFjnnneTQ5F868AtjU3XtkdBK8XVKn/SD6JZwIxB5k1xHjRzlQrtxWns87C5v0XzI35PVzLSbC8uOLmoVtE+Za7Wije7WEb/n3d1luXy68o1tFldpLxFGyN3BqvwvKYrm9JG0jiz9Xb76BuZxtcZR+datg0WEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JNH5xUl2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JNH5xUl2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cca0c5799eso25075875ad.0
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786414006; x=1787018806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XNoTPBmi5ooOPVWeRqi5RL/3itbRAm49mArkGvygYC0=;
        b=JNH5xUl2RMQdyEiRWmDg9q5EAVDIhaCSkVDUWlZlchrqgPEQv5/AYhssqZz9Zb8pox
         yLNQR5CiTA9KTO/Nk9OQNf9WTWyUpBgLI0IX4E3TUCFtUB246N6zec/urdbtCSr9MGLh
         Aly2eUXmahiiOD4a1yi5jKVNlTPfv0s+y/96I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786414006; x=1787018806;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNoTPBmi5ooOPVWeRqi5RL/3itbRAm49mArkGvygYC0=;
        b=tJoiYl6IU6hHkcKZWDSOf1bDQUB8Id7hM2QwccAWs+b7lEtEvCJAW5ZLls508tp6dn
         DNA+7sEMXS7a/E6gGht6hnMwctGP15P1458+uyEDeX2DNYF8U8haOpv2QOrZO4slRNr+
         qBLf0HpOc4Bt6+zhZKRa8ejwYLLp1RLJ6pvF4d5vFa4ucqJYHauToWPQHKac1s89Qe4u
         4BPX9GtgCI7ZRbvCQlr32xs2+zwU5m1jpl0XBMw2OhsDt/6HpfIjqgMfeQVIDImgISnL
         rlefx7XfAAaYlba+6/nX4LbxCJNMCng/ChfWUvbvKT/A9zrpCDAZyMEXe9KTFVbl0s7m
         ul0Q==
X-Forwarded-Encrypted: i=1; AHgh+RryP7F0JtpHsaEzS4ugrCKD0q8ohIYBFrYZeWfFXTaYlmGXGbaYfWzEwYqj+YpyGVHe3b1Fv+pHxa6eIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1WuIr3UlfdDnrCEOjHEViK8X/AjUcwX3mWCQ6zfxH/JE98w5
	wLbCSEvrzFQ6+CgzuZddQCz2/AOl+wFu4nKL5ydcHa/k2pFuu3QFKYo3B67hBcXGIA==
X-Gm-Gg: AR+sD11w9PgxDqisG6CuVXsnExeyV8iOpmRRD1OzDKoFEDZAtlLKMtNZiF6p0i7q0+f
	1LnLllO3yO12nbLe4b/lZERcy8VpCU2HNmUdJD2KBS5upHiEQCxEm2XQUIPSKBX/YsvCENE3ijP
	ReDFWClezDgSQpmeAZEY3hIn8nuW7T/XLyy24l6hUKKRBMWitiJF5XaUBDJyusXQEYL1M6Wel0p
	Q1f+d/n2AEkbTF6m1DbBs73c/YOnucw9SKGn5Md3dguloK/l9GPOFSb2yWYrbhgkxVseiavTcvY
	g/rETPOfheRtq80jTLJQ1VAB28vhKHuwuF9jYaTRPstGDdRNuxATRMv5EWNF5vic1I1bS+CxmIi
	j0A2Y7G31QCrXDu3GcB+Zkn+M1alXWzhKpIP90QXLyVzKCGT92vT5cLQNVnEGp5eexOQOJ5FjrD
	xCTgh1bw02/r1LvhF6PSVF45EUEdl6hOjQdK61kQvUHEXdgGj4rm9dHp1m04O2FAriKx1AwUBSu
	igHL9jEyqRsb2taCb6kNFoG0Z0h6w7uoA==
X-Received: by 2002:a17:90b:57cd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-392823c808fmr23452524a91.14.1786414005723;
        Mon, 10 Aug 2026 19:06:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ddfb:e755:8f7f:81af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050827sm1513560a91.2.2026.08.10.19.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 19:06:45 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:06:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Carlier <devnexen@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix slot lock bit position on big-endian 64-bit
Message-ID: <anqDmZKiVfyNB5FL@google.com>
References: <20260810202241.2436603-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810202241.2436603-1-devnexen@gmail.com>

On (26/08/10 21:22), David Carlier wrote:
> The slot lock is a bit operation on the whole __lock word, which
> flags and ac_time alias as two u32s. On little-endian the lock bit
> lands in the position ZRAM_ENTRY_LOCK reserves in flags, so the
> aliasing works out. On 64-bit big-endian it lands in ac_time
> instead: with ZRAM_TRACK_ENTRY_ACTIME enabled, storing the access
> time from mark_slot_accessed() or slot_free() wipes out the held
> lock bit, letting another CPU take the same slot lock; an access
> time value with that bit set makes the slot look locked forever.
> 
> Shift the lock bit into the flags half of the word on big-endian
> 64-bit.
> 
> Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
