Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D7224D5;
	Mon, 22 Apr 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800173; cv=none; b=nhHgYurnJcA8FkxU7czQgO/bNmmDubrXBXSaQoxTrBxhUxjnA6GjDQCW2SwoDJ2AKAaBATg1ejS9qts5jeE/Gu6xqji0x+zfWuHOqxocGLfYW6npTEAIMwkYoPPnsH67InOg9BiJSYbrq6u667liduvFEtk/duye94iai024thI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800173; c=relaxed/simple;
	bh=u9HCdteMB+HMYRjR4arnujnff9oEN5NosNpH3UJ9++w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B/BgzMMDL9sZ/f+Zbo46JYu4W2MaTo2lw207EWO3GPPc37533HL36TxnrAc67eMhats+SUwiJnmR1WXVHBfKVS8kyJMdXTJdb5rWft0prrpqwKVo8plHOkZXHr8zEnoc6de4XpQskSdf6DsEoCODCUYJhA+9qAxTT6VP9JXXncQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb8bYD4R; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb8bYD4R"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso6819077e87.3;
        Mon, 22 Apr 2024 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800170; x=1714404970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pvm+9Ih6B15UM0NoHUWNBzlKXdp28/1dMYo2uad5Ts=;
        b=jb8bYD4Rl+pG+Hg2GLGvFcOj2N+1/TbGc6Bh5O/fiVYwq+AaguJLrTlPqhP/VTVxJr
         7BbMgz0QPDygSc3BUK3cJPeBmkMK+Fba0q3XZCTAbDQ7Wy1v8o5wLhZrPAj45PM31kxk
         PbBwvjinufHrW/gUjLwcbSPkJBORZg9QFJNKwuXkrHH1GtnHJ5WE9VlWxhX+/IWt0Fjr
         ksDjAEGqBNpPJXcMDjDeJ7jDKqyVgBG1Z59xmT0UGcI1jIJzJj9iTs+oPuxqivSX0UIB
         HkU+rLRCkKjYAMrAqXxkDprCW4CFgc8Thn1IZaN3QyehFMZEBHxpMO3D9RvLbNtQ8wKA
         +N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800170; x=1714404970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Pvm+9Ih6B15UM0NoHUWNBzlKXdp28/1dMYo2uad5Ts=;
        b=laiBG133WfwXkm+DyY0HIwmCujGiilsgvg83UMGd9Cs2JzFgiX0R0RzpxFv/TseQ+7
         uV+z0GZgn2BBot9gvadbeYbnCoNdupAj3ub46du9Af94LWK6cfRJvEeth3lEsWAK42Tn
         XmP/x340U1FbVzrnXpEoBGD2/TBuUjc21FhvzasUQfCu6wVML+8J3Y6+s6PSuDbhpUOU
         qy04UNCfYFi3KnTbvrCdL9GQ1z0PTj3D8Q8T1PZ1k5n/jrodhCCT10pCnFyRAbC5KO84
         H8rCQEJXbzxlWFXpdkW4gWI6DrBEnXyyh+9mR0symC0V8Sm5OKlDYKHLqGBBEjGFr86W
         vNNg==
X-Forwarded-Encrypted: i=1; AJvYcCVirAZX3rXLLUsQHfC1CvYUR4qIo+/dhVqJZGFoKVvIzV9BFNr7RiqKTQEs7vqZD+Z8hRTT50whRyIhGw9o6rQmh9zsU9akM/4ZgJw=
X-Gm-Message-State: AOJu0YwMusVQu8qwfdxllth2X5FuSLI3QdjpY1cFy8VWezrM8fhkzrgz
	92uXjKhnd3G9zVlFgOqE/h/yopATYD8v5zwf4UKKx/YDsBbTa3eztPWzBQ==
X-Google-Smtp-Source: AGHT+IH8oYNV+froVxZZBfVcUz0Gswh4HvKplEEaUMXLrUNqo0BUjkfbera210zCHANfwadlpH/y4Q==
X-Received: by 2002:a05:6512:3d24:b0:51a:df97:cc8d with SMTP id d36-20020a0565123d2400b0051adf97cc8dmr9213871lfv.26.1713800169781;
        Mon, 22 Apr 2024 08:36:09 -0700 (PDT)
Received: from saproj-Latitude-5501.yandex.net ([2a02:6b8:0:51e:bc0d:8fdc:ab42:84e7])
        by smtp.gmail.com with ESMTPSA id k8-20020a192d08000000b0051ac9a297aasm1269612lfj.141.2024.04.22.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:36:09 -0700 (PDT)
From: Sergei Antonov <saproj@gmail.com>
To: linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Sergei Antonov <saproj@gmail.com>
Subject: [PATCH] mmc: moxart: fix handling of sgm->consumed, otherwise WARN_ON triggers
Date: Mon, 22 Apr 2024 18:36:07 +0300
Message-Id: <20240422153607.963672-1-saproj@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When e.g. 8 bytes are to be read, sgm->consumed equals 8 immediately after
sg_miter_next() call. The driver then increments it as bytes are read,
so sgm->consumed becomes 16 and this warning triggers in sg_miter_stop():
WARN_ON(miter->consumed > miter->length);

WARNING: CPU: 0 PID: 28 at lib/scatterlist.c:925 sg_miter_stop+0x2c/0x10c
CPU: 0 PID: 28 Comm: kworker/0:2 Tainted: G        W          6.9.0-rc5-dirty #249
Hardware name: Generic DT based system
Workqueue: events_freezable mmc_rescan
Call trace:.
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x44/0x5c
 dump_stack_lvl from __warn+0x78/0x16c
 __warn from warn_slowpath_fmt+0xb0/0x160
 warn_slowpath_fmt from sg_miter_stop+0x2c/0x10c
 sg_miter_stop from moxart_request+0xb0/0x468
 moxart_request from mmc_start_request+0x94/0xa8
 mmc_start_request from mmc_wait_for_req+0x60/0xa8
 mmc_wait_for_req from mmc_app_send_scr+0xf8/0x150
 mmc_app_send_scr from mmc_sd_setup_card+0x1c/0x420
 mmc_sd_setup_card from mmc_sd_init_card+0x12c/0x4dc
 mmc_sd_init_card from mmc_attach_sd+0xf0/0x16c
 mmc_attach_sd from mmc_rescan+0x1e0/0x298
 mmc_rescan from process_scheduled_works+0x2e4/0x4ec
 process_scheduled_works from worker_thread+0x1ec/0x24c
 worker_thread from kthread+0xd4/0xe0
 kthread from ret_from_fork+0x14/0x38

This patch adds initial zeroing of sgm->consumed. It is then incremented
as bytes are read or written.

Signed-off-by: Sergei Antonov <saproj@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Fixes: 3ee0e7c3e67c ("mmc: moxart-mmc: Use sg_miter for PIO")
---
 drivers/mmc/host/moxart-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index b88d6dec209f..9a5f75163aca 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -300,6 +300,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 	remain = sgm->length;
 	if (remain > host->data_len)
 		remain = host->data_len;
+	sgm->consumed = 0;
 
 	if (data->flags & MMC_DATA_WRITE) {
 		while (remain > 0) {
-- 
2.40.1

