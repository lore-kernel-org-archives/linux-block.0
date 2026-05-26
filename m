Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA238C412
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813748; cv=none; b=mU+Ayq53mqzY4HclCM11CNkManKoTE8saZnkRQmvdN0KC9gi4+9LX3W4Uovxz/ovo+AbhmmST81y2mZ5sz5jOICDS0fBIqYPPEZ/3dOTBLuWiu04EJNJe0SELNCucYNY7Z9RwWunAS1/xqbEvo7BiLE5Sr5vBlXysF3/Z+ObmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813748; c=relaxed/simple;
	bh=I6qxs5gFD31ns4SIcEqacuzBnSb1Y5IFGAkpolq6l/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R/VB0WD4sGU0nhKqpqeuAhni2tx5ybu7G30G0acsZpJ2wy3E+SM5y2JPy8pPAVoO/OcvTMMdcDxmXVaSRWlYpCfE6V0VzeLIZNN84qjjE26RRgdDsshlP/6UJSZn1FWAKgFp2dUptKeuLyn3d8516qet36HTUx8sAZpRBEycs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=cLNNk2qp; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="cLNNk2qp"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e61e25199bso1250699a34.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813745; x=1780418545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1d5rra+epsO8XeWZqM/JaSZo/rpugmNgXvadOidTYE=;
        b=cLNNk2qpOrj8Zr0gaxx8BscbPRsYPyqMqUcUlKzybxqo2jCZaTBy0g8J6gUUQVCeAH
         I14YnEAbtC4UZjPC3ogWOWnFeeXMetXPZDg2tfOGW47p2MQ0edznIS+4mSItjnTDoQyi
         /77FRZe4oOU/tIsF2X3Bp9TBAr6IEj94j3h8KuCNhuwCA3lIClgwn2aeT7cAIiszEebs
         tQ1iuo6vD2Y3PHqaJ872RSSL/uR+vmXTrO4wGHql3UA3q8Lu3C/0oa/kXbuw2rrIvQ+n
         xbmUTEeNb2oOMAiOhCFg5GFj2Io/6RaWiUulhutshVuiy5xZzqIbyfCfkBhMvEL9afFR
         BDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813745; x=1780418545;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1d5rra+epsO8XeWZqM/JaSZo/rpugmNgXvadOidTYE=;
        b=T/UvPDSHYIIGCCLLEhugCgUqM5kiEkM5t/t+4mbfchsrmqh7REhnzZWtxWxgiYB0mb
         U1R5NEq6SUsyZp+C3h9bl0ZrObnzzDQ3FqX1url+XTPeObGoXXAtUkurkMO1xFYW8oPI
         fpy+4wtr2aE6K/iZo9n3QqirwEDH/Tf1emYef7T/27ehJ7eyk/NyqFMm1ZuNEHgTHDhW
         AId/VklsMs2q5BLJXl5nfYWYtJbgEBnrXm9fjVCGGTDPFylQywMp7yDzQ7B0s1aF9kiE
         4RdydEdyR856gZ5VrExcDt8XKwvhw8C0/8y348V8BNeCKvJDKhX48FWP6nKV7DUNn3TG
         qwMw==
X-Gm-Message-State: AOJu0Yz90RPfyZRDPKSU82Z/T37ezA9DcGusPaNd1xxvcPd5+e6glfD2
	wmxGSGJSeYLbsA5lcEdTcpqqDG0jOxnejFNb4xw8jIRfowarqAmydnuM2kfskaIN7Z4=
X-Gm-Gg: Acq92OGiMNMRwESotKHh+zyeUSfPaQ6/4EQHITl4L+uDqcyywiwCOjj13rWSfIMiE6T
	XSEWpAV47nNWQo6Mu9VeWJ5sYnLAo094YAhmPiwDzHQbnH7hZ6QTgGG9kEEe9GoS95YehmuoajZ
	KIzxGPR7TWx+89I39xL/C/1htFOoXHjddI8nr0IG2Q0C5WTv7ePTiTNTBDiafVhmNitrQmfWKHp
	mnXmdpuL8sZjQ4yCtErfLbNgH3p8L0QgaCWpQqcSwmeBWLz7UXhwnLAgr/IIyEwcNcHCQ9/evpr
	t3X8kz2BuzLU+FvNkxpqqN0usbibj/i3RxOSVyRCrnMkBUr/ET6MOCBpbSErD5dl7uQT2arRbA5
	gvNMx78QYP4WPleqvrVAaJ2gAvtdY0dfKCeRKSiZ5ov3s95F74Mli3uA17isf5VlaVc3Js730cq
	W0F3lZTYDVMc9TgmSYo2nEuA2ZXeiRUK9yazt1puw6mHJu5WCqzg6Pwwf98ipGLoeljaSrBoZwt
	wc=
X-Received: by 2002:a05:6830:82e2:b0:7dc:c620:aa12 with SMTP id 46e09a7af769-7e5fee9b2dbmr12557460a34.20.1779813745266;
        Tue, 26 May 2026 09:42:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606482473sm9585235a34.8.2026.05.26.09.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:42:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>, 
 Tal Zussman <tz2294@columbia.edu>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260525-blk-write-cleanup-v1-1-391c073e3831@columbia.edu>
References: <20260525-blk-write-cleanup-v1-1-391c073e3831@columbia.edu>
Subject: Re: [PATCH] block: remove blkdev_write_begin() and
 blkdev_write_end()
Message-Id: <177981374365.466119.17940556306078598208.b4-ty@b4>
Date: Tue, 26 May 2026 10:42:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 25 May 2026 14:25:55 -0400, Tal Zussman wrote:
> Remove blkdev_write_begin(), blkdev_write_end(), and their entries in
> def_blk_aops. These have been unreachable since commit 487c607df790
> ("block: use iomap for writes to block devices") switched block device
> buffered writes from generic_perform_write() to
> iomap_file_buffered_write(), which bypasses aops->write_begin/end.
> 
> 
> [...]

Applied, thanks!

[1/1] block: remove blkdev_write_begin() and blkdev_write_end()
      (no commit info)

Best regards,
-- 
Jens Axboe



