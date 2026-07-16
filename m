Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797A313283
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196523; cv=none; b=OSf7Q+UY5uLJ/vOSyTEW1evbKaqX67KxI8baGIbvlXulrTqDQqvS+z2OKBOPbmGyofNhbiwm1OJED2n5kqXjhVkZ3nhsWxCllnRy+wy+yxXmD0XRA+ASX4oRobaq0nm7SROHybIbR3aRhAkoYTGDpgLVX8CFm1TJXoMgdBbibgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196523; c=relaxed/simple;
	bh=YKRWY8dBMoi/vutG1zMabVtX8x9LL5msEM4WjjDlyiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4gNat+0MApCmsgkGuli+robhMyRJYOAv36obE9kAvXFn/oN7UuMyLzWweINAPYhXXl86P/om/VQvx425avm6fkEVzkG0BDWA5ngCwzeiIOxKTbPB57RwBo/8HMB8RbcSZmeNo4UNwoQteWdKKZzzD/ZZv5Ql5TNYAVsI42Fn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKMWnZon; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKMWnZon"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47d6c634f45so3651237f8f.3
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784196520; x=1784801320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Vsh+W60OzNJvIpPirNiAnTL2qQVKKNCFSNaXDZ5eyM=;
        b=dKMWnZonG5LXycSRig1f0wZzD75XCZVovDrC/yQh19UOkSEWAhjHU3H2Ugfqy/RaSg
         w/uY/MrFNLtV6CFvisa/IUeD6GRYVXQumqu5x9LgiOo+RB5N8tmazz3QVB04b+Qw7cY1
         ZLo/5eAaut+APy19klAGTi4G0fbXq0Tx6PJBzQ8gCNSXNBs0U82Oyo/ronVvt6ahZEy9
         1KFpgG1B8DMwlpETSApxmgxEjc8UB6QrQcGc1z8PVIZXpUfYoQYkOZPKsdOjOOw8R0TB
         2xY8HNYQnwk1JV2/gUvn+Jcv6LgUTwf4dmqhGAvq1/HK13EqVPVjxzicxSmRkBtYUdm2
         4JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196520; x=1784801320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Vsh+W60OzNJvIpPirNiAnTL2qQVKKNCFSNaXDZ5eyM=;
        b=Yt9B8iBHtkPXRTUG4XRHT2xYHvvsMlPbdTVzgBkKdc0Pr6FpnblXUwOKEZ2Q6kBCUI
         oxTdHfIjqC/iRfXKyKh4kov9nz0f8gIfgV5ccTF4cvGQRU1MYJOgpcEMJLDThYdDQPe8
         QP8vO1eYXzNwmrZZ798SCAE83BSqSG0vMdbNr6H2QQnAVdSifNmyEdQx37IBhvdQB4W9
         CoM0q6LVlRJbZcdKVpjy+kjW/McByXWEAgvLAbx6FUCxyqMdyr/gypwxE/+WkXiddrl+
         8e2F5bg4czHpvmaQX/GgzDr2PSkX6oPVXK2mf8a+n5opxypb9pI/BfdXPs7HAnMErxx8
         H3AQ==
X-Gm-Message-State: AOJu0YzLi9lwnbQ8Nvjmbm7QBYFRaZh76xrdPJYUkp4rqQAPLGMPSYWU
	CMCSU3RfVgwKpI3DZVocEpaCnojJ+JMgjrhLsXA8USaDL2yDB9rrGKAymWuigg==
X-Gm-Gg: AfdE7cksa2SXtrCyO85wWGqxGzH2/6mNWOb4WyOtvPw2o5QW4lwzerG7wnT+br67qz6
	L97yd16ZIgIync+Kzi0531vZmgt7aysXYuNdxko6Pg1Fr/0WxyFLuN6V+8I7O4/RFvxPpEp5WEr
	Q2m3/hu0ltacPld/ssQheRdgbfCzpxj0qPE5u0FF8Dz1xinSCybWl1vtxVQ/kxNb11pwQH2SkV2
	lhU+ey/ti7FSmL5/Wc5IjDEusTvF9pj1lC9MS0A7EpwRAs/xa4CJ/3mLybb+qMIAhzkr06PkNj0
	jlF67bPK/xsyZTWV5S+w07O0biUKPoI2HmUStUQpKgEBCyANyiE+uN6/Rax3K5DS8z2yL7rwcpz
	iz3XflfFb0BjSeUsbUIIBnyBTklwTQsI3PGf4KtnAnlxPmol9HkfkzMloAh9FQau/AtOc2UYpy7
	MVzm45cPhBB5KgU0Ox4876o45kNbIp10ZO8L8gMlFBOg3hToM=
X-Received: by 2002:a05:6000:4a1d:b0:475:f0c2:5afa with SMTP id ffacd0b85a97d-47f488bfd4dmr12431553f8f.48.1784196520381;
        Thu, 16 Jul 2026 03:08:40 -0700 (PDT)
Received: from localhost.suse.org ([37.109.161.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e5c3sm22743613f8f.1.2026.07.16.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:08:40 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH blktests v2 2/2] nvme/039: skip cleanly when debugfs is not mounted
Date: Thu, 16 Jul 2026 12:08:31 +0200
Message-ID: <20260716100832.30570-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260716100832.30570-1-sebastian.chlad@suse.com>
References: <20260716100832.30570-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_nvme_err_inject_setup() reads/writes files under
/sys/kernel/debug/<dev>/fault_inject/, which don't exist if debugfs
isn't mounted even though FAULT_INJECTION_DEBUG_FS is enabled in the
kernel config (e.g. SLE, where sys-kernel-debug.mount isn't started
by default).

Call _have_debugfs() from requires() to skip cleanly instead.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tests/nvme/039 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/039 b/tests/nvme/039
index 8c70c5c..b634008 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -15,6 +15,7 @@ QUICK=1
 requires() {
 	_have_program nvme
 	_have_kernel_options FAULT_INJECTION FAULT_INJECTION_DEBUG_FS
+	_have_debugfs
 }
 
 device_requires() {
-- 
2.51.0

