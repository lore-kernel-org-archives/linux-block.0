Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2530EF86
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288619; cv=none; b=E0enY63g6E2Q/XfV+qj6C/e2iCI8JHRr7wu78HXcJPzJEEDY2E3zf7URE2xk2ksaXCFv4aEU02C0aVd4qXlRqPNPOVhqDGrFqU4XwrRVkLwBOrjbeYlR8MafjHfDsNUXF0JhwqhCPT7gDkj9tfcO9RbpcqJfnFKzO2h2Yb5BD1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288619; c=relaxed/simple;
	bh=o0zO2Q03U7Pcfdqtx5+AD0mu1VvbkhrqFuD+Vxrzvc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WP2gL1/+4e/63zYJj+uDLblpc1AGFg+MkytdYpGLsVZIzmy1L9hvZpcell0ekLTgG5ixUkHahKAgEXQBJXnBzOGgKYHE3Gv1MNz/2RxqwiJk5j8F+rMLBTuGgHONcZV07AM/ffOVmyeyV3uotW85l3IKawgWt+OCc5wgxOtMMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HDDc9Kpm; arc=none smtp.client-ip=209.85.208.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HDDc9Kpm"
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-69e0f4eb4ecso77847a12.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785288606; x=1785893406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBrubRZRlUiQu9aT/4sx8tjb66mgzpR1rjCplw/e+uA=;
        b=HDDc9Kpm0HFK9pZlGlR+9t8jXRJbMtFVb0U1isORc3Vebmp3jyNCx8BNL5jxEf645b
         rRAf754EWM/fjW0ihXo0LwpjdIWwN2uumjncc5y9T4ypYz/XDnazJjCSeJVAN0z2GtXp
         drVOTI+l4tgo8f/nK0E04RZnz4LVAtUK46SrO/tib8YC3A6gOKqjT14kY7cVAqMyKxda
         Gf6bjOk3feS7DdO8t2biGs3LOopmiqnLzhHa/D0LUWnjsjGJM73PgV3pU5cLPEqq3niy
         NP0FNgzrkZ6oO29+66RFI/Tid16TgMaQ23Ml1kJ0WKWx0c1SbM5w79IqeIsGI6C1wMsK
         9TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288606; x=1785893406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GBrubRZRlUiQu9aT/4sx8tjb66mgzpR1rjCplw/e+uA=;
        b=matJGkPHauc/3iR3EyrtQljs+l6ELoEnJttWlr9DgBn1/cg4AAP09Ie/dS2+fiKufQ
         GCfo4U6HX73j8yFy611VNqL8JgfDIQZegph8R3k1cCHia9+Fc4r97f03QYWZR/uWvyaW
         wiIJED5H4bcMj/5FVAuOvQpEDY33kOLw9yDKgwmEwa7Xgjf/wc9errsZtE7tTtc+ZjmA
         2WJwLij+mFt+MABfKTfgMSg7W7ql+c2rZFhY4snZMDBPnNalqvywJYskd4E6i773Gdzr
         8jbHItrf9/fz+tuEempWhXBpZddZlRV+O9nkJlETOnqvie6Il0qU3LScSD0Kb9BFfe/6
         EDVw==
X-Gm-Message-State: AOJu0YyBQb6tHfQ+msuoTyP+t9YWrK3bVHP5FZ0OT2shqUeImMX11uzE
	LFk7Sf6idMIDZn7u/+6iwMrGfqtro2dg6sH2c60d3JWl46A2yu3WD8NssVkQa6n6kawiTvjIsLe
	pODFo1yzD/PsRGqKxmQOuI6KLLh4ZMDdKGS4T
X-Gm-Gg: AR+sD13kglkdCCc+B0ibBL6wYk2j5rue4uraHyaIv7vx5tUfpTktR54SLi5OTZIAo+0
	h84JCCy+gnTjZpLztSozQUbPwLMTGpUjKM5lRlcPCyuwM9OX8efUZur6wk7pZ10qtERdiSMKFZ3
	FUWvYmHfWqQ22IJNnFXKyXaTpJVeN2KpCwziOQcr6pj4TTN31KUEZvO9aEemOVHYnRDZto32lN/
	YrUcpr6jgrAGDjD9QV1n6Mzy901bGyicJsnveMat6pWzJPPcnQqrrXt/zEKazl1fGlViKgA2Yl5
	5XX4iH/TMTjDMcZzrD81kWfSnJv4HtVV43uw3k8ugAuCCENz9XTJUyaJxyqoBVTSXF2CKlfJKfi
	Oyxk5jPVqEGjlgibWMVhpX3/XzF007m1y
X-Received: by 2002:a17:907:d113:b0:c12:732a:fe52 with SMTP id a640c23a62f3a-c1f7223e3b6mr149100166b.4.1785288606281;
        Tue, 28 Jul 2026 18:30:06 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-c1f83fc22c1sm9003766b.55.2026.07.28.18.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:30:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 0440E4014B;
	Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F25C3E4095D; Tue, 28 Jul 2026 19:30:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/6] ublk: io_desc optimizations
Date: Tue, 28 Jul 2026 19:29:45 -0600
Message-ID: <20260729012951.3744582-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk passes the parameters of incoming I/O in memory shared between the
kernel ublk driver and userspace ublk server in struct ublksrv_io_desc.

The thread submitting the ublk I/O writes to the io_desc, while the ublk
server thread handling the I/O reads the io_desc. This basically
guarantees a cache miss on both threads for each ublk I/O. Avoid the
cache misses by writing the io_desc on the server thread in the kernel
before dispatching the I/O to userspace.

The size of each io_desc is currently fixed to 24 bytes, which has been
an obstacle to extending it with additional fields [1]. Additionally,
with multiple ublk server threads handling I/Os from the same ublk queue
(possible with UBLK_F_PER_IO_DAEMON or UBLK_F_BATCH_IO), false sharing
results from adjacent io_descs sharing the same cache line. Add a
UBLK_F_IO_DESC_SIZE feature allowing the ublk server to increase the
size of the io_descs for its ublk devices.

[1]: https://lore.kernel.org/linux-block/aV8QfvaNO5P6vOs6@fedora/

Caleb Sander Mateos (6):
  ublk: consistently use u16 for queue and tag numbers
  ublk: remove struct ublk_zoned_report_desc's operation field
  ublk: split request validation from io_desc init
  ublk: initialize io_desc on daemon task
  ublk: add UBLK_F_IO_DESC_SIZE
  ublk: lift need_map check out of ublk_{,un}map_io()

 drivers/block/ublk_drv.c      | 213 +++++++++++++++++++---------------
 include/uapi/linux/ublk_cmd.h |   5 +-
 2 files changed, 124 insertions(+), 94 deletions(-)

-- 
2.54.0

