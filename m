Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5D2F9D98
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879537; cv=none; b=bORV+mcXjj0dB7Q0ZIfpZJy1ScAi6Dq49BhxrAeW9tqP0eDyjpvcPE1WwzifQFZsuLDjyFqkt5Wz7n0lmABfWH5v61/+4VgEi5j8MM4ejKHletu1YiFQa0QrlNOCHGOl7WQEXw5ss0HvqFF0I9as3RomD0HVdaOU1F2dFyOM8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879537; c=relaxed/simple;
	bh=3bp/LCOqYEbRe+qVTz+riFkXNQZIoegdbIbWRYYJrsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUtbiKstgWWk+HdOdcHcTiFKCyO+nfxb2vTXgSjKlBUAqCg/pRvSUsy9mZgQL5QjkfaY5EV3PhPp04VL9BAkgsM3R/C0t1EEaBQdhaLzEOLAPL94TmleF43AqDDhhQqoRMH1cCo1eP4qiBUJNhZVm2BoDh3m2AlrduqEoAtPO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Helv8oCr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Helv8oCr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceaf8a1265so1995335ad.2
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 00:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784879534; x=1785484334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3UTPDAS4LL2M4zgcjNoNg9Cb0YaXjfr58AH5VykXMLw=;
        b=Helv8oCrp3zrTh1g9ve1dHZ77u9FWJDuZ5eIaRIoEcm+SL+Q+ff48uhfA4Xrt/meRv
         7reqCveRkw7Zo+AtLrU9lx6Z9vqxNI1Qui3K2OJNRD3YpIhtRuaym7Oo5CbGud7jEH+q
         WzVIJzfmxWIEYg3vAuPl8Bj0CZVg2IjyHzZmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784879534; x=1785484334;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UTPDAS4LL2M4zgcjNoNg9Cb0YaXjfr58AH5VykXMLw=;
        b=dXKeuMzDew1YnK8V1TgMxVBDJPla78eZaVev9QvxwPisPnK0UBBRg+ManxzX4z+uR3
         53SHLw8LTBMKWS6c16l96UL1FXGXkDOiNGEMKZkcp5eSSkr0q4f2tgRrFUTDzJleoE9u
         vKatn9eeaNNEwCsKgYtVQwLECZSGphwA5HGWvGNHENpm7SSHiKd13yW4fRtJPPfIeZ1H
         QvDQQi6MXcUBtqau2FKC9XiTktbrd6JJVYLRAJmHDsLg8Enk8T/sib4nVlNxEtzKq+1P
         YNZqtrrKvoOhvJ/2IEaGoqQY1fh7YyP9ngp27F5hLhsPROu5hbfyJvoOOqCvtqPTwBkE
         jnew==
X-Forwarded-Encrypted: i=1; AHgh+RpZ6IrvjnPvuucuTYIswNqjThnZ8AmM+78jBN+TLf87YQ2usYlzt+E8SVmhCuZU/hhYZmfb0oSdQvHKMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZmZpQfOIktutUjGJP2loIxA0I7tY0a0U8A18+SfT/MsgMaIz
	UTiI9KluflaTK5qhB1lqGQzGHLafWhUf6WlP4rtbyAvJUHkQ4eF69DEpI0AoQXIHkA==
X-Gm-Gg: AR+sD11dadMBXq8EJJP/NfUyFUEtLV3m1P35GEqEUw6E7k/cKj44U4tp6b9aif83pxp
	/BnVYDzhurgvyvn78/PW6hrb30Dfl1x8z61ShulNYBEn7cAHfhBmbq0jgeYbXI5hLFQDhUpxJrh
	polAbZghABP6oJ7Sk7K64S4avhXXIBayF1c8r3y+Y8cpQGb95lIgOrKnsRDXVCJPgA2eWZuysec
	O97oKGanPiBbHBVDcJP+G2MYLuXLqkr75llTIZXfDRFlYLhDF0R9HQyhPNJoh+khUKg8dHsFPIb
	HTQ4wtq6QPxJ5pDxV9LddVAaHOE2ZzrWI6cBCmiJN71tk/Kqhao/xftAC2vjaWlv4kUOwEMk17J
	auX0sR7GS8QPMQYTDiONpKLf93rV3Z5UBgoqBfTETU39FohNBFI82Tgovucw9GJtnxM697fRd7s
	4heO5qSoSCJR0jjqPs6G+jl1PU8ZHaLqFDJJkrjVz3Iw==
X-Received: by 2002:a17:902:ec8d:b0:2c9:f73d:4b38 with SMTP id d9443c01a7336-2cfa6be13b4mr74259095ad.19.1784879533947;
        Fri, 24 Jul 2026 00:52:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa38c1sm48114145ad.8.2026.07.24.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:52:13 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:52:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 2/2] zram: Use a custom key for each zram object.
Message-ID: <amMY79An64SSBWD4@google.com>
References: <20260714141300.3945672-1-bigeasy@linutronix.de>
 <20260714141300.3945672-3-bigeasy@linutronix.de>
 <amLYsq36Qm4Isj63@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amLYsq36Qm4Isj63@google.com>

On (26/07/24 12:24), Sergey Senozhatsky wrote:
> >  static bool zram_meta_alloc(struct zram *zram, u64 disksize)
> > @@ -1999,7 +1993,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
> >  	if (!huge_class_size)
> >  		huge_class_size = zs_huge_class_size(zram->mem_pool);
> >  
> > -	slot_lock_init(zram);
> > +	lockdep_register_key(&zram->table_lock_key);
> > +	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &zram->table_lock_key, 0);
> 
> So I wonder if we can give distinct name, given that it's per-device
> now: "zram%d->table[index].lock" and use zram->disk->first_minor (which
> is a unique device id).

Probably (see below) is not worth it.  All those ifdef-s...  We used static
name before and didn't have problems with it.  So let's just keep doing so
(IOW let's keep not having problems ;))

// completely untested
----

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4bfe63a5225d..080012e83f86 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1956,6 +1956,31 @@ static ssize_t debug_stat_show(struct device *dev,
 	return ret;
 }
 
+static void zram_lockdep_map_release(struct zram *zram)
+{
+#ifdef CONFIG_LOCKDEP
+	lockdep_unregister_key(&zram->table_lock_key);
+	kfree(zram->table_lock_name);
+#endif
+}
+
+static int zram_lockdep_map_init(struct zram *zram)
+{
+#ifdef CONFIG_LOCKDEP
+	zram->table_lock_name = kasprintf(GFP_KERNEL,
+					  "zram%d->table[index].lock",
+					  zram->disk->first_minor);
+	if (!zram->table_lock_name)
+		return -ENOMEM;
+
+	lockdep_register_key(&zram->table_lock_key);
+	lockdep_init_map(&zram->table_lock_map, zram->table_lock_name,
+			 &zram->table_lock_key, 0);
+#endif
+	return 0;
+}
+
 static void zram_meta_free(struct zram *zram, u64 disksize)
 {
 	size_t num_pages = disksize >> PAGE_SHIFT;
@@ -1971,7 +1996,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
 	zram->table = NULL;
-	lockdep_unregister_key(&zram->table_lock_key);
+	zram_lockdep_map_release(zram);
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -1990,12 +2015,16 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		return false;
 	}
 
+	if (zram_lockdep_map_init(zram)) {
+		zs_destroy_pool(zram->mem_pool);
+		vfree(zram->table);
+		zram->table = NULL;
+		return false;
+	}
+
 	if (!huge_class_size)
 		huge_class_size = zs_huge_class_size(zram->mem_pool);
 
-	lockdep_register_key(&zram->table_lock_key);
-	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &zram->table_lock_key, 0);
-
 	return true;
 }
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 4fddc582f3b8..377832477588 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -106,8 +106,6 @@ struct zram_stats {
 
 struct zram {
 	struct zram_table_entry *table;
-	struct lockdep_map table_lock_map;
-	struct lock_class_key table_lock_key;
 	struct zs_pool *mem_pool;
 	struct zcomp *comps[ZRAM_MAX_COMPS];
 	struct zcomp_params params[ZRAM_MAX_COMPS];
@@ -143,5 +141,11 @@ struct zram {
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	struct dentry *debugfs_dir;
 #endif
+
+	struct lockdep_map table_lock_map;
+	struct lock_class_key table_lock_key;
+#ifdef CONFIG_LOCKDEP
+	char *table_lock_name;
+#endif
 };
 #endif
