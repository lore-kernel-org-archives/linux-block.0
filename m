Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205914;
	b=veMzYPMEZbGCxQ0NKLkfhl3/jD1cIy565OS+GjQZhJZkII7ER2vLt2R3csonsR87FALm
	 Lx+Ka+YUoQh0DxQuH06q+z3ER9blFubtDbzJRX4698jDeGptOAX1aXalZsN7yPoIN/wnM
	 FGellKX+nZaHg/3zwg1AmFI22bahZL529N036TVFQ2/5/K3io9C3b6ZPeffvRJYfO//AF
	 jyNXrx6FdmdF+Ks7I+vhUXASaNjJlIXlzp9oc6Vb9LvMXR6BvclCeG3jiGVphmBg+w93v
	 GEedaYJiQN5783LohgIGiGyCgu2f/F/iyFHd/mfijVxtgtI0bQt6b7na9193UgrBXoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZQygQqzAeHoVwL3mVEgLtFta3z0P2K3BZAYWz5UxS1c=;
	b=TlSchK79MAho76meBZ1wdGW8cpVh2EYHX+IuVE7LdzZ7rLJiaYJQyCHtm2LMkUGe1mZn
	 bhLdkRMSqZqqm7TX1Cp9ygCylm9IGgkJsOchRpuD9Zqn+3wmZTTzy2OBVSZ0/OA4h/eXP
	 n0kMoFG7H/RS6zXnTspag8X8ULoqRU7s2UCvWZWzQZNUMw8tJS8puTM+ZkIEv+RM+Qzgb
	 ZTRZ5ErwxWEmzAgj/4CzqUgEpgSbGpQcN+QoH53uqWAXlj1RtBE4pnbe0EqwXXjUEowUB
	 3kGbn4JbYdrp4dRBxvce7qwaV7Gt3Efsh1jeDz3lPtrAa+nBnb2rv1JcsL3Eerf4yXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MhUJyUL8;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEFC606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DEFC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MhUJyUL8
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-84a248254f4so775697a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205913; x=1793810713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQygQqzAeHoVwL3mVEgLtFta3z0P2K3BZAYWz5UxS1c=;
        b=MhUJyUL8bO9vg1AEFnvbYkYAD/yV5LJLco+uWRTJbZ+dzFCbulk1mRqATBcrAAUGg0
         m6g5eDXf2FICsYyFdzwxjACTKZLODSZq5pFJ7R2HTYtUhuo1Hraq8gU0BN6K/w/2Otxw
         9OPWpkuPRVSvZcStBK1hup+Yj1SFyZ2ID49UpdEK1tpKdlED6jRfK6R5MFNHtId3Bc/u
         FegerMXIfD3TKhBAo6JkQ4Mu+Uz5nB+iHxyVSTG8vRULUvEp/ymYAiMAYLfr2UZdQwpI
         o02WYRF9zzBIilYr0gleUlfFfWx6nihfsZTKREL8JyU1tTfhTOb8tX6PzCNE7lz+LAbU
         2VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205913; x=1793810713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQygQqzAeHoVwL3mVEgLtFta3z0P2K3BZAYWz5UxS1c=;
        b=ugTQXmSd93MR2mg/nvElJeFKwO8H+vLS5GDaF8AuGYxVGpESX07ta4fpmwXk5TZ+mf
         AyTnPvm+uBeu73e7KqSP2dFxMazBJdJAS/1LOwAt0yKBjACmImjWGGzOAp2w8JqU3jwn
         pSJhomzUMBz0eMW9AOe6GSxFpCstMWnLc4hMB74Sm5m25m5qpOxzhyede3k0KFbho/6h
         abI8TtmpRrk1yyLf62yQqbSrW+qgenM8FgJHXCCGPEzdNAd8vnMCAjSwcLwTUmAOvGyf
         4RQruf3La0ecGBMX11tHQTAxtbkdnQTgcxwKVmtmT1cw4WokRcXtkC8BcnaGVohJbv+p
         8C+Q==
X-Gm-Message-State: AFq9FYK2gM5PHjcwQ43h0dcxE0S27bnp5QBBg3yXo/TxGr48yGLktkBM
	c8EGW7K1DdOuWQqVOJRX1pqePiXLVAnFJ1a1UxauZ/11TAHBepmkDa0VyXYDg2dhslJgvGOADMq
	W5vW4b6Q=
X-Gm-Gg: AYBFou19jXm4evsxHEss2YE37p5vcqgmbY7Qx4WqpKW6ASM8GEdfs9lSgpwZUWaXcG4
	EOGNgoriGjVg4vecKuo/qfyVpO4kPvsOch2Ew1kH/J7C6XFAA7odr9w3tF7YHhuN9YSccJVwFXj
	mYli+IRQWbyLsVCSTHrCVJaEaHA5lDN/AZjGkyfxDYTuH6VpIDpcjLV+QPPM7YwW7hfGREoMaxx
	6BoAQbgYovNALnUM1uqj/lXGjn6L50EHhdFvsr9PiKJXB4k+vxx25q2Dzk/1sBwpMtvmMUOg28p
	hGy4cp8Qn7WRJPrdFf3B9A4G4g0+eYUHGC+kJT6eJXwWI3lgLQQViiPI6hB5zWXOR4YIQMRdRde
	Lh1/xmEVHsg115OGaIIxuQZTZsVESB5K8xvT9W3DnR5iPzOaZVc+SvLS6k+1RW7khLRLox7BWCL
	QzQLgHbk7ThFhF0s4OyF6G5ZQTBPKQ0MvWysDBk7XkG6AQXU46TWW6llXiRrd79+onGv1U+GRfJ
	R1RusEENbOMqp58b9BCc9mtFIFD9V9JRhp5xXlex3sJnbX4RmKDAbRt5Cfyc0ZEBwKoRtJAu7V2
	mkyvPuUuy13AC/SS3gpat44fozwlaChjMCAyA8Qymn8T6B/O4Z+0D77dENqFLQQ/Y1zsQAwHXA=
	=
X-Received: by 2002:a05:6830:4aca:b0:824:df9:971 with SMTP id 46e09a7af769-85abc7246ddmr2769762a34.10.1793205913200;
        Wed, 28 Oct 2026 09:45:13 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 45/98] nvmet: don't truncate the length of big discards
Date: Wed, 28 Oct 2026 10:41:48 -0600
Message-ID: <20261028164415.1262013-46-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

nvmet_bdev_execute_discard() shifts the 32-bit nlb of a DSM range into
sectors before widening it to sector_t, so on a 4k namespace the top
bits are lost. A 3 TiB range discards 1 TiB, a 2 TiB range discards
nothing, and both complete with success. The target announces no DMRSL,
and hosts other than Linux (and nvme dsm passthrough) do send ranges
that big.

Widen before the shift.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..ed2e2c89e3e9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -389,7 +389,8 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 		if (status)
 			break;
 
-		nr_sects = le32_to_cpu(range.nlb) << (ns->blksize_shift - 9);
+		nr_sects = (sector_t)le32_to_cpu(range.nlb) <<
+			   (ns->blksize_shift - 9);
 		__blkdev_issue_discard(ns->bdev,
 				nvmet_lba_to_sect(ns, range.slba), nr_sects,
 				GFP_KERNEL, &bio);
-- 
2.56.0

