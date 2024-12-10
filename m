Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FA23DEBB
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847463; cv=none; b=N0/wC3WX3OdmcAomrqi9U9hj5GIkQZ7KiAdc91FcuBAHjvCKWNhzU9HW5U59gAfbt93W546emzxAtmXV0JmY7XXRJYUJWoztmRu8EkOuGvr9BHd7aA627YR3OODdjrvKqvm3p5Ts/7hY34MSHV1zzaOTObTL9ccMETMXZ31xvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847463; c=relaxed/simple;
	bh=MRSf3q/DqEAzzo+S/0wFTN6Zq8rXGpEMjbE8BS7GxxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OGIOqgJZOPfSv4SSoRkP7FVCjGWIt5+hBAQLe9Ht+jgC6qlTEpw3y6LFHnSy853Y/zzw74jt3fzLrKtB/D9Xzr/1L44ixt4C9T91dUlVHg+k1f7zMgngCmR/cKQE/wKlyC9FmQo6Y2l5y0R1UexEmIJyvqcrhW3LBW2d/8zwBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F1nmyq05; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F1nmyq05"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71deb8054e1so1138976a34.3
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733847460; x=1734452260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc4ZR0GV0ZI1cVG2KT+gdfOjvtpXJx+W8WqkDzEwQPM=;
        b=F1nmyq05lSdZoij9wsRmJfvRt44t8M33hxqg4I30osF/TjynCozvOmyGN2c3rxRTjN
         zmM/ugD8PCxMGPgTig+o20KAPGyDlujKl9dV9G+2wJ9IEvnV4FXMXWs2HLL3QXhobaNU
         ppx30F/sz1eMM9zqawCTdzh2KMwYSFpSpTHVC768B4bZKLKYfM8jMGJpIF2TO4RefC6C
         B91gFp0auK1z8sKSZZB8evBBQ9SE9g3z1KCSNwqANadlG+gFZo4mrB/cEY8sHsujzqIm
         uR0zTpQSD3EHBMz7Uwowwp+sQLtpLpb4fgAMbDHfieF4L8ikvKIhqwBGgqCS/7/ZH9rR
         xzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847460; x=1734452260;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dc4ZR0GV0ZI1cVG2KT+gdfOjvtpXJx+W8WqkDzEwQPM=;
        b=eo7cDiPawcoR6tXoVVAG4BeA4Jnp1q3CoAL4en5fbW8x8d42nKUZjkoADRKp8RO49K
         o/vtaLsAiE6WKM3u1Am/m3CWEWUlimX+wgAVVH969wOwhIHnTAgtF4suHxhtiWDxWrgl
         G4Jbd0JdKU2qbM2LV4FzU2IBzUpVs2R9X8Q69mxA3IY80esNaTr/aOu6n3495oeFVAhM
         qWzhIldZafhYX/6zsOaQQeY2I4LPg7A4aAPnnf8mlylmAg03wySerfuVO/9qw095DlKN
         Rmi5I5qi4tJm8slzDCocH5jH4Ae4glNfWj5dbHB1gk8XeH1IG8DdIkYuB7DgDtz+M8bw
         2hVw==
X-Gm-Message-State: AOJu0YzqzQ7bUwR5xQglsjEWJMpAFBYmXZjR3h2kfcD7kVhgJjJ1BO9U
	R1MSb1ha+/IJl9wcCYQrM6NhWKVKCvBbe3fh8mO5FHGJRrdEGElU5vZ8GKfCjXU=
X-Gm-Gg: ASbGncszaNKKmfvX14Pr1bHHhV5XBrww01LLfDSVBCJ+y+BpezBwjemM2HJKwqSnuvY
	iu7+9EqnwvSiWM585iMVaB1Y4aikq5IrPwCUQ6zkDYjn5JkyvpJWvSRMCKK72TQtmWo/raJHalV
	F5Jli5evrwvawEryLceP62iZJsqYQXo9pSwlfv/Mprkybm/9jCTqMJxfxa2tWMtmHD8IF5Bpitv
	gSP/bug1gKcAP+9M5GyYCOEqjNd5gaAzj7HE3mM8GMX
X-Google-Smtp-Source: AGHT+IHxAAZ3D0uWncPjOqMAUcGsBGp2f+JTbeiTZtPMweHPAYze11QhDriq1RsA/ElgKqMrIzIOxQ==
X-Received: by 2002:a05:6830:700f:b0:71d:fdce:79eb with SMTP id 46e09a7af769-71dfdce85c3mr4105336a34.30.1733847460244;
        Tue, 10 Dec 2024 08:17:40 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f279324914sm2639115eaf.36.2024.12.10.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:17:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
 Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241209122357.47838-1-dlemoal@kernel.org>
References: <20241209122357.47838-1-dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/4] Zone write plugging fixes
Message-Id: <173384745884.444526.13752069755945614497.b4-ty@kernel.dk>
Date: Tue, 10 Dec 2024 09:17:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 09 Dec 2024 21:23:53 +0900, Damien Le Moal wrote:
> Jens,
> 
> These patches address potential issues with zone write plugging.
> The first 2 patches fix handling of REQ_NOWAIT BIOs as these can be
> "failed" after going through the zone write plugging and changing the
> target zone plug zone write pointer offset.
> 
> [...]

Applied, thanks!

[1/4] block: Use a zone write plug BIO work for REQ_NOWAIT BIOs
      commit: cae005670887cb07ceafc25bb32e221e56286488
[2/4] block: Ignore REQ_NOWAIT for zone reset and zone finish operations
      commit: 5eb3317aa5a2ffe4574ab1a12cf9bc9447ca26c0
[3/4] dm: Fix dm-zoned-reclaim zone write pointer alignment
      commit: b76b840fd93374240b59825f1ab8e2f5c9907acb
[4/4] block: Prevent potential deadlocks in zone write plug error recovery
      commit: fe0418eb9bd69a19a948b297c8de815e05f3cde1

Best regards,
-- 
Jens Axboe



