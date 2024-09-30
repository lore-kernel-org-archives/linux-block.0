Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DFC18E75F;
	Mon, 30 Sep 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695891; cv=none; b=P9v+zcubvCk4kvhLq2ZiGPhZ+pu7Eg7n+6hueetMP6iDe/7n2dI8Vn94SKYIoAbVRQ/6rspKgtRU8UAUGlr9zsqY0Glw4U9eUY8eUJNy5bd8Wtd6gyOde3x5leBeO3PxlWt43RpltEfSXU1Cf4BqRT0/RU5Yvdrai4ZXYFy47MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695891; c=relaxed/simple;
	bh=vIZUmOhkctrpxNjE/bq31Se+xRGgI8VKyz9uNEv0GsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ibgvoj8/E5Od4nNaSvj94T/SDh854Awhg6ZZZv6uvEzgeLpdkJrj5avK8weLVhZsDjXu0NqwrpjmQSwSJ8YkAZc5vIEXWUezKBoO+fEO7SoYz6uOTYgfJAfKbS9HiRXQ2mSrwREq96eZv2C9FU1nNpSukuMYuMiMj6MWplgnysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMFhT0Dj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMFhT0Dj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ccfada422so2182403f8f.2;
        Mon, 30 Sep 2024 04:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695888; x=1728300688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=kMFhT0DjXKwlwSbR/Azjgv4oU26ytUskdfREhpyzdOLM8HzGCk123Ztqm1wgZYzjft
         /ndOYUPBJj8sDxDct2qiUkiAbK4yVqBbPpx6yyyoIVNpqw7SX+AuPL4Eax7gC1NRdHDt
         FMq0QlZTFiycnTTW6jdRb0blOO58SqZeVBTdgyg4GmRHqn4zieUGABR9ZGg2N8UUJDGq
         KKfb+CJT84CwM+b+b2LfXvK5AxBrawDhSeUEExC7dEJwRxg6XQGjt8n1ghNFt1tu/9Ny
         TXlaU0LmMUXbZo29bozLftiL1rFEFK3oB1zMRMhkMX4zN7SDp76uY0EpYNx1qALb84Gg
         krtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695888; x=1728300688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=r8dbXECdZoHgWaSpQ6mvue3FZdTH+m9F2PT8LMQORO2j38yjCqImKPgFlipn2REHs2
         Az/NHd4qUCamvD3uHmBEs5jCPw/CXaC+g89/dUA81uIGAAjiqFxhsUut/765Mq7BCAhw
         idE9xaR+j1ZZy3nS6vkAL5mkxHYME3BiQB5bpQyuagIJ7Hv+YHJ6hK74H6O43JOazhAG
         eVTgNxWtQlV1Brw5uJAr4jtVwtsJfZFCxpXVvghpD+7YXIa0MNLn3AR+7TjpfW+B+PUo
         BVY5UrQ9XZMYNVAj4DfbGMX160VCuXwy7bKUdnBJsbbyF7DCbUSesrcP1QmDM/RGN6w5
         ZVkw==
X-Forwarded-Encrypted: i=1; AJvYcCUOQ/YOqAXbrzAlCvFpsmDMSvUNoyJX3XkMjO4apWwZXv6QGHDUoZYfa4OXNnOS14pv+h4ORKqTMzQG@vger.kernel.org, AJvYcCUUG4ifDISd+83ZXodkabcfY8/R7srSw9zlT2aYTGMjWJLBP7a474hnTieaYKtTsf3YxAPFpyN1VEt3@vger.kernel.org, AJvYcCUXRE4jM7moSQ30gOwsPFFxkLm766EwjaSLf0p2DYXmZ+Vk8BtqxPKkIfkyi+wPFdEa8y8OA4PLBh29@vger.kernel.org, AJvYcCWuGiOwP3cHg0vxA0LTHs4wv1oc6zvc4tzUgW9LFMa19kl1adCQC32jCvJI54MVVXBwS/SFBQqwZe5lOng=@vger.kernel.org, AJvYcCXO7RUY04RdHBUaL4XDo4K8Vz+NWAQZxrZc/cJmFTXjn9ObFHHmwvx45Y5RhTRtdBSVpSY5iuup88Z/eqXQ@vger.kernel.org, AJvYcCXWdYJaMrFBEtfSnz3PBYeq0QAB+KnZkpr4a3V1/F9ltOUdMde8HnFWdY9gB7cHeqgmmRMcCpZmTXJvTyCQIaB5@vger.kernel.org
X-Gm-Message-State: AOJu0YxqV5UeuESpw4Llh/wNYpiDy9Uzh36XPJUx8PDpyIBp6icJVEqu
	VwoVsisT1aTsIM8vvJjO/toZZyCgikHLIvuuTGs0ESNZQ7JpeDn5
X-Google-Smtp-Source: AGHT+IF9WsH8NhMVUflWW6Q3l/hIjgZVoJvdNgq/QcLbG4GjJGrw9atHk9fPnPJRYuLBLHD7vOmpNg==
X-Received: by 2002:a5d:5052:0:b0:37c:d537:9dc0 with SMTP id ffacd0b85a97d-37cd5a6bf42mr7699742f8f.12.1727695887712;
        Mon, 30 Sep 2024 04:31:27 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427c6sm8889363f8f.96.2024.09.30.04.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:31:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 1/5] block: add support for defining read-only partitions
Date: Mon, 30 Sep 2024 13:30:08 +0200
Message-ID: <20240930113045.28616-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930113045.28616-1-ansuelsmth@gmail.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for defining read-only partitions and complete support for
it in the cmdline partition parser as the additional "ro" after a
partition is scanned but never actually applied.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h                | 1 +
 block/partitions/cmdline.c | 3 +++
 block/partitions/core.c    | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index c718e4291db0..f300212d3e98 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -558,6 +558,7 @@ void blk_free_ext_minor(unsigned int minor);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
+#define ADDPART_FLAG_READONLY	4
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 int bdev_del_partition(struct gendisk *disk, int partno);
diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 152c85df92b2..da3e719d8e51 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -237,6 +237,9 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
 	put_partition(state, slot, subpart->from >> 9,
 		      subpart->size >> 9);
 
+	if (subpart->flags & PF_RDONLY)
+		state->parts[slot].flags |= ADDPART_FLAG_READONLY;
+
 	info = &state->parts[slot].info;
 
 	strscpy(info->volname, subpart->name, sizeof(info->volname));
diff --git a/block/partitions/core.c b/block/partitions/core.c
index ab76e64f0f6c..abad6c83db8f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -373,6 +373,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 			goto out_del;
 	}
 
+	if (flags & ADDPART_FLAG_READONLY)
+		bdev_set_flag(bdev, BD_READ_ONLY);
+
 	/* everything is up and running, commence */
 	err = xa_insert(&disk->part_tbl, partno, bdev, GFP_KERNEL);
 	if (err)
-- 
2.45.2

