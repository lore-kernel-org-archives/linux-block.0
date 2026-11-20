Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143382;
	b=2t+Yezjn6L2USzaFfFj9JZidLJiIODxO/S3cceawo+OQFsiBQFjGAlkAIt31ASy4c1Am
	 uJsOHRcL6QBGpAi6G7Z6286NOJSZBFoSoJHgZLrTbcZzgjnQ9rUKlgUsBZDb3ma3iW3b6
	 6Hd7cUyqZwKlRTzfY8AsYsroZEPh21fBq7ONRmQRRukDG7bGhmOyWtymKBwXdXSq5Xsf7
	 uUHkx2mwe9Aj4rd9I4P1H8cb6jzkvNSM/gijxX8cGp9aIql9ZhuQ6P3EU3ZsmkoMpJ7li
	 0nz6eZmtShSV24w79rrLOkf2uz/HxLeB32Hm8nEDfQkuspm7xOiuZ9DQiNFokC61LCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Caoanj/q2zuB5Qe0Ofd0VM/ctXIcqUG18uCi126/kHM=;
	b=VGR5fbfZ0scn8dgfTHX6b0cx4Ds3CWlfHJ07l/vtom8ZgNZ9HqALEHONEHCXqyGxPToI
	 t1VP3Wmk/sE239ROm2b2lgOmrIOuU9gz8n9+noPDTwb4knVJJ06cdLpDa7UW7mkYZN5q1
	 ny/x714IgGCszl3NsCTj3iB6byNwtP12rleLBsyymUH58+oa3jKUNPMyI+IsTEw3kBFT8
	 CIOHTVw/FaUfNvOs6CQOMkIk1XnKcCh0GFhQDU+YGSRjFLetVfTXbmXBeFqiBqg2wnMP6
	 CmXTas/jRUuR/ypKf76gsCL78YmjTf0KmiQGo0b8dL5KBUlWrm2y4W+o05t4kw+24eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vp6+Z4c6;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7560A2617
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F7560A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vp6+Z4c6
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2efd7259872so2433445ad.2
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143382; x=1795748182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Caoanj/q2zuB5Qe0Ofd0VM/ctXIcqUG18uCi126/kHM=;
        b=Vp6+Z4c64SIRhY77FfO5UKECB3CnezZ9muL35DU0H9+vcm8Ux/SFrncYAQ6mZ1k5r8
         isETXxblW/89nzT0vNQjr+cyyLW0SHKZbLwRN3TiNFwDeZZUf1W2wEIgxOQ9uN8D8oS9
         Ujcpm7i0/NA35oY14/QimjW8jyOw24CH0+qrH7IM+thdfHQgd8Rr1wYxQQTbjgMmVSEH
         PGGhjTpoQELzPrq5CXZPdzrLzwawJkMbVJYkRH4xHVipHTuJa9q8SpGcYzB8P5B98v4Y
         VpXj8g1wlw4tFuwQLSpxZt8Nmg0whGNrwbTPBIqLxOY//hGGMHdyDP5rePBy8+f5RrQQ
         rCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143382; x=1795748182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Caoanj/q2zuB5Qe0Ofd0VM/ctXIcqUG18uCi126/kHM=;
        b=pFRQWQEBF6/C2bhEoh2fQT7/NDLXzSd1/3sLKHXG1rU+IIu2tCc2Ku4VaYNwWFr2V7
         bdK2IfM3BMYYHgvTU8mvE8DWCuswZDzKD5/VFErb9U31006y/c/hQb6IHfYsUB7tWAbV
         c60QiLGH+e64ExovWs6NHvzWDlEFSKga5hZ2KAQTthdD8kefIwkM1EU56jNun+/UXlus
         5s8jye5c+GI7AswgJGECOj9sF+X6kcxv3RpG124bwJO2QX+4UXCuDw8qobkYkKNvD99X
         eynekZoaPMxx5MdLSasb979cN/gg7AJkW7M/mzgPF+uV4VK3nOby9m++iq4TvWXIDKY9
         nTiw==
X-Gm-Message-State: APuU4Z/k4PuhI/1FPWH8i/hq6V1MtweyNQZwlreR9L0epzJ8n+GOygYl
	s0nCp12/QzRKUkx+Jrk2ZwIAoEEw8BEzfD7k/d4xIC8Mx/Cl0MtKmo/1fYGV38s4x1XrM2LoQPG
	DboOKjPJpYPtqNUNWDVTZIb1HuCeK9Ie6OjMaAhArK4FNNylKGHnMiisYNw==
X-Gm-Gg: AZFdTZdvsfB/huJdSrVkFiUauxo+CwWi8obkWheS5BYdrr/U0UK8WVdHuMOFWSdc1bD
	Fmh3cH63D0Q0RAXwa18q+mM7ka9iEwZ5zRqnGw7TygMAUdj+ABJ4WUjLg9R50RTpfID+sOgdxms
	5GdIaNqCJz5LjL2o30mwQbBlNvyCARR8xQV23NGwiZADDOryYQvTeB044XZl3uglVvP0SpYvF0k
	+JFORmuPYbn07LC4YIHG2k+4jzSBTXrbwnTR6a3Dk/cIBIsizlRT3mwPL4Wz36FPI6MdByWjF5L
	muWb9NMnFmN5RDxJ1FN6FC7LmrCFxVNJc2ZwGehZ5FPb6D6v2u8DFrMRopCqkelTl3TPfZG+q59
	fB1vN0mhiWhMuc8cK3lkrUw7z6uAje8UKN63g8XIvvzONPYLO7t4+Rmh49tynEhgypP8anDpF+5
	bjZGadsaaaLw+qVaT3Nj+cDDX5rcH0TKxyw6arpy3IP6MzKB2DDdGI4VgZxq5shqiIGkz+b3vbq
	WpSiVlyBgZubnlijbyvDcLpan9PY8nv+eqyxTw9FSwSIMhfQsG5hhWpyZxmRVBFJbQLWDE9UKX6
	KKBzBoT3SiZxAPFea+t8mWIEVxXKQqCGrD4Ykg==
X-Received: by 2002:a17:90b:4ad0:b0:3ac:80de:44e8 with SMTP id 98e67ed59e1d1-3b41c933783mr1373568a91.43.1795143381867;
        Thu, 19 Nov 2026 18:56:21 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm5546461a91.8.2026.11.19.18.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:56:21 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v2 4/5] scsi: megaraid_sas: Link tag set debugfs to the controller
Date: Fri, 20 Nov 2026 10:56:03 +0800
Message-ID: <ebe08c3f48026d81fe2af55d5ce8f4743d0c4a39.1795143228.git.lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795143228.git.lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com> <cover.1795143228.git.lei.chen@smartx.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tag set debugfs directory lists the adapter's request queues, but
does not link to the adapter debugfs entries containing its RAID map.

Link the SCSI host tag set to the megaraid_sas/scsi_host<host-no>
debugfs directory after the Fusion adapter debugfs setup succeeds.
Remove the controller link before deleting the adapter directory.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 drivers/scsi/megaraid/megaraid_sas_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_debugfs.c b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
index 81698cd83f5a..12c582e29ea4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_debugfs.c
+++ b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
@@ -150,6 +150,8 @@ megasas_setup_debugfs(struct megasas_instance *instance)
 			debugfs_remove(instance->debugfs_root);
 			return;
 		}
+		blk_mq_tagset_debugfs_link_controller(&instance->host->tag_set,
+						    instance->debugfs_root);
 	}
 
 }
@@ -160,6 +162,7 @@ megasas_setup_debugfs(struct megasas_instance *instance)
  */
 void megasas_destroy_debugfs(struct megasas_instance *instance)
 {
+	blk_mq_tagset_debugfs_unlink_controller(&instance->host->tag_set);
 	debugfs_remove_recursive(instance->debugfs_root);
 }
 
-- 
2.43.0

