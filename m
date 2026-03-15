Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3334C374E56
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595026; cv=none; b=NtdiUnFn9Stvk6LuedobePzGyBEP5e8SzEoGQDXwUNIhtXz1h2frDk0uB5PR+OCho1YL50vZplDkmMnPQow852nSQW2F90sYOg3OcnHfSmrR68LNwDt1tudV/1mUMizEo01iXJKOZSKBNOBnuHeHe/9j+a87heYIApsXolCu2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595026; c=relaxed/simple;
	bh=xR1aQtJyjOGsb3F8bKi8GxD9ZWQvMlCBKAMwTQealv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igl8un89Ke/gm0MWzKPncVk4zeW6B9P6OEciHsGr+yK1i7bS4zfr5hTF9PPZUQJFWClQkAY+GneNO6AMu+/Enhs2ZqufsVJw/K02sL8Ge7kGtrp2AFX3VN8tAkHva+KDjgL2Uo0M/kR31bJxHCm1zrqlVqxmLHzWHUWqHQmwE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGDd2s0M; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGDd2s0M"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b7c2788dso2349777f8f.1
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595022; x=1774199822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eNrBLnJJHbmPI7WkNJ6vq9A1HMj64DfR2iaRW7E89k=;
        b=LGDd2s0MRWWVzXiLUlhscGY31hZPYrH4KObYvbpf2p9Ur+gOzA6ep5+r+WLKV8QH9/
         +/4S8qNW/piz9OVtsNFhHEK+QQNbGl7USWoD43ej62kuooI1hxOWuwzxxVphv4bNfxHQ
         lXO4IOJsrITQRmID1rAQyjekPiuqPqSvwc5T4DDj6fRl9Xtzu1hn1XkIPKQ+mg0l1olG
         beUUL3G+Tx4LMx1AcTr9YqTznBOAY1nZOpvJ4bwqjGLTvaS4eftDMgtwuDsQsNNh5R5s
         iMDqrGuK+zeWy65nDQLF/OuD9rYse0Giq148n9HjONRPABWI8T8LuwY+JGv5+WGrL3Zr
         RUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595022; x=1774199822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eNrBLnJJHbmPI7WkNJ6vq9A1HMj64DfR2iaRW7E89k=;
        b=hBL1YHOOnEyUyLaBbgOChTVDwmA9wCehSgqZJud9GE87z+ihtOXHEZoIHeEkLwHOvB
         cZI95VHhhN/FS6Pm7Z9Eq4PF2+LmcHxO5EgHNDE5jYO225MSn3zJs/rW9e+/JOJKMjxC
         GUmmOlxf0vdeoTVTHUtLBDkekaHITbDfYxbZEvxdq30E+rIKIzFmXP9KGc6N/RUgZ01J
         KDJFo0E/ROqkZISzBOegU3RWbGkp+T7R0U18x1V3FUNFUC2t/FMI9cEh1YYAkwNP56O1
         eooHFWzcy5rHk5y8guqIGTINnGc+7ByOQtyzIubwJV6+DoF1A6+Sodfl9r6Q7Ms6KH0M
         JDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAiUd6Mp81kKlgIUhxgNXoWL6v5v2Z2PSMMBPsZde6rlTpssOkO9/ZR0Yk9lb0uypJcQGTqzQTJdzeoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCduq+ZCx4pjxth7FvBvrWa/hpMSSEfHKfVh4EoGKKibeaHV/w
	dWDcptkFbYdANZI6PIDX2442JLpNMAcO5rkWEv5k41tErI7iUzzGP0d9
X-Gm-Gg: ATEYQzxkqPXTEyOf/GGu/i9sNE1LA1AOwO97cql/7I+GKZAmojsr38QIIsePTIZ+e/V
	DLGr6SrXnyOsECEW+eA0XjUwAuZ1c2bFWZ+BnvWBBXrhTbbgmJD/Pkd8YHCxnUgOqbHiRXARP2T
	85vzF1qBcegWSfB2i8aSmalExjPcsV4+/T8ZE/oPCoE1UgtkVr/hH0zdl+y0tU9+c2YZb7nPbHX
	d/DCONMC8PeWafSHJtTPyHRqqS8pD1bci1ocBYEiO2JYjqEJjnCPGU4i920rgV9mouiSulI3BmN
	XngxsTukTxHYnPhT4ZJrvZCUfor6Y1kr78Swggl6VgHEVQ8yQtbMi0zQVeeYIFYmewF4awujXmY
	tSAflg482aAkHk82hqqvDzS2cucOF+ixs193bGDczVRj6SOgEJ1oq97xwmICtL+mlm2LnlA93fp
	lfauS0J/9/4Pg8r+sf0fhFigRIN2TTRO1b9Q==
X-Received: by 2002:a5d:5849:0:b0:439:af0e:57a8 with SMTP id ffacd0b85a97d-43a04db7edfmr19896954f8f.33.1773595022342;
        Sun, 15 Mar 2026 10:17:02 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:17:01 -0700 (PDT)
From: Adrian Garcia Cicuelo <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 3/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Sun, 15 Mar 2026 18:16:52 +0100
Message-ID: <20260315171652.269020-4-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
References: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a balanced RSS queue distribution by skipping CPU0 for
high-rate MSI-X interrupts when multiple CPUs are online. This reduces
contention with system housekeeping tasks on the boot core and improves
overall throughput.

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4560d92d7..87149f29e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1683,7 +1683,17 @@ static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
 		 * Get the cpu prior to the place to search
 		 * (i.e. return will be > i - 1).
 		 */
+		/*
+		 * Balanced distribution: skip CPU0 for high-rate RSS queues
+		 * to avoid contention with system housekeeping.
+		 */
 		cpu = cpumask_next(i - offset, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_first(cpu_online_mask);
+
+		if (cpu == 0 && num_online_cpus() > 1)
+			cpu = cpumask_next(0, cpu_online_mask);
+
 		cpumask_set_cpu(cpu, &trans_pcie->affinity_mask[i]);
 		ret = irq_set_affinity_hint(trans_pcie->msix_entries[i].vector,
 					    &trans_pcie->affinity_mask[i]);
-- 
2.47.3

