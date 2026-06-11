Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70A13635E
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137966; cv=none; b=sriJJsuSabVl/UkT5DtVmA3hnUJoO5MZtuFL7giRIsh/Ssrx7poA/IuNB602iI8WdwTi0wy6IDJL1S3aOQx3JYY+abx8RVcajv6UmlMoqHPY/2I/cA0Lj3+Hd7aVvHlSTHYkf44sZloSPcoIa0bb/JNcL9Q5xu/NvNjSam+24is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137966; c=relaxed/simple;
	bh=S1tHIvOieTU4j9LzjzSL3pWXo6mgEStorgewiv2OtHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYonC43aehphEl+jocbzMDLneCSNY0Mq12C1hpp+k3pol5G1GmwQj8YcqvCX4HDOBIhRFZKbtCn2XtfPXh6c4wLz/WvV4CQKTYqk79HkEw+sdVTPTaO44f/OgmFcsG08E6D/BfFCuTKmsxY8x5SrWjsSzFmu7v11bTURAEnBqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf+JxGEF; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf+JxGEF"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13832028e9fso2701888c88.1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781137965; x=1781742765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToIQfCnhhxhc6DD1qH3fv/EmwmlVtSC2+ooZgMKNohQ=;
        b=Mf+JxGEFIKFNCjg6fNlaCBusZ3U+nCRIzmTR+Yoe+Oa860cIhjKz2cGgSIEXTrk4s0
         R78Sq3AKL0f9YAh2DiPUr4PhTLLwUM1MF5MI1qoMPHXS4yVFN6cw9Z/DgObqJ0QauMjc
         rDKzpRexKDpDhimf4WUDBQEl1Yd8thOHPyWo+wHbWJ1OXxr8PKlyL0ESMw7TOf6lh07n
         lGdrlUS2650MOmJLJMVBHSQnKeuzCIPFEyNwrnaX0OGpn0Tq/y/zY3pVIvwAk+jivrUw
         OAbtjVXoJSoaLXkFuNMrHs0rZVo/eBa2+Ti9TRVSisOP7PneuNmo6illE6IScc8gcQBw
         jAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781137965; x=1781742765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToIQfCnhhxhc6DD1qH3fv/EmwmlVtSC2+ooZgMKNohQ=;
        b=tZuGb2wOy9YTidUhQgstYMdxEsgdY2QhCGESbOQKIzDLwuJbGNdPsD2z1IhtiXBeOY
         ObGPcuW6zyBJqtF7fs6TzkXJK0CHFp0btGOVCh+mHf3LKAjob8y9HvGebXw4Wzn4VOhi
         2EijGaZO1vSfOpBZiPDvLxf49/09XNLRzsi9P13foPki+OSWmStn9TtFaWahFfuqtqx4
         eJShHMmbx9fecuJ+6rpQ7viFHhI/8BJIELHO8574OUpi4XtqhXgYxf/nYM9IBdfQVfYP
         prtQ8EYfMaAz1dPJdmOwnzeDbzoctw4I/dJAD1riNKjmOGs9ov+vu77xEYgH+nQGlo3u
         Di1w==
X-Forwarded-Encrypted: i=1; AFNElJ/gNv5cDCKsZgqIRZk6A0w+dPFuSgRoawTjmV1tnA6RTyHye4heqB4Bt2HCgOD8B6zEuXQiKKLFSWOVrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTAX7UFjY9IDkoGu+ovkFSF9DSo25plU98+/2PyexqsWpA8JA
	py5DTl/ORvPOpzoJV7LQdC+/Tc4qcq5LB/VTn9Cs+6UxG+jMbsVSaywj
X-Gm-Gg: Acq92OFdVGn+Fs/7ChrDbcpvvZf+Z3Kb7W10Lh6COcb8ynElVunJuDSuH+p0bypzVfE
	aThoi+rJf+0b3rha6em5uC2rCI8AJZM+ShVNuHnvhGeNB6oXtfZ/OnB4ZeI45PqcDtLXRxPX/1y
	rvvn69Sj/z1t+2u22PtaFumO8ub9lRlYjY6itigfI1bdM8X2lWUvQ4fgbZqNV2veaiQGyNoyHB/
	RToIzcHd3KktEqv9uOMgkrta6T3dmWx5eUzkXS6CRCNDVsiXqK32kfNp0ZfhzRrUEVcLs+Y6y8X
	ZDIrTy4L5RCCb+S8HmRDfI1WByWLGP+rCtK+OIkeWzpgPTMEJdKbnitehPhMd8BK+zLam9M5Smj
	vu1EprxYi/GCUCWX5tzyh7rhcWDUQ5oYh9a88IlmvW9b/fPgUYD++wzsEECHzKTqPiA8jUDO81I
	e2eP+DWQ8B41L1KX5V1LhTVkb1/A==
X-Received: by 2002:a05:7022:3d86:b0:138:62a:270e with SMTP id a92af1059eb24-138421396afmr356720c88.11.1781137964641;
        Wed, 10 Jun 2026 17:32:44 -0700 (PDT)
Received: from homebox ([66.75.253.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13842ed1ccdsm208047c88.0.2026.06.10.17.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 17:32:44 -0700 (PDT)
From: Yuan Tan <yuantan098@gmail.com>
To: a.hindborg@kernel.org
Cc: boqun@kernel.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	zhiyunq@cs.ucr.edu,
	ardalan@uci.edu,
	pgovind2@uci.edu,
	dzueck@uci.edu,
	yuantan098@gmail.com,
	Yuan Tan <ytan089@ucr.edu>
Subject: [PATCH v3] block: rust: fix `Send` bound for `GenDisk`
Date: Wed, 10 Jun 2026 17:32:20 -0700
Message-ID: <20260611003220.3512652-1-yuantan098@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuan Tan <ytan089@ucr.edu>

The `Send` implementation for `GenDisk<T>` was conditioned on `T: Send`.
This constrains the wrong type. `T` is the `Operations` implementation,
which is typically a zero-sized marker type that carries no data, so `T:
Send` says nothing about whether the data a `GenDisk` actually owns can be
moved to another thread.

A `GenDisk<T>` owns the queue data `T::QueueData` (stored as the
`gendisk`'s `queuedata` and dropped when the `GenDisk` is dropped) and an
`Arc<TagSet<T>>`. These are the values transferred when a `GenDisk` is sent
across a thread boundary, so the `Send` bound must constrain exactly them.
Bound `T::QueueData: Send` and `Arc<TagSet<T>>: Send` instead.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>
Reported-by: Dylan Zueck <dzueck@uci.edu>
Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Yuan Tan <ytan089@ucr.edu>
---

Changes in v3:
  - Add Priya and Dylan's names to the `Reported-by` tags
Link to v2:
  - https://lore.kernel.org/all/20260609-rnull-v6-19-rc5-send-v2-1-82c7404542e2@kernel.org/
Link to v1:
  - https://lore.kernel.org/all/cover.1780633578.git.ytan089@ucr.edu/

I am a bit unsure how to handle this v3.

The change in this v3 is adding the missing trailers.
Andreas' v2 already addresses the TagSet issue from my v1, and his commit
message is also more appropriate. Therefore this v3 has no changes other
than the trailers.

I am not sure whether it is appropriate for me to take Andreas' patch and
only adjust the trailers. Please correct me, and my apologies if this is
not the right way to handle it.

 rust/kernel/block/mq/gen_disk.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..b36d24382cc3 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -199,8 +199,14 @@ pub struct GenDisk<T: Operations> {
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
-// `TagSet` It is safe to send this to other threads as long as T is Send.
-unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
+// `TagSet`. It is safe to send this to other threads as long as these two are `Send`.
+unsafe impl<T> Send for GenDisk<T>
+where
+    T: Operations,
+    T::QueueData: Send,
+    Arc<TagSet<T>>: Send,
+{
+}
 
 impl<T: Operations> Drop for GenDisk<T> {
     fn drop(&mut self) {
-- 
2.43.2

