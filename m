Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834039;
	b=mshNDOWOoQgsmRbenbz9Jw/+wxK0hGzcef8368yRGQ25vFSoItbvn5B+JEUSoPbKRiIL
	 xOLAR9e997TlbDaILvfMBRqC8NWCS2EaskhYXKU1bFv0a8/pQ4o5G1e7REfx8qo0F6ec/
	 2SDfypYPNS3bjJobnXOeva3p5W2dgpr92hR3b+QoMbNfBZU91XuqbRhJVkzBmGSjL11wj
	 G4EUbqLGuhMkFtneV2SCkyDO2ZArbKMW2BCfCyfkkRVTlESVHynpYXKWRwdQfY6QCZxrB
	 m2N/tedtl9UP2ejIRD4Elg3lz2XPAITdnxnc+g3TWKxB7NRPAOqYb17ulSGkD2wgMrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=6WKT27fdX/tFqhewESdRPtk5HTiyQzUxICUqNBuVX0M=;
	b=StRtRjRYDwjfdYn3uXsGk+ne/iS3KcsrR9ni03k9BPR/Dr5EzLVaWDdWtW9BtE2aMWFd
	 VEYi8HhWgg9Vx7To8PLkteqF8RzpuQAxpNWMr51vg6xB5Gr90r+RzLVpghs+YHF6bQm7j
	 aWbkm8YwJqqzeFOPOM8PibLToYiE17FwHg3D1X7/RDTUtOBqTdEB1r7eqG5w2f2Z2uBV+
	 1CfEDhkn7OQMZyOanW1ZlvVf9nptKOgrveOkpEhp7d0Rcp5xPh0bxGFAk37sqC9GI7iFI
	 IOdMq4SFcUX25jdBHmu9bM2nTsto1uVl7XovtkwcFyXFL9i3YZE8WgUCMglbkiSLjJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=FiuhkhtQ;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A842606A31F
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 02:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A842606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=FiuhkhtQ
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-386c336eab8so5169950eec.0
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 18:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795834037; x=1796438837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6WKT27fdX/tFqhewESdRPtk5HTiyQzUxICUqNBuVX0M=;
        b=FiuhkhtQpTj02YUL2JydJxu7pP80ao7UIcx71q2j7NDWqv8zjwSqfHsgdYc/vNm9uZ
         OwV4iQpfm60T48BM7zkX30KHYk8NM75Q6QpM3dWv8XQvpRIyXqzZ9SFzsEIx9wgE9mp9
         gbnHoXfhWqG9nzd1ItBNVhu3rrmCjBYaAc0Jk+TW1ufAbAe//L/36bk2jNkDRQQXdJec
         Inf/Fj2kKa3TtaMFUbRAbCfsa+qypmduCT+3CZpkFVDNn6KnVRSBoTqqqYQh7oFQ9q1p
         nHgQJ3LwwMoHLHOJ3j4nVjJkhWMaov75Zvp1GyPiFADc942jmTe3Z3EwST7PFtLDNbDr
         S4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834037; x=1796438837;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WKT27fdX/tFqhewESdRPtk5HTiyQzUxICUqNBuVX0M=;
        b=GZ+/DdCbej7FMZGZXm7CSEGCkviCtZOg/xkeEmfh4c9Lb2JWcWWdu01suqeZAVhv7z
         8dSoMMVJWp1Evv22okfuhyxRnYGZlboYHrp/fatLpx6BOVkuuKCSXZuWkm9+X3YnTJiR
         G067QgNnBTljPtvQc5i9qAn5FewbRzuu/CjZEgWqoIQ+jJYk0b8kuMNjljYi38acY0im
         h/SylLip1ABAaQnEMmhLe962PWE3akg7lPcH9PWU3pEdWiJu0vZk3OJVcQY5c5Y6kvhW
         B232ulaxEUC6M4LG9CqulJxlKMbsOuip8Awo1o6+O1fCTAM16arBEbQXR56ilCgRu3Wz
         LjKQ==
X-Forwarded-Encrypted: i=1; AL+hErF98CNr+XITQZaU4GEdofATCYAuhGDxHDP3wO9uHAs94SjZDRAla7s7ZsOKXBr3/OEJtaHLErnNHN0Vfw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+FOzWK38yU1j74XgBTS6O6NByfuvQ1l/EXOVT71R4gSHCpcMJz
	Hdp9Fbj/QEAVpjLClXc7csIy51h3E73qHu1+xjxqvAro5H+l28+B3+v2zM1waDL2WLk=
X-Gm-Gg: AZFdTZetNSo+xUI38l/wxuh2BUEfvI3Gr+/ltfb8E6T3XXMl5defycK8LECYpryChNR
	YOecaz58XiPqFMTke/8FCtt5kvmYRCBhVn3ZqvjJiCKsDvE5UeKvW2l0Vbwy1YeG6YIOvTojOFe
	Zg4B+iLVJHbVs3JGdG1tBmFTxR8tgvqxEMtC/sxrnZm9y74/CHR32wkBD9ySY7ekx6Hf9/IACPJ
	AXz6Z29msBJlPjppGWT6TtZuce9oY2R1bvOSaaEKKYALJkXSP/3klXhYrdgMpBnjEzVoCCzA1HJ
	WySVa9NtISqYLdk1dobkbvnLTKvfc0WW5/vqiOjgcpB8hObhFU+f6bmgo2fzq15YpJfQ2I6ojHL
	n7kmIT9asEBYd6j/7/zTbXt9nUDDGaiBx68AF+IYOy/mSbGBlf6nXBtRzK4VUr+ucWC5mgbGHT2
	pAmE1nWau3Rz01RtFm5qYlodKWG+aLoT2WItKpzBnewdxmcPU71P0IGpvlPfrf57868OYDrehj1
	dMuZaR1n2UDgovfV9Zo4S8tLKanxsZTIF+AbUwV2AnBXdRT7TdeLZc5I2qH7g9Q8X93rzHZoHZ5
	p+dh2L65Rg2HXrkdVyKobDTLMPeP9STwTXC3XyzWk/HQoWQlEEKSoyzwlGiTMrh+8Cy6oUWkp/2
	0TA5MTGuCCzuSrV478tSM69yaRKW2tL7e9ClstK+pwkEbeYth
X-Received: by 2002:a05:693c:88d5:10b0:386:9e9c:867 with SMTP id 5a478bee46e88-3869e9c2df2mr21137020eec.10.1795834037229;
        Fri, 27 Nov 2026 18:47:17 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm134059672eec.3.2026.11.27.18.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:47:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: hch@infradead.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, mtsai@redhat.com, 
 stable@vger.kernel.org, hch@lst.de
In-Reply-To: <20261120101758.45513-1-dennylin0707@gmail.com>
References: <20261120101758.45513-1-dennylin0707@gmail.com>
Subject: Re: [PATCH v4] block: fix discard alignment for non-power-of-two
 granularities
Message-Id: <179583403624.86956.1820367114895807728.b4-ty@b4>
Date: Fri, 27 Nov 2026 19:47:16 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 20 Nov 2026 10:17:58 +0000, Hungyu Lin wrote:
> bio_discard_limit() uses round_up() and round_down(), which require a
> power-of-two alignment. However, discard_granularity need not be a power
> of two. For example, dm-thin supports data block sizes that are arbitrary
> multiples of 64 KiB and advertises the block size as its granularity.
> 
> With a 192 KiB granularity, discarding one complete block at offset
> 384 KiB is split into 128 KiB and 64 KiB bios. Neither covers a complete
> thin block, so dm-thin ignores both and the mapping remains allocated.
> 
> [...]

Applied, thanks!

[1/1] block: fix discard alignment for non-power-of-two granularities
      commit: f6ce3d09d6480b56e357336ac080952f9525eab0

Best regards,
-- 
Jens Axboe



