Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289758;
	b=dOQwmWh01mR95Ve7bvOsEnSP7GF6NdvS1xVj5svrYBYDIzwM0RzXmBL+8LGEFLMsjMY7
	 FqeQ7kyIUFeFQ54ylGgePBkUTRG0k7FCHImNfgEXdYDPcmMtBwoWXy4eJs+ehg2uis3zV
	 zgQB7vPS5pwnmrC03TMMdsjM2ztIkadBJzV6B7Iy4g0Bzgrt65S4ck6WN1mEcpDRhImVV
	 eZlnG0s2p3l5A41G1B4H60Ivk6b9BC0FVv62ZPWK5GNroKzt8nZZuwnZcliFb8ohu/I+m
	 hu5uzVd8Lax/u8DT+3SVTuT3RNJIMP+TSejcwV3AGsgn10DZkZ7X6YHDDU2rB3kyS9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lrmi2+lOFJxXdkix+UX3wdRa3hyeMQKr15+9Sj7OH3M=;
	b=Fv26wxBki7K5qQg3SWZwxHVmtDGNClmaY+nTvcFZnCJH0S7rcBHWFbfiiXiRt6IMLeU5
	 kxWmhSpTqcS7k7AJV7LC+pksgdkaOWJ+Td+rFWSAl/2ym+/VOVejyCrd4zOVj8WaN7L15
	 K0ucEXL4hpSSmMM52WzIDjlX/8p85J1C9bwr73HT9gQASwAQgXEk7LsWL8buXctZdsa64
	 Kwoj4GO9LqnwQHH4bBLSmj7fOkq5iF71p//vnNpYNSX6iRYCPTnLV8UTIGJW0xWqGiFt6
	 7zYCJFTzNaqckYJL70j3dOJZI4h2iT0WXRqNo0d9AL8EkINTvhW2NuwLQtYqh8CEP5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Bqgg+k0f;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B219606A335
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B219606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Bqgg+k0f
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e940d5d2beso6260345ad.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289757; x=1794894557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrmi2+lOFJxXdkix+UX3wdRa3hyeMQKr15+9Sj7OH3M=;
        b=Bqgg+k0fTTa+pKyiYCST8SEKagAEW+44pMFRbd4swH8xMqrb9rwqpBMFvtyyvpTSPQ
         JE863d2xzK182cvcqLpp/6ub1kQ1Zhn33Iy45nFeJ5Aa6lTffP8D0DxLgHCumOmm4Skr
         j201polbUzLzWnbelffldwAjBud6vhJnOXSVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289757; x=1794894557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrmi2+lOFJxXdkix+UX3wdRa3hyeMQKr15+9Sj7OH3M=;
        b=anxT9zbT93Mp0dk6Fcx+bdVeK50E6j9gL+DT+tSNxqMsOAwxZqKIG4436729mduG78
         SAKoMc0CwZERgmeY/96QEflzUEEVCcIPHC2v/hosO9T2zZmHTHd9c1lyGzVGdk4ErGVQ
         EwlZBRq8lqM5TGc3iB759zZqc9Y/SlWHF+Qeandi6TxKGrap6BT2QKuR3778nj584Ryd
         mDEMDXHDBQTlwLvmXpiH6+3224/wsLcX9qtUiJX/LAGhSiYWcJgQI1xamW0LQ6lsXDaM
         OE3srbM7jZSoJYAf9LwZmkW8EjzBqcOXNN/0zo3DMqiMilGmTgXfFkqip2sQHg9kS92w
         vmEA==
X-Forwarded-Encrypted: i=1; AL+hErFSYAwy8/rllqYqP6lw3iYhr0Gl5GYnKc9NTAY1e7uy2KdUVRLvRc7aLhgEW3hfO3XyOSS2i+56MuKQgw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7zIkazdiLCs1Hr7hRf2hWtfQ9BsWbGwFylmU54Dy9j8OsNMJt
	rgSA6fu/lTHUHqeINF8HzYta8D+RZ3EfCBbh0l5zsZ15SyLEMOSMhBJNG9eP/Gcaww==
X-Gm-Gg: AYBFou3c7uK0btIf3r29JYBRZeLPLGeuwm+2f2y2GIVeHlez8znbrL52d4Pker7kY89
	hPuWuR1grw7073ln2rkGGJNXoIdI7LaPH4pdXZbkqNdPkPMWQ64EERR83sL9a29qupxDkZ2rEcC
	9bDlvMHBzxGLrOwA2EOHL/XBT2Z69WSh0+Al0ky4Rwy3bEtoJZMsmcxx4SUnMgrq+61r8wJxe36
	ASMnJ3B9kpx5cijJcPvF4g9s4sZ/AGFoJ4O8JySMa44orq3ITNgz0vHLxOgHgccILqo01QYE3GM
	gIE+IvpIAAihQqpUB58PEcPDgBlE8Qabxe0O5LFVBcK8srsFFi2Q+NEXFbpjNKss6MFa/JD7jUp
	XBglNnt1PEOYcCyFPd2uz9wbEz1l3OZu1ro+b8tCyFaSsekoznJB8F0hvkLZNnLjzO2Q/Mh+lTW
	ZaNV/4IEV1il1t+5FrPRgd3pAvCqYijTazeo3cZsiVNnZaYST9JJlj4Hh1uC0gxYmmQ0wQUtLI+
	wDi8dMLSx3uF6E85u4SvKgucUjPePo8F0RqFe8R7qO59bTD4iPVObuv/iuyvKhpAyE+AI5ZANh6
	xkm47+l7TRbLW9O1Xg5V41oPNYgWhrbjGXOYl1q/tUOIXdOydzq/PCodNNJosNIAi7K74lRuEaj
	44oQUTblT1MrSKFSlbw==
X-Received: by 2002:a17:902:ccc4:b0:2dd:c0ff:e72c with SMTP id d9443c01a7336-2edb93179ffmr13147715ad.62.1794289757474;
        Mon, 09 Nov 2026 21:49:17 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:49:16 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 11/11] zsmalloc: populate new zspage outside class->lock in zs_store()
Date: Tue, 10 Nov 2026 14:48:16 +0900
Message-ID: <20261110054836.1515030-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261110054836.1515030-1-senozhatsky@chromium.org>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
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

A new zspage is not on class fullness lists and is not movable until
zs_store() calls insert_zspage() and SetZsPageMovable(), so neither
other zs_store() callers nor compaction and page migration can see it.
Nobody else has the handle yet either.

So for a new zspage allocate the object and copy the data before we
take class->lock, and don't take zspage read lock.  This makes
class->lock critical section shorter and saves a zspage lock/unlock.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 09ce8c294c5e..2f4adbae82a5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1319,8 +1319,12 @@ int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		class_stat_add(class, ZS_OBJS_INUSE, 1);
+		zspage_read_lock(zspage);
+		spin_unlock(&class->lock);
 
-		goto out;
+		obj_write(class, zspage, obj, src, size);
+		zspage_read_unlock(zspage);
+		return 0;
 	}
 
 	spin_unlock(&class->lock);
@@ -1329,8 +1333,15 @@ int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
 	if (!zspage)
 		return -ENOMEM;
 
-	spin_lock(&class->lock);
+	/*
+	 * New zspage is not in class->fullness_list or movable yet, so we
+	 * can allocate the object and copy data before taking class->lock
+	 * and without zspage_read_lock().
+	 */
 	obj = obj_malloc(pool, zspage, handle);
+	obj_write(class, zspage, obj, src, size);
+
+	spin_lock(&class->lock);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
@@ -1339,13 +1350,8 @@ int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
-out:
-	zspage_read_lock(zspage);
 	spin_unlock(&class->lock);
 
-	obj_write(class, zspage, obj, src, size);
-	zspage_read_unlock(zspage);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(zs_store);
-- 
2.56.0.506.g506a7eabc5-goog

