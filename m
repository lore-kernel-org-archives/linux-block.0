Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8770304BBC
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789803; cv=none; b=SCLwmgZj2rg1JCohH7ZGpPFcxA8qWqo9W1jfSiUU4KQnpmsP6g1RmuqOD+7LJkdU5BYuWuhz+mlWcqNSFRYc2Jj8VP3OTPO8JDpepJULmBnEGVpyaU0grzGb2fo7/BddA1f6tXhLC/lLNSeKfI7Qz7pzz1yxIcBSaueWK1SvQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789803; c=relaxed/simple;
	bh=zIIuXiQHuI6A7jBe5zC2l2p2dVl1a3gJocNjXAYKpHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6CohqLKLd6fzb5mYmhzft0lmRj9CVU4D/S7Uo07ej5ugUJkpf7xmyU0N7VKxCfDInZRvgRqrmpa8WJ5o6YqznEmA+WRByZFWhq4yTfmHPGGDwbxSsekHptlHwmTuYtP2wnJAVELYhmWAt2e26Vub0GbYiSeQHtxl7Fd/9IyYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9yY5Xon; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9yY5Xon"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a7109f568so4980467b3.1
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789800; x=1774394600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9xryH9h98FYSTs+igdpf8Vohpee7TsL/bp6sM3tzi4o=;
        b=X9yY5XoncaYzIZcYEigciiPIg7UAVaZMBOH/tnaTNvWxJetJZcIZdv1VBUuJsfVqNp
         tf89PP8ZmkPQWzWqFBrCQoasxJkv1bAWDf9JJTZekdp4Ym0TefY/nUaoEw+7GTtjohGE
         zv+IeP5WqbZHHPeit7xCoIG6GwEWgLRjS7aV/ApuoNJAu8d3cNBXVr3clQTtHyJdM8CZ
         TGBbK9hCO3aBrpnIkQWj+3t+dt0jI/ZYc+WmD/WzPej3RS2m3XZDxYBUba5KW0QjbkCA
         e9rVCXygtcFCAd84qm4daI5XrX4AxiJWobxaWLcXNfPmcIevvBoaAEbDImqDdXn6vAdr
         9y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789800; x=1774394600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xryH9h98FYSTs+igdpf8Vohpee7TsL/bp6sM3tzi4o=;
        b=qeDRLwyLXxYD/NiYHjRuYLXLmU9DWVDVgnULjBp7eMotd1OMpNgBImdYJR0PnVfgAh
         IoV8XIYbK5+d1vkM4ZMsTdynMrvYe7yL1ddckDgIQeODAdBJMTqoxFOQifNIbM+IpfSz
         ts/7PmDCJv8pJivdCYCeG9GKD9pORDlpE/x0P3OyJoItf0HM3fedbJwqlVrsu2ERV2q4
         I1H+vsyUMBQx+pnvcacab16fjcBU5pSfHqGgCIrnKBuQd0Zy6/6SlNpj1oG+DxaeGW/5
         gVcDQWH4GE4qfCzVZnRUWO7MKc8Crk+v93WY5RPjdBKnQs0thA2YVmJ1MDuPXQ96ibMC
         suqw==
X-Forwarded-Encrypted: i=1; AJvYcCXm5lfjhd0SSpXo6FgiGQSPaE6wYZz4c8jvvoFgWTE8X3NXUOdgsXZJ8uLEaDeYbnOyQVpfbnHNtmj7Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+MwvsM/JB4VWcGfOYAV3sq0QRxq+T9LhUyWmlSQ354RS33+W
	6KOiDNS5qZrSfwgTN7z0RIgpU2GPie9swr69J9+slAaFFxAegBa1sxbf
X-Gm-Gg: ATEYQzzvMdgqNivxeW8BlknVuCzYhscTzvDeijfMRhTJuONDKBaLaOCbsuB4l3OlNV/
	/FWxdrt+RaL0EirnfaJq0gnChqyWb4ijKP566dBNOWbiOHYCxNedQ3cwEBKPDOO2egapuQYK98I
	9eJgbgghkMpRvxoit2q+bJaK9jvB5AYgJ/n60bKABsKq8FSWgzTKaiuISY3dofHrshNOIDLUZWS
	T3L6rvIm7piEv4MsP9xVpUp9Nf8kzJHMU6/EbvvVGpwju7u4CpbwaK9KTEOeRyPFc3sTZ6fZNT6
	NL8ZJ4s2mi+uBxnlEWpHcPrK/K8PLqKCwG6Ivmo9CtSxD8jOFRS7SyR1ZDkIY7BH7peaTdVVYH6
	jkLjADAOzYTCTmuwCU4HhEUtwPeuKmgVqanGZhkyB5LSHHUwAuzezdGuy9ac1cSbKiMydnjEp42
	O9k1ssQ+Z6MSCLJ/SY6DNH0W8MnyHtFc3buDyI+bhI69QJ0rDXrFxiOKTWa5q95QjKL5Jf1Sn12
	70jg8E5oMjG+4SuSc88W/80
X-Received: by 2002:a05:690c:4b85:b0:79a:4f48:ee20 with SMTP id 00721157ae682-79a71ee1ff9mr14353027b3.62.1773789800597;
        Tue, 17 Mar 2026 16:23:20 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a715d221dsm6858217b3.37.2026.03.17.16.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:23:20 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 0/4] drbd: A few bug fixes
Date: Tue, 17 Mar 2026 18:23:14 -0500
Message-ID: <20260317232318.18923-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are 4 bug fixes found with Smatch.

Ethan Tidmore (4):
  drbd: Fix out-of-bounds access
  drbd: Fix variable dereference before check
  drbd: Add missing error code in drbd_main.c
  drbd: Add check for error pointer

 drivers/block/drbd/drbd_main.c     | 1 +
 drivers/block/drbd/drbd_nl.c       | 2 +-
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_req.c      | 4 +++-
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.53.0

