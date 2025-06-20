Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086F2BDC1B
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432219; cv=none; b=ONeellxaWoGY1z9JoeaNp+JNZFJSfjfeAvGveANOKBP2VoVSwAO+4x33tiWGJxaaH0Yixa9k443t6tdT8IiEDeKga9V3LDdIH1+qMagPLEiU91v2VkJD++CBKusJ972Oqmv34rrdKmpuZv+T+rrp5oTLEQl7+1w1k/v7WNDCFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432219; c=relaxed/simple;
	bh=tnZxTZhGFwNqILQVKD8hgVTlVREqevRrlXd5knUWs/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2AiDPed5QuEvHSIoOVXJRV209qDsD1i2qP6EDc+om5k1MaC+X/s0EO2SUt8wR6uZkBUHVViWfXxeY4F+TqWotWadJJcva3PLkkytPTNvzeAXyDfdIUHBaI3hxX9CZ0tUK2RdfAD0oT1Ly/rAFGLcS2r74kYuOBucKX9D0FKV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W0g1PLlX; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W0g1PLlX"
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-609ccf08baaso142239eaf.1
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432217; x=1751037017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+sVigpYbxLBnyEIV9S6skzizDrpHUVeeUaDVRy1G/8=;
        b=W0g1PLlXHinFpTSlE39yZsYYla9qDi3i+5nDk9uAowuImmYKUaZc9wEfmAtgj44poA
         W3SzcTZMbGp1AQ0pJwhrJuB8bInSqiHx9o1E98afGMwZa5qxG1RahkxUPn1NzS1v7hy7
         cfk3VqDeGuHeDWRe1EsXb0IhOKm+DPwAxHfZ0Rv9ZmHPoQeuU+KjEniA2f0MWG4nf6xr
         UlMWfJQVF7BNt/oiXGbh7hbnvgKz6iUbNCtsgZMW4g+MJxsGFXMaLuY2X/4x/hOJ3V8i
         HBsn/hbfC1JFHzFDYRZW7ze04AoBukSUYyFzsf/f+DJeuk2iLLTlHD14+FRxh0fWMPGt
         5NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432217; x=1751037017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+sVigpYbxLBnyEIV9S6skzizDrpHUVeeUaDVRy1G/8=;
        b=eXpWaonZX3tX5Rp+L2IXyCl+rM5qHvpPyF51+r1ja5aoX+RzvoJLRNS9ukte4MS8pl
         WQsnOlVPAkQPSYc2QkKIxvfjx1WukKNJd+PQ4BNHF+Z4lrMVVanKXs+Leu/OVqvgxCaG
         OQ2mK4xtmSOmhcnFoEJe/HpbkRONjGnmhZ9fpSaDWDjdWPBMJEvR5F/5bBc/aOknKgAE
         4LLyS20e551krJs752+CrmvAFetn56Erdn3Axl4f2tBefJd61RB3C9aYrDCrevnhQzCd
         MxA1czF/V3gKofMUckc9HneDUC/5u8E0omMt+NLXThDZI34eb9dlgqjBDujJzwqAoWDr
         fsVA==
X-Gm-Message-State: AOJu0YyndEremBgFbUdD2KSncFz2sdftonuxVNkZh77t7J0tMV7OmvXg
	du0e1I88WYMkW8iE1A5OpBkEqDVKxqWEDLC6nb+io5zccwPwKRxhqZYunnF9LfLxzlhgUkTlNnk
	11sv8UGjPbKJGj1vuI3NDd0VQeoOCVxkOqMss3cGEwFUKT1Ub073M
X-Gm-Gg: ASbGncujKGKcGcOgRpNuPhbAEVahewgEcqxBYG0nd1JNdmcnv26d1AOwv11K9JHnpZH
	jrgP15VbkK3y9cSHMZOORyz0/V7hEh2XGY+p1thZdmLjbj3A5yiV51m1e3aGm7GM2qakc8WWyV9
	HoHssSmDK/wqCI6hYkFCrnD/+cGWRqWgR0MktdP2azK+suY9nz0YnTkgITXqLvunFK4paPZtW8k
	hX3xwFoT00pMPuyPacG7tpBIA3sqQXKFwhETHSwT5JDGVeJbkU65U/W3bicOfxLc2IzySGGDwZ/
	NvRiv25ybs8OJv8xMwGM/qCp46ggocyM20E76My4
X-Google-Smtp-Source: AGHT+IHu5DpIoZzI+wsZcgGtbVjIF5JfsWmCS6AU+aLluhnKy4JjQWyKmmaLWfziFcofBW57OaHhUL1Pws6H
X-Received: by 2002:a05:6870:ff47:b0:2ea:9822:e49c with SMTP id 586e51a60fabf-2eeda54b253mr732285fac.6.1750432217036;
        Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6115b87b923sm41879eaf.23.2025.06.20.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 389EF3406C2;
	Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 37F7FE4548E; Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 10/14] ublk: return early if blk_should_fake_timeout()
Date: Fri, 20 Jun 2025 09:10:04 -0600
Message-ID: <20250620151008.3976463-11-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the unlikely case blk_should_fake_timeout() return early to reduce
the indentation of the successful path.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 11aa65f36ec9..f53618391141 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2143,13 +2143,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	io->res = ub_cmd->result;
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
 
-	if (likely(!blk_should_fake_timeout(req->q)))
-		ublk_put_req_ref(ubq, io, req);
+	if (unlikely(blk_should_fake_timeout(req->q)))
+		return 0;
 
+	ublk_put_req_ref(ubq, io, req);
 	return 0;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 {
-- 
2.45.2

