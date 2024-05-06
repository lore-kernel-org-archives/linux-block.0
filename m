Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E11448FA
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982367; cv=none; b=o4UGThhHP7d4WqW7Bk3D2GLtHs0/R0vl+IwIsDWFLvtLgKyCTjjHMXPooiIimNshvszySrYn9+vE433OzrDRK4QboJUJeVyWpgmhlnBETt1HeS5wM9t9luCa4xT+4iZxLxX8ETXPhRwdqXT5RZyRlGJh3vtdsE0XZLSnxi0iaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982367; c=relaxed/simple;
	bh=0QKD/VRLqE4UJhTMThwx4W0GPaxzgatlvvK+3EE9Gd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzVoeSy/W6fsfQOKHGkDapZmGnAkJ9cOTVv+7MeyCW6gRjUFEllqszc+WjboaLHLmMoHuLSmit1r+ezYRfXbJQMPl3A1qTBVj4FZta5VIJgjFXndF/7CR0GMWJm4NkrFDfU91rFAAAIGsh6pvZcOsBa2J3RX3G9378B4Yk2zw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HNK33Wdi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HNK33Wdi"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec486198b6so11724765ad.1
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982366; x=1715587166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow2rUHFnrcYhlTotFbBj4Gwxyq4hSnuB9nn9e+mMxIY=;
        b=HNK33WdiJNKGrbAzcZCJfzRSc2z/Ri2zshCOD6DA24APChdR3JA0J5CAzCO7q1SU87
         PUfREEHBg1dSMqwo1vbGueiEI+jU798eebatD2M/LbL2cTIp/61JNGN0+ycnumaFZHfX
         mQ1cPkJlCyCjPahkp/6LsvqX+18eBNHB3+oxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982366; x=1715587166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow2rUHFnrcYhlTotFbBj4Gwxyq4hSnuB9nn9e+mMxIY=;
        b=GE6xD87ZPngGHWyt8O5+LK9zwk1N35/9jzyHB544S6Y2BbUW6kifhg/pMNlaEH1OEW
         xA+bJcNTexpRU3VffMtGEVOvJc+ufXSxxUjmA4BMh4M/ksxbSZzP67KMN+X1HNZiYgjd
         qbOk4lpkedjrFQgUac6vp8Q65qz+3sbN6SGW8LkYdRvsbeSX1pq8C4ZLQ2gyuRg9e8zg
         msYJViw0jDQN0QhEJ0Fyk7uebDJsP0XlmWCyM3RM/eZfHWcblUO2xT2l+9+EnWhqbPt2
         cxLhc8IgPdmeYgZdXTyWfY5dZetRP7YjlmaEjfgX0iR8gC5X2qIZgzkhAqAk1FjKMAd/
         enng==
X-Forwarded-Encrypted: i=1; AJvYcCU7A1fU1DJ/uyUROpI5kliuiWWZ+9s9yJH0uYs4BgDYzubw7H4w7aCl+Um6F+N1HhWODPYtgWrXaUAqUlgwEOk46g+BNqq2udZhtHI=
X-Gm-Message-State: AOJu0YxFYZVAo44VmiPew/MjMC8tlDz0AaCXwyZ0m9uzE/b4HUuGZStb
	kTiZMW+LTVYfJqiyMd+h1sSPB8D9bPafyHczkheRy1klac4nf+blXEUWPcrrqw==
X-Google-Smtp-Source: AGHT+IGtD6df0LGz8qgNCcFIQycCbTSE1kkQVyBBaYoc1cmb4rEblCnjBd4Fq0l6WUO2JRvfpM/M5A==
X-Received: by 2002:a17:902:e749:b0:1e3:cf2b:7151 with SMTP id p9-20020a170902e74900b001e3cf2b7151mr12883681plf.59.1714982365968;
        Mon, 06 May 2024 00:59:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 17/17] Documentation/zram: add documentation for algorithm parameters
Date: Mon,  6 May 2024 16:58:30 +0900
Message-ID: <20240506075834.302472-18-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document brief description of compression algorithms' parameters:
compression level and pre-trained dictionary.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 38 ++++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 091e8bb38887..58d79f9099e3 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -102,15 +102,26 @@ Examples::
 	#select lzo compression algorithm
 	echo lzo > /sys/block/zram0/comp_algorithm
 
-For the time being, the `comp_algorithm` content does not necessarily
-show every compression algorithm supported by the kernel. We keep this
-list primarily to simplify device configuration and one can configure
-a new device with a compression algorithm that is not listed in
-`comp_algorithm`. The thing is that, internally, ZRAM uses Crypto API
-and, if some of the algorithms were built as modules, it's impossible
-to list all of them using, for instance, /proc/crypto or any other
-method. This, however, has an advantage of permitting the usage of
-custom crypto compression modules (implementing S/W or H/W compression).
+For the time being, the `comp_algorithm` content shows only compression
+algorithms that are supported by zram.
+
+It is also possible to pass algorithm specific configuration parameters::
+
+	#set compression level to 8
+	echo "zstd level=8" > /sys/block/zram0/comp_algorithm
+
+Note that `comp_algorithm` also supports `algo=name` format::
+
+	#set compression level to 8
+	echo "algo=zstd level=8" > /sys/block/zram0/comp_algorithm
+
+Certain compression algorithms support pre-trained dictionaries, which
+significantly change algorithms' characteristics. In order to configure
+compression algorithm to use external pre-trained dictionary, pass full
+path to the dictionary along with other parameters::
+
+	#pass path to pre-trained dictionary
+	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zram0/comp_algorithm
 
 4) Set Disksize
 ===============
@@ -442,6 +453,15 @@ configuration:::
 	#select deflate recompression algorithm, priority 2
 	echo "algo=deflate priority=2" > /sys/block/zramX/recomp_algorithm
 
+The `recomp_algorithm` also supports algorithm configuration parameters, e.g.
+compression level and pre-trained dircionary::
+
+	#pass compression level
+	echo "algo=zstd level=8" > /sys/block/zramX/recomp_algorithm
+
+	#pass path to pre-trained dictionary
+	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zramX/recomp_algorithm
+
 Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
 which controls recompression.
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

