Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0865C388F7
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BFFF246CD
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5LjzTvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgJ1WNl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbgJ1WNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:13:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C448C0613CF;
        Wed, 28 Oct 2020 15:13:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p17so297667pli.13;
        Wed, 28 Oct 2020 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eR73H0SRKjWBsnxzZwc2xaGbCZRK3e9DcEGdBKm49pA=;
        b=H5LjzTvv/UWQRP2ccKOg+Eh/8U3L6c2MloCN9olns4O4sIVKZ/gcxk5/XDcqArXXSv
         fFf8xRMEvN8jsKPWKqyVCDNBBbc0ZeXdz1QGO6gbfwTryjGV3GLe8Dt6/YnP7I4iQxhT
         oFeUsNI+ajyn3a4FcnCfX6b58z+vuEDXRh0uF4STJmBO14oRyg9rPPtTL71ilRkrxLFL
         26I9AmLYTgNll1ltPZIHOX3FKfBZuoBHK5KDbxG2h+hBVaVosYs1X5naElvLiE5vF+yZ
         sMFXxI8HJ4vByqwiS/464BAL20Nk1lx4kIaZFuRgPq80oql7oHkmTrJx5QSvVjzPsAQf
         dMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eR73H0SRKjWBsnxzZwc2xaGbCZRK3e9DcEGdBKm49pA=;
        b=MBidPlmf6pS/vy6zOdbI96/QT7FqkKpKkZtORcPFXLGrDs29E50X7EegYlqWe4vm3d
         tCR8+wzOhcqaQ3V++TpDtjPWkfAur+dIrfSyjPo2knApulRLnu3MkbyAqNd1r58YQSYE
         O/IsB46KYhk/bycG96C1qSxcmfg0+geptmePwh0S0y5KBbHDnsNxddpNwYqrhrGQRfCB
         YHfq2bqFKLcSn8JXKc23B8HLg4q74cNCIAQB7laBknMquIgNxpVw4lsKIRuDMTzDfG4D
         s4N9RwgPYsQiJhCIe2nK3v1AgzHNZsJIQMlsf+XsO1ZX3at6mOhmM2h1OMBDnGzelQEY
         Nr3Q==
X-Gm-Message-State: AOAM530jUbBy7mgumiZWJMRTKyX4bAXjYCcmHA9+XL/bPhKFiwPqMK4T
        4szcL/d1/RtsJRCZGrN+INxLQaHOqHU=
X-Google-Smtp-Source: ABdhPJxw5mo3nFBhnSgJAyjgusXDKsM/FLnQRgXobRdthsXp/eW2UdoMkxmOmyk2kZclkapxG0TaTg==
X-Received: by 2002:a17:902:8541:b029:d5:b4f3:314e with SMTP id d1-20020a1709028541b02900d5b4f3314emr6615419plo.31.1603880377834;
        Wed, 28 Oct 2020 03:19:37 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id x9sm4767150pgr.22.2020.10.28.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 03:19:36 -0700 (PDT)
Date:   Wed, 28 Oct 2020 19:19:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        minchan@kernel.org, ngupta@vflare.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] zram: break the strict dependency from lzo
Message-ID: <20201028101934.GB48825@google.com>
References: <20201026085141.1179-1-rsalvaterra@gmail.com>
 <20201027012204.GD2412725@google.com>
 <CALjTZvbf4qK6SHEe7OhkTC_o7kaY4oOKQ+kk-D2OUq_ULsYAqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvbf4qK6SHEe7OhkTC_o7kaY4oOKQ+kk-D2OUq_ULsYAqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On (20/10/27 08:39), Rui Salvaterra wrote:
> Personally, I always use zram with zstd, and the only lzo dependency I
> have is zram. Disabling lzo saves me about 3 kiB in the final
> (xz-compressed) vmlinuz image. It's not much, for sure, but when your
> total storage is 4 MiB (and your RAM is 32 MiB), every bit counts. :)

Can the following work then?

Completely untested.

===8<===

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..f93eed40e155 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -2,7 +2,7 @@
 config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
-	select CRYPTO_LZO
+	depends on (CRYPTO_LZO || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_ZSTD)
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
 	  Pages written to these disks are compressed and stored in memory
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 33e3b76c4fa9..98c7c46c9c3a 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -15,8 +15,10 @@
 #include "zcomp.h"
 
 static const char * const backends[] = {
+#if IS_ENABLED(CONFIG_CRYPTO_LZO)
 	"lzo",
 	"lzo-rle",
+#endif
 #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
 	"lz4",
 #endif
@@ -202,6 +204,21 @@ void zcomp_destroy(struct zcomp *comp)
 	kfree(comp);
 }
 
+const char *default_compressor(void)
+{
+	/*
+	 * Pick the first available one (there should be at least one).
+	 *
+	 * In theory, we can drop all the ifdefs from backends[] and
+	 * just iterate backends array doing crypto_has_comp(comp, 0, 0)
+	 * for each entry and return the first one which is recognized by
+	 * crypto. But crypto_has_comp() modprobes compression drivers,
+	 * so we may endup with extra loaded drivers, when the 'default'
+	 * compressor is not what zram is configured to use.
+	 */
+	return backends[0];
+}
+
 /*
  * search available compressors for requested algorithm.
  * allocate new zcomp and initialize it. return compressing
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 40f6420f4b2e..f104be9eae9c 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -27,6 +27,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf);
 bool zcomp_available_algorithm(const char *comp);
 
+const char *default_compressor(void);
 struct zcomp *zcomp_create(const char *comp);
 void zcomp_destroy(struct zcomp *comp);
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1b697208d661..f02ee050c7bf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -42,7 +42,6 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
 
 static int zram_major;
-static const char *default_compressor = "lzo-rle";
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
@@ -1960,7 +1959,9 @@ static int zram_add(void)
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
 	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
 
-	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
+	strlcpy(zram->compressor,
+		default_compressor(),
+		sizeof(zram->compressor));
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
