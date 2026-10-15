Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88E342509
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029142; cv=none; b=Rcf2HJWoU9xqcCMx2Ig3vHdfu32HQvHSbJaWz0ZhZ2304gMKNHyT86xvfuaI3pBbbp9hDIkq4N1nOuzhdpoJT5Zj2QjHsymhUKS/qHzZCs1NkboE+SwuYWSW12+7A7JscQoy+pr6GE5io4nTskUah0cEfNBe7chgasqR8pYmjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029142; c=relaxed/simple;
	bh=KP2iHaL/44s57MvPvmwfua7vwBb/vSPDJ59vz0bCga0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hlhfpgJ0J5GSXM+4DY62c3m52kVBHyYXPPtqUgvHxx4aXaIN/vGbaqM2Yij/mlRm3KLunBnDZeXChcaZ7n13gHwDWVg1etOMHlobcp1Xw9J4kgDpxgCQdqC+gtOTtLrVPXVVV0Y9SI/0QIwO1SWM/+CBJPHVIiRFq1JDKqbq9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qm934V+C; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm934V+C"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so4553069eec.0
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 18:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792029139; x=1792633939; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=glf3wPsStHsKi3TlEqw1dZgM8u514rgSxUDeGdh5Ugc=;
        b=qm934V+CtW9rd/Y9vMifc/pQ2hKkxJeV9wtiqMHuf+loPeUvpwTemCYSeSZbZaUz6t
         ml6le4ZR/CW+uX2hFPxPFHzYJKPA6dtKb7vhgxT68b9fe8Osnkrf1Hrpo2ial8UlHoX7
         Qd7p3JFSCzy7RCacnjBLscaZd30f0+exR5rL+srhw45X6Q3HyOiF0GCwtZFhr/YFtRnu
         2kEEhpQVpgHorAbW6jA4BAYG6rHjz3R/4iIa4xyGSIrubfVFjE3sXUbfL8KXICuX0g+w
         Mn2Air1qC6BNOON7XvOpbrwJ07k8BlCEDNUYFtcL/PvIkKpXB3Rf22/VMZpDcKwiduI8
         Rbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029139; x=1792633939;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=glf3wPsStHsKi3TlEqw1dZgM8u514rgSxUDeGdh5Ugc=;
        b=MohD+Wnqb/4DfXbiAsvfNalwmFzF7ikFbcRvi7RRqD2jOlPf2QrwwpR0tFrC/Rm1A5
         qrcwSpGv/qST4FH9Kp6VC4uyUzqdHFLS98W/+iVC+IRJ8338pb5HUEAo3BPtVekz9ve9
         i4K7mLREgZ1hvG49zzWlmNh55iWAxoCsf4aJeQsx3G9dcg/MlY4vyftzlpQzNNrRvitS
         9XRPB7Zld5rvWaEFmYXkfe5JomdFCHZUiH8A15uvXWQEdnOfPO9D9/pu25fJu4Hqrxks
         LHfTLWKpvFiIFEgHe0CSpxqcPixSAeIabU9Sf28u3RLMclJ0CdMblymyPLmhnEDjsctS
         426w==
X-Gm-Message-State: AFq9FYJ/Cd/xxLMQ4O6ed7Ls6tDjuIf1BLY43VlKtl/cyAinT6V/1iNB
	Gj8fnScuVgKod+R8MWUCPVafAbuJ+rJK3JfILg9fntONMMr7lU+Z1ueaTyu/bVoozvk=
X-Gm-Gg: AYBFou1wIk67pwaUa+3sMlUWlxhWbBCTIH7Ax4R1naSas604qldrBXU9bPWVe7Fr369
	AlYjTJYIZ0jyaXdbTpxzoDEKJ7FOW+QcFhApwLBa3q5zB8dffWiEWk6N3FKs4Qf+a386/7jCXI1
	mLP6VlY0kwB5D/JgAbXpFF+M9wiLX/U0WLW6KHBE1JMnFZIFAstlqx7uG93F4iheAXaUmVGvP6B
	Vq33aVtzSWK1I0Pd6SJvu8TnFQAbEHGYIHB7COlsOkYxfOsyk70zVExTL8N26rsGOkTTcf+27/l
	QEPWpXG3Tl4GQy92UaJgYHt84Q+F7A7WRwgXqgahjZ2IlKf5IpqEVMiZt6Mif9XzfBFYwAdAiqF
	pPXwUaO3/P8Nu8gqmguiAdgEtAzJzma7UToRyWTVp3GBqn/Wd2vSPwKyzTcShGdJogjudL+uj5B
	cVul37LQz8ry0fLQOQnbJRnE0QrfmGSYPNAZ4301LNrpXPrGUxomL+Fy23J6XUU7i1y9CL7lyIf
	3q8
X-Received: by 2002:a05:7022:150e:b0:163:bee9:b250 with SMTP id a92af1059eb24-16a5ef287c9mr26663841c88.22.1792029138518;
        Wed, 14 Oct 2026 18:52:18 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16997c21ff3sm50647870c88.2.2026.10.14.18.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:52:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v2 0/2] block: skip quiescing the queue for the default
 elevator
Date: Thu, 15 Oct 2026 09:52:14 +0800
Message-Id: <20261015-bug-block-elevator-init-quiesce-v2-0-505a2b0b1c07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4x0GoC/4WNQQ6CMBBFr0K6dkxbLIor72FYtGWAidBqC42Gc
 HcrF3D5fvLfW1nEQBjZtVhZwESRvMsgDwWzg3Y9ArWZmeSy4nXJwSw9mNHbB+CISc8+ADma4bV
 kjUUoVXsuu9qcKtmybHkG7Oi9F+5N5oFi/nz2YBK/dXcLzsVfdxIgQNmL6jRHq2pz6ydN49H6i
 TXbtn0BVfHvPc4AAAA=
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Setting the default elevator of a new disk quiesces the queue, so every
disk added with a default elevator waits for an RCU grace period. Patch
1 skips the quiesce there, which brings START_DEV of a single-queue ublk
device from 7.74ms to 0.68ms at p50. Patch 2 renames a misleading label
in elevator_switch().

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Add Reviewed-by from Ming Lei and Nilay Shroff to patch 1.
- Rename out_unfreeze to out_unquiesce in a separate patch 2 (Nilay).
- Rebase onto for-7.4/block.

v1: https://lore.kernel.org/r/20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com

---
Qiliang Yuan (2):
      block: don't quiesce the queue when setting the default elevator
      block: rename the out_unfreeze label in elevator_switch()

 block/elevator.c | 11 +++++++----
 block/elevator.h |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: 0f6b042f9a13968c4cd6cde1a70a7b242009ef46
change-id: 20260930-bug-block-elevator-init-quiesce-35d73f9b462d

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

