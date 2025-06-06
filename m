Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C538233136
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246060; cv=none; b=FgV8em9wPMkyTOZnrgweqRjhXsFSQk8oSQn+7mgARu5UQXPL4Anh+ifo9SDN7Y5vmfD/MkusYA9I3GzuXnJj7u1BNlfVm5gGggRrMxOuXgM+WOhITm/+YhPjD8VKmttYR28a1g3VTm3d928V/XjMuYm8ZG+DvymYKExUPoElezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246060; c=relaxed/simple;
	bh=NV78ecJcbwLlbKq1uIsiD2p3649y8cSKhYz8xLKyCuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JR0yjoS6G25S/+1mWzLaaxb2m6pb5JbVKWuAi+vO1d/1wGB+HPx8wpQ9c4evPP6/ClQrBPqHSWF5vegHc0Ss1Z7lNxJUBt2UjoV8xUDPCF3bMJenAEEUl2nxlZLBLfIeCclB40Rnk3aV0SRiWXXW7lZh8oF1xV6Nd6Hv1aNPMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Bntv7T30; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Bntv7T30"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-7cd43fd56bcso31806385a.2
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246057; x=1749850857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85PXs9ZsFgG5ELnFrR4OeoSNORNNnZgFgkfSgryvOqY=;
        b=Bntv7T304jPfQ1QeW8QI+q4BmB2ECYZtbUA90V2SP4lBoPxJoblXeAvWYOSoYPm2iZ
         Jh1ESDtRlZam7RdUdubGtgyPTBzbJ7FmYUMuJMzM8keL0mq1SRpMhlOpPwfiF6U7mHdR
         D3Ih9rV6K0HWjmVeT/sEbnBkf1tV9ShStyBKvoO5hZf/weEU8LqV5PdTir2g8Rk8vkWr
         r/+9U4DXa4QvDrxVrA9NvgwVb9DJRRwSV4sk2GzKU5VLml+2xxh2n1ZV494jnrrHKcR4
         IqsM7ZBj1uBiRRcBlECr3MsMXY2zgDb4DX+uHamXRivuNrL0mlRnFFgmY7J2Ya4Ci57Z
         wc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246057; x=1749850857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85PXs9ZsFgG5ELnFrR4OeoSNORNNnZgFgkfSgryvOqY=;
        b=MMeVkifbxEgRiNGu9g9U07XattgHrtk1cnuh7eIkwUC/LuK/CemU+T06CRw/0Fhb2a
         jHohLO9zMVEVCToMMp45vSDY19jWZeP6kGxi91+TlGGwUDDVh03GyHl3MHDXmEXYc3B4
         65+orozBL8CaQV3QBR33mT0E7iBXJMrxpcP3JfM3jdS/8RtTygUaQSGscYvq5X1EEI4u
         qKTRvEzEaIDOPLCBLAA82l2BVzyqVpnTujvPRVIjbezIr7Zh4pNymTBYFkJa1xYlQoVw
         STl3rPVeVRPvfaQ6twZFDYRFlDptGbTiknDccHnf5gXIijU1EkUDpHx2bYL1IwZROgSf
         pT8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zvw9whENzY3LZ4DEGN6zCNV+ac15OcBzzVw3IAgI7K7e0opPkMuU24TLVwwL2Yln6V6gf/Qt+cCdCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZtn8adreQY5tJM3W3X7+LiTOoj1DeQWOrElmt7oGQodtDPpQ
	1prHtUvQgiCwPgPF556cvWgBTLwf+EdIa7cTNbfa92QQkggaYAJgSiSdLHHMYEvHRcogpYIp8wi
	ncXu0UhucIdYdSGEB/qjILi/zA03JC3LXHlSaDMqA5jEa2Us4MuLI
X-Gm-Gg: ASbGnctD5GPXa5zvPBxYuafkcB8P1wxbbV8LIylbbL6NWE1IVpARMDCgXxyBMqBO3qV
	K5ZPaBtZzJCKwDVSLLX8M3zKBaKM8dXB+zzlBjTxG7z7aFUCas7WpWV9UhSRS5VYzPjI1BZ4pm1
	WJzGLEl2XLtyaeqwnd1ypHfPCs8m2hUpMzO4V/N7g7OYxpvJ2Z71/k8uMsgOwVy5fuiTLToIUWm
	CUbgf02rcIu+Kn5H/MIoadAsRENNFrNIbuAsGif34h7mJJ84PzzoCyVmDGEKFj+qGhaBRF8bOJc
	p5dlx/U9Wj/NQL8Q+3aby4w0BV0AIw==
X-Google-Smtp-Source: AGHT+IHV5sT8ClFACrLcTUtiyGVX8iKG5qVIQ56tum5Ad6A5Q0eICeJsEj9k2QV8hAODE+kDrtI4TXTqNDzB
X-Received: by 2002:a05:620a:3949:b0:7ca:e519:6585 with SMTP id af79cd13be357-7d331c4db9amr189287385a.4.1749246057183;
        Fri, 06 Jun 2025 14:40:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6fb09ab3179sm1366146d6.9.2025.06.06.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4E0433400F3;
	Fri,  6 Jun 2025 15:40:55 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 37C54E41A13; Fri,  6 Jun 2025 15:40:25 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/8] ublk: allow off-daemon zero-copy buffer registration
Date: Fri,  6 Jun 2025 15:40:03 -0600
Message-ID: <20250606214011.2576398-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently ublk zero-copy requires ublk request buffers to be registered
and unregistered by the ublk I/O's daemon task. However, as currently
implemented, there is no reason for this restriction. Registration looks
up the request via the ublk device's tagset rather than the daemon-local
ublk_io structure and takes an atomic reference to prevent racing with
dispatch or completion of the request. Ming has expressed interest in
relaxing this restriction[1] so the ublk server can offload the I/O
operation that uses the zero-copy buffer to another thread.

Additionally, optimize the buffer registration for the common case
where the buffer is registered by the daemon task. Skip the expensive
atomic reference count increment and the several pointer dereferences
involved in looking up the request on the tagset.

A few other cleanups and optimizations are included.

[1]: https://lore.kernel.org/linux-block/aAmYJxaV1-yWEMRo@fedora/

Caleb Sander Mateos (8):
  ublk: check cmd_op first
  ublk: handle UBLK_IO_FETCH_REQ first
  ublk: remove task variable from __ublk_ch_uring_cmd()
  ublk: consolidate UBLK_IO_FLAG_{ACTIVE,OWNED_BY_SRV} checks
  ublk: move ublk_prep_cancel() to case UBLK_IO_COMMIT_AND_FETCH_REQ
  ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
  ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
  ublk: remove ubq checks from ublk_{get,put}_req_ref()

 drivers/block/ublk_drv.c      | 169 ++++++++++++++++++++--------------
 include/uapi/linux/ublk_cmd.h |   8 ++
 2 files changed, 107 insertions(+), 70 deletions(-)

-- 
2.45.2

