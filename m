Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79F2FF65A
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318823; cv=none; b=GH/gLCihU/D8Pb0ifJnTa0TrUcKmVKZs21Erb5pEIG3KFt1l7lKFzx7zv7DLjseK2clVJOJaSIxD2truJUBONiJ9Wm2EfJIr/8yb37cx7Q1NxJLwgPmP55rOjz3Rwumk5XREiWXl/iU+4ic4oH7FznuOWEO/o+ZNHZZmcAEhb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318823; c=relaxed/simple;
	bh=HTuaf3JKiz2KHLk/jbQPL7NkOb05byK6j+tq4J3zrGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFflAwhAaRI7kh5DRGHpoxLVEnO+Yfpi4Ajs6JLE/o5eTnzYYx9ytbj/EEgbzGboFn1+hzwBZfqFDtBsSklIcORzDdiRJe540p3B8sbwdzGq8zlxD6nfvPq+06ddSD2ScByJKgGTd47jyuGk8693y5ou1+rDoKbRL8ykOiinUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTjE6bRE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTjE6bRE"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso1002929a12.3
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318818; x=1764923618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=;
        b=iTjE6bREmVJASqSDl8EFaPBpPk/0T4H/LQbXF3pe7HyptW+mMYa99/LJ8ElLXOMM3F
         Sd1Bb+StN9LTrgQtOJzA6Z8y5oi6xmzg45HAPvfnFx+7OKFhMyj44RqbRm9UkKJoweJy
         bsF1I7MI7UIuCSy11JPccmNBjPR82TIbC3pVXwWKyyzcaAMz9jRUxwSAU9z/POeNlFWI
         EMtBGBCOQdRelgl/DqzIfbJRW4w0G8qWR76cpDznOwZD2usTxkCnrWWfCkyCLcI3LbJb
         jI0DV8r8w2K4Q06tnvQKwq4aJEa4N6MXeLCER59iAVqSwHrVlaUpfJsJSLc2Ihsc9loy
         ramQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318818; x=1764923618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=;
        b=hm/XwnVRt+Qsm6/8BIVqzLRjuvonu4u1H2xfMy9z1gzPCRmM26kfZt8+sjk64uDncr
         67q6AIz7C1M7KdLLFfMnwRQ2iNTld6HM61isjKhRFfIw0k2a2a326m+3GJU1G7ulyZZu
         LX9q+gbtbR9EJMRmFVhxSmwcPJSNoF4CH7wOG8mUUaGJYBO3ucAYLkWgOOC5m5XRg08E
         SmOHCeS6GKAmwrvS4oh8iv8xxwdXg8H3+adMrxHVcSygM7AP8cKd11DQkcNqBBMR1j+X
         INCl+nVu0aNLn/unyRs6z+Jq0IIxy+Yt3RC5d4i/jNZS7FoGmsRleEO5BJxRcEEoSdzA
         tYSQ==
X-Gm-Message-State: AOJu0YxwtOEELwz4K0mTeLRNgvyiwbjA6+CIH2pSJrYISXdMtsYmkTZY
	fASQXQtXPu0H7kyjPRvRnse1NN2cpJ3UNphxaxyxUbjgqyIv0RlVDpQP
X-Gm-Gg: ASbGncsn21VJ3C9gVo3vSLLy5TUf2J8vXa0jR5TQUjF3ZnjjH3/yBwQ2wEnOFfpqnk2
	y10JlDPhFX4FuAYx2pDNvS5e1dwRkhF4+NAnoEFnCdomc++g5Hars/DxZ+q7EQYC2AqFofooL4n
	XOw8c7t5rQ1U7gPygTST9NwJWiz8Pa1IbD87nRgg8INHav1eoM9INHr/nkG/qe7K5q3Iv40Lxe+
	J52Vv3dwqma/rIhV6SJescSmdcv1S47/OdN9tU19enUvAoboJQLEhijKqmYUVTksz4/KyLwUAiU
	gvszXuDjVgGi0PnrxEyNgzRHGH/v27LnDhhYeWS/7xTr59hESE4qyWxW9oBMMHD5uVmx02czvg6
	N85iEvrlRgmxRaeHRXTG/ftKlfzKgNHgrLW5zKbEkZJuyxJMPRKOQKJBU2jAim1YspNe/VluWxi
	5m7TGfBd2AWlLEpCmjeAb0P1wr+A==
X-Google-Smtp-Source: AGHT+IEiYKFOm1UmbHzu9Io+L0ipF/pftCo6ih2XEqCkxPLrZNrFMt6HrxgMvpe9BJ/P01XRe5CPUg==
X-Received: by 2002:a05:7301:162a:b0:2a4:3593:ddd7 with SMTP id 5a478bee46e88-2a71953bfaamr12018765eec.4.1764318818087;
        Fri, 28 Nov 2025 00:33:38 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:37 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
Date: Fri, 28 Nov 2025 16:32:19 +0800
Message-Id: <20251128083219.2332407-13-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Replace repetitive bio chaining patterns with bio_chain_and_submit.
Note that while the parameter order (prev vs new) differs from the
original code, the chaining order does not affect bio chain
functionality.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca60..4af45659bd2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
-			bio_chain(bio, prev);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 
 		sector += sg->length >> 9;
-- 
2.34.1

