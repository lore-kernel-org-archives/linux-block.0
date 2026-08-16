Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C14B0497
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838552; cv=none; b=aVvq9K5jEqA8lhmE7bpcwA/cVxW/5lT48GLyfEN1vifn9ZVO4xskJteswO3sCz2o10nxq52oJYncN6wLtGKKXAnT4+ngsrNAGSVxIr8ft4xRWacMttOwYo6aMm2s2ruc28gjKhXJkIYiP42xt/62kkddKFY47Wac3nwr5L8EYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838552; c=relaxed/simple;
	bh=K/ARUTpBpXqbP35eA1H0VvAiuYE/UpFOcyaZrCvbfVY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TmdFGHPbZcLsHnOycVLGNfkm7+nuhkgp8mo+fiEGTZ8FSlOcAcEq7mfnctXs6XHKv8evu9TmTeXNcEPCucZiSZrLYLe3bGgwJGZXYuSfyXwUMpQE+F2HNjHkvEWRbMVa5il6iEUh0nLWCBxXl4+YRPuMElCe6VxbjIa/PoKH1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Q021mY2c; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Q021mY2c"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a45b3f0becso1491903b6e.1
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838549; x=1787443349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYmCcXIgtJhZ7sa5k7zB7n+SMsUIkJx3UOjxv84yY3Q=;
        b=Q021mY2ckxt2KbG1Zy53wBDg0ahoyl2PYygYHPUI4mf3EDddm4QUEsRpAzPbEkVVkp
         uYm6lYQiKSpBzlMQcKDReEXbV5Cuk04mQN7CW4HaDdHj7A8ca+mY2nkfHvhpSPclukdj
         DRfTk0koUwDHZgsKYecyZKFDPB/spFZGyl3fiE0WKwAlo2QVvyX+FMyr8gbEDoAb82Ps
         KHHIYaI+XemnrFGYBvU2kmm09J0nFHFPsQV5dqyRBDQGR3jXrTjbaXzUx5dnYXghfe+X
         Wqh2dhojzQZSqTH4gA3U3GpvA4c9k4zF40wqQbfI+GgfXxTbscfcx7o3T/XkDO6l9Ei4
         +5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838549; x=1787443349;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYmCcXIgtJhZ7sa5k7zB7n+SMsUIkJx3UOjxv84yY3Q=;
        b=EPAntAzp6afU9vI3ZJtWJPYvyyW+Sc9gsS+YHQcKyD3ddTEPU95v7+XUtMXnRJcnig
         y3n0tUOzuyl3UWnzTV1oSx8hyXZYdA+2gkDVE1hd7UQuhN0QKyDA60LySt1n2hud9QKu
         nyavdT1RHB4z+qe+hAsPngSAdTkajvA6kMl00yqVHCq5qVZwD9eHlpKvjYUvzXR9M2H+
         MQwj/3p/tHm//iDAuoftuiXNKX/NXZAp295XnFx7L/R42q/DhKsgx3P2+T3c1vIQaYwL
         jEd7o02C6tgW1Cz8aLPxvZwlJUg7BMW96UONQ9/ZbCcEBlS6kCR9Y4x1Lbh+Xy7uSeWe
         AL/Q==
X-Gm-Message-State: AOJu0Yw1bf40ooZeOuAl6tILXONN91lQcZsj+ly9k1Eqe0tvOiRwLZD0
	RXbdit0u++a6lZ5WBAoWlvh1hejYTuwJX0doLxwdXEphlZK4tVctbC09Ud60tWxMCUZCX2QL7Ah
	KoVw1uvYLUA==
X-Gm-Gg: AR+sD10bLOw8JBd8t0M9AMuHOTTZevtPY+WvNOdMCaQeUHHks4kNrYoyVdjT9XaThEA
	62lk3+poCgeFbFUQJXfr8gsEOM88cvOQYEv4AvV3Lyhx0X/IwWW8ByAtX2wSLYw2yxlepaxZIQD
	4mXg+Wb+mYfQTZJZv0KfsHDzc+wZBpX/EoF7+gwbCv1xJvq18etAIhewOL9UHVKnukl4s+zG63X
	E2O9gEhyFfKtTl3Omkn8rSQox5052Fplc+nQLcwn3hGhYkCsh9lmkBO8YsxjB/me6p21Y+CYoCG
	plBjxZyy9MhdFfWeqRSbpIj6BiA3jutLgNTAUW0WHFKoOJ2vZER8gImsShv8jdNNJojSyDzDsXn
	agciSqSZDJv7tn+s0E/ISS0e/Xnp9AVSQfcpLSiQKlioa6Ss9BUciReGneA/xFyMH2inmzB0SbG
	TPj26BsayBoWKS16cSHYQ3LPAGHhud2zQ5Hq3Rol964nYiZR0lwjUWhl6lR/sCCP84WUn7ft7V6
	+0c5dOdq98h/QWmZTne2eapJ4Q8ZnhLRaiAt09BVA==
X-Received: by 2002:a05:6808:3086:b0:490:315d:e0d5 with SMTP id 5614622812f47-4b241ed317amr15551288b6e.16.1786838549543;
        Sat, 15 Aug 2026 17:02:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:02:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260810144603.453283-1-hch@lst.de>
References: <20260810144603.453283-1-hch@lst.de>
Subject: Re: [PATCH] block: don't include blk-integrity.h in bdev.c
Message-Id: <178683854415.1984298.3969271116846186515.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:02:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 10 Aug 2026 07:45:59 -0700, Christoph Hellwig wrote:
> Not needed, probably since this file was split out.

Applied, thanks!

[1/1] block: don't include blk-integrity.h in bdev.c
      commit: 13c251b2b7fb150f22b55d652ee66c2a39c6635e

Best regards,
-- 
Jens Axboe



