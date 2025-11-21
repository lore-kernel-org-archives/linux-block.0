Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBA33F8DE
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713113; cv=none; b=iCncKtgSAhgqZK4Rv4/0ayUYHkhnGTzXHQWe2gWgxzLYFQMiIKEY/6yYE/z1G1HvCaAFGlpw/PrxcPe2fuovoVKmgmbGiT3HzTNN8DRpAbu62lLIomj0UFZK8sjTC498gsrV8HV55O0My1bDMUVuJiR9WBT21hVieD9KV/Fhh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713113; c=relaxed/simple;
	bh=a7LSL2iwilO1NB088738btanTUaCE2U990irg/c2KQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTEK8MoIsD3Hm2ITOlICIWZ27XMWCfMeadWhRYEykslN9G5y1YIKHxvt9c08+7COOcE2fjAUGwM8SIxkUuQVMD3jH0VExM5uMAcfoloe01V7xb5zBdHK+UW8eUDUnp3xlNStX3KHsLy1KSqaHntpExWvOGcVL9dMoWSWQbD/PvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6/aMCwh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6/aMCwh"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b98983baeacso906212a12.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713111; x=1764317911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=;
        b=K6/aMCwhqki8pQbh0ZG/h5mxLbbv5t/ykS0ZBYLq34+/kvwNAKxeDjEevztJ2QvgQ6
         5LJ81Q8Ga51NT11nF/pJ7qXiOzdAhqrWkuuqse9Nx4jmJI6Pz9Y/DqN11FRc1O7k7PXC
         qGybKcugjJT1SM5rIAXw+1xmmyAaMo2/ui3tWph2rZQ4E6sAiimJS6roKUA4w7+sUt74
         W8bTOkT3IlIEPSLuy1+EEooFzEWCFwqPasBAqSl9xlaJ5t5IpG/jTXRWER7m+P6qTU0F
         dKHfnPqhlUBMksbC7heqHJFtBN5CytsFZXiLRK1wAKeehgEexSGv2kMwtjfHwzM7GNrR
         JS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713111; x=1764317911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=;
        b=m9m5vHxFd1J2asXU2l8H7QtwXh0Ngy8vXIHVtUJd2hDWNOqR9+8E0Own13qpT4kpvm
         x+vL9tx1tZNfyqL5EeR3Hlo6hfd+uFvst1vjTnoTu0i8x1aGCmYvWSLtfSoP4dBkFFzM
         gehpMAWWeG6HuYG4ZO5NLXGF4a0QR6SpFXBQwsLTJeSlTzbvCql4lf6z/mNCpm6DjKdv
         +Wf0zz0Pkg1gr6zdHb0GFfpW75Q51dN0m3TRvybUI/3fBVqSknQ6rCXs8mRH1tAQ6DXn
         YaUEjUeNK4h6Wq0a5+VO3GpgWfRkaNgxCE1rGLFF8KSgX92JnlAeJqnHRTA9s/HzL/zh
         H3eQ==
X-Gm-Message-State: AOJu0Yy/epR1FLjFd0F10+gTUonPiAusJB+h9VCAIrVg8ifl7OD/RXY6
	7KCXx7uCIbpom4A8mJhw06MPT6q5OTOfz93UjrV4EmncfuiPc2+96loS
X-Gm-Gg: ASbGncsVXcpILCw/29/TMeyRq4IdWohY0gV1oZSEm793xZSW64HpwIAvxsSwFlDc5sJ
	v3JESaDJSrir9jhSbQDsd6xYuCP8RxoGbNKC7HJnaC6m4iUGzk67ncLk3AYhMPNm7G3nfXiXR7V
	yXLTbXv0FFCT+r9l2pzDId4wB+lcwVC708Cto0L9huV8Qrd0JA7LUcJ/I2/9WHDTT+qnTEHeRt3
	RpqKT/PWB0IKWVSKX6/tp32pJTHc3IpOaMU8taEezGgBaavmMyd9Sesof+fAd26hX4thX8RGAgy
	NNpJgQuuCpXg0oL5veiXbkELBSb/wpJuToWjUxGmReyOxlR9pmDN8qFgJMLWonLqFsiQ54bTeS5
	YhzZcXt831uTXXj0lyWSpKANct1xX/ueIe0/NqpHuvQoAuoPeSdWdje7Rt4FwyTTX7KWAEY9y5Y
	Wg6at5CouALFTpg0s2kAXoreB32g==
X-Google-Smtp-Source: AGHT+IFWgtWuJbeRkMQREJ+GB1+CIl1owO0q1AKLfdba/kSV5Dme/s+uE/AHBWMGMV79yRIBfle0AA==
X-Received: by 2002:a05:7022:628d:b0:11b:9386:8257 with SMTP id a92af1059eb24-11c9d87a334mr448835c88.44.1763713110905;
        Fri, 21 Nov 2025 00:18:30 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:30 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 8/9] nvmet: fix the potential bug and use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:47 +0800
Message-Id: <20251121081748.1443507-9-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

the prev and new may be in the wrong position...

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

