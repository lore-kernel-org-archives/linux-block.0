Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1A371880
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192809; cv=none; b=uOT4DyLfDKFlhIqAZmWT+FRIP9ag3p8zObj/Ja/ncF3HY1XH+Y7EOaeVNBR25u0baTd/Eo57aVzHBQ+6hY80MQNKs8hOH92WTGbPPOK7Q6uGHDhW1CPjbRWTXEGCk/DSm7Bbrqq0nA/QEg8ByC/xPdOVx084EVaiyPcHaixCeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192809; c=relaxed/simple;
	bh=yc1ZERZmyyBl9BFJfkpN7IfeLpD6Cx+LUniYcStIryE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQhH/5fcrdoqY06UsMNcMYJ2QwVn2/7muBkHxxKNcvoW9VGUkiBULt3AlGVFsCjY4uF8xE7p9gm+CpvHV3cE83mH9ye4EdH/R80ccdB2SdvprGPWY8tj4+soRaWsRXQ+jc3bgImQTXBlmJ+fr3A47ZdrTykd7AAA2pJ07OHMW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJcz1iQx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJcz1iQx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso37411045e9.2
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192806; x=1784797606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYYKiLk1/mJhSG8VU9NAerU+4eCoRKrnRltemvuY65c=;
        b=OJcz1iQxnT7ZinHYIqMqx0dsypnRvD9pxcSCeMVtsdkuW7bt/EdqlP0pvmo/92HpeT
         Odcr2vawv6SnQE3jPud9ba2gu2M7TDu5vq46H26ZZktY/QQutgrcxMQfiyW9PDCSjZAK
         PjwJ69j1IKxMZTP7p7nEFEZ101e784aKEaxT2v9AcWhLqTD4RLT5Zm5wFCm3bDsaRBFy
         h5R/04uqkVhSa0n5bIkUKHE/2Ez2i/ClHZLMU19HF+R1SfC6nUuztFah6jtwtqMctsD+
         MxswNPtbTTZP5OfkpEPzZN2uJv7FwqRjlnhd4QMa1LuDUDJOlcCJSnJWBAP78Mpm37UK
         yGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192806; x=1784797606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bYYKiLk1/mJhSG8VU9NAerU+4eCoRKrnRltemvuY65c=;
        b=i7LZNrz3Tv+fQTcLTeiPfX2hUBN5I5GBQ/T0BcuELi2h420GirT1zVrU3DEYEPKhvb
         rpiN0sRjfEFRTojWgp12v3jpfbMsnHt6grqf/JgoDQx5FCAk9TBY5hX63SzQmvL4B9k7
         SOYCvlWMkNTidt6V3BCLHUnxytoG0AApL2E/syV6tYPyKVFrrBIamQLefno1p1Tb0sbt
         te4dpuzjpPVFz3yz3p1PMT2g1oXRLiJL7kWqEyo4gOyurjHAIdLluIwa3cltI4uAL4ir
         Xt0MJP4PnD7whaOUHtzZGQpFieTMc/P0R3IOA/CqyVfDAY8xz8obgC6Z19ykCezqwBF4
         2UpQ==
X-Gm-Message-State: AOJu0YzmUhorM8sjKzlcDfG3wIO3fgW18NOftW6K3p/cbzwj0EwNnF1I
	Qc0p4tW82uL+CF93ofhYSvjsiaBOEubohfggtb3KOn5mjTTsKuGMwbzgDwtE7g==
X-Gm-Gg: AfdE7cmQKHm59GmU6S7yrg1h/ACkIXTfq9c3Clff0TvzoUz+3sDwYgyN6jy2NxXkfpB
	J4MHPPCkGhFCIa0QYCxgjHb81vMIdF0t/xsJhyT8r516X4yWdQMiFzWJZGg/CdoxQ5ij65cuzxK
	GswWW1898ZTCqAXlpboco+vyVzD2rLSuS1Wg++F8i8z2WN+rwAzLpVy7Zvc3DaGK2mhcZwTog2v
	x1DmNYtxy3sXxH7pYg9fXvObLXZd7JCGUO51dS0JFMtnOIM1sIkkdJagxRYNNixp0mGOdFrmfqq
	FpSmo6pX/8wJ5RPIOFgHKPwdxIxXAHMS8s9afpwu3ogU8tV8OctJBNY7ok+dg27atW20lsUazHJ
	ssxH+4xgMFmE8WaWT/0VJm/tCtDavP9r7qkGaEt5FhOUZbIC4AJ/AoYJsq65S9Big+uFbEY3eXB
	9PQONuePgxfv6CSu9qV7kiIzj3XueTtkHi8zaGek+A25CJ6qg=
X-Received: by 2002:a05:600d:6405:20b0:493:f807:1a79 with SMTP id 5b1f17b1804b1-49538a0ef82mr85194155e9.27.1784192806088;
        Thu, 16 Jul 2026 02:06:46 -0700 (PDT)
Received: from localhost.suse.org ([37.109.161.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm39662895e9.6.2026.07.16.02.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:06:45 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 2/2] nvme/039: skip cleanly when debugfs is not mounted
Date: Thu, 16 Jul 2026 11:06:26 +0200
Message-ID: <20260716090626.27558-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260716090626.27558-1-sebastian.chlad@suse.com>
References: <20260716090626.27558-1-sebastian.chlad@suse.com>
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

