Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC222222AB
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696620; cv=none; b=RoLq1Mdw8oHBHQyNp5Ze9o44Nl2l4ihVFwLo6foP4wdg6CZh6TzB9NHOUYhlspEBiRrzOV6zjWUw8QfUoTQLyW3lMEgANZj4iIoD1oggfbAg/X2tzM3wcOTDCTu4lEXIzX7VwyGx1JPRoo0tlH5gLcxjiM0uxvJ31CuIF9iDHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696620; c=relaxed/simple;
	bh=3fO27bZgRSLX+ZjJteSn+272IeY/0JUe6KT6vJpgZF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksCGBD6ojG6PiT8wV6x4ABkwd23Xd5nx9bcHiFSPW58e4RjjmpFTzLyG0CtGffBEfgFLYUkk+TDqabmxNVtCxH3EHNTSj1WfHInyA+pE5KVR0JDF6abbOD4mFl2IMUKbsrBWuHVELHWuurT7BJSy3rCU5ktKjWLl0mDARtX/nEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BqeD8fBG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BqeD8fBG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso32121885e9.0
        for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696617; x=1742301417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeNwiCAXtv8YYTGNB6COQ1c83CjJXd/IUXH7xE+l9C0=;
        b=BqeD8fBGYb1N+2ZDPxv3fuEKAJAbnrhqj5BWeyODaWECtWw8uiaNIdYzfJuBv/J2LB
         qU4is8T0u/FhQAiwteu9Q67uW3iOwo0Qc1POzeV2mxzundKw27KMuqhmoNDnImApMWNM
         MPa74CnVj4s7EbLTdurkNzitpcQiagnrtviu5vB0LxkEpC5ejENwdmCDbuUw1rkPBgYO
         W69f6+tYWr2zAQkshkkRYqz0z7w4C1NiGiiYKcDOAD5VVo17bujgBoYpWgQORstw5sw9
         5siLzL5867/f25Qnr0CX7iM6NHV/dzXdrR7ENmNP2fy+mcgFDVxXDXoKOoxgYisGcksH
         kelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696617; x=1742301417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeNwiCAXtv8YYTGNB6COQ1c83CjJXd/IUXH7xE+l9C0=;
        b=McK/IdAG5nOs3kqOJXkpRWx7j/dP3jOLnUgxphIe+A2ulZePcXOIgvxrtyQHpMGf61
         0RvKAuEPwps2qN/IeO+uf512w7nXXlY4fimTlCM5sBsYRcA/cOE78cVdDC+yFcnr6T3i
         S1p16nU1UNi/kYXlQ5IHT1ISBCjvmJUM+EPYKyhO2/DJGlajgOzJ2onVcSW3jxhasfqu
         iyk/kAccQ2oDHatPfGoU2ghjpIAs+T7n6HvGqDgEadZRQL9rH69zDNMM76Rit9DbuapL
         j0tvOAJa8sE9YC4K3S1yM7PnND4wOG5veWV0+V20RF22U3535b5GlsaTwlI6yBaYp21y
         I24w==
X-Forwarded-Encrypted: i=1; AJvYcCWvgUtbsxPyHvnhfBo6H7U/M44IxOiRJtO0jGz68D9m/bs3OhAigne+DfY71UAcIdDwvNbPccGfn37Wsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQgPBRufxuRozmDb2dD6aqhVkVxRcnVwA0NZhwUOEjardnP9T
	bezDBS5+ramEGL/OUNOdsBGdqRi8r/0tGv4kZS9DBENG06kRrKKHHqiDUD8TD18=
X-Gm-Gg: ASbGncurZHFUfV1mUQcApObH+lwqEzE3V4otljzh4HKcUIR5eBEZG+6imHqKFR4zWHv
	2oGrM0SbJaWdlS1Q6hNn+07o/7HCUVyf3wHi0+bNmHV8hg4jqgWSX6ol/Se0RAjud5q53f1gHzw
	GdoNqOsn3ZdP26iGFbmWGLmUYAZJccLcplyDhlcuqOndcpBUzCMCGLvQ1BB9OmR7rvymdd8LL5K
	nQaHdzmtK9acVHp98wuyRjBOk96b65FoySFLLzoVNoEDAdldPc450k/J+gM9U5B4Fk7pnXncTzW
	4jO1JPy1W8T835dGJzvOIglqyzyi23V/fA8/jCsKSP+gC0Y=
X-Google-Smtp-Source: AGHT+IHn6PvkpQKJBbjtpTZtl/brCs+22CGDxaMUBRMoRp7lTvofXIIlLNevzeSErD/52v0LpfOABA==
X-Received: by 2002:a05:600c:4f8b:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43d064952fbmr18361755e9.13.1741696617111;
        Tue, 11 Mar 2025 05:36:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:56 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 03/11] cgroup/blkio: Add deprecation messages to reset_stats
Date: Tue, 11 Mar 2025 13:36:20 +0100
Message-ID: <20250311123640.530377-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is difficult to sync with stat updaters, stats are (should be)
monotonic so users can calculate differences from a reference.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754a..1464c968eeb0c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -659,6 +659,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	struct blkcg_gq *blkg;
 	int i;
 
+	pr_info_once("blkio.%s is deprecated\n", cftype->name);
 	mutex_lock(&blkcg_pol_mutex);
 	spin_lock_irq(&blkcg->lock);
 
-- 
2.48.1

