Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842F374721
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103284; cv=none; b=L3Dn+dW8jVSYumCqeSeKpIXcFVeovN7WUDhrEWjqarE47q1j2iZ8LbeLn5fJRZjYN3i/C9wuycPBVO1YCoX/LhXMnaQ9XVY9r2XjI41G4sOSup2l4Mk+aRRkubarj4ZTuhKtKjpuaPnrQgZ7XgCt1GR30N1/Nw8hh1O85zEp/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103284; c=relaxed/simple;
	bh=/uz/mgNzqCCdIWB+lfcRdHFZzkBpQy210rPi/3Saxps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXioI+GGRagYYUnaHhTuoa1O3la7D9jUcDmwTgcr7syXTDYp4XlFfqI1Il9u7A82X9p5Z6LocihhZBB4dZTTsW0yiTyJsCurxIcP3cEGYbqUJUKpaLuDTQG4RLA1fh4dOydGFDazO5zUoCZzfmdVxz7MpHaaDlsZAWOyFtmRZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqSyE5kV; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqSyE5kV"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so941274eec.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792103282; x=1792708082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rH7qDh5A3FEMtgpSQimqE0vvF6ppC/OBh5O5bMiH+AE=;
        b=YqSyE5kVy4VlfivzUqDS/Nh6JHmyGBspr53LNHyeqbxOP+2TJR7CO6wGqikTxv+Wp0
         JPotpxbNPBTwvYZfFBwqjiOlQWAUiBul9o3wOopmgYlf3GmvPRV00qOgqHLw60foDKSR
         q3MBN41ZSdLS3JQyani6W3FYgva1M+9fL4HsIgIs1jlF1v5Hy0ZUurjfi6tQzaDv4kQZ
         sGFxHUqHFhzDdYvi73itUZGKD2N831eZZ0bxcobRMqsdMQAIaYGxPpd1NHvv9sHthlLD
         wMjyeJp5rfeHbG+9HgKf78w5sVF5tyEXJNnixZrQ4mMjRpM/OaANXCQ6Auk3sRtsXFje
         //tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103282; x=1792708082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rH7qDh5A3FEMtgpSQimqE0vvF6ppC/OBh5O5bMiH+AE=;
        b=nZVtofn2CwaSvICVbnc7bIjZpkxOeyQfKnuFvYecgNxx72U+dmq1ztK3UgLb7MmBUt
         lTF/n5++72awbXGqQ8Ovr5ivShNdkRwyiQlJ119P1+CWDaznD25772O0Lzl2uzk+DUoQ
         Eq6zzf47uOIaCKukU1F8C2+IiiEDTrCMjDnYqHrVM78vtIU9oHvQfznnZLQ1lsTSN0ot
         ttQftXe77A5Nant/3BgKdPYIFgMNz5G2luczbM2ex+dI/uTEvGWI7/u8k46sm2reNkJw
         oWbz4/56FdkU1SqLs+NyZWIFp/n12oAgAs04Kw/JUwmbjpYNBMuNsCcZKsDUv9o6bCzS
         ywBg==
X-Forwarded-Encrypted: i=1; AKwUvBxhKqSwnMAZ/Pd3z4ETapqFo9slHz17Xw4niykiELJpsUHGelYEFI+7MQQ8YdAOEkYmirrsn0oE/gBtNg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIpET8gnqx9s5e2eTTNq1g+hBkos4ysLzMw67CjAznic39245Dx
	HIEu+49RQTzZmlKWP3n7UZ751eR81n9lNjbQbcjZD3SdMsWAur3/cVi8
X-Gm-Gg: AYBFou08KIw7guxYOWQu+lCZl7f4ZEIpHz8mqC/eI/nHrosRSe/LsUMGGR01G2O1u6L
	BFi6wFTVhKD1+6FsuDnQo3hKra5UXSJY1fXyDWV/BBOqcD45nn8flPXoIeTr03ju1+iKMbbw09k
	1qkIBcfXbTfAHeYYP4X0NAHdqAKkhN+oeQMQBizqJtQFXZUYK95ocKExNum+luFUV3gCC7INjO2
	9yt1/hZqGVPMUlE2xEorxUTDub9SAIsCo5Mi+UT6FYBAuMb5ErVcEW5N2r7dyCCl4gcZPcta3ar
	8R3IevLOpIbLrVJe7hWjuObl82feeO+tgFpRdPoYi3pdh98AjfssJgXPyq0jNnqA6dwGSo+FrbN
	GE1NBAZYsVUhfwi+SynwE5fEo6buCRKW8SxAqldGzvo5rhfialYwCs9LPFrQp4Q/UFdWoQfH3iQ
	NUsMGAk2PYgUvs7eyHPEI6ZgMsEWlZu8tvwtUGHe4nxIZrpBLTCUgJLf53er4tb/7FWHYZ2WD7d
	do3m+MK1UQdiL3F76sBsrTYHkuH6o7PMQEjVRRW7qO8VFTJaQQgXYa3yXJ0dejY0QbkNq9VQfE=
X-Received: by 2002:a05:7301:e10e:b0:35c:707b:acba with SMTP id 5a478bee46e88-35c707baed8mr12276609eec.3.1792103281885;
        Thu, 15 Oct 2026 15:28:01 -0700 (PDT)
Received: from yibos-mbp.3500.dhcp.asu.edu ([2620:d8:8000:8078:404b:acf5:562d:50f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm873307eec.16.2026.10.15.15.28.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 15:28:01 -0700 (PDT)
From: Yibo Liu <yiboliume@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Liu <yiboliume@gmail.com>
Subject: [PATCH 0/2] drbd: validate payload sizes received from the peer
Date: Thu, 15 Oct 2026 15:27:58 -0700
Message-Id: <20261015222800.85928-1-yiboliume@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two places in the DRBD receive path take a payload size from the peer's
packet header and use it without comparing it to the size they expect.
Commit bd910a7660d2 ("drbd: reject data replies with an out-of-range
payload size") already rejects negative sizes in recv_dless_read();
these patches cover the remaining cases:

1/2 rejects a P_DATA_REPLY whose size differs from the read request.
    A short reply currently completes the read successfully with part
    of the bio never written.

2/2 rejects P_CSUM_RS_REQUEST and P_OV_REPLY packets whose digest
    length does not match the configured algorithm, and makes the
    worker compare digests only when their sizes match. A short digest
    currently causes an out-of-bounds read in memcmp(), and a huge one
    triggers a page allocator warning.

Like the earlier fixes, this only matters for a peer that does not
follow the protocol; a correct peer always sends the expected sizes.

The problems were found with the help of an AI coding assistant and
were reproduced on block-7.3 before posting (details below the "---" of
each patch). Testing:
- before/after runs of the reproducer in an arm64 virtme-ng KASAN guest
- a complete csums-alg resync and an online verify as regression tests
- each patch built with W=1 and sparse (C=2), arm64, gcc 13.3: no new
  warnings
- checkpatch.pl --strict clean
Not built with clang or for other architectures.

Yibo Liu (2):
  drbd: reject data replies whose size does not match the request
  drbd: validate digest size in checksum resync and verify requests

 drivers/block/drbd/drbd_receiver.c | 14 ++++++++++++--
 drivers/block/drbd/drbd_worker.c   |  8 ++++----
 2 files changed, 16 insertions(+), 6 deletions(-)


base-commit: 41cab3a71dc7be62114d91cc849424879062d324
-- 
2.39.5 (Apple Git-154)

