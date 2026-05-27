Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22C2DFA3A
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892683; cv=none; b=ikphTyn7QCApW1W3ksCivP9vWev79W1n7rwQHx5OY2VcLHV24gY5tsR/xi6jVHA/F+lMolzImklW2NraLgnb87PzkblvDX7ycZBrpIue+Ofb6DIUqxQpgD+aRIFIMfR4QNz3PYEhWe8DglVGagqZCXpRuhhPgUCK8G4sOVVjDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892683; c=relaxed/simple;
	bh=7Tw8blTzWExKa+fiYKDw/2Qtz6VkV9iIiOjF9Jiph9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g3Ue41gMSEyKQgsSogYuRPnYMyy9VoAX00G/Hz8fmNhcsEyr1gMHGB4oTs/9fq5xNlRECAfd1MVwodRxnW/uvkpjPDV98DcPgm6Hei9ExUC4OFmLc+htGv/jn9W52O/nYfJFQWuzmA0omAkjCGCBVapFdhoM02azvcar8fSM+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=DZS+Hpfa; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="DZS+Hpfa"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43b78b54dbdso3310835fac.1
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779892680; x=1780497480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zecYAQBk+wDedXs6mOLsZBG4IOTyDnusWVeZnPoBgS8=;
        b=DZS+HpfakJRq0b7FuCXPfx4TLswCy/pdekcGyap+xGZVNdcRG3K4y3hea7aWQmDCzB
         Va+fioRaWpjKYBzTf1RlUYxlhU9bMtjDeU+9pPAswpkq46UIDSgUvyBXoe6f7hWew2jh
         faN8/v9RZluzjW/rMHHZgvTI9WUqQg3WMc46/6SG8vJHYLCkVkQu1RAN/NuhRJKzaB0D
         jm4McwRsFPGqPvN2TOe86VrFSUtC4XeqRDDdChxgF/kkuKwO6ezIG+pxkY4qbuvrvUmf
         +2bADgEFh+b8bnFO4ojtQhkOu5SpLt7Mi1kos1T3L2ljc4hgSic1kkXiJ1dJ8/RAed/c
         lnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892680; x=1780497480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zecYAQBk+wDedXs6mOLsZBG4IOTyDnusWVeZnPoBgS8=;
        b=j+kQFYNnK38QQEiWy8G2cOxYwcN4PmWtB7jB8ARYuSp6f9QlsomXkkKAWiSSMtnalA
         wZlkGwC9ET14U+jMEkbtMwgIS67apT2cD3Jo6qzXLb1QJBPDzQopeQf6lyvRicKCCS4k
         +Ztyd8Rjy9fe8CYQFzrz7MHgWSSsiVvk/afoJfcKyi8ePDL+i1YfzBRjEFc3bB8lWYAn
         J1ETcPi3mtZRyH2xBWTMjYqW2fMkXTI2U1praNR+FeZouxVLK9TEvqCIvju0zJDjXSch
         BAg56p4mu7aOXBZktO1Q3MNulf+9I7eUQxyDdYGi9vKlA/B8UHHtiS1ec17VD8mi+1Sh
         jsnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9g49/VH9AJuAR72+uTl1S/7i80xqh1EYU3+/UiykzRPimgvBuAd/5UNOWJz9f4qev/YUiR7pEQkouHCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk/NKwOIGgn1hwCIrBTNIBr4dgS3bFavQbQdVc8ZTcLnGEV3Xs
	HoaL5z5zUNWcBuegMZcafVf+xYsQCEOMfKWG4pURiVWD4xJUJTxaoBP+dGV9/TN8fXecw2zL7sB
	yI4biUag=
X-Gm-Gg: Acq92OGVANZj5pZ5WmNAv3SR9DeBydOScRJeNGWXW9fOiMkuQfE6itkk+IRYaSJikB1
	F3a4HxFNxpEoR/TARfq5lE4612Fx5QNoybYSjcxYkZy2U+iN7Fj13JOnNREaipYzU4k8zOZ3sI5
	FGqKcKSFqRudUSLZx17dUTOX6wHlJTVwYEWDnpO6UbvlI8IIUc4cJsVez0jUaW9mdep4loTlt3s
	EHNNpOmPkNbVfaUCZY9kwUE2SBp/K+LPeX7GntSzjTPdqgRi3otw+9LBBlbFOHpfFqvuFb2ZlLe
	xXuGT/l1rKUqAEXuEd3MIvK2+gIkxYJmtyH/Gb1eI6k1QjlF4/+grwfkMgRAnsyCD5OkYiRuUfw
	GinR+KNqNsJPePe9LBXSHxBA87ffFFt2fNhQPNWGdpWBmloaFjEPR2ZqjQ9v5K2SURpPreeBFcN
	9EgVvPw6GhaE7X8oCRTierNLScI6iEdGPWuXWMnrIhSDeYkWJVGFxJOy1F1ONEUj4psv6pwpa7O
	xXbNibbRui5rw==
X-Received: by 2002:a05:6870:2b08:b0:41b:edc8:7b93 with SMTP id 586e51a60fabf-43b5a576a3fmr14403973fac.0.1779892679801;
        Wed, 27 May 2026 07:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6351a772sm16950878fac.3.2026.05.27.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:37:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>, 
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20260527-block-v2-1-8e06f914c484@kernel.org>
References: <20260527-block-v2-1-8e06f914c484@kernel.org>
Subject: Re: [PATCH v2] block: partitions: replace __get_free_page() with
 kmalloc()
Message-Id: <177989267830.742656.16328543608099641872.b4-ty@b4>
Date: Wed, 27 May 2026 08:37:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 27 May 2026 17:33:28 +0300, Mike Rapoport (Microsoft) wrote:
> check_partition() allocates a buffer to use as backing memory for
> seq_buf.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> [...]

Applied, thanks!

[1/1] block: partitions: replace __get_free_page() with kmalloc()
      commit: 17d7492a50251d913ae7101f898cf30ede856cde

Best regards,
-- 
Jens Axboe



