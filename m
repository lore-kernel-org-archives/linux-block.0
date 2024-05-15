Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EB4AECA
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757464; cv=none; b=maKWos3bCQNoceWpOLXmfaYBkgbzsSbqxF//zr3ibie+YmLS8T2wSLFywVSzohM2iLy0wsyERxfWzupM0AQM6e3UGHa7ka579NL/ejTGs/3CbTqrJXlpg2TRusjqiDQUzYq6TPBkHXIu/XUDjmdBBkdvuHBM9vfqc0npfnyo0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757464; c=relaxed/simple;
	bh=vwOiFI5WYyrjHytmKrfcWdUOay50C5Amcx9THlRsWqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyhfop7tvfpvZpowVdbMpidzqELghpLXem+G+ncL4B8v+849V/zS+wnnQobSVWN6swXUOin2a3L7ScBRUftBOcqQMDTu7Da+5foQ1jF39LsDTc+ZVUiwzZgUiWug7jLdauwcegUNHFGJtSUyDoC0iBOZ6VLo0wZJc9g9cZIw1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bTXAM2h+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTXAM2h+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f05b669b6cso36651885ad.3
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757462; x=1716362262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWMx/siR7FY9UCYUHf6j2VRPjDt1sZ3YrZXGDzQRlXs=;
        b=bTXAM2h+GhS9bRINMcGOldAw3OpEZEMGRHDRC1FifNDeNhfo3OJYmzpJGHaWJ8Ksei
         Hu6WsJeiWQjcqMkIPGu2YoDWPxzcytREKOZun2lRdj/zdNs+5ZWnjI27UPhX+RGjon0H
         X3vaF7/4KDKSRsiBa9CDkRHtUT8I5PcTnLyL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757462; x=1716362262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWMx/siR7FY9UCYUHf6j2VRPjDt1sZ3YrZXGDzQRlXs=;
        b=IVJ8JqZDG9B7qC7RegnTgh4/VuTK+cz4fRZG2nB9LInTEdv9+c+RHFeQDmYdcAScRc
         4APaYQEtp/PrU9YDXQc/ysQOPvUETu3+yDova8YHgc4jZHXl23XumVdYLqmfEWJaKCqd
         /8jk/ASDcUD3l+zxy1hEP7lX8GPnPipWvbpwB+I7Dtv3n7zC8BHOz6n8yo4djObtauEd
         StvZcb23gmS+5pim2agGUKD4cBh3ah2g8sES8eMt6KqKhkDadMh9vO4T63OmkgADc+Qu
         GZjZzsG58qiW84lrPw+Lfg3vTL32c1Du3Dk1pafyyCJned8z2JrZYoWsXArUFQfTwpfv
         HufQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPC88dB8c9b52jXOSi043qFY7SE5FffPFBT3h376pHibbVR8CppoS+E6/q8L8LbNDwyuH18OmQJoDU6X0lTw9ml88L3TaZfSQBppI=
X-Gm-Message-State: AOJu0Yz3iAByO08IQCtrP/27fGIjQvfTetAS/mTkQsgPr40Miu3Bnzqf
	7W7vQf08Q0ZGMrwRnETcSmnoPIqt2ftEhLG+pA3syTHsRH3FMz/kXM8EAijhVA==
X-Google-Smtp-Source: AGHT+IEAZvvWI3L3dp2OnVta0kR0smXesfqE4//K2Eg9tSM/PQOb96+KhvywxjLh/WRSanjCEV8rcw==
X-Received: by 2002:a17:903:1209:b0:1eb:6477:f2e3 with SMTP id d9443c01a7336-1ef44049595mr180248885ad.49.1715757462340;
        Wed, 15 May 2024 00:17:42 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:42 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCHv4 19/21] lib/lz4hc: export LZ4_resetStreamHC symbol
Date: Wed, 15 May 2024 16:12:56 +0900
Message-ID: <20240515071645.1788128-20-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This symbol is needed to enable lz4hc dictionary support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Nick Terrell <terrelln@fb.com>
---
 lib/lz4/lz4hc_compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index e7ac8694b797..bc45594ad2a8 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -621,6 +621,7 @@ void LZ4_resetStreamHC(LZ4_streamHC_t *LZ4_streamHCPtr, int compressionLevel)
 	LZ4_streamHCPtr->internal_donotuse.base = NULL;
 	LZ4_streamHCPtr->internal_donotuse.compressionLevel = (unsigned int)compressionLevel;
 }
+EXPORT_SYMBOL(LZ4_resetStreamHC);
 
 int LZ4_loadDictHC(LZ4_streamHC_t *LZ4_streamHCPtr,
 	const char *dictionary,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

