Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EB372686
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309419; cv=none; b=Vh7pG26rTE09ivqyXrt1xA59NpQFvF4b1ebBA7hbUhGzdK+/iJTqr5l31KQMRWWuMzFJYgDzIWG5GmZbW/IonI06LM8g04SICB7k2t0CvMeJ0hTBSlp7AA4X9ai3CwlqBwQ3ia+JRpoQNkllPcu/k39N/3ydw65HXKRbzdjNwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309419; c=relaxed/simple;
	bh=AXzh/mBfXg3NFBdvZLAd+hGeKwx/X6yoiJV5zoROixE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2k2xltfEtQkkH207PfcCNMwXL9FC9qxnUXCCGeiE0kNpjoucLR430PY474B824AwwVIE0iQPHsPf1rL+JAjh3PIbiM0P/TbQa10mX3WWgMUXm1U/kWVq9eQQuJJlUqC8cZhwOIonAhXS1wLiQxWjmyAwvax2SzaSE+OEMPm/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OPFCPJRd; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OPFCPJRd"
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2f53c6af46eso379015eec.1
        for <linux-block@vger.kernel.org>; Wed, 20 May 2026 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779309417; x=1779914217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IHCH2zUeE4WZgWjWtfehPnpWdxpRBIWRnVEW3/GqIY=;
        b=OPFCPJRd52BlUuHYNASGlwqcCgbJY3xzoYRRJe/MDC56l+M2MPTRJtBGY24F5r/ms9
         O8MqK1QJ1Kjxee7xe3R0Mf5/B959KOMLYnZ6hnG+F0Pt2G/zHPUnBCwWT24pJAav65ua
         wIBfem5ESkuTb0CRzdRdRgMndCyWXUflDoRCW/Wc37Co+K+gTj1+gHuwcSlGKXvY/rIu
         BhONk8uYajfmkdJ0PDAw5GeDIN4AYSM1mkSTiUFrE5omvhN/gmp7bCS4cBcTOahbpRWw
         y4th4q2BO0ehCho92XAGx0EnvTsxVqPvcTlkSW0XDEUhUrrioWyTc0nwvnz3VYLfZGc9
         weZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309417; x=1779914217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IHCH2zUeE4WZgWjWtfehPnpWdxpRBIWRnVEW3/GqIY=;
        b=D472HPOnvcBnRW/SP8kb6RCd4dQSQDTbTk9zFU+WDt682CP+PeOg4UmLJ/f1TnCHxb
         5r7hDpFJVbe5DhyoPk0XIIgvcRoIWJbJLKohc7jFpovtd8t32lYv3Xh1wx1dui6ye9tP
         GPUYydR08+136RK5QxAhV3xGvsdEClu5sGVvufn5ucZfnDova/rxLJ/V12oVNppr19T5
         rC/F4Gp8bU/nRhkGXG2yPbAFRjnTstfCzyzBch2Dm2qfNI0k2s84wsIjwMe9brGEk5ye
         ggRtNGmGQC5KTvOuhVlBzt8ei2GMVM7rznWcEf3gb+YOCGVVfkHP5okh5taHdFQ6MQJT
         MUaA==
X-Gm-Message-State: AOJu0YxonJ6Tu9U1v2PTFEtGC9lRZkWGZX8LddRiPCsqV4z6A2Da9Wba
	4K8OL3E3lz0ifvReZrOs3TZ8r30gC8/lMYDwcNBKC/3KXSIqVpD88yrn4c9JLGLerv657aRyatA
	nUA6YakOmtcZyqphWAfLJBaRA51uwDwbv1mor
X-Gm-Gg: Acq92OEClG92y/JvgUT4QgyaevitOGharW43hNbpHbZe7UMcGsa8f9V5LACw38Bp/dE
	9Rka6S3dBDbw0p5vyBJWeLSrAsRGjQvEIIzaykQVjRaSZzKKmn2rTrJ7wRjpUFocVQ1SjMbK/6R
	6zZA8NXdorJuxtgQejv2aFgUOWZuN4Zx4fcZ34UaLJoGjF8bFrrytzzPMwRmWbi323Dv7lZ6pDB
	Yvgjpq1fTVS5NGxetlWrNqE/zW+3NAKFsiy9bOnGPmSKTNWm7wP9t91BGsmFgAHUYV3gpHrwbm/
	NaWOfeA3g3iFxQjgw11qHf/CRXmhFo9NOOzDgvKwGWQBQ+jVeu5r4BLVd6ikZDogICYZFFjDHfL
	UxqXvsnCR1b0xEKb/FMtGzfQAFp1D6JkOMGY5FaM74dDdhorbzoF9Rw==
X-Received: by 2002:a05:693c:3007:b0:2ea:5057:a320 with SMTP id 5a478bee46e88-3042f4854e1mr51466eec.2.1779309416522;
        Wed, 20 May 2026 13:36:56 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-303db272c3fsm886651eec.24.2026.05.20.13.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:36:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n22m09-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:449])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 96C4F340245;
	Wed, 20 May 2026 14:36:55 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 790DEE413BB; Wed, 20 May 2026 14:36:55 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7.2 0/2] ublk: enable UBLK_F_SHMEM_ZC on zone appends
Date: Wed, 20 May 2026 14:36:52 -0600
Message-ID: <20260520203654.1413640-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4d4a512a1f87 ("ublk: add PFN-based buffer matching in I/O path")
added support to ublk_setup_iod() for matching request buffers against
registered UBLK_F_SHMEM_ZC buffers, but missed adding it to
ublk_setup_iod_zoned() for zoned requests. ublk_setup_iod_zoned()
duplicates the code for initializing struct ublksrv_io_desc, making it
easy to forget to keep them in sync. Move the common code to a helper
function ublk_init_iod(). This allows zone appends to leverage the
shared memory zero copy optimization.

This series is based on "ublk: optimize ublk_rq_has_data()" [1]

[1]: https://lore.kernel.org/linux-block/20260513211846.1956810-1-csander@purestorage.com/

Caleb Sander Mateos (2):
  ublk: move ublk_req_build_flags() earlier
  ublk: factor out ublk_init_iod() helper

 drivers/block/ublk_drv.c | 123 +++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 63 deletions(-)

-- 
2.54.0

