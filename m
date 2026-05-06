Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC83E274E
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064231; cv=none; b=jaw/N4RwTW2HmT2pM9fIKGqRT6usrO32czrloWds6jpBFaVneHwkEBqmQ+n6YP2h9n8vT3LMJ6veWoqtf+9yk+nIuamds8EML+H/JX27Bu40ntsraV2BMNUN5G90q0RPMUcbIi2Bnk0/9TqYQUOKSAlNXGevEYmQH5Pdy60bYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064231; c=relaxed/simple;
	bh=rgXASZZPDaa9G1n23BlLBSWZZOWwdz9M8Npc/9lOkJU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W9Jm8LfZ92OA6Jj/ANKCZ3SflSGpEfwJxiVBvxQGM87u5funJBG8DolgC5lGvQiTvTfTo8phTn5symHVgfTn3d1Ps4bnqjwYwO++pR8V/4S80Oz0V4TEf67CaJOJon92h2upGaseb3k9Xgw6Dl+Xb5w8y3+x7r1eC3D9/D58e0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ulGwwjlC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ulGwwjlC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso44755485e9.1
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778064228; x=1778669028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSURP2HdbK0sPohKgfwxb6Rs2dgx3dzaWPbJQA36JQI=;
        b=ulGwwjlCEsI7v//xRcs/h/vdLQNDdktxuIg5+REmLpzCg4YVLYe/OBz7CGaoYoVJXm
         cW+5w4OllJ5GnsWIp0YoIKYpuG1+KNkA7ty4UDcdSL3SkdJq0owLOZQGv9ie5FxrBbmC
         e+b+3n3u6TASJL3PSsKSKdRDbtxVKZAILDQJBhPo2eaqEBvIb7DaAIdyz9chNdd9DCeq
         6mcie9sMJpQ6TLyfK6qi8EqFaS1kBgvN67uHmCOiXbW/HYNxG+sjW1X1nffRQ1V0LCEm
         DXNhVQ9IHYiAaMy3e7CSdSqnMWC4ee3zVVknGL3Oa7DrkAOkQo5TnUdjn1z7/V6Jq00H
         Utug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778064228; x=1778669028;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSURP2HdbK0sPohKgfwxb6Rs2dgx3dzaWPbJQA36JQI=;
        b=MPZavonnfJQTksy+N0hYNkl09WoOfBQUDalznypLxce66Z9RY2OXQHhAA6UDtimICg
         W0VH3kf5NTUKHby1+fMKqBrhUPW0HOAs0MQ3QMna5ogLFDLnXdBMjG6/i0cidnfHqwEm
         2eha5jdk0S+53ijuzwKqJm8EtLR17X6gn2lZzeGmjTHgj2+QRiVCGDwjD1g9qgn6Eytr
         XYNZhtWSGkktANP6X8ayTTFeRtBvKkaUjlif+77PDU5B19vB8LzT6qi6E2xV7q1lZdDe
         3Foyhp2C1vosvxZNMmQS5hXgs6lAC5DeOCiZp4g6dgYACIlztL6SSOBiS5cwrW4BBYH5
         yYTw==
X-Gm-Message-State: AOJu0YxcKSvxkjzziyYqqHsARg9Mpm+6+0ahEYkvrP8mSGoPJS7lsmNG
	ztjsMZs4acwyAJuuLcHs02Xi3PjEoXA87lEw4EnSfqBl0IkS59wSuMV9+ahWq6BeauY6klM5+uQ
	4EteUcjQ=
X-Gm-Gg: AeBDietSO9LOed+zRYuRXVAbki0PGJlCyt19rwf1dpNLZIaoHgiVlW29WqBgVUoSSwL
	jAnZLEsRbDCvkDncosOqAyulSZciooIiJ9xA99z4zNRCwOEln3l+oQMl9jVAaS8epkuGXER+rjW
	E08eAzKpqAQL5y9zqKCJ+Sa/V5mAFyHBOol1MNpAh6EUSkYIdsnaCiMVnom9K0sWm2eMjjqo5DU
	PMqLxT2XK8DqCSmOR1fL3M2NGogeqZ6MEOd0e+PLva6AO5paYCK7wUARNMrA2zuUkwuUfO0CDzz
	Adu2ATekj1Vfu0Yy3K2Ub4buvLEhYydGKqr+dheSn3SSlxtVikUS6uV/mrZg8wzp447Sb8xRKZe
	q9N2z8JRgr0zgvv5SnHkTVKNPJXZnmr7qb5Ss95KsdACJe2f3Fs0pnFcN4bsBivkgW3EyG/wJLg
	AaHn+AbwekbXGJ7UrXGBFxC984iVNlSGF/g4784XjdQrpJkCp6qz+bUZjelwqHAX85BnSGg31qP
	Kns/XlWQ1ko+C6E
X-Received: by 2002:a05:600c:8908:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48e51dd879emr36170465e9.0.1778064227423;
        Wed, 06 May 2026 03:43:47 -0700 (PDT)
Received: from [127.0.0.1] ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fb19csm35842415e9.11.2026.05.06.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:43:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260506082238.22363-1-tom.leiming@gmail.com>
References: <20260506082238.22363-1-tom.leiming@gmail.com>
Subject: Re: [PATCH v2] ublk: validate physical_bs_shift, io_min_shift and
 io_opt_shift
Message-Id: <177806422620.858947.3767387955868417962.b4-ty@b4>
Date: Wed, 06 May 2026 04:43:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 06 May 2026 16:22:38 +0800, Ming Lei wrote:
> ublk_validate_params() checks logical_bs_shift is within
> [9, PAGE_SHIFT] but has no upper bound for physical_bs_shift,
> io_min_shift, or io_opt_shift. A malicious userspace can set any
> of these to a large value (e.g., 44), causing undefined behavior
> from `1 << shift` in ublk_ctrl_start_dev() since the result is
> stored in 32-bit unsigned int.
> 
> [...]

Applied, thanks!

[1/1] ublk: validate physical_bs_shift, io_min_shift and io_opt_shift
      commit: 86f33ca9bea30cf011f2b1edad4593faea9c6e98

Best regards,
-- 
Jens Axboe



