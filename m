Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839631FBA
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726116; cv=none; b=VsHuvpwGj+dbFkLI3Z0BKTyLXvZ4aGxxdGXJlWAC9l7pk4Trf7u6udElBwL+YUBI+SG9F+uqIyhoW5wV+GFYaWbqFOruL1eNl6scOBxyxhg666S9jteZDh1luHLNCb4E9isULlfZZxdPNhYFSWmfJL1YBz5GYBBP0j3qRgOCbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726116; c=relaxed/simple;
	bh=B6A3cNFDQoWZcZusDvIfZ5ELoQmmZ7AW8P6BRuur85Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jqFkVwFCeD3qZ6iXD84KF4u3pAS0tvZlM3AngUyE4jOHzaoLeodQrvt9R1p2zP4SVzPcZEWRL4eRtvZVHwm/+b4VvbFdbcw0RfjL6YdsU7cury6Zoabpznl0yNyK5s+JZuDjMu9JQ8jrs7Lon0fCqAcB3t0YJ6+SocBxfNkcgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sFwMq0DL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sFwMq0DL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6c38be762so214414b3a.1
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711726111; x=1712330911; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8zfJ89ytvh1yn8BeCmxI/QU3jWPilUTqcv2OtP6MX0=;
        b=sFwMq0DLvjMt3atCmMgLCr2nskW0ecSJcAmwEuzPtzQPbRKw/NsjsHAgPZ1HQWrerm
         tCrRgXsu1xPFV0zsxcrRl5uMaooAIufbsaHuKwTxgGEqfQaXIP/lRtFXWgA2CgW+Vghp
         gDsVh25OSxvdZ4OgYuaGL0/kCMmMod3I1UNgnHgkc5Zhf2oFjAUv3/rEf6lyiTYqLt73
         JZUAyBnW3NUPysustPCDkULLt/Vx9k3mSlU0jx1iNqW+ymqY/q/N08e3cDki1b6VAOhf
         NAjgH+fLwkBxazafVa2R6251sVMFSKqLspJra/jB0lzrLKGDxkIekRRWQjwgBCFnbYfr
         8oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726111; x=1712330911;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a8zfJ89ytvh1yn8BeCmxI/QU3jWPilUTqcv2OtP6MX0=;
        b=RuvKSUbKpKoKywT2h4e/Z+U+LWZVWc+QyRU0XJ7fLthsbreps0aaajjhflXJ7QEbRa
         jBctMQ7JBaVZK1ab7/jw7wAUACEdKVBKZb+kz4NEllY7r3OYWGMSO/W8Y5zyUsPRG2gi
         WtzX85V51sBWqR7Ow13buIyis4EDrkxel68dMLoJjgtX8bfzJ9uAFQwQAWu04vxry/hv
         ip4usWu1BxrCyIdu/USOmcr3WzKeIOjVgXYV2LuJ2Fps5OOnMRY7QKadE1CsbDWwXx1+
         EarbkbuoQIUXMbfrukIxnsclwGnKGg1Hi1Et2Ua7JUYAMXIzXWJ5VPUgw+uDAIkW/OA8
         +0Xg==
X-Gm-Message-State: AOJu0Yy3gyyXXb6gKBiyHA9IV3oHOWaNbPZMNTEPY/EeZnbBwMcdvsYj
	OAl5Bk/qc5yL0RkH8tAw6SXwd4LQUzyoQ09yTfIipDu6XQ+KEZ5NcSt/pZiYkYZsylSCbz50kgm
	D
X-Google-Smtp-Source: AGHT+IEOYuB5iq14xs/CoYVUuCqEVNAbZO+QeMqGM+jX6Vu6kr0yVtlVJOc6tCcbcl6aTOgE69fixw==
X-Received: by 2002:a05:6a20:9187:b0:1a3:b00a:7921 with SMTP id v7-20020a056a20918700b001a3b00a7921mr2298001pzd.5.1711726110834;
        Fri, 29 Mar 2024 08:28:30 -0700 (PDT)
Received: from [192.168.201.244] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b006ea8ba9902asm3165722pfj.28.2024.03.29.08.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 08:28:30 -0700 (PDT)
Message-ID: <eed6cd8f-58fa-41b7-b442-141752d16237@kernel.dk>
Date: Fri, 29 Mar 2024 09:28:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.9-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Small round of minor fixes or cleanups for the 6.9-rc2 kernel, one
fixing an issue introduced in 6.8.

Please pull!


The following changes since commit 07602678091c0096e79f04aea8a148b76eee0d7e:

  Merge tag 'nvme-6.9-2024-03-21' of git://git.infradead.org/nvme into block-6.9 (2024-03-21 13:23:07 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.9-20240329

for you to fetch changes up to 55251fbdf0146c252ceff146a1bb145546f3e034:

  block: Do not force full zone append completion in req_bio_endio() (2024-03-28 17:04:48 -0600)

----------------------------------------------------------------
block-6.9-20240329

----------------------------------------------------------------
Christoph Hellwig (1):
      block: don't reject too large max_user_sectors in blk_validate_limits

Damien Le Moal (1):
      block: Do not force full zone append completion in req_bio_endio()

John Garry (1):
      block: Make blk_rq_set_mixed_merge() static

 block/blk-merge.c    | 2 +-
 block/blk-mq.c       | 9 ++-------
 block/blk-settings.c | 3 +--
 block/blk.h          | 1 -
 4 files changed, 4 insertions(+), 11 deletions(-)

-- 
Jens Axboe

