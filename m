Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CC526A86
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651604; cv=none; b=TkZ1TqaV8mUacWpbONfHJMm0+T+ZzvTkwKz5IFopC05aDN/abrgK+hImq8BfhjizlWxmUuMSGadmYkUVVx+jMkrT0I+SHdGiDHb3n/Ngm8DGiJ4Pze6IgN2AhblvwBnL3t715bmHrS9AFh7Mb1tRf/32iph6OWUCtmWZpojiqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651604; c=relaxed/simple;
	bh=m2UU0/l7oXH4nDDm4aNiVdsK/0ORRSvCe00W37MZM54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbgtEmuze5PndyqLuvxNSfs5li7nytMHMzsSIPsywv77PVM0MlthIqu3M5ANUfOUzW0eD+f2585J76sv1ush0G4ls8OKsx6eiBIPEVmwUqZ2roegWGYOPInjGgQCCavEPHqFidER4AKxFFzmgeQ2Ok0l1fD1M/3xyeozZZa2gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=QU/D8fjp; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="QU/D8fjp"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so561425f8f.3
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651600; x=1790256400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYqy4JvgQiRzCuvqvHp97HhL8V2ft2LLYeHwmXteui8=;
        b=QU/D8fjp3FdyDDs4Zw9GAUX6wERcZu4+cCkyTquYLgUKh2K4/e9Z3CsogrukcRlqPV
         vezxT1Ppfy/HTuw1YeP0wufv879MH8X7xJkJ1MdhLQH5ePyPCnknaSToD+H0i996QU2F
         ezfeJ+0PBOx4S8si0MtVHuAfvcykyJktxeeL7ziqs0eX4kuOegbziJVg+5HH+xjX3S6z
         pkIYymfTPOhXklw5VmQc54VDQOy1Vnfbw0l5jri+63+CNzStVTBydn46tUL6K8WPBUkO
         g5uLV7mA7yLzAMvEwt//2gUw1IC9ou5KNBZSIu0siJysW3Yy0Yv+s2D4rYPSWfC8r/9D
         w4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651600; x=1790256400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYqy4JvgQiRzCuvqvHp97HhL8V2ft2LLYeHwmXteui8=;
        b=wuwqe9veIcWtLAPhFakHaDlcyElr4nizd5fSgQDAuyv51l5S29OA5T5D140wepf209
         MBteLWITiRfmzyVhcGS4GM1McwkwYE0rN0qjIx+6/bkDhCDlTOwhGbhFn+jo2nCurhfE
         doVfUX4GlxgtUmGbdYMgmLhjmKqJnKMLuH75GxG09j9NTF2iSLdw2gkt1ec5VKkMOLss
         KfhySNO5q2mVtzkF2nylISenkPlcbIr++JeeKtTIwJzb3N9zap2+JSlHdOBqBcKEdEdd
         CAKgeVjTLeFwLgTr326oayBEJU+XDy5psZsdtrXn5eKM8UsP/vqFirNakb4DPtiOkDmb
         cUeA==
X-Forwarded-Encrypted: i=1; AKwUvBy1gCz5RQ59QuQq9IhJfxIAT4VfbfZBK1VH0Afd/h61zHgVq06mxm0DxQLEMv3xyjl6h1D6RAq/YXqoXA==@vger.kernel.org
X-Gm-Message-State: AFuF++lRdfG4CKCrVVLm+aji3nvpbcnsJ6dVPmZk1eKnzSf6enJddcHv
	mDut81fthqzEbZxqY0z2HhK8l7nTETHpDXqgP6hZHqpyxQFR84wUwmz1JDXyczX2OA==
X-Gm-Gg: AYBFou1VWEd7wWjmoxMOmw9Sp+WtNEs3KL1C7M8GtHpC3cJO0RRMUpdXi63HPJAxii6
	s4YCJi3Ixk+kJhml/kHPAVtfjryncocsl/PnE7kRXPn7hIM3sh74TvJu1ztDVafhWTdF49dipmL
	MNtXucaMyXNfWEg39vrrynQArD1gs/U8sIqSHB+joTxLn/MTCZxWY1UU8sAmi+CVeHg49Sc5249
	r8gEjVKsuLfukg0DG2eqjQFjBJmOzDfTpTTzdJyrNjMe6AR89V25J4aHOXOQJfHzK7z4pocHqv6
	lcT17BGO+NSmxYPTwbaUeqrAI9uY1/dpwMYfKj12voTp45nMrgBKJ7dc1ctn+BID/Dwrc7ViTdn
	jaryqZ3lJS8eO1ZWfAjbLtd3poTui6E3k/YWTR6KLTfFCvzxvcVWlIU1+QboCD1jaHqok7FPnHc
	Q95xNn2mUByEmH5u30A0h5O/dnQUlK2R1WWvWhhmxejI59sWLAiglqsinmCCqZg4196w1XXwF0w
	2AILYSBGGB++kwARYheUFOfmvGA
X-Received: by 2002:a05:6000:4209:b0:487:77c:f6c4 with SMTP id ffacd0b85a97d-4870d0667a0mr8425263f8f.35.1789651599627;
        Thu, 17 Sep 2026 06:26:39 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm15879947f8f.13.2026.09.17.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:26:39 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Subject: [PATCH v3 3/4] PM: hibernate: permit encrypted snapshot device under lockdown
Date: Thu, 17 Sep 2026 14:26:30 +0100
Message-ID: <f237b56e8444ea7b477dbcf4aa6dafd2ff0c1dc7.1789651581.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789651581.git.sean@starlabs.systems>
References: <cover.1789651581.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdown disables hibernation because restoring attacker-controlled image
data can modify kernel memory. Permit opening the userspace snapshot
device under lockdown when encrypted hibernation support is built, but
require encryption to be enabled before image data can be read or written
and before restore or power-off ioctls can proceed.

Tested on StarFighter MTL with lockdown enabled: encrypted uswsusp
hibernate and restore used the snapshot device path.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 kernel/power/hibernate.c | 8 ++++++++
 kernel/power/power.h     | 1 +
 kernel/power/user.c      | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a95cb447a13a..0b8626bdf81a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -114,6 +114,14 @@ bool hibernation_available(void)
 		!secretmem_active() && !cxl_mem_active();
 }
 
+bool hibernation_snapshot_dev_available(void)
+{
+	return nohibernate == 0 &&
+		(!security_locked_down(LOCKDOWN_HIBERNATION) ||
+		 IS_ENABLED(CONFIG_ENCRYPTED_HIBERNATION)) &&
+		!secretmem_active() && !cxl_mem_active();
+}
+
 /**
  * hibernation_set_ops - Set the global hibernate operations.
  * @ops: Hibernation operations to use in subsequent hibernation transitions.
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 815c84c1e0dd..351b5f68bde3 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -168,6 +168,7 @@ extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
 extern bool hibernate_acquire(void);
 extern void hibernate_release(void);
+bool hibernation_snapshot_dev_available(void);
 
 extern sector_t alloc_swapdev_block(int swap);
 bool swsusp_swap_range_allocated(int swap, loff_t pos, size_t count);
diff --git a/kernel/power/user.c b/kernel/power/user.c
index de41f590c98d..b8d3342f1548 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -184,7 +184,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	unsigned int sleep_flags;
 	int error;
 
-	if (!hibernation_available())
+	if (!hibernation_snapshot_dev_available())
 		return -EPERM;
 
 	sleep_flags = lock_system_sleep();
