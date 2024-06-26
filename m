Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5445E18A921
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414896; cv=none; b=NBI9OFwnge8HJuqJGT6opriU1dArQrvbDkrDvFZ7lDuhFz35lp+eN83HmivguNr5swi8mG/sQoHzLxjbeaDsXWjLiOiBHkpLSztU38q7m1yRu8bcMNp7HeX+pS/0ezE3o9YH6m82koZq3IFUrt8kUBru1hAotgWbYkzsamCune0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414896; c=relaxed/simple;
	bh=bTL6Y2DEulOBxwrx74oiHr0lCWdB9/T+TOfCR6Xx908=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=exBmcEEVhpfxofhCBsdRJvXwO9bG2BLU2e9a6msLdVvhddk3yhgsCIR4DFp+jnN2zXkzBBhojaptrOaBuvRWdTc6Xo1gAWmnkSEQaJ6FqVxJTa33P+zgRAJeaDfYu1vU5UklFn0TSWZMBsNIkypCz+GefGUdsYSYRlqt4/ZrjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nPHaVs0+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nPHaVs0+"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70677fe5d87so143207b3a.1
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719414893; x=1720019693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejiLOCPjQYH7ACXd016xEl0yCudpyXAA5MF+cxuWv6M=;
        b=nPHaVs0+/CbFH/T/68Td8MicrX4BsiFO3Tm1XvIicPm0G6fpfKlQgS00gVAqaX3D6F
         OENqvF63UgAKX/Ihnavd0VOD1eYUy4/yDIr9xH3ldPw/wNHQ8QmtpTHwl/sA/RUaqEbT
         QdtSQB4eowKG36XQWsHoBLynBk27avdr6iBfU9T7UzywV7L+yGnjVWzzuzW5Cgljo8FE
         ogr0ffNHNjqSd78IdNDiGTYdNM9SmrlqyZ6ILu13xpQL9uxN44FBv3wPjMV3fh6BMzgw
         y0r6bDoAr12Lhqlnz6IBp8D/VBrdSn6uKdVYpY0nwyh2x11OETCfW8TQ94ryJlwnGF1q
         Wcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414893; x=1720019693;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejiLOCPjQYH7ACXd016xEl0yCudpyXAA5MF+cxuWv6M=;
        b=D51gCr8q/p6/+u8bNgikjfJNFJU6GuTl28yrALfLKbYgkEP5WIHhIqgz0AOVYjGL2k
         OyRAINNEEMTqcVN3pxPrxw9GpNGZ0NJvsk6sUVhpJ1Cf+4jZ0/rAm1SDaX35zwozJC09
         /GKlpxzMWprg1oRaRVQVLhJcwYn9UrWJl9eod5nXAdILSeruPNsNCBdgv/Jn2dbha8hW
         MhGY352VpBlZ6CPOXDSAApR4e+g10jPbQgAuDJ7MLvS5TwcGo6GhlQ6F7WIy7jMn5hM7
         BhiCodFkS9pQayqX0fetQfTwKCKWiQ6xBZpSgg4nhu/NsXe3RI7mY8qnCwG48WKejbNT
         QyRg==
X-Gm-Message-State: AOJu0YxMGRTelAIlsFDge6SywenJHuCemih5MQquRZdShX45PisdKU2u
	4GSET84q8C8n8Lv3WNH3oMyQI2yk3QhuCAvpS3KMoCkaqy9ARO46s0ZrJqDKySWiLQ2ZWJ5EO1h
	qrQo=
X-Google-Smtp-Source: AGHT+IFmzeqdqLg5SiV0tu6djto+9EcNyF5jowS1AcAqpWmkqpnRMXJ/vbnzGjN2TKNNd7d+87nUFA==
X-Received: by 2002:a05:6a00:6085:b0:705:d60f:e64e with SMTP id d2e1a72fcca58-70667e2b1cfmr12723111b3a.1.1719414893526;
        Wed, 26 Jun 2024 08:14:53 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066c2ebd85sm8184326b3a.93.2024.06.26.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:14:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
 Milan Broz <gmazyland@gmail.com>, Anuj gupta <anuj1072538@gmail.com>, 
 Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-nvme@lists.infradead.org
In-Reply-To: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
References: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
Subject: Re: (subset) [PATCH 0/2 v4] dm-crypt support for per-sector NVMe
 metadata
Message-Id: <171941489217.836289.13164322028417269597.b4-ty@kernel.dk>
Date: Wed, 26 Jun 2024 09:14:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 27 May 2024 17:39:14 +0200, Mikulas Patocka wrote:
> Here I'm resending the dm-crypt support for per-sector NVMe metadata. I
> made some changes to the first patch as suggested by Christoph Hellwig.
> 
> The first patch fixes a bug when splitting a bio with attached metadata.
> The second patch enables dm-crypt to use NVMe metadata for authenticated
> encryption. dm-crypt can run directly on NVMe without using dm-integrity.
> 
> [...]

Applied, thanks!

[1/2] block: change rq_integrity_vec to respect the iterator
      commit: cf546dd289e0f6d2594c25e2fb4e19ee67c6d988

Best regards,
-- 
Jens Axboe



