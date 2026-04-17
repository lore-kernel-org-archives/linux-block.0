Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752297261A
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776386907; cv=none; b=HdAnaXLwej7/twWxJlcWKLf7W+QcjLE0kKcrlxgG632Q+p80QBOcTYXtGgcHo1Ewa3tvFkVB092RSRq8T2obK+76ajPB2eDEh+bqcSfMK1RbW8tgZyTOeZtDrWNaAyS4+HX7FO2DKUAsi4RpjgyG27A5zbSoSBqMmjA23P2sE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776386907; c=relaxed/simple;
	bh=W3b1woshkK4hegJhTYcV/9MQngeYZldCVzyFYxnvnI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5KzDPE6vn92YxtK+XYzNpA/A+wgatn4rMzm84gdLPaqKg4kV+ApwtOW6VHCATDujvVUyfW9gP67KVGAIBQIdrFMqRg8l97oyRx5E5cynPDJ3FB/QLU70w3AiMeBoo/Ob8FQ/9jQwWDlTGKnFzJjJAZnOmcjGxPlvzydeDtCgPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDv1JCNk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDv1JCNk"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d90833cacso96918a91.2
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386906; x=1776991706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUBcOJvdzrg04mlLi/Lj3lm62FWLU6fMfvXH1a9ncMU=;
        b=dDv1JCNkkESVGbtyg72ZLyYf9zREBXQeCFTZKXHOobhAXYwvRUatcXNwQeD4BBH+WF
         hYMWK8ynmPZDP4J2dXcARstdj4IphtANG96y+Y/sC8ytVeuGd49s2+cpQPy8RaArYFJ3
         v/v4dFCPDww+fPkP2p+N94n3MVuUDQRXL8pXsu4lwIzhJtkAz0mrbvZzRq2k9kP/oqgD
         9cwiM7vkpPL0mpMXbaqpZ4YYaIFU1Z7tvLtSxG+yaEsVoz4LSeynlwbvPOLGLE3bgkxq
         aBFAwaNytpe1dlSRYuSrtcQ1cCbOo62U5beYM17rkJPvzvqJD0QeS5xxUCn6F3JywAoB
         WxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386906; x=1776991706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUBcOJvdzrg04mlLi/Lj3lm62FWLU6fMfvXH1a9ncMU=;
        b=K9ozxgJ2NtGP5iFN/mgJayFTZDWzxr3g/HjL7Md/x+Qbh+lxNSZf7U2ZbMlVAB33/6
         4R9TsmVOSpjfp4gpkTypYOQNU5anw2GL7YRHdHXEZV46v5/rKLHp43lCoOjpJW2z5ENm
         gsPvmMet+L/ToUQQ5I72FiixFkLCr9SNed9/LYcbuI0inM8Vff+JZbJ1Fw226iZ4Dyzc
         HGL2proOM0l27AxwMZy1Dg+LLIyUW4kgSvnTplqHcP9/RNKm2eCpY8+NPxC0SaFQSY6s
         orQiFvVVXy/8RJnb3yY24AfDgBODl0TQIcmUsgPHaT4VZj1yEJCJcvxMHqNjTuQ7EuFP
         t9tw==
X-Forwarded-Encrypted: i=1; AFNElJ8XlcIBGu429ufmMuZfuRyjGrliwvCgcOvui2EZXioALgv3hFM6AD5QtDW7KVDzlWolkcO/KIX+DGZTFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxswQ97US2zpnKA7rq6w7ZcuT/jRR6mwwXQGwZvyVLo1XmOjs2
	eqAFgPRBDE0hPknUQjmChpEhyEzL63vY8OaSdZAz+gESHgDJ8G2C0f5J
X-Gm-Gg: AeBDietIQc0B9YNHXR81xzw55F+6jrn6gKj8Nbl1P9QMuObUnl/ZmvqLUyHp53vWMXK
	j9yyBQiouUx2fAH6bwk3f3SXAMqmnqfXx82atOv+MXyUBGOQMADnbFZFj7lg5PA8PFMS4coxoZH
	eiUbFKkUjgR+2wQCe75JnZb5ghJ4VLBssKGK1A0qCBRK8daYbd3G+47TGWdCTmI3MngJeC6YFmr
	vgw1Xt8D6ghY/D85fvdmDcC3i63vWEHw2i80MnoIKq1XNyLA6ZnqFOm8BefcYsvHxjOzwwv5h0D
	yeL1gBKCQgiEXAf/RoUBBacxVnzoGFWJlEPez6fEHo3g8bsQxGq7eU5o8FvfUEfUdhA6Z+H1+to
	5WNznxSEuAoFJHftu4tEgf9YlsU8fxSdWZFc4WE9vEfZQpn2jEqOjkVYJVC/Z71BDHAx9AnPhXm
	UDJYC+gwue4ie7zC9pz6OG16lCUBqPjYupqXiM+EIQlSawtaR9mVLO
X-Received: by 2002:a17:90b:3e88:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-3614048e396mr568374a91.19.1776386905830;
        Thu, 16 Apr 2026 17:48:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3c067sm1057345ad.76.2026.04.16.17.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:48:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com,
	mlombard@arkamax.eu,
	linux-block@vger.kernel.org
Cc: alistair23@gmail.com,
	shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] Revert "nvmet-tcp: Don't free SQ on authentication success"
Date: Fri, 17 Apr 2026 10:48:08 +1000
Message-ID: <20260417004809.2894745-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

In an attempt to fix REPLACETLSPSK we stopped freeing the secrets on
successful connections. This resulted in memory leaks in the kernel, so
let's revert the commit. A improved fix is being developed to just avoid
clearing the tls_key variable.

This reverts commit 2e6eb6b277f593b98f151ea8eff1beb558bbea3b.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index b9ab80c7a6941..f1e613e7c63e5 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -395,10 +395,9 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto complete;
 	}
 	/* Final states, clear up variables */
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
-		nvmet_auth_sq_free(req->sq);
+	nvmet_auth_sq_free(req->sq);
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
 		nvmet_ctrl_fatal_error(ctrl);
-	}
 
 complete:
 	nvmet_req_complete(req, status);
@@ -574,7 +573,9 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
+		nvmet_auth_sq_free(req->sq);
+	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
-- 
2.53.0

