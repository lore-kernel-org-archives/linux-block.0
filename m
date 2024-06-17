Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C1187560
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653500; cv=none; b=Hb/C0ehn9TKjRhDTw4gRdJMv6yPdWlv4sjOStVn2rtVWmkkRLkr4sm7OBlgqnNzVLPHRocpr0p4qcwsihgPewRwI4UJKCVrMV01avGtSU53teZTScLjKMBGIgpiZyopQAU20GULbfsFCVgjKp/2H8FfyQhCX/MHg0YL/i0BLKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653500; c=relaxed/simple;
	bh=TB0b5He76oEYOi7HeGyMzfy4TPswiRE8aTo8WxeHx7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ccywNKWWx7Y/Exl2c3zyCTpk1KDXzww/nKr2nq9QbWM0f61fKFhC1nWALytC3SR6BvUYb3VfFkusUv4AHpd0MqQr0b/+S2C6GVpS1VvnmUKPCLiyc52m6UuINTMZlVL9Uvq4qcNzokut7njNWhhEOcufgOa5sCrFGuCYxEimZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fnLMY/Zj; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fnLMY/Zj"
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so39701265e9.0
        for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1718653497; x=1719258297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vSAld8ZEeEkQaH8FIgfp796W7fStvjD5kmzvDupsVc=;
        b=fnLMY/ZjDjlZp0N1t3qTMVpTbZMVw5sCNf2HFr4kZs3sEyz+Cob0kpO6A4x3inSfHm
         M3IEK+DZkgMPTAXAyboE/A43XnsoBYcDOX4MrJQOq5eU4zEEkPJXBIpMjXWBelrhnixF
         zaAh1zw0Bg0QqKvjemmGpLKFPc5XvUKC8u+RfqAzL5Qjfcdrtcu3njKXfCQj+ak4HkTV
         C0EWXPKqmMtW76yd6b/yTAZ6sQ0eVsirrpTLOXJ8Vi3U0bUPiFTSMjdgb6n+p6bmRRTY
         YQFyugOKAsvG7g8fDfTukL2RQBz1tuvyHdkBwjZTNrRj82FHBwZ0TRhoUXi9TdJwfJP0
         VC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653497; x=1719258297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vSAld8ZEeEkQaH8FIgfp796W7fStvjD5kmzvDupsVc=;
        b=qtQnbldHNbmfGvfw6RGJmZWbrjBhtMq9s6/aPdXMg8C8MVpTx7BMYQxBhoKIYhL5zi
         PKIk0zAoePNiBcL//1gHVzC0Thl12S5EAnSJieb/C4U/1/3ad/+JUyxm2KUEFsnE+HsQ
         svdyS5O+Tob99+ZUC2wvmOsvUS4hZgRc/+i2sd5yxDjNVX/gmYx9MPbKYIgEvUqWVjem
         +644clpe+P62K4+esxMTrN/FqVDawD2XpcvW69zPmcX+OgN2Sh1H049YDcKYr2RZ1O2v
         uAhg/E/SER+BOn6Qj+NSISKRpeaK8Te/df9KIK4ZZ2t6somAwachemvzwjjgfQ/+uRMI
         QKLw==
X-Forwarded-Encrypted: i=1; AJvYcCVHeXglfjDP8F/7+SNB4Lz7b/nSZ4WzH0VMPIlzgyk67jEvH/kFcfSQRWzdT4+i9j1BL1VZvnufQpbmszlp7jrpA3kDJn/ZzHZTJRU=
X-Gm-Message-State: AOJu0YzNCVoqjVtLHK9V8oAUxfiV5ezDM2VacmOkHUolbjpIrujxZW/x
	wjdFM4p8clY1PaNGb9O+M4HtooUwCRf4k1jyiXVdhrzmNIEkchApr/ifFQJAOhtDlf/K+Qpl0Nk
	p4JzcSC03oqLcJIbFs10a4O56lHEt3BBSAChTeifUjbbDmlY3
X-Google-Smtp-Source: AGHT+IEb5jxFrEJpLP1JZM/hGXj4pCnoANjCHqg5UmPkFxRJm7U0HxmQnZxFJa0DOM/vE1nZT0a0sJE6H4fw
X-Received: by 2002:a05:600c:1912:b0:423:499:a1e6 with SMTP id 5b1f17b1804b1-4230499a43cmr72330675e9.29.1718653497161;
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-422874e79ddsm5955205e9.43.2024.06.17.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DF6043400BE;
	Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D2642E41412; Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/4] ublk: support device recovery without I/O queueing
Date: Mon, 17 Jun 2024 13:44:47 -0600
Message-Id: <20240617194451.435445-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk currently supports the following behaviors on ublk server exit:

A: outstanding I/Os get errors, subsequently issued I/Os get errors
B: outstanding I/Os get errors, subsequently issued I/Os queue
C: outstanding I/Os get reissued, subsequently issued I/Os queue

and the following behaviors for recovery of preexisting block devices by
a future incarnation of the ublk server:

1: ublk devices stopped on ublk server exit (no recovery possible)
2: ublk devices are recoverable using start/end_recovery commands

The userspace interface allows selection of combinations of these
behaviors using flags specified at device creation time, namely:

default behavior: A + 1
UBLK_F_USER_RECOVERY: B + 2
UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2

A + 2 is a currently unsupported behavior. This patch series aims to add
support for it.

Uday Shankar (4):
  ublk: check recovery flags for validity
  ublk: refactor recovery configuration flag helpers
  ublk: merge stop_work and quiesce_work
  ublk: support device recovery without I/O queueing

 drivers/block/ublk_drv.c      | 169 +++++++++++++++++++++-------------
 include/uapi/linux/ublk_cmd.h |  18 ++++
 2 files changed, 125 insertions(+), 62 deletions(-)


base-commit: 7c7a0732285c9dbdc52c04241a518df0367fd116
-- 
2.34.1

