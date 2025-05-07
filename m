Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABC28CF59
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654596; cv=none; b=IhTZ9zR/x1Me/DHJQWKSrefx0uecn1UC+/TqCuV3Q4RZnMkCwZRPpYEH57ts6wO35NItg9WvFJqE2mQ7HV0eqsRfQYeEymOYycydTamHzrSGgZ5ubLPsm+2SjkICA3QdhXgqXcmmvs4lR9e1JuwmTvVNdZGc28/a+d21a7YQQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654596; c=relaxed/simple;
	bh=0Qujy1kfDr+mlsoVpDUC2awsURSbNQWCx6o1f8NMNBE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V7FyubeE4+9aKKS+ZJSSG2grLzXFO7UAygHbg4HisIBW3/nKMCprHZRrauH715KmxdTO/4sfRmhmd5Rkg/7I+wku4dc9NJTz6qbN2xMjVR5MCSSZ3Lh5pNa5zJvUw4kElHmpQmwclUD6fo4hKAVAEH7O3Ap1MdJGMz4WgUQ1PQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WsCoRxt3; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WsCoRxt3"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-605fda00c30so185792eaf.1
        for <linux-block@vger.kernel.org>; Wed, 07 May 2025 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746654590; x=1747259390; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kylPn3myg7MB+8r/JO4iIhDul7z/UNT2E3/u40Zvh+k=;
        b=WsCoRxt3ZbMSEWnzld0+c/YVb0b8GrrJoPCBoUeJftMuOqiO/ZDqIHueIEOqUOtDnY
         bEalSsSgDLNpvgOFlA//aRD1PUDWNk4heUCA5yWqqe+SJ3CGheh2NEXCy4eaVYX6JFQI
         1AGwnrhlSA85V1wkXRP7RUP9KKwC4e7SP9eGu+IfdPJSqxVYUu/RCbsFS39VvdDHDtT8
         vOhoe23G8SmfThkVqwUQ1OhxLQVL3XSLAg9VmFdsuZr5cQhr8xAjkuB0q2FZezfxmiJ3
         haq2zkpkfQYYwth/L54JD9LaUGRNTsrpYyzltSba6dEdDlllrkmUkAxv7vs04CriHDdG
         iQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654590; x=1747259390;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kylPn3myg7MB+8r/JO4iIhDul7z/UNT2E3/u40Zvh+k=;
        b=HGcLvhpwzjjrjUkQtlCgdDXHaHAfWuuhfafSxrH7xznmTZx08BgDPJO0R5970J9vi3
         5r5ODZzEhoJgccVh6JLV1huUBYJ2/SgGYW2VsjRe/ehktPyzWLcKpB7lMcZ8lUclX/x+
         0En2LCSZw6AjRXsemYHP0AuOHblXiRe7J/WcbEZjtnjE0abZgDw9AXfNygO4E8Fj+ymt
         ASTbvDxbCYDv6aQXm9BKqJ0EsEgxq8YexK42DC5OAdDVHfNlFcIF1ZHniFYiRIFudnyv
         DLqQhQ6bTybAQBBAAgSyL8p4GAnWX6Ksgo1UGHqbuzhP53e34NnLmpBScH0E3GD+JBGM
         UEqQ==
X-Gm-Message-State: AOJu0YyMMUK9R8ySYKnaMgxOsjGf4OOgtUfgePUDh+HV6IhSrToesYjq
	gXlR+X3xeZF4jeECOYfvDyzSVFuqJiP7nu8uNsZgb8bkQZe3ItZzTFjCUn34XLmZ4hfmZ0T/toQ
	7zcY20sMhu5Pp7NrUrkjQ2gB+6jlM9E2v
X-Gm-Gg: ASbGnct9Yfl7G+4MvV6XIp9Q5dhT6ERBPv/bQpOcIfTiiHoDbuBR6ptxjnSj6t5HK+0
	Gzjg0GMpeLWo9IRpUaannA0TQPjvvswlQMO+hIT1bcCc/V5CFz3PCTa+x0IE1RR8gMYwgs/6gyA
	QFLHRQ+vmUSzKqG2POQOkfCoVAUboFV0BvydrJY7xL/55T8RWVqq+pispIMYNkfYqhjrOcouxCV
	XY41ZC21b0WLZLI7iDihWJNZTwyFOLdcjM1rkRpCEwkZdwSlr5En+fR/gpNQipNiqSmfwJTpF4V
	ZrLDIw6wYniG9iqL5qVBlcElmD4P8d669SA0Cq53/J5o6w==
X-Google-Smtp-Source: AGHT+IGxTYRVROqSw+PntwcI7A2UP2deuVBjAqN9iwSYzRPtmrwG5naeGJsRSqj12cTFivMgnoYO9o1xdqU9
X-Received: by 2002:a05:6870:47aa:b0:2cc:4516:afc6 with SMTP id 586e51a60fabf-2db5c13303bmr3217990fac.36.1746654590485;
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2db5cbf0be0sm139573fac.13.2025.05.07.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:49:50 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3CFAC3402AB;
	Wed,  7 May 2025 15:49:49 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2EF1CE40A46; Wed,  7 May 2025 15:49:49 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v6 0/8] ublk: decouple server threads from hctxs
Date: Wed, 07 May 2025 15:49:34 -0600
Message-Id: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/VG2gC/3XPTWrDMBAF4KsEraswo3911XuUYmRbSoTb2Eixa
 Qm+e6VAwQt1+QbeNzMPkn2KPpPX04Mkv8Uc51sJ6uVEhqu7XTyNY8mEAZMgwNC1/5y6u8tTt/j
 UxZkOyvIhKDCjdqTUluRD/H6S7x8lX2O+z+nnuWHDOq2YQADGmBBcnzkYYw1SpGsuOyeX3pY1+
 VpzF38e5i9SoY39lf+5ZGMUaG+10dqrMEpoM/zAIDQYXhmD6E0QUgrXZsSRkQ1GFEYKhtBbdEK
 FNiOPjGowsjCWKXSj7kNgjaf2ff8FgBpccsgBAAA=
X-Change-ID: 20250408-ublk_task_per_io-c693cf608d7a
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch set aims to allow ublk server threads to better balance load
amongst themselves by decoupling server threads from ublk queues/hctxs,
so that multiple threads can service I/Os from a single hctx.

The first patch is the functional change in the driver which switches
from per-queue daemons to per-io daemons and allows for ublk servers to
balance load that is imbalanced among queues. The second patch fixes a
bug in tag allocation (in the sbitmap layer) that was observed while
developing a test for this feature. The next five patches add support in
the selftests ublk server (kublk) for this feature, and add a test which
shows the new feature working as intended. The last patch documents the
new feature.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v6:
- Add a feature flag for this feature, called UBLK_F_RR_TAGS (Ming Lei)
- Add test for this feature (Ming Lei)
- Add documentation for this feature (Ming Lei)
- Link to v5: https://lore.kernel.org/r/20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com

Changes in v5:
- Set io->task before ublk_mark_io_ready (Caleb Sander Mateos)
- Set io->task atomically, read it atomically when needed
- Return 0 on success from command-specific helpers in
  __ublk_ch_uring_cmd (Caleb Sander Mateos)
- Rename ublk_handle_need_get_data to ublk_get_data (Caleb Sander
  Mateos)
- Link to v4: https://lore.kernel.org/r/20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com

Changes in v4:
- Drop "ublk: properly serialize all FETCH_REQs" since Ming is taking it
  in another set
- Prevent data races by marking data structures which should be
  read-only in the I/O path as const (Ming Lei)
- Link to v3: https://lore.kernel.org/r/20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com

Changes in v3:
- Check for UBLK_IO_FLAG_ACTIVE on I/O again after taking lock to ensure
  that two concurrent FETCH_REQs on the same I/O can't succeed (Caleb
  Sander Mateos)
- Link to v2: https://lore.kernel.org/r/20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com

Changes in v2:
- Remove changes split into other patches
- To ease error handling/synchronization, associate each I/O (instead of
  each queue) to the last task that issues a FETCH_REQ against it. Only
  that task is allowed to operate on the I/O.
- Link to v1: https://lore.kernel.org/r/20241002224437.3088981-1-ushankar@purestorage.com

---
Uday Shankar (8):
      ublk: have a per-io daemon instead of a per-queue daemon
      sbitmap: fix off-by-one when wrapping hint
      selftests: ublk: kublk: plumb q_id in io_uring user_data
      selftests: ublk: kublk: tie sqe allocation to io instead of queue
      selftests: ublk: kublk: lift queue initialization out of thread
      selftests: ublk: kublk: move per-thread data out of ublk_queue
      selftests: ublk: kublk: decouple ublk_queues from ublk server threads
      Documentation: ublk: document UBLK_F_RR_TAGS

 Documentation/block/ublk.rst                       |  83 +++++-
 drivers/block/ublk_drv.c                           |  82 ++---
 include/uapi/linux/ublk_cmd.h                      |   8 +
 lib/sbitmap.c                                      |   4 +-
 tools/testing/selftests/ublk/Makefile              |   1 +
 tools/testing/selftests/ublk/fault_inject.c        |   4 +-
 tools/testing/selftests/ublk/file_backed.c         |  20 +-
 tools/testing/selftests/ublk/kublk.c               | 329 ++++++++++++++-------
 tools/testing/selftests/ublk/kublk.h               |  73 +++--
 tools/testing/selftests/ublk/null.c                |  12 +-
 tools/testing/selftests/ublk/stripe.c              |  17 +-
 tools/testing/selftests/ublk/test_generic_08.sh    |  61 ++++
 .../selftests/ublk/trace/count_ios_per_tid.bt      |   9 +
 13 files changed, 488 insertions(+), 215 deletions(-)
---
base-commit: 037af793557ed192b2c10cf2379ac97abacedf55
change-id: 20250408-ublk_task_per_io-c693cf608d7a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

