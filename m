Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndm3ET3I"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31520CB
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 00:29:54 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce387bcb06so432652b3a.0
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2023 00:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701678593; x=1702283393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gd/ON8ihgg83SHPH1lmOcG0aooT/dzdiqAV5DRlTU9U=;
        b=Ndm3ET3Ia+eLr13YMREznk9S6/0MfdDjk/LrxMYljXB5ZPYQ/2lu3QE8qllyyUIr0r
         fGUc5Y5RXaomsbM78hc9MFIigVju/W+tOIAsD5UauPCZTzzQETuU2tKl9B+BYue8n3l6
         1QUWgom8x/8w1VctyS37tyAgI68zgWTCJDstWqsHhlONWd1zQmBEPelJLZ+P3Rk4UxmZ
         RdG0nng1VL2eWunfJXsFLW9ilKJkPDhccgG4hHOtZO6Cn8snd5Pkc1lrSENqpshqgsdY
         OVK9AxX6gGj39auVsPlLnrOG9iF9UTiBZIR1ipo/OqaTCdSOHpXiNTLHymQtmR6tqDrL
         OVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701678593; x=1702283393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd/ON8ihgg83SHPH1lmOcG0aooT/dzdiqAV5DRlTU9U=;
        b=ZFqZExDHRApw+DTTLHznfkRnRYDrHEj31tNrLNFS9/dHclePmv7ZiLjy/Miq84hC0y
         leFFWnFyilOqso91qalefrbRZiUzu8lUYCiWcQGDsiI1/9PYWhy1VBa0+tn6lO6mu5XY
         rlJCjRYfJYJKs1TfgtyAQhUwoCeEwKLqTL0drxSkdNtsLVVDg0IF4WogAPoVz++O3Mvm
         h99Gz2gZSQl7sStuKaJ0W1xQv4WnkJJMyraXSkkR8KRx2U8byhITuarqjNj/HceKuiT5
         RTsUUQyarSGPuxiy3qK1v/+CH9Exb5UxtTJ+W3VeeolMHJJnSWUEuRSuA/iyz/axy4Ju
         AeoQ==
X-Gm-Message-State: AOJu0Yybrq3uQXaVduAoHSa8LYTPrZ9OOvfmkdkf/Aoh54DIyw5xNmEW
	13TFQTe3+3c8dbYwuD+z2WRLuAgiY31OtKyz
X-Google-Smtp-Source: AGHT+IHGCt/3/6Taz9b2zaiBiJTkwEyqgmHhKlpJpYJBgCsH34pp+9ervGVcCZsuDezi63mbRFHcwA==
X-Received: by 2002:a05:6a20:c906:b0:187:a4df:4e57 with SMTP id gx6-20020a056a20c90600b00187a4df4e57mr2144673pzb.20.1701678593620;
        Mon, 04 Dec 2023 00:29:53 -0800 (PST)
Received: from slave-950XED.. ([101.235.194.17])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a00009200b006ce458995f8sm2177116pfj.173.2023.12.04.00.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:29:53 -0800 (PST)
From: Hyeonjun Ahn <guswns0863@gmail.com>
To: axboe@kernel.dk
Cc: josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	Hyeonjun Ahn <guswns0863@gmail.com>
Subject: [PATCH v2] nbd: limit the number of connections per config
Date: Mon,  4 Dec 2023 17:22:48 +0900
Message-Id: <20231204082247.1940762-1-guswns0863@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately, I encountered some difficulties due to my unfamiliarity with the process while sending the patch mail last month.
Here is the re-submitted patch attached for your consideration.
Best regards, Hyeonjun Ahn.
(last mail: https://groups.google.com/g/syzkaller/c/peuwDOjcCZY/m/pQLVAYP2BgAJ, 
https://lore.kernel.org/all/CACoNggxJiTfTd3BCNbQfySbW=D4jmCPe832cZO1XLhc0=r9C9w@mail.gmail.com)

Add max_connections to prevent out-of-memory in nbd_add_socket.

Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")
Reported-by: Hyeonjun Ahn <guswns0863@gmail.com>
Signed-off-by: Hyeonjun Ahn <guswns0863@gmail.com>
---
 drivers/block/nbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 800f131222fc..69f7fe0d07d6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -162,6 +162,7 @@ static struct dentry *nbd_dbg_dir;
 static unsigned int nbds_max = 16;
 static int max_part = 16;
 static int part_shift;
+static unsigned long max_connections = PAGE_SIZE / sizeof(struct nbd_sock *);
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
@@ -1117,6 +1118,13 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	/* Arg will be cast to int, check it to avoid overflow */
 	if (arg > INT_MAX)
 		return -EINVAL;
+
+	if (config->num_connections >= max_connections) {
+		dev_err(disk_to_dev(nbd->disk),
+			"Number of socket connections exceeded limit.\n");
+		return -ENOMEM;
+	}
+
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
-- 
2.34.1
