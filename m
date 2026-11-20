Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186892;
	b=oVz667ZbjiY46nwVQKpvJv8CaKm5r88weTj/xK77V+YibWsKc8HrfNMZW980yfV6ZKUV
	 AyJtnTWS8NtXIjHnt2BHcoDTgHztKIUV4yjNnlfn15+QLj2Qq3rkCn9oboRSA+7ZAo+sQ
	 hN04LxxKJY0QBlqVP0jlN+T7xGTNUyGEkjxYXoFfTJm/qvWV0ENz5JTxJhPYhZHnheKoq
	 kj6HIeQ13itvgjbxnzNPSPsOwncl3MfFLuei2/gdakVuuIM1VVIYzGBo2c5GSRXxZwXG9
	 8j7OrPZCwvjRM0LFdJfuxdfLBO94USvSS609Ow4Ew2sCFJFk7DdTOjOH11dp4tEejGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jrWS7IBw0l6WadgVn6pAwxzws8JpQ7BsYeOxejRCwI8=;
	b=jQY/PLNOQI2wg6aoCaZLFKeEnjkiKcjGahc5oawCd1ePcs5Kbblly/A+1t+kxQOZrWmu
	 oC+NYmkmUeT+KrkYD6jC2UqWc3Wt4aTKqB3FGHx5UNmTmOIYGC+gcfxJFbaWoC2KccKa0
	 T8ZZocBrvKky2ogN6AYUcNRoYtL7B3KRm/I3gaFclPYoUOvIUnN2fjofxjM6jfRKEK59/
	 3DPNLA54BV00vydEotA9Nn3Dxzia3NGGVWs7ZnTconWSYx53ynJ62FeNvPijYi52cdxZs
	 bjAs3BJgS/SVsIsHfxNcDqUHSeyiq+LmFpZFjhTlPr8VZrgrvy1BOiTgb2N96eGEmAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qM7lbabL;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FECA606A33A
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 15:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FECA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qM7lbabL
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f042a34db4so4361325ad.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 07:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795186892; x=1795791692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jrWS7IBw0l6WadgVn6pAwxzws8JpQ7BsYeOxejRCwI8=;
        b=qM7lbabLobt+s8KA34fnit/qF4Wrgk4yasw0UTHe1wjYszmHHw6YhlBKblD9XjZruM
         kGxFeDpSpCuURInCwfoSJHfQjTrBlZHgGn9PpT3y8oTID2k2fuDArkum/lRcvfELeMP9
         KAJ4tfocyyDNM5ZppLSzYVopvaDbfSB8wRAY5p45N/Du/pAWPgGquGxLXHBk0DqOI+m+
         UHHY/OJZM3vaehSpysEoXi60SqlyZVLOUj2lJJ4RjECXLUVrzzJoq/KfHgKg78+BKINk
         7IsH6teynkZFzo8fvjupZ8U09TmB73WvyKdwsuhKjzHeKGL7fWopzyLJrZF8ZGDziQfc
         VnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186892; x=1795791692;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jrWS7IBw0l6WadgVn6pAwxzws8JpQ7BsYeOxejRCwI8=;
        b=kjOX6nf650QyVW9btJRnaj74ChSL14Vi64iSq1YsxBBFlgUPgtRcdkaq5DvR+ce3Oi
         8Br++FoXeO84CVAUGNOD+Ah6WPa7RyL2xlftYHo6l61BAi0i3MQc52KlW9r9XWRivzez
         coHDeq63OTYsbwkirqxhxT0F555OaLK7QKwOtr4MaBJzsHPmjIG6Ldx8Fch7PQ1XoZLZ
         HANB4LMlLYJQWpGGkwo8QELDYwqcZCFfmWRz9rrlqft3kTeLAWX926VF5L68jcNqxTnY
         +84rjbMC8aTJw+Jb+7Ybo9jb8G5pQWRVIEMHGyuqYq2gEAV27kDgU+dMZyuhv9QuYTwt
         aloA==
X-Forwarded-Encrypted: i=1; AL+hErEdEjj9BMdwIvKzI4eGECo07y1mmdJw80LnKgZidb9cJOmARVaW8KneaqvXPvcHyNeW0Ecvey629K9egQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8s1ksx2tZT4w3+1FKUTG4NTQ1fK7u1e8tGZmRPyeNNI+sDwuPA
	qzK4QqA42bSDJP91W5TN+vMBCYcx9/PawpvxcWOhmXFDDnPX0i8f4jhkf4zKzce8zjOLfGj01hh
	MFCdz92o=
X-Gm-Gg: AZFdTZdPAYeBzoNNg/mc4wNyN6Kj5EKyA+wZFog/C9SbXcJS4ROZh3KvK0OZ9rfVxsu
	/iNl2VdIGogkAATSK55amvIMgoH1k6ywz/GrNJL5rGyuQDsmCq9veytNjRX02nhqyztKe3Mmse/
	u4r8IDAv3iB8QEUORV6ldkqNvAcxbnWYcaeeLjEMgy4lEY6J+aY6K/xlTT25JD3gQre5nOv39Cv
	nMfPJCxVT3LcX4rRZFQyf4cWAcwO+yYO7TaGlnb+Ed+p5jw9t9x6XP8dooa5cqIc6HDcVo5/Q6Q
	UN/s4sVuDMfL17QmfnFGrn8KIhz5ouyYm3L7ksSkRcbRmQJJ5cFzDmPn1BRUPETmUJ5D941uEJL
	5T3Mu2pfbeSf/JxntDeY2YIesHMBFq+XpuGpE41uXpsgpQH6f1jueL3dsMvHEXD6U3iV5Pg4Y5A
	hLgZNfW+lKqyi4UotSk8oW8d5d+ZaYBvsJ0kXe7mpK7a7nO0/n0zpPeUAWpKp0EFXXHdQ2MTjL6
	5ZIHkUve3Hq8FS58nl/7NcUA4+PYz8pVUOQB+mEQvTM0BZoVfKTrQz8ejunIWaBmXoMDCqOlaVv
	YvLlrYrrTBJM5rSx+PtweCjMhpYcek0QH9dhgST4oZLqQXCRs7GRivMDN9wvKJp1HjvjnX9XUWY
	5YcGVEsBxX/xW0/SM6ibatpgEGPcBRhVr60qP3+TH/riBOMjj1FTtmkFeSQg=
X-Received: by 2002:a17:90b:3cc7:b0:3b3:c6b1:2277 with SMTP id 98e67ed59e1d1-3b41c93cdc8mr2237808a91.32.1795186891769;
        Fri, 20 Nov 2026 07:01:31 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:8b25:951:ad8d:5cc1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm4680914a91.8.2026.11.20.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:01:31 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: philipp.reisner@linbit.com
Cc: lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Sat, 21 Nov 2026 00:01:26 +0900
Message-ID: <20261120150126.3128366-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
References: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 06, 2026 at 12:57:13PM +0900, Yehyeong Lee wrote:
> recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
> accumulates the bit position s across the runs.  The upper bound
> (e >= c->bm_bits) is only checked in the branch taken for a set-bits
> (toggle) run, so a clear run advances s with no check at all.  A peer can
> make s run past the bitmap with a single run; it is stored in
> c->bit_offset unvalidated, recv_bm_rle_bits() returns "not done"

This is superseded by v2:
  https://lore.kernel.org/all/20261006141509.521128-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee
