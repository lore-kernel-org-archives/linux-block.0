Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E81DF26E
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160234; cv=none; b=YnOMdQagDBQ0aaSK2JgjKt/X5kZpRNVgvFwDwn9znQ+vssfn/0Do1DJmhMBrSap8g0Na89IEasEUeX8kiJqcNq5u0s/iL84wN2nahAq65r1EiVncAj8UUfnWIqBzI6mgSyLjEUp3j6bK2cIwBvEiTh2+68K1rIteclInvMAKgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160234; c=relaxed/simple;
	bh=YmbL8tWBk7PcWIy4d7codzBe7sqj3ogMoQ4DpsIfxTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yq2MfGlAihaShmbyFD3cwtc0JBJlMzvLE5L3sHVW14VHh7yEYT98b3+oFHLe+4ApNG2pvsa6l2NgAWAYLtnbhjvs792gmi8+ib9AN9+QYzcbC0ztOC9uZNhtFFM8eKhkIs2MAgI+2IFnawXAKtYld/EDSI5fgr7nPhCI4xMgj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YxFTJFKm; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YxFTJFKm"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-30ccec232bbso45256fac.3
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160232; x=1758765032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGIvktuNokMfEeQBYkw+feVubqH5mU5MNNf0kIjurc0=;
        b=YxFTJFKm+GOwjfBoH9z85PSg9AUcAUd+cAdZAyQjPMkMXMWxLgNHkir8fXi1gWyh9P
         +FSQPaCehaHpibVwkwYAIu8ZVgbt1xYOSE3poYZLc4zam18wM/rmZVJni2ZbLqNAl4hC
         a+r6GkQVp3s3wYGpESdOxSbDDnNTFoI55PiMd9LsUzijzexfdVygJP4aLjsMFmWHgDpX
         eCybjVCWctM1XtYCyeXoATmLPvSb/62SLe+pEEfhjgos8/+8bRtTgNFlTTK/XK/HHyfp
         Mlk1r+U5owKENgfknsbChNNPvZ0EwDe4jtWV6vseMgg/lpvUSntpAAGfFl3Fykm92UQd
         j0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160232; x=1758765032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGIvktuNokMfEeQBYkw+feVubqH5mU5MNNf0kIjurc0=;
        b=C9DpQb57ELDPt3akkLwVjXLZNzvhc0jmAFwtBrUai/MapoFg6qEDhLOp7C6lYok/DD
         kpILu/AbMWUU6SdMpM3cGqGWTbefKGA8heyB0uPnYUxZiHaqvyu3sCDTiQWww/AvuX6Q
         Wf9jCt769fJCj9xYwXYLfQu3i/RYDPAREeDY7ndtuBvOxNGbHTd8hNRhabqGhPPo2h5d
         1kXpzUSiTP8riRBKog/1nK5BVUJY0PommrfADLwC8nzs7wZ6yYrkA+lj+BI4oL/ms1fp
         ONrnj6aJ1OHskWo8vF143uCx+7kG6VAyMtC0tq7xXquxaxnjbp8BvuPC4aUPcEMp88qB
         PIdw==
X-Gm-Message-State: AOJu0YzAIdU5HfbBkyUn0e9B5HvjBU2e4yYiGJogpeS4TyipNEUxARZM
	kNQeDRtQa8yeKDnRiLAeE7qCdS4pkX9+JKOnlIbZqKpIhMreV9C5uoRC+s+wLBLtcZYUTfapwM9
	EkfzcxKefAyUsD6w+1nRGYxBHbvtdZI1b3YD2qq6b+2oTjaXHXo0H
X-Gm-Gg: ASbGncsOff4aMX1bbojkqe8I8MI4DeXZ8WELDqqXiujeE/oe5Zsbgh+qTLBHjXeHXBm
	8Jv1AEFGcneNamB3MaRZl/SewjMZ9YavraOFqZkoZ+/ZRVkhEYWmqviDNZWKEWUjWfiCS6ApaTE
	zRN0wIxIoyi5v87kcI7G+JZukV6qQoarocSs/ITecp8QXOJJ+/HQA2n+BEpQ27QZ5Y8H4if9sAp
	j4/0IV5g/GkUyh2qJRXydcvBaymBOjo5vscHbHByf6A3RO3g+JDIbkFlecj/Q5sUlAB08IAjw7T
	CuFqxo59gYXJanxR8OwNvisok3tepkzfdAJKkxtGO8e3XW+Arwarle+Jlw==
X-Google-Smtp-Source: AGHT+IFjlktqk/3nYPmb+CRYzX3NN7hHld95pMMXVz0WtXy5Y67cG3TeyxcLYDmSvHwYCTNNBsADk3KeahBe
X-Received: by 2002:a05:6870:9a97:b0:31d:6420:8791 with SMTP id 586e51a60fabf-335bf6206demr1202085fac.7.1758160232119;
        Wed, 17 Sep 2025 18:50:32 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6487e4asm123459fac.18.2025.09.17.18.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:32 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A36D6340325;
	Wed, 17 Sep 2025 19:50:31 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9BC38E41B42; Wed, 17 Sep 2025 19:50:31 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 00/17] ublk: avoid accessing ublk_queue to handle ublksrv_io_cmd
Date: Wed, 17 Sep 2025 19:49:36 -0600
Message-ID: <20250918014953.297897-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_ch_uring_cmd_local() and the functions it calls is a frequent cache miss.
The ublk_queue is only accessed for its q_depth and flags, which are also
available on ublk_device. And ublk_device is already accessed for nr_hw_queues,
so it will already be cached. Unfortunately, the UBLK_IO_NEED_GET_DATA path
still needs to access the ublk_queue for io_cmd_buf, so it's not possible to
avoid accessing the ublk_queue there. (Allocating a single io_cmd_buf for all of
a ublk_device's I/Os could be done in the future.) At least we can optimize
UBLK_IO_FETCH_REQ, UBLK_IO_COMMIT_AND_FETCH_REQ, UBLK_IO_REGISTER_IO_BUF, and
UBLK_IO_UNREGISTER_IO_BUF.
Using only the ublk_device and not the ublk_queue in ublk_dispatch_req() is also
possible, but left for a future change.

Caleb Sander Mateos (17):
  ublk: remove ubq check in ublk_check_and_get_req()
  ublk: don't pass q_id to ublk_queue_cmd_buf_size()
  ublk: don't pass ublk_queue to __ublk_fail_req()
  ublk: add helpers to check ublk_device flags
  ublk: don't dereference ublk_queue in ublk_ch_uring_cmd_local()
  ublk: don't dereference ublk_queue in ublk_check_and_get_req()
  ublk: pass ublk_device to ublk_register_io_buf()
  ublk: don't access ublk_queue in ublk_register_io_buf()
  ublk: don't access ublk_queue in ublk_daemon_register_io_buf()
  ublk: pass q_id and tag to __ublk_check_and_get_req()
  ublk: don't access ublk_queue in ublk_check_fetch_buf()
  ublk: don't access ublk_queue in ublk_config_io_buf()
  ublk: don't pass ublk_queue to ublk_fetch()
  ublk: don't access ublk_queue in ublk_check_commit_and_fetch()
  ublk: don't access ublk_queue in ublk_need_complete_req()
  ublk: pass ublk_io to __ublk_complete_rq()
  ublk: don't access ublk_queue in ublk_unmap_io()

 drivers/block/ublk_drv.c | 155 +++++++++++++++++++++++----------------
 1 file changed, 93 insertions(+), 62 deletions(-)

-- 
2.45.2

