Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C71F463F
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920910; cv=none; b=nusRkY7MnCtkh6S4+V/NoeO0TtKm+kyGXp9XTctGRxRNe2n4rRghJ7FM9arr5J8qEFMsN85uViCTUfWplyGHsBcYPQi8HGUpWiZzbcWMvcyi4Mbj/K+wbiwI9wLwyHCnHjUD4N0xpraW5aZJ2UEvvUthOT/pwylY6cNGFpydpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920910; c=relaxed/simple;
	bh=STsPUsLHRGaJhQCS21q0YWuD/BlvmNCkJ7wEGDFgCZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YujjReiWz1RO4NZhDerHF2Fh2w1AsIZLvV74hu6mBFiweDGTUEImnOim0dSiGq4OcPn04SH1KtLY0EwFzKR5DC3hp0AZERBneDQY9teBkyL9rmq0//CAOf/oHSbmKF9s5VIazisActFxsOTEyT9AuSj3oQmdAYp8ATWXM8x3WsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YTv4Z/bn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YTv4Z/bn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32138e0d9adso3705288a91.2
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920907; x=1755525707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrjwnJSZ+wZDyD5fuZ203u2zL3TESbG9zGrsZ7kj2OQ=;
        b=YTv4Z/bnPFYjEv9hnkCGK9OYnIcSH7+EkDOatkI7fJaUpTNI0n7o/d/aznfSRVL42T
         ZAEhK2GhhkfmjR1KtCbf3yLR1FhlNs+Mxa3HeX6SiEWmveCeP7x1OnZu++5uNzAYTTaP
         X/ge2FvutLyubZ5QZEotNemuwDMt21l0cvrXZls7zivrcTk+faqAdT0N42BIJol7C9gX
         INzdN3JrRY8F4EJMkNv9zdeaiDLjE9QxWt1B4UVA4JBngJqa3IPxT7oexcJ7hRWnwGsH
         DVkwktnbikFamYBuNu7TSc6s0nv50iLnzEyZEu1KHcVTmkfpLIPG1i8nPTi0FAzRTv8Q
         VHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920907; x=1755525707;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrjwnJSZ+wZDyD5fuZ203u2zL3TESbG9zGrsZ7kj2OQ=;
        b=PAMEsJvW8N7sKB1JtSyZj5qofPCafD2OnX0uxG24FJSTXUQssYT9BS/ii9mAYX0ILV
         rsNu//PS095xiTS9z9sJkjKQj/p2LTyzfAO2kzgDpJIrQtql6RI5M3+WJHCvkGZLZK98
         N3m7GqQGi/MHvGC17p7HrolBhPxSTju7cM/pqzbEIDSM88THmyrFZIzDm7PZ0AlOt2Un
         azpaX/DlltVUzpEA50Ae254JBMH8+NAfqtZeQFIG142j3VVuQSM1b++ciPCdCu99VPPE
         aLRcWW1tBLKEP491wq/p8tNfQItrLgjl+QKmu1Kt1f4i6GsRZ7KV/LwOQfbHJx20Y/29
         RWwQ==
X-Gm-Message-State: AOJu0YzRxB6m5mG8mlHJMrszkL09M5mGUSD/b3UkQGkWZg68NdX5JwOf
	pzY7FcMv0oZvicR81RBzpAf40tV5xselCO9kGh5gwYAXzWRUMgbDyA+jj9ZSlZ0N7EU/pw5uBAq
	MPC4a
X-Gm-Gg: ASbGncuFurDePtVwJbUZmL7/HBVqUKk4pz18orJJ3gKJNI62aZgmi8fm5Mi9VCQrSBq
	HNfEJZnnjrK43m8x7KyGvRojaZrkITsW9MDp9qSGDv4X/71cM9ySNOJMmTk4uZYKMEYVMUPClQl
	HSXI0Zo0SEaiIvIxTjd8UjTEU1FWGHCy+wE907taEZF2qRMBMbge8jE47eS8wqh65o9tX0ROxqT
	7dOSc8I5cT5UvaFYKF+UMOwZ4rnXCt/DpDU45GMx0g9Fnwfrt4kwcKCMKM2onwsC+rxCgIKmSu/
	vcszdMy6pMavnP+KIscD93xXSMINIki762mDvhrF0DwpRczw13uuhGidqLds7HiFCtLFuNNghNW
	mwHM+ERf6iTA/zQc=
X-Google-Smtp-Source: AGHT+IHm/xVWlPxViXI93wkDfzFjJJiH4VpSC5GMZ8J/p8uaeD+8Ug6hnGkIQbUPnhMoWBj+pSIc5Q==
X-Received: by 2002:a17:90b:4f47:b0:31e:f351:bfec with SMTP id 98e67ed59e1d1-321838a61fdmr20966406a91.0.1754920905096;
        Mon, 11 Aug 2025 07:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808-ublk_quiesce2-v1-1-f87ade33fa3d@purestorage.com>
References: <20250808-ublk_quiesce2-v1-1-f87ade33fa3d@purestorage.com>
Subject: Re: [PATCH] ublk: don't quiesce in ublk_ch_release
Message-Id: <175492090390.697940.8796642091342962699.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 08 Aug 2025 15:44:43 -0600, Uday Shankar wrote:
> ublk_ch_release currently quiesces the device's request_queue while
> setting force_abort/fail_io.  This avoids data races by preventing
> concurrent reads from the I/O path, but is not strictly needed - at this
> point, canceling is already set and guaranteed to be observed by any
> concurrently executing I/Os, so they will be handled properly even if
> the changes to force_abort/fail_io propagate to the I/O path later.
> Remove the quiesce/unquiesce calls from ublk_ch_release. This makes the
> writes to force_abort/fail_io concurrent with the reads in the I/O path,
> so make the accesses atomic.
> 
> [...]

Applied, thanks!

[1/1] ublk: don't quiesce in ublk_ch_release
      commit: 212c928d01e9ea1d1c46a114650b551da8ca823e

Best regards,
-- 
Jens Axboe



