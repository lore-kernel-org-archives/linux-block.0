Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716264;
	b=BbQsHTxSSlKgZ3alFEhR0S/QJdTZT/vvmhAEoolckZKTQmmfFzMbAGk3vNFjihpihAo1
	 TrcjVybkkOcUiXoh5OuLRKisKeO8pCxdb5jiDBy1MwI0fAGazJ2f1HiRJ36lrc72Baex4
	 9cVF03O3yDNUjoxK7WYc7EBA9yXfd2lPEQzwsWgbxw0EbyC2Xfaad7U+zr6izDEkpBrsD
	 PXCdiNN0Xga2J49lK4lb2b3McEijtuIchUWtJuI052CX9DGnEEVWe1p4q/dTT1oO1hVgF
	 z9h6diAOmpkZV7CXrHOdHX1LiIxp00tichb9CGimYDK6t0clE+KNFQmmDnpY0tp2z4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=LHkHgSTWm4PEAV1u0V+AYcuaS0pJzqhlqARjGallgdg=;
	b=kIrTsSaioP+JPrx+yKw3PWDFerS32w0y3MkEt3v+p/5xvvSs3GTihvDhHyq+FpNVX0W6
	 U4BqesrGPaPqFB9BNZpbsHEpnFoG75963govFbuN48CW2VYYA3dvfX/IotI09FlqoQsHS
	 301fxeP2H4k+v5p0BH1i1iyTPjGsHSqIESmFRxHm4MPC7064YCr2K90l8DgmVxpBe2p7A
	 lp+NiGrM7PEn8POWxKRuH7OMdAcnx4nWVwuYWE2ZJfeuYnb2D+1L4M8D1VH66gPFrCWlp
	 0guq6KQlnePbRi28EUDsw5v2LaddwP5Wec7bfs1bPNP0nHln2k3HK8D/NwfsmMsu1lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e7808rs4;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF00606A329
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF00606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e7808rs4
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14fc585291cso3354542c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716262; x=1794321062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHkHgSTWm4PEAV1u0V+AYcuaS0pJzqhlqARjGallgdg=;
        b=e7808rs4tVSou2aun50S4+VlSYTO0R6/b2NyErLTAX8IvZXOZRxNRa6n+EZtxNh5mV
         C+YfuxFAoY9E4LmCpswZmQh72S+rdlLnf9PEOOzqHP8zmRGP06rlzdxitRZZJYaxkwjn
         2moRf6sOhZ+/HeDmXqfkDjuL54J1XK/s4d+r5PRaoP3rC6j5gA1O7hJ8QvZxXFbgZ4iO
         hnRZ0EU06s0fpYYnwiLpkMo17fdmysqqNg+isAaWy3/e4PCc1vZo4M/TdHcvF042Dr4C
         QmjeLlawn7WvGtjF3ShK8yqiLAkdazD5OTOJJ6X/5ZjaygNDpAK1gCUvZg50QlxPzSJ5
         9SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716262; x=1794321062;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHkHgSTWm4PEAV1u0V+AYcuaS0pJzqhlqARjGallgdg=;
        b=dVae3chjwblbadkGvWZ19AKFIg9GTVgwIobzaGNpBOpqetfdW9phLY2ss7dHieVOtb
         BsYaWEHvv+wugRwQT/UQXzycFa5BelbxEB9aBGTCeNFSeHd3gub+eVdPxzhsehq9ifpO
         eWDkRQMtzG15KNn2LzbcUT+CN4AyOiQ0Y0pEXSpdNem0shzzKtjH6gepMUPv07st5hhv
         cqkHTaVix18jheBekpnlsKCim0GiC/TmE+Ipv/xD35/hm4x2oWfvX3U/xx8mwRSEFXpc
         iKUTTbYK7qiThNwRphu54ef17Aoa5BJqqfTyKHVQATlP5A638nZsKGr+dQIE2IABn/Wu
         ew4A==
X-Gm-Message-State: APuU4Z+U9mviH4ejHqb76flDlFQ8/XhnaCmGuolg/OB2HZTmJaw28J3J
	5T2ep+inDJtbPFKJGJdccUbV9IQdQax4GhLZd6jEJBFyFcFOV+upsAIGVjZVkVIoaak=
X-Gm-Gg: AYBFou3YAECtL1Rac/OzEKqIVaEVDPAtK7pTBjlEKRAKb+vrZO4dka5/m1L+v734fGK
	chl3gjiT9t71nzEt7WpeMRS/hFAQDtnP8aIRmqvgn6Adv0rkCmX+2Ohu5F/ZiBlafQvnAvsO7ef
	QDUU/F2AgVbzrj+d5miav2QL7dbIcHk8OuH2nz6gbn2mnt2HKrZaghueRLdC3tELWKvZp2h/e5g
	ZU5cdcNRRSbt3SHb4Yu1+jjlYiGNeobkRS8ARTuYKpfitI3VfToVIBX6whkfMRpVh09MeDGIRGO
	PkEnK8Q671aK3B1aseZTNz1PhqU04PWTe6Ia8FlMrqsilYzrDbV6FkI5sdjKWNEBPtkD2LFjRjS
	NyclprGHpCwBnQYj3nNpNcY6xsPvw5RpLzu+DZnSGU7IbdxRhcfN2J8iQ48ddHElog2UkIfsmGN
	TVXa+fANR8FW5gOjMAxRJBlxS5HbVH7VnwmKRuzchz0hieDjNWO+SVF8QwR9D+bH9og4T3FWaqi
	zyO/q9FH95eAyeAJtry9f3btwTa1BlaAM5D01GqSSSVau9lPYcIf2/y+wTgENka/lVWXxePdY8+
	HN7uVw7dVXN8ErWx9BDYgJ3agtdE4Np6zt638DnO+i+gjaR/b3ri14oxkKYDUTGG7SIuXzz4Ho7
	ymTYyB0IbR7Ak
X-Received: by 2002:a05:701b:4542:10b0:1b2:42e3:e5d7 with SMTP id a92af1059eb24-1b242e3e6f4mr1359237c88.34.1793716262106;
        Tue, 03 Nov 2026 06:31:02 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
In-Reply-To: <20261029200110.1328103-1-ebiggers@kernel.org>
References: <20261029200110.1328103-1-ebiggers@kernel.org>
Subject: Re: [PATCH v2] blk-mq: end the request if getting a keyslot fails
Message-Id: <179371626131.3691261.14610016364741901960.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:01 -0700
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


On Thu, 29 Oct 2026 20:01:10 +0000, Eric Biggers wrote:
> When blk_crypto_rq_get_keyslot() fails, blk_mq_submit_bio() ends the bio
> by hand and frees the request. By then blk_mq_bio_to_request() has done
> the IO accounting, which blk_mq_free_request() doesn't undo, so the
> in_flight counter never drops and iostat shows a device that is 100%
> busy. If the bio went through zone write plugging the zone stays plugged
> as well, and every later write to it waits forever.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: end the request if getting a keyslot fails
      commit: e67cb6ed40e7f45912b63d7d575f18dfd2ebc98a

Best regards,
-- 
Jens Axboe



