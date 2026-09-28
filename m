Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C641E6B9
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576086; cv=none; b=rc6s+WCAYM/+yOfpiAXM9GTJojuB9YASxnxqMqdII19E5VnzvPGU2Q5YNsA9yBMfkD6c3yUmR3Age61MUoTQ91y0s6o7QFhJHL1MFb3xa4ymnyjfuMy4CV6+i8uT8wkfuf9L8FYDzSkLBD54IkX05fFLA+5rmWi/GIz2AQnrkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576086; c=relaxed/simple;
	bh=yGo84h1q5k7DqGwFtapqM3KeulWARXvoAl3BUIovgJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CP9U4tWCcXBEAH5inEe/tNTKlKEsjEPTbx/fmggj4i2FPYNIp7HtfKHKh0D7AdTwvLeeuRWXYhpp6HTo7pmWQgNCgRWUXY3Zgc4crlG5ZdWZhTR3HbbV9PY4RMWKraPLnFrfLsGSHenFRFhjRnmraGmh3CdZkEXujSIgiIpWwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCnhyY93; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCnhyY93"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc78d45f78fso1506975a12.3
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 23:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576065; x=1791180865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enVf1SyIQ9oZvAJl5nReVDRZKns+mfLkqH0FfDFTL44=;
        b=YCnhyY93JpbW0Ue1tSIvHG6EbBfLXvg9uXIIzPXq9H997b5HjM+b5XTDe8Y5EUxJ/9
         m8++dvn9QoQu1KNlW/XQH9iKFSjF4fzWHXUmAtY3OnJ3xsYekVXVi0mgX/tYC8TLjZOf
         +AUOlNlXvK8RrU9BgKc11zMGFfm62iSR4cxL9BMp8r/ipaVgBNH97ormakWsk8Hr/hfs
         13z7g7B+GtI2QZP7gox5ClaZr1dOrlAY7Do01ygHx4Bt7SdHEHyyTG91F9vj+TZrLxn6
         b5lNmSVMCym6h20rEkPzeqiSFgDc7fiR2kBp353UcIWL/4/qSYWkDJXS6yYxnCxMnAsc
         YKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576065; x=1791180865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=enVf1SyIQ9oZvAJl5nReVDRZKns+mfLkqH0FfDFTL44=;
        b=QkbL0yYqh2Wh13XSNEnjcV0EC5msVpBWhl1VEyndDlusjIJbrfZplGsbDGfo2rpXbg
         W5HV/ovNAyqc7N1lU5f3GFOmj0M/C97TUAfmIX6a99ys9K4LEAzAnvmPFhmc9Z2gTf4B
         RP/xDuiW6jsDLBb0p30XCaiTOPtWWCw3FYx+kTP/YeGi3EmVf4cd+cZeyL1nlbj487zl
         Urec5xyBQsCMaVL6S+Ro1EqVPgrwKUmPppjEvfkLt2S770aURkJZ7/hkOf60AjEessEX
         aJGWMYBQSeHoLrW0KOkqz5ne+53CzDJp64nQRTIdJqh8ouzrplpheYYrc19XhC/ixiaK
         eJ6g==
X-Forwarded-Encrypted: i=1; AKwUvBzSfmm+MLT4Iiab0lxs0/ouXJmntHx3h7dattMAQzZEyRfSX7w2xkga+gQmwMD3JMXfbD3VL4amsKHlXw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKHUb8613EywR20xB5qHPWczyjJKsVeNQMehGlfRHyGTsO1K4gE
	m2ptsidySsAgCwZ7ydELyAYh0rJlLIf0d9bWC3u+9SVHpwQLpz6AyyvJ
X-Gm-Gg: AYBFou2ePJGJ1EKPIDe/p0y7AOy9kaPJVCseSPHJiHDf/r/8zhHDRKzn7snj+Xzk+RG
	H736gAGD4zNZNaEEyqsnzoRBV8e7kQe97N/ex1nXV9n7u5ArDQEd3wUUYDPHg17Cne9h+wnrr4a
	1djn8zGi084hkK68j8wqBbZmN8XF4JRmshsMtzCgp2ji+k8dwb6MM1dexD4pgDoIWjQJ177xkx6
	ZvUKu/O9ew8tmpYQB4UbpjU+/5HeuQXP/nE/THMkMU7YrQmfiaH7EzOfNUco4VedV1y3Ef0gGN0
	aofAxu0zaIcn7pNuxp3zJPEkLFoY5ztnD2BhhJAdioBTdXbc9qk60u0G8sgeDX6E6mzcGva4HDh
	EZJDgnIhSbR2U7a0RZMiAu4wqxMdcl/DsdeSIZgCZZRShLyk3XU/fmqVUJ48+j1jbC9MwvxMjsg
	xG6D6XNQGniVhmskzDTuUi0uyU/h/YzmcVqi4lprqjjxT3wCG9TUW02Vl40FffJkCeZWXG6XpOO
	nwuxLC0YOP9mUw6cw0HnUin52iCDoM57TiOtgrOE2JsIl6rUJqozqXrc4bXVfeAEUTlI3EKok+c
	A/s=
X-Received: by 2002:a17:90b:4c03:b0:39e:6a82:afd6 with SMTP id 98e67ed59e1d1-3a098feb5abmr10108909a91.40.1790576064881;
        Sun, 27 Sep 2026 23:14:24 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9892dbfsm18864088a91.11.2026.09.27.23.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:14:24 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v6 2/3] cgroup: export cgroup_e_css()
Date: Sun, 27 Sep 2026 23:14:16 -0700
Message-ID: <20260928061417.1574676-3-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928061417.1574676-1-yupeng0921@gmail.com>
References: <20260928061417.1574676-1-yupeng0921@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nvmet invokes the cgroup_e_css for each bio and under
the rcu protection.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
 kernel/cgroup/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 69b0f0cf2f3e..5a1708ed6b23 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -554,6 +554,7 @@ struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 	return rcu_dereference_check(cgrp->e_css[ss->id],
 				     lockdep_is_held(&cgroup_mutex));
 }
+EXPORT_SYMBOL_GPL(cgroup_e_css);
 
 /**
  * cgroup_get_e_css - get a cgroup's effective css for the specified subsystem
-- 
2.53.0

