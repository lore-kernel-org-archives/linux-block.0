Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494A27EFFF
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062336; cv=none; b=lU7KA1RH+JtSX7cWloodIHS5Q5zuS3U4MALu5yqSLMcLHorhZi6WamBLYBx4EMs0A3cBlH40W6B3qKsPiu1Vi8Z3D9YR+tFLsjzrzAzfyQ+narfHn7W6SirxAkxueAfcdXoH6oRvI9BotOB4NTxOaUQ/NuVUs257gCPTTPCsOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062336; c=relaxed/simple;
	bh=JvX7TqkBXPSB8OitMgWG1eESIdw6g3S6GklBekHhnLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5gxDoqIxeZWZnPGo2ygzlTXE1qqiRyORYsB3s+VMReu/F1yFmtorVT6RxNQ96REZzgFasKWBojpDhsIvFZ9DXfWNr6JuVYgdztG0A5bcAf7UiJHSrbPirCP+8bauzPi5l8AvTncDuq8RA2nEXY+8wZb9kqoelt2sBI/TBWyp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RJK9eNQ8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RJK9eNQ8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso10803605e9.2
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062330; x=1757667130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4OYQnEDg2MM33An1P1417ylBBWSz1KWKHVVwtk+B0Y=;
        b=RJK9eNQ8NtG1DjQt93AMB4WCTuw0VWhar18lbJMEpGdvB0Eh3efS8NpMuxj+p9GuXq
         gcnQT0VBtfXHR2SL15funqBpFaWXP9uxrpIEbvE5seSAkhxDHQuO/R9mHZmxHHhbqmOQ
         sHyhotVjGHjDTykHs/FBSrFkqJqxGr0rf7X3BXC/WdkW/EVccFleQxwZ42yDy6p78PQQ
         dj1YMFZR68KGAeDILcxknWjlHh1o8ZdthqnT/tuQcTY+imHKG3xR2PlS5okQ01Lxqchs
         rnhFso7L2Pe86x7xeDBrS6VExKfqZx8CG/n0klM1/aq/BDvGpbpNqh9K4LQFtK+iGwQF
         3kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062330; x=1757667130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4OYQnEDg2MM33An1P1417ylBBWSz1KWKHVVwtk+B0Y=;
        b=VGNhyqBYbl8f6T+BFKEvUGHNI659tbFFEOGxEU2MEMjTEgh1lkBrfz/Y3j8nDvcLN/
         VFGwI5H910eygCqTLJamrHHUi/BIs2uC3H8f2oE76kf0j/GIQP3nAwbcL22cWE80HtxO
         EQ1QbHrXnzGpJlqbsZSPQpbLir1/LtNc1ISuZvGUlpUGu/YwYrf+9O+INKl2hGFOvOUj
         vm0Mh7ThKgpPdX6YOGMC0DFQxPN8+FnCjeZ+MUPeqaNPuaVeCwSAAvEWRSlveGIEosc/
         7FEjb9HIV8VREtst4oyjmPagczfgmAIuzEo7ldOG6CtSTPGLSXgAqhFi2dwvQ9S5992j
         vbag==
X-Forwarded-Encrypted: i=1; AJvYcCUQlO/Dre91wfDWDpjvqLq9EpK9OJDtL/43gWMHrsguxm7PB3M5ZCNHCQBLqzdqd+oz8n+quAURDO29Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dWYGCCZAmDkbYWAJPjWWLaTt90RIZVPcqqCAl4f8tSY6KmlG
	qkZdRhfV6vyYXsJp4uaWBVTuewdzOYd1UrP15D7ag59GihJl1t9TjW8mHw5TJ69s+L4=
X-Gm-Gg: ASbGnct1Vyn5T3xckZI+R3ozBNMei0D3m6AeuYg7w610Fkh0VtOgJmiaEag1Ywi4BEk
	DkxAiG/RDJ6i96eqwuytyBB9CtOI9vlZ5L3tb6lh8QcrMveyb1ycbFMeaHMYBVtuyG9mVgXX1db
	FDyABMxA5qeC59tJkEiSHlrP/pVEjQ478IsS8vDsYJO2y5fYESYhVw32dSUtbhRnSq3SLuT89K7
	6pSe7de10L0Lzoh8EECkPsOuFXRwJKNGAV/V05LFHAqRgfZdv+xccHk6Lz0o0f3YgdphHZBpMEB
	QpW7/Qm9dNOaCBG8+vtu5HaqbF3w4CSfZBEc72IX1mCLs9q6pOyqQOUT3Iss+n2m4YBfNJrTW/x
	HkEchEqE1l9gUuXZU5WR+xyFmhTaD2WYtvD3SwLiGiAe2CfftHP/y5OdKMg==
X-Google-Smtp-Source: AGHT+IEqBd4ds0RW6PXStRIDBwTEDhSLakCtAA3K8GPmgNvMAMaafWSh2e4vyXdrFtjFO7ZutFqBzg==
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b85550704mr189754635e9.4.1757062330275;
        Fri, 05 Sep 2025 01:52:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm166359115e9.2.2025.09.05.01.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:52:09 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] drivers/block: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 10:51:39 +0200
Message-ID: <20250905085141.93357-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085141.93357-1-marco.crivellari@suse.com>
References: <20250905085141.93357-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/block/nbd.c    | 2 +-
 drivers/block/sunvdc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7bdc7eb808ea..7738fce177fa 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -311,7 +311,7 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 		if (args) {
 			INIT_WORK(&args->work, nbd_dead_link_work);
 			args->index = nbd->index;
-			queue_work(system_wq, &args->work);
+			queue_work(system_percpu_wq, &args->work);
 		}
 	}
 	if (!nsock->dead) {
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index b5727dea15bd..442546b05df8 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1187,7 +1187,7 @@ static void vdc_ldc_reset(struct vdc_port *port)
 	}
 
 	if (port->ldc_timeout)
-		mod_delayed_work(system_wq, &port->ldc_reset_timer_work,
+		mod_delayed_work(system_percpu_wq, &port->ldc_reset_timer_work,
 			  round_jiffies(jiffies + HZ * port->ldc_timeout));
 	mod_timer(&port->vio.timer, round_jiffies(jiffies + HZ));
 	return;
-- 
2.51.0

