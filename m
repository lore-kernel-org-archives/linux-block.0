Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86653259CAF
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384940; cv=none; b=pksOH8OYUokmo4cJbBngC+Iq3Ne8MSaElF6r4AGNnFe3s2740jpIU79Z/57mskNVAMeyIg9BcMX3zF93VhEAp6gs2T6Fws4Hz204ZB1fEkZ4Ct4tEbCzyGnk9W0Z+wtJy1laXoeKxbESXBQ5RzuqpTYdYg8p9s0ivnd0wynLRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384940; c=relaxed/simple;
	bh=8p6C4aYe2SKh+tq5i+Vi9J40BRHT4dPQN0Bdhbrv0GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTy83lnpNuY4dug6SaSAK0+fqY8fKdMKECKIRxxLl4fzbqK0TtHDlQGO8Wb7R0DqusuL+kIOr1YYAS/z8ADXspy50DiXOx2anvSYohFwLdwoFe2UUP5gM89sznGzv79KVm5vjxTwE7FmvqK6IvVuMA5uT7g4oXC0SfIywdzvkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NQbG6Nhn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NQbG6Nhn"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31effad130bso3225320a91.3
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754384939; x=1754989739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ig3ejo4wL4oEVtv/WkueYSUf7qCSryypCGes3HapAjU=;
        b=NQbG6NhnAa/lq2HyHhHqOGFEJi4CgEAFCr0argLKm90trPtXpWmKP1fEIscPtMPt//
         cq5COK4lRAfCjzHSefRA2lsWAuKO8SG5Nw7BnGtcbzfi/CoTZL6VB27Df0xc6gsy99mJ
         k6eSzOCQFJU8iHntSoFe/b7lb5jZDheQ3tpM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754384939; x=1754989739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig3ejo4wL4oEVtv/WkueYSUf7qCSryypCGes3HapAjU=;
        b=tyNHHLZyc0dtIZGTJNoimtWznnym+BsrQJQjT2JcyLDATLkbw/41CP5efhOeZVBEgC
         J/uxFb4fdLet8vKCHxG7+CsJcM4INEB3oDcEzuwUDH/gJzNmKB8X7BVWn7gFrQxYldlu
         gHoRLDtOa1ju49DZURVkIKvO5fXtxs+pZQXGKEX4q2Cm6FlmxR3oK2WmndEHuIbNJk5E
         ao9ysF7DT2ZB7DLcGiJZ6iSRYoS9u60sPuF8hLbKHW3vyw0nh8hK1q9FfH14j5nHS9OC
         BnOZH2hcAMZE+u8WhO/8sawijdCYu+yU5apC7N/AIg2TlvgcTmHD1j0w6C1pSTVzT5zh
         nMLA==
X-Forwarded-Encrypted: i=1; AJvYcCVx0HPsCl7ApV8gBJOioiGSJPA9lnYBMAQJFfY7ueFmGS7VHxBFtWgDuBQ+D0SFTyCA5XE1ByDUl9bnMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVp8mjyqZk0YQSFyD7JLyHJvS23CnG2wcBDJE19VnSE9ER5mj
	PKB7zKUpFqN5P5bp+iCwCL5FARC+0rM53Qg6IQHsbCqRx0pkcb2uyxg4JfXINkDn+A==
X-Gm-Gg: ASbGnctyEe4vjTO/dddvbg7GTC4v86AKxp7Lo/LIARlh4YCxcUql3tzUk7LYKYGpjm/
	g+zzcpT6Cu3F6yEYcBbZ+7DNZn17ECQrQyKshE8KbMuB/+STplCkvn7jZ3aKw6ei2F/hwEuXVQu
	40/xNs57MtJ/vbKrRpSNJLIXD4Ax+RvuWTB3jpBsMGvjGLx+/qjkQGVuD0TXxolfNUjo0Kp04uN
	XBwr9NF+60mH5o8qmqdMBXNT6ccJoYse3olvlryrjlPbN1FtFj6YBDs491xyS3ea4VAxJAswSMO
	Ijh4JSCEUjTTAXBBNa1nYbN8TK2GYy0/95vgxC2BoWvThPGjHT+mexAoXEj6LHi/cwv48T7gjQI
	iU+6fIxVDv4s5yatM+Y9D3Qc=
X-Google-Smtp-Source: AGHT+IEC0CkarFCC9tbObUgl96lF1pEq0czMe/WEVpF3KDzV5+OA8lKXxlxpIlMyZQd9QbqWO8ckzw==
X-Received: by 2002:a17:90b:3ec8:b0:31e:f3b7:49c6 with SMTP id 98e67ed59e1d1-321162143d0mr18939390a91.15.1754384938585;
        Tue, 05 Aug 2025 02:08:58 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1688sm16690050a91.9.2025.08.05.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:08:58 -0700 (PDT)
Date: Tue, 5 Aug 2025 18:08:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <ovw53m3yjcqrp334wcrlukcsusqkhxjbkbngpgjqn35cb2ay2t@vjopd6ksszxc>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803062519.35712-1-ImanDevel@gmail.com>

On (25/08/03 02:25), Seyediman Seyedarab wrote:
> During zram_reset_device(), comp_algs[prio] is set to NULL by
> zram_destroy_comps() before being reinitialized to the default algorithm.
> A concurrent sysfs read can occur between these operations, passing NULL
> to strcmp() and causing a crash.

zram_reset_device() is called under down_write(&zram->init_lock),
while sysfs reads are called under down_read(&zram->init_lock).
zram_reset_device() doesn't release the write ->init_lock until
default_compressor is set.

I think it may make sense to make sure that show() handlers don't
release the read ->init_lock somewhere in between. I only see one
that does so: recomp_algorithm_show().

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8acad3cc6e6e..ee3aa9cc8595 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1228,13 +1228,7 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 static ssize_t __comp_algorithm_show(struct zram *zram, u32 prio,
 				     char *buf, ssize_t at)
 {
-	ssize_t sz;
-
-	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->comp_algs[prio], buf, at);
-	up_read(&zram->init_lock);
-
-	return sz;
+	return zcomp_available_show(zram->comp_algs[prio], buf, at);
 }
 
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
@@ -1387,8 +1381,12 @@ static ssize_t comp_algorithm_show(struct device *dev,
 				   char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
+	ssize_t sz;
 
-	return __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf, 0);
+	down_read(&zram->init_lock);
+	sz = __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf, 0);
+	up_read(&zram->init_lock);
+	return sz;
 }
 
 static ssize_t comp_algorithm_store(struct device *dev,
@@ -1412,6 +1410,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	ssize_t sz = 0;
 	u32 prio;
 
+	down_read(&zram->init_lock);
 	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		if (!zram->comp_algs[prio])
 			continue;
@@ -1419,7 +1418,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 		sz += sysfs_emit_at(buf, sz, "#%d: ", prio);
 		sz += __comp_algorithm_show(zram, prio, buf, sz);
 	}
-
+	up_read(&zram->init_lock);
 	return sz;
 }
 
