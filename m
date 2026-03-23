Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012027470
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774227851; cv=none; b=u/fgaNRIEiE7gNJRIZIYfDYHKD7c43O10HmK2LtlXjYnRhwSIaQmCh33w1OFLsoONjPOfp/NKqPD6a50cjuiqtmkBh6LploZmgNPdTp5lNY80stMM5Llug8FwM4dvtot9ZrHkZDnvbMrfm7a5Za6cNdNZLYOCTT9eZupcKYEQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774227851; c=relaxed/simple;
	bh=b/A7j0hjNvSSGHgfep4ZD16Ax506S8Hl9U3vdY/MDtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pU1kLIgeFPng4hfLZ+y3l3FHqOCcqJ2qNRN7/1Om/BJSWYP1Yhvyi/eGkamw+gsf5kFrCRnEsA8dEQKD+w+ElNZ/UumquNVMflpNqZp4pxm0StTwRH99VpYjRucn7aAb1LowLynaophkLtbO9QFuyFA3PgNN2o+EmlfKTHUmNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zh78KXNH; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zh78KXNH"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-464bba3a9easo2122962b6e.0
        for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774227848; x=1774832648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqewgqaY2Dk1rx9G2gglNoiCFwHVc4lRod/pELYCXPc=;
        b=Zh78KXNHaG2ooWVVelASEOXq5S58U9WJ958kcj3WjFmUod7BKSG5fdgzKoJJePGmVa
         fmV2ebJVI+DMCHlxOQx3y/rvr0N9Y429EK+4SPJkwJn77K1R+9bNI/nlBLiNCLedDoiJ
         iOehH0sAPFjv3wVeKH0N6r5k02oercYzZctaG1d8kbz+H/PwobrRQ3OQc/f8ko2Wbn50
         zkUsgSyCw1HHFxHhe9Pjn6mxPahj2umM/cfblpXSgD2zKmUDYFUVzqCBc3VDI2dVvyNL
         +NstFqRQupHbehCKpk/ztEz/HoU+em+pgVAR5D4ga0+W/b+9CagbX/rixqFbzKYmUKzZ
         3ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774227848; x=1774832648;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqewgqaY2Dk1rx9G2gglNoiCFwHVc4lRod/pELYCXPc=;
        b=gTDZV3xb96UiUPsfOHm+78Y2iNfpyKGyNdhNSIcUisJiFYBw+ZTRgNOqASsp+rPKQY
         2c1AIDH2XRUuivcRil1f/WSVYrldaVasz14BnckkCrQYoWAS4iNS9JAztaTAzTXw1lkO
         nAgNtqzfi+YKvIPfxi+zWO1HP+6p1PzMxpyPZPCSODflxq4ySMiOTCphDNIQ0P+jYl6s
         4o6F/fZfT5SG7iJi4QnfDPGpRN6fBDhZUlz9ogi5RZv7p8Pibsd63pWo9Gf+VU+F/+fe
         p7u1OUKwFzbbgLi/jfTu6w9yVPueHFW5cege2YJjvtv6qTWcTFWp+ZnfLtv31AcGkX48
         JzAA==
X-Gm-Message-State: AOJu0Yzuv47GRDxul4MmC0peLqwtqpEvNfMnU58Pm9tug6hj8W7QCrBO
	foOY8npl+anTsN2u+Y32Q4wWKcG8rGv6u/CkSM9XvGlpj6RxfGhbVRO5frIyYRYRCkc=
X-Gm-Gg: ATEYQzwt5x6C6NxJdiYuL3n4V1BPkYYR7dBHUZGeqavnK23RYenNeIOq7WEXBNFb/WO
	InBWUBZPKdTUYVt8qDdfIZi1ZbjYjoLkNIythy5zy0Vpt1gjz9wRTS5IJovUdf7+cDr2EHxZjYI
	Va1eWBZwCV5n7uSwWWl6wZ06Do95kO2r9p9TV6Q3fFcLTspzZYw6B+MXp7CFhGPtJiBbgw3WZ6Z
	WYSuBhd3R4HyQ+i0iWFMuVSp/a4XG673k0z6EoV5EDLO4P1ExkLe5jddXTPQlYKV7hjMRh0LSbr
	nF3BfdWcQNCts/DfimCZm1XOvcLYLnJBHeoONJR+pt8NeBUy91+jrAQ4NYDM2wtFOff6rno3yUf
	6vTbLhZkjnxjca1cHnz9Dwm2QnxJmG6gs9jU4pmIa+0oMNBlCq6prhBjMQcuju/JSQerXXEjKgj
	ewgEN5jz2Gp+gFySbfHSSXCZH7HLYSgwpmqkqnf8IoAT8EGAXSBAvxXAlx68eN+2I6CNXBlL8SU
	/tf
X-Received: by 2002:a05:6808:4fd0:b0:467:32c1:ad08 with SMTP id 5614622812f47-467e6032eadmr6047673b6e.56.1774227847857;
        Sun, 22 Mar 2026 18:04:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7f131b2sm5711115b6e.15.2026.03.22.18.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:04:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20260318014112.3125432-1-ming.lei@redhat.com>
References: <20260318014112.3125432-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: move cold paths out of __ublk_batch_dispatch()
 for icache efficiency
Message-Id: <177422784683.359752.710935782488869559.b4-ty@b4>
Date: Sun, 22 Mar 2026 19:04:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0


On Wed, 18 Mar 2026 09:41:12 +0800, Ming Lei wrote:
> Mark ublk_filter_unused_tags() as noinline since it is only called from
> the unlikely(needs_filter) branch. Extract the error-handling block from
> __ublk_batch_dispatch() into a new noinline ublk_batch_dispatch_fail()
> function to keep the hot path compact and icache-friendly. This also
> makes __ublk_batch_dispatch() more readable by separating the error
> recovery logic from the normal dispatch flow.
> 
> [...]

Applied, thanks!

[1/1] ublk: move cold paths out of __ublk_batch_dispatch() for icache efficiency
      commit: 24d4c90286b9a36a2b72d1e0ceeae237d427f975

Best regards,
-- 
Jens Axboe



