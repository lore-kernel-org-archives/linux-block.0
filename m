Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20418377575
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595678; cv=none; b=ui3uOe77rGG2RPfGulvySI8JqvMjGyVKUl7Kzyr1K7brxjNz/YSY+PpSydf9u5tnWgvqunGmqk/CuIr42EoIRmtx5N4K2TSj4Nyzf/GMMi+AIg5o7E17zPxLCkvbfKcymh5iPyIBe1X35Bb4c+vEX1KW17kn92WBggWcd204dHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595678; c=relaxed/simple;
	bh=3xFqNDbANLuxYwJZCL+0J4Zy2U0siwNrORG2I8A78Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lr6QGrLagv8TEeRu+HjVwFjuznnne0pItrXRA+ZOaVv4WOP5u/nHn74B4GwpsY4aQFhJ1ZcmcCAGT32OqVUBsbsE2TvN4bRv04F9nKY+rhO4tR+oL1bELC6W303WkPclUfxeGVgqJB4wp3lGK8MyzJi2d9U4FLg7SYUtr00uTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARu4y2Gm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARu4y2Gm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso33628875e9.3
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595675; x=1774200475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBtR9VKnPKJgjfwnbtGvinYVj4EmpVw+ixE7+VzQpDU=;
        b=ARu4y2GmG8QpEa86w6wV6HozJ+IePGtzrgO8f2Cyo5k5GRcYQNuJPtlF+s3R/QjVs9
         qq0h8HIz8Hl+kKZG8q+UVAOAiggVhGAA56fT5Lxcvg8RTWszZcEBVFYEawgyy3bAtCCW
         kLVh0XwZ+N6z7U7yhUF/UQ0qzDiUl5QUnmeWgqdTtjIgppV9nxyVZUpb5T//OR2mUFvG
         xQJvpDXPsIyJCejURnU2cAiDA7Sddfh40zilghcy4OZJ1GovOXbu7NHo6l9Q4P3XIAGD
         ZGfmG/xfhA0hde6hAXbQq8wlI2kWPxDudCEaO5Up1Ahfc9QgsgUHjsLmCjC4sfg/LnhG
         JFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595675; x=1774200475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBtR9VKnPKJgjfwnbtGvinYVj4EmpVw+ixE7+VzQpDU=;
        b=C00uPZJ0DS8F13EgFjF6ujlJm9hC/VTPHrP4isGIPLiofE6pJneAxhbdOSeq5zzNxS
         68PEV4rp5kLUeGdCKniCyH6kko6u794nBIir5i9h3lKT/USr7m6XbvfGoRbm+3RnUm2/
         DBX2c3kfjoHWmBCC1BXql9J8SAZ8ET39kaerSNtRmAQnov8F+MwxNQ8bHOsglsMu25lk
         suJvsWbIqleBFKVZfcOtNp4cxEOZwmPO6nuW3p0iGOj+mfHW9jv1mQGbCoDYdMnVMLTr
         3f8Hz/mRjt/VzYWZgqbNAoGWJWp6piKcGC3Q3vIbGaNS/D4Xv3Cstrj7sV+akg13v5nw
         duQw==
X-Forwarded-Encrypted: i=1; AJvYcCViIicOWlJh6KpkoBUHyClO1GFHdlvYHFMjpqFyYhGEhVuhx/6Zpxak7Y0cxXX8KM6zuS4dbNQT9GdAog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdV/0sz0tqqKNKiIjsMMmD7pYd4auujxiNnKrrbaG/kM54l9NF
	YyMIqZXRTMln2wcBpRBKHssP27aJ+WfI8DThhTWPJ/0BL9Qm7vSjaDJn
X-Gm-Gg: ATEYQzwbU7UfOb90TFeE9gru1wvPau7Yh16n5JwZjUxpCkVVeekvR4fKvrhiCbNB0pO
	h4uhoIUFmjjnICeCR8KDq2cZ8v3Q1GZ6lxyppXzYFLmLrHAlqwoB1rKaNIcLKosS1EvJN3rU9E7
	OEp/8J1mkjTswBdxuWQLjoQbIH6Wlv4U8ArfoRrXXA8X5TGbL2QMgVYKReDYXf+5o9qoggEjvpc
	rUdIWGJgb+8TYBeVU+yQI01GZv9zwvsCqbjVR3TM9MhVBCnZfuAM6NwucMArvup04Gyh2EVjphd
	/AG2B0J4pT3seP43PsdLQqozNMukqAoI3jnqg86oAf2sJuad6jRk5sPYvjgFIM1byqjEQ5QL+wA
	fNvsJjIi5gj/S1Ity8eBbM/hVxGVKqWsiJvASsFLPtUxH0ro2GeyQjgP2Vi6fXLYAPiBtKA7Aal
	r6IVYCDZ1yAy+mG0AVscvGn3jczI1p7udzUQU=
X-Received: by 2002:a05:600c:1395:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-4855670b72fmr170714095e9.27.1773595675367;
        Sun, 15 Mar 2026 10:27:55 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm73644905e9.20.2026.03.15.10.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:27:54 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
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
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 1/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Sun, 15 Mar 2026 18:26:38 +0100
Message-ID: <20260315172746.270734-2-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement a balanced RSS queue distribution by skipping CPU0 for
high-rate MSI-X interrupts when multiple CPUs are online. This reduces
contention with system housekeeping tasks on the boot core and improves
overall throughput.

Signed-off-by: Adrián García Casado <adriangarciacicuelo@gmail.com>
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

