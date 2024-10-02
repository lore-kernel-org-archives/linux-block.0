Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F68B1991BB
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906996; cv=none; b=cGzaW+j96wPYKMJA+zjEejCQ+4bOmolbzbVw066wv+bm8obd33uBgTE1NhtkZPBzxG/GCEKTdgyOr0WjHuezw/Hm6f29bQ8mlgvzUVaDV3573mnQ7aQdgkEF1bYs9fsC4u7/mEgwj09qpzjb/QpHVMjpmbHRjR+BRNW3S8wuSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906996; c=relaxed/simple;
	bh=TJenoRWV5iiSMiVOxQG4wyi5AwZ8LKNj3o2D831+6/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oM8GenOB3fy5JCIUAMkanOVCcPsEbIrTmJ3dlUulunPBOXd0LxVHA50L7l9FZEiASXamP8k/y3B9FD2CjuJbkNZlPBIAB2flQWReCRakOKZ+QBQIYaFnxNr2bW4bsAQ/LlUUkJKPnOzTceNrep3d2nttxUX15IGty1Cr59Q7Z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KE1N9Hho; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KE1N9Hho"
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-831e62bfa98so13303039f.1
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727906993; x=1728511793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvBX01KOMTIf/+HpfXBZ3dslZpJTYSb0gO68n0vITBY=;
        b=KE1N9Hhofadaf+dhb9BjtLDtFM8vigCalvipXAfkKM6GJ8i+0PImvCitLy1kDg3uD5
         hUt+0Lp0r3Y6sVLoET0H98qydWUruoqSOY4CNBkbCN/AjL0/bljuvsFWvRCgRRbBHjPc
         3joqz73YZhxNxMkIDB6rJo+bjLhq2hbs3SiiLi3uYDrrDCCK8CaaH1DIx5qV9BDMkwIp
         CmZmlXyWxZ3dcIclJ2bTNJ7DKuaIqcj+TqMJQ6w6YPSiQyFTIkLDSaPBQ/DNzIvVdf/7
         wO1QhW0iYvcdxSGTV6sQSLhP9Q642hg/5s0ktPXqITHs6OTMOpUPP4K98OrsUtj0aaLN
         gXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727906993; x=1728511793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvBX01KOMTIf/+HpfXBZ3dslZpJTYSb0gO68n0vITBY=;
        b=Lcg3Y1FguDeBxVk/qKgfm7+HJa70OBMOwCcG6esCO/PmfeTwPWiDZ6nchzRfWlkNyF
         yNVxYScdpN+ahQKwx6W8DZP8cV6iQjTsV8qrom/im+IUzjlXUYYkP9sFq3Qxdds9r99M
         IMRzw1LMQL9c8imiE1EX2r0D6moGhakQjfcRDbCzBK8syf3kIxdIEAONDi6x7ser5hKg
         OPEtKnFXaz7iYleU/0QK9+QUWqYV83+5P7eSbrXLHmBdyumQOfCiyv4xsVGxn0Llf1le
         9EOPSckl3ihW2U7rWu9CagUEdT67LjKEvphoJQGvXObtunyomI+2ANHey9CYsI72OdBA
         kC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCQRCVnv/Cf9fqtbWrR347ncT7PQ6d9y7OCixArZPf4LY3/qxvdDbMZOPZs0dBhW64DJfH5JAt7fFHZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEFZCG4tI0cWJgcfJVUPBWsBNgZHTgSqmLNk+fWYRDOHJkfuS
	e67Zaie+ltp+o6orbJdXo+h98zzQIHtjr18zSi/KhRSATv0DOPvCJLgyaZR4Ulm0FgvfGJzKjkZ
	PX6K4kFvPU9mJDwpzgUA3K6uzPrzwQdnAW5DfD9tOIA4AOKd7
X-Google-Smtp-Source: AGHT+IEUQBqUN2Ik5UhWSJCVcsujMau92n2zjWjJUTlnRvpP4TrCkzP0tz2V0cVswP1sKaFckGF+qIIs2i84
X-Received: by 2002:a05:6602:2dc2:b0:81f:8f5d:6e19 with SMTP id ca18e2360f4ac-834d83de15cmr426823139f.2.1727906993308;
        Wed, 02 Oct 2024 15:09:53 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-834936b0e27sm18711439f.6.2024.10.02.15.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:09:53 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7BD5B3407CE;
	Wed,  2 Oct 2024 16:09:51 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 78E4EE51EFD; Wed,  2 Oct 2024 16:09:51 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 5/5] Documentation: ublk: document UBLK_F_USER_RECOVERY_FAIL_IO
Date: Wed,  2 Oct 2024 16:09:49 -0600
Message-Id: <20241002220949.3087902-6-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002220949.3087902-1-ushankar@purestorage.com>
References: <20241002220949.3087902-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
New in v3

 Documentation/block/ublk.rst | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index ff74b3ec4a98..51665a3e6a50 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -199,24 +199,36 @@ managing and controlling ublk devices with help of several control commands:
 
 - user recovery feature description
 
-  Two new features are added for user recovery: ``UBLK_F_USER_RECOVERY`` and
-  ``UBLK_F_USER_RECOVERY_REISSUE``.
-
-  With ``UBLK_F_USER_RECOVERY`` set, after one ubq_daemon(ublk server's io
+  Three new features are added for user recovery: ``UBLK_F_USER_RECOVERY``,
+  ``UBLK_F_USER_RECOVERY_REISSUE``, and ``UBLK_F_USER_RECOVERY_FAIL_IO``. To
+  enable recovery of ublk devices after the ublk server exits, the ublk server
+  should specify the ``UBLK_F_USER_RECOVERY`` flag when creating the device. The
+  ublk server may additionally specify at most one of
+  ``UBLK_F_USER_RECOVERY_REISSUE`` and ``UBLK_F_USER_RECOVERY_FAIL_IO`` to
+  modify how I/O is handled while the ublk server is dying/dead (this is called
+  the ``nosrv`` case in the driver code).
+
+  With just ``UBLK_F_USER_RECOVERY`` set, after one ubq_daemon(ublk server's io
   handler) is dying, ublk does not delete ``/dev/ublkb*`` during the whole
   recovery stage and ublk device ID is kept. It is ublk server's
   responsibility to recover the device context by its own knowledge.
   Requests which have not been issued to userspace are requeued. Requests
   which have been issued to userspace are aborted.
 
-  With ``UBLK_F_USER_RECOVERY_REISSUE`` set, after one ubq_daemon(ublk
-  server's io handler) is dying, contrary to ``UBLK_F_USER_RECOVERY``,
+  With ``UBLK_F_USER_RECOVERY_REISSUE`` additionally set, after one ubq_daemon
+  (ublk server's io handler) is dying, contrary to ``UBLK_F_USER_RECOVERY``,
   requests which have been issued to userspace are requeued and will be
   re-issued to the new process after handling ``UBLK_CMD_END_USER_RECOVERY``.
   ``UBLK_F_USER_RECOVERY_REISSUE`` is designed for backends who tolerate
   double-write since the driver may issue the same I/O request twice. It
   might be useful to a read-only FS or a VM backend.
 
+  With ``UBLK_F_USER_RECOVERY_FAIL_IO`` additionally set, after the ublk server
+  exits, requests which have issued to userspace are failed, as are any
+  subsequently issued requests. Applications continuously issuing I/O against
+  devices with this flag set will see a stream of I/O errors until a new ublk
+  server recovers the device.
+
 Unprivileged ublk device is supported by passing ``UBLK_F_UNPRIVILEGED_DEV``.
 Once the flag is set, all control commands can be sent by unprivileged
 user. Except for command of ``UBLK_CMD_ADD_DEV``, permission check on
-- 
2.34.1

