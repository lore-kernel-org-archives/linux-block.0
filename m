Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5571B45
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646416; cv=none; b=idVu9vdLV6nwxIjOjCSnPoZp5P0jzNkz7Ay+KKXxHuXVUG+yaJeorgur2DbGp02ZZIsufuWt25lisaUwq7ko9y331YDjteE4YfJa1h8tMofIgjAMPlF5mW4s3wvU4geCScSaxuRDbxOjoh6gafnyGQmDORkFgoB94+8NT4sQ5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646416; c=relaxed/simple;
	bh=DAHKXkgGX6dVy7GhunRGD1wJ+VIJeHNTtVOtYIcDKzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KqZmVjtJ+mHvuaN+R3974lTdg+DZVdtG1azYe6jM6J+Ode5nAVn7eV46m+/VRF6LaPiFJWyfEJ0sv9KmkTf2JEtQczrYcrW2kgCX2SgPxmqJcgGLCJ+zMvFGsRMOzDmBHiFPaJd/rjPYaJ1PgSPa9WED41/1INLq6cORJCybyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42ab7522bf6so4989151cf.2
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 12:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706646413; x=1707251213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfLVgoK5UewERlDGZW4uzJ+r/QTnm1HhBcO9MjZ8mO0=;
        b=s2rv/8r2MU7ezIjsA3UO3dvvpQSD8KONTR59Yt0qBXcqtb/Q93aHUuesoP1fOheHo8
         9mA43MGsTJjWpGv7om+w5MYxpwKwOuxKFEb7lqKEI6zWJIMOs1jxrf5sc4t6Tz/2l3AP
         OkO0BvB77ktSzg8fDjVsUjDpSXls1sapfh9yYkw3gbMxBfEf/eQgyLjFZssXJGeOfrJR
         4UjvK5fZCsovQDcngReASk9kXww3f/IObvQcEQbFL5HnMyeXHfj7CiTkxF2bMUbTj58L
         8i6GNi2u2AERj2EsV4NBf2aFCMRuihv5A/6Bua9i63gmfCOA/JeNsFYI2bsVUlOIanZi
         WiyQ==
X-Gm-Message-State: AOJu0Yy0mK4+3UtG7GaBCZQJ/jiJP3NSAlO4U6orz72VDURtc6WnZp4S
	OWFysW+sa7jI6lH4zJuwe3kytbr4fR6dw8J0KFiBNSBRF6ss505U9XdkMQZQjA==
X-Google-Smtp-Source: AGHT+IH6mATX/KHzFYyK7VQNDRL07dVKXIjYJyfwoY/OnHBQNtdI5eHSqQjVJuWoJe7ytWzZhKgSag==
X-Received: by 2002:ac8:5f10:0:b0:42a:6333:e85a with SMTP id x16-20020ac85f10000000b0042a6333e85amr11417468qta.114.1706646413121;
        Tue, 30 Jan 2024 12:26:53 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id s14-20020a05620a16ae00b0078199077d0asm2389194qkj.125.2024.01.30.12.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:26:52 -0800 (PST)
From: Mike Snitzer <snitzer@kernel.org>
To: axboe@kernel.dk,
	hongyu.jin.cn@gmail.com
Cc: ebiggers@kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v9 0/5] Fix I/O priority lost in device-mapper
Date: Tue, 30 Jan 2024 15:26:33 -0500
Message-Id: <20240130202638.62600-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've revised the patch headers a bit (patch 1 more so than others).

Jens, please let me know how you'd like to see patch 1 land
upstream. I feel like it should probably go as a fix for 6.8-rcX; I
have some DM fixes I will be sending Linus this week and can include
it (with your Ack of course). But you're welcome to pick it up just
like any other block fix.

Thanks,
Mike

Hongyu Jin (5):
  block: Fix where bio IO priority gets set
  dm io: Support IO priority
  dm bufio: Support IO priority
  dm verity: Fix IO priority lost when reading FEC and hash
  dm crypt: Fix IO priority lost when queuing write bios

 block/blk-core.c                              | 10 +++++
 block/blk-mq.c                                | 10 -----
 drivers/md/dm-bufio.c                         | 43 +++++++++++--------
 drivers/md/dm-crypt.c                         |  1 +
 drivers/md/dm-ebs-target.c                    |  8 ++--
 drivers/md/dm-integrity.c                     | 12 +++---
 drivers/md/dm-io.c                            | 23 +++++-----
 drivers/md/dm-kcopyd.c                        |  4 +-
 drivers/md/dm-log.c                           |  4 +-
 drivers/md/dm-raid1.c                         |  6 +--
 drivers/md/dm-snap-persistent.c               |  8 ++--
 drivers/md/dm-verity-fec.c                    | 21 +++++----
 drivers/md/dm-verity-target.c                 | 13 ++++--
 drivers/md/dm-writecache.c                    |  8 ++--
 drivers/md/persistent-data/dm-block-manager.c |  6 +--
 include/linux/dm-bufio.h                      |  5 ++-
 include/linux/dm-io.h                         |  3 +-
 17 files changed, 102 insertions(+), 83 deletions(-)

-- 
2.40.0

