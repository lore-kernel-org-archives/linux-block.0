Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BF1D54D6
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185118; cv=none; b=OCQW6x4BDYCcsDH5PHtaKGu2DQerpivrrzyU/a1IfniEREyR/eO2NG7AeA0+UvyXw56PWKpenxrCNTRWyWROe45hNThvB3jAHrMl+AaGOp/VVjPEhsLvdb4SKwvXUYw13McK/sdu75tWf++M6U5tPnzquNd5+BRsRUlp8imqP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185118; c=relaxed/simple;
	bh=/EJ4ZbjnkYRQ/SfJMW9byzKiIXwhHDQOX3y6P4axrN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrgFmNAbgvZAxZHlDUxIdN6/AWFWM7yrr48uEp3I65q3v7bhizk+zHszNl/sP/ZCesg/8UEhXJyoJUpvI4Y0IVMIyYs58lV34gcANulH2aS+MEUGVLHKBQJ9pSdXPBrs+Yt8pwutjudyO8UWhoYPPkK67NHj9bkEFH/lwiUK8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Pi4mGhJl; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Pi4mGhJl"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-523d8cc30a5so50399e0c.3
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743185116; x=1743789916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKO+URIjpVJ9uG1rgJTxLMHOxyHBEWIVMk3SFxHLeIU=;
        b=Pi4mGhJluHpukbmZLYiJYUJC8rwKfzf15vWKb02o9EGC47U+FcsTFHr4ji2xO3r6RP
         t/Wa6S2bvprYe0zri+/lOeUPZ0nsye9lo7POkvzfV91mVLFJslmlD8z4Ij0aEEVrj7YT
         ETH4KfIVEeFgtWjew+rq98431XzYrpMl/3htmi3HPhAq/UMirOPA7mD3Tu4AIf1+VBUy
         jc9BauHQUHByS8z7bLhgk9x/VJlna6Ghc90W3eKMkvnG+AoiEGtt5DWO8A8VQvYsR/YD
         CEBtiGKEiM0hcBtMrT9b+Np9b6paiX8b0OTh8svHRZYhEfV8Xg+o6R8PhOHNw+MC6djT
         Meqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743185116; x=1743789916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKO+URIjpVJ9uG1rgJTxLMHOxyHBEWIVMk3SFxHLeIU=;
        b=tp0yHAYDl4J638xwbydiBXSk+Dz+4CYLDwTA1XafcejH5K+GXKr/wbwOhZaGfN+NxI
         Ngow2EHEpz3a72Y2KCOf4IbLo57Qg8yBCk7jO14tgBc9Eb5vD/pjrAg5+uqjjkWTnxfY
         WcVybfQqkZw1YLLzF26ASDxs8IYRrY3SurW/e4gHbag1d88IH/Dw/9tu0eysjwgWTNWc
         nFxBwUxxcNpNxAEf0Uwuk5whAP9MzfNXJaBYlgxRxvKE7n8L5gXHt6myzfOJuebyPYNG
         j2PTWogAXpiGRChz1Sh7GXmQLmOKO6NeJWU5Fq2Qgb7SIoEz6Rndc/BpYTF2l0SRKM88
         JHOQ==
X-Gm-Message-State: AOJu0Ywi17gNYUBH46QBgeWrZhHI57OWAkj0MSJ/EqrqwPMKYfd0bV4I
	ncjlXTQW+Sgloguwluw+q3kIwERA6k2oAlnCgZeLNxLMTqp6+wA/EobBoyQFHNceVUG5I4J97im
	x4uHMpRz/YTncHj5GERW66lOGh+2bFQyR
X-Gm-Gg: ASbGnctb3aCwdf0xBaiFdsOP+iWdHmF6kSo4KuN5Vm7y4bsh9Jh7gd9qC1nJSGyHd+T
	7UJ2ozOWZz4XwuToz7XAEAUIeKWNKi3VuTfcoF1tHFC4/QDMDd+K3wHYy5ldYtcHoy6r14r5n9z
	o+qBNXMucZAD+SjQFZF9rf8xaVRW3ocexriR1AdAsuNioW9D/L9fdCggKrOCT49sayjzstsnMK9
	xJ+2B77ScbYfZB460YXozPc8FPG61P8a0N3EoquTQhlCmF/Ml3hRaeK19iCNvQkQ2OhqcNkbd0Q
	Na0ZklCcO+WjKh9fuQls8a+27XtDV53P7kJxVT4UgNdhEhq1
X-Google-Smtp-Source: AGHT+IFAQauqg+sisZgW8z9z5TD36rwH/+HiDXUUrVmp0B2ndOE3PZDgqz5p6Y1vA4wQ/WM3IeHpP3hPsize
X-Received: by 2002:a05:6122:50b:b0:520:5b43:b843 with SMTP id 71dfb90a1353d-5261d18035cmr211486e0c.0.1743185115578;
        Fri, 28 Mar 2025 11:05:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-4c6bfdf1f10sm110525137.3.2025.03.28.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:05:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7F1183403C5;
	Fri, 28 Mar 2025 12:05:14 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 74C6EE408F2; Fri, 28 Mar 2025 12:04:44 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/5] Minor ublk optimizations
Date: Fri, 28 Mar 2025 12:04:06 -0600
Message-ID: <20250328180411.2696494-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few cleanups on top of Ming's recent patch set that implemented
->queue_rqs() for ublk:
https://lore.kernel.org/linux-block/20250327095123.179113-1-ming.lei@redhat.com/T/#u

Caleb Sander Mateos (5):
  ublk: remove unused cmd argument to ublk_dispatch_req()
  ublk: skip 1 NULL check in ublk_cmd_list_tw_cb() loop
  ublk: get ubq from pdu in ublk_cmd_list_tw_cb()
  ublk: avoid redundant io->cmd in ublk_queue_cmd_list()
  ublk: store req in ublk_uring_cmd_pdu for ublk_cmd_tw_cb()

 drivers/block/ublk_drv.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

-- 
2.45.2

