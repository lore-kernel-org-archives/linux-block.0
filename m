Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="caREJv3q"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB44B0
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 13:47:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d348653591so4464425ad.1
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702417665; x=1703022465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGmY1Uvusz9KRM1ewzjAcFGoyvGtvutXac/XpSMvAOA=;
        b=caREJv3qFPyKTE3hXh33HZswLmCRKzRyqUZkaXZbBkVmLcuxWYm5g+UE6fCVS1miui
         xDJdJLZtIPDCeOw2CRq1brq1uQdOjb8Qtb1vn1t2ZTM1F+zUP8rc44VhxhOa6n5fTJVu
         8M31H4XOfBFfJDhNrgxEuJFBIeeH7eu0gG8WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417665; x=1703022465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGmY1Uvusz9KRM1ewzjAcFGoyvGtvutXac/XpSMvAOA=;
        b=Y4U3W9QSs/ZsgUyaNRN0Oz529FVgTy0O1jOzQWC1/70z5YhDpAm95FMpbJHSNJuwyh
         nFUpumATlswILz0HUorpQ1kyNThmHYsvVVtfceo1mdeamv5uufJFYFwVuUySwg1mjjhr
         h/Pw6qNrAh0EC6vIfX/oWynGMFIJyu5GdHkVAUipn16W+DkBqrqjWEM9J1KaqDy7TuJk
         eAIKDJ7uMCrLda3kXvd1V/9fYdJd9HLpOvzic4uOLrfavx3M9n4HS7PvVSNUX8a1A825
         n8Go2wAiCbdUgeB+E+UosVK3P4u+27qEFIaUJcLuUbl6z7YiJSKyPvvh/dwvYwfy08gL
         RFZA==
X-Gm-Message-State: AOJu0Yz+RPsQLHMqV0GSJ48z6jXbOhw7AuV/jDra8supQmUTQhpRI7cB
	YlcKN8U8iZoQL8yyhOQl6Ky4lQ==
X-Google-Smtp-Source: AGHT+IE61nVVxmRTcPG4VnpIimwru4O29PFp3Lw+eViuTU60sOFywAgCOIn3AH6tjTVblBEJ+C+GXA==
X-Received: by 2002:a17:903:28c:b0:1d3:2a94:cb4f with SMTP id j12-20020a170903028c00b001d32a94cb4fmr4090795plr.56.1702417665346;
        Tue, 12 Dec 2023 13:47:45 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902bb8200b001c62b9a51a4sm9047963pls.239.2023.12.12.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:47:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] block/rnbd-srv: Check for unlikely string overflow
Date: Tue, 12 Dec 2023 13:47:42 -0800
Message-Id: <20231212214738.work.169-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054; i=keescook@chromium.org;
 h=from:subject:message-id; bh=/mi3nc0g4oRgX5N+DxHSOijZJP8DaKE9s4ZcfEAmc4A=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleNT+/+fQJv8lD/CzfZ+wBFsIWTKuuP6Ea0qKz
 lTeGvIjCMqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXjU/gAKCRCJcvTf3G3A
 JgA+D/4iqIh/WEw2wL1eibi6OzbrGUOQTWd4ba9CTzyJ92esQQBSmozPvfzLFGV2UXj1OrKpEmH
 AMtBgNeaaA49Ug8x0M4g+fyZkvJEssUE6+9jB9ZNelIdig7FRZwcrIrz6+T/hJM/KMFTuRVsSvJ
 ldT2r11YMrPuxzk9+GRn0QlZLvKtZ+HyW4LAql58XrsGKUtwE/0AUSDhnyE4ehih+2/cDb8mSIT
 RgMqSW8ItO/+yvawzZoijSkXhKliUga/AwRxq9Xky8mML6up32c7adVodyE6g64g98TfQmpl3RN
 442LKZUr1e1YLpXA4WGRReuOzB455vMhsYcwZFrFXA/CnmGBSf7JknovE6JpPxF4xFqk1uxIJS8
 /sZg1XlURnnmbMAna+VCwNaIcq+cwfxrX9nz3YFseA9aS+vjfG8ZGa6/Vasti5D0Mv//ylrQd7m
 Q96mW9Dr/L3zo6Wy56e/w35rOsObQK1fA+omKvNaYb+1wrwlC76hjtZLYpsA7UwGWz5+Upjyuxn
 NcBjg+MGB5zPph5Is914gk6mOcb5LoMBbnf6e9T6TEcStcBNjax4SfLSU0kaa+IPdNpIZ5vtH7L
 HqApoH2gXrCiag0vHQCMCdS16bVXMgRM4XWt/qL1M//Y7ty8r5DHq7Wh+iSxREGhBZJd9eWRXmK
 8h1PKYy 3SmBCBQw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since "dev_search_path" can technically be as large as PATH_MAX,
there was a risk of truncation when copying it and a second string
into "full_path" since it was also PATH_MAX sized. The W=1 builds were
reporting this warning:

drivers/block/rnbd/rnbd-srv.c: In function 'process_msg_open.isra':
drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output may be truncated writing up to 254 bytes into a region of size between 0 and 4095 [-Wformat-truncation=]
  616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
      |                                                   ^~
In function 'rnbd_srv_get_full_path',
    inlined from 'process_msg_open.isra' at drivers/block/rnbd/rnbd-srv.c:721:14: drivers/block/rnbd/rnbd-srv.c:616:17: note: 'snprintf' output between 2 and 4351 bytes into a destination of size 4096
  616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  617 |                          dev_search_path, dev_name);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~

To fix this, unconditionally check for truncation (as was already done
for the case where "%SESSNAME%" was present).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312100355.lHoJPgKy-lkp@intel.com/
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/rnbd/rnbd-srv.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 65de51f3dfd9..ab78eab97d98 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -585,6 +585,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 {
 	char *full_path;
 	char *a, *b;
+	int len;
 
 	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!full_path)
@@ -596,19 +597,19 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	 */
 	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
 	if (a) {
-		int len = a - dev_search_path;
+		len = a - dev_search_path;
 
 		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
 			       dev_search_path, srv_sess->sessname, dev_name);
-		if (len >= PATH_MAX) {
-			pr_err("Too long path: %s, %s, %s\n",
-			       dev_search_path, srv_sess->sessname, dev_name);
-			kfree(full_path);
-			return ERR_PTR(-EINVAL);
-		}
 	} else {
-		snprintf(full_path, PATH_MAX, "%s/%s",
-			 dev_search_path, dev_name);
+		len = snprintf(full_path, PATH_MAX, "%s/%s",
+			       dev_search_path, dev_name);
+	}
+	if (len >= PATH_MAX) {
+		pr_err("Too long path: %s, %s, %s\n",
+		       dev_search_path, srv_sess->sessname, dev_name);
+		kfree(full_path);
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* eliminitate duplicated slashes */
-- 
2.34.1

