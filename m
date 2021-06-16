Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D5C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C50B613B9
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 16:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFPQmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhFPQmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 12:42:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C3C061760
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t17so2450777pga.5
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwtgVJkhTDK7FkC0vaUra0M374ERbF8RXthI68zkQrk=;
        b=PjKgFRjHSJToA5x31UIrlT2kQz8QWjvtUtYBHJLyMvk0e1Hb9GK88sJy3Wo1ywei+B
         z0DhACruELJPvs+3RZ33FJaX8HsHYVzcpOxltyO2La4fkO2wGBv6zH1UaGS7yZ5me6mJ
         vUp5deeq1o/Htj824MXRwhI+mkytJCSWrZDnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwtgVJkhTDK7FkC0vaUra0M374ERbF8RXthI68zkQrk=;
        b=Ko3wI0IoFXQqmK/bErmZku6eizgTViwbCrW+MBHLWR1jH52YbYD2N7Ys4vZY/RSIAE
         8CXOqogU9rNu1Dqmqh/XDTVxnYmnZ6RR7Dvb4iR5XtDci9SwpHLmbzvprmjxOyjm6No0
         4OY74W3esuSitF1afTMfT/rY8hzEUAH3ctXEr8NlWtyD0rXwq6qyt1xKLfS+ObrznT/x
         Bm7gd4Tc+1Kq5Ap/PkbuXAkOYczswN/n40t0+5ESTWSzLXBE/u9UraVbsb6TyWFGTvhf
         ob+WKP74Pi5F7SzesBQiJAaqiNQnt1oyyXdqO4sqgjPpDXZ4aXborVbSistn5mHgWUMU
         tNjA==
X-Gm-Message-State: AOAM532yqKJphyN6us3bdhI7TS2SLZMp0RMo8/TNG9N8jhCA84CJM6jj
        6ggYEDXuxCRR/6rqGoLesr6UMg==
X-Google-Smtp-Source: ABdhPJyZY0hoVBBpbAB8LGirsSlZb/UXJaZdGclDdXDTOIGGnPZxvbdmt6gy8/o3bWoM59xye5Uu7g==
X-Received: by 2002:a05:6a00:844:b029:2f8:5436:dc39 with SMTP id q4-20020a056a000844b02902f85436dc39mr624754pfk.10.1623861646934;
        Wed, 16 Jun 2021 09:40:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ip7sm2663266pjb.39.2021.06.16.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:40:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/5] pstore/blk: Improve failure reporting
Date:   Wed, 16 Jun 2021 09:40:39 -0700
Message-Id: <20210616164043.1221861-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616164043.1221861-1-keescook@chromium.org>
References: <20210616164043.1221861-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=95c1880167375f358445fa6b36d9d46efbebcc09; i=x+eth6WIY3ZV3RikljpGvsEDOkHC4+JR/D6VkOL4MwM=; m=KWKLltarrgCHVaChKkiXTTMXR+nWhEDb2yQ+7Fx0dy0=; p=hVqcquLAjJY5MNtchTMAytKSIfiafQn164H7tkcB2Bg=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKKYkACgkQiXL039xtwCZgHhAAode R8F21Ztaztm9OD+m51tZDz9H7Jmr3b179RR3mjQtLY5uCy9QlEpGuYAsz/ABz9YrgP0QBOkMztOPC oQPxj2VnCVVuMJRSzFTue9HH70ItKKMz/VIHIFeV7GPStnetLsLWB+ndgzT9ustwokFew+5O35X/l pOmZy7Ol4tvlE44IfAyL6U9z8p9P9r+3a9UyoxW9Hm+KrSC9fxCG0wayJe8PqBkEdSvJ7VolFsRPr bT2bKgOb1F1vZFcHVIK00XvErTh0b6lTlWZWU9m91uH0S47Z7T+rnsJyiRLAldZiTQW2TMWo4zkIs 0QXC77HT2aXShl9P8FZkqmxDS/bYJqYFmt8ags6dV7EPjaOdAt42WMXdYEYuwsZBUVjFVwqpxZPm6 v+z7VzEJQYXs4rrkOOdcUVk4p+BuoyTrmR6/YbOjHkmvW8ufWZxNlndmPcAXW2+CMqV+U8p3LiHnF Yt8bHShaW175vGPMGqhldiLQpQQvJUMtlfrf35EBWHfvA4lDbhJPkvYW/nytaYgyjrnSUmdNqcLTA sb5e0RWD0gXDZqBhYJX7byjf49AFfMoBn3f/Jke02up/jENft69J+Zz4+g+yXD8yERwRPUVy/A8fG Mty73UjHC9R3wIIIG2JsoPGhsP+8rLEgD7c7d6KYl/Pu9NcT44LdTcznpdHhVMi0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There was no feedback on bad registration attempts. Add details on the
failure cause.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 4bb8a344957a..eca83820fb5d 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -114,8 +114,22 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 
 	lockdep_assert_held(&pstore_blk_lock);
 
-	if (!dev || !dev->total_size || !dev->read || !dev->write)
+	if (!dev) {
+		pr_err("NULL device info\n");
 		return -EINVAL;
+	}
+	if (!dev->total_size) {
+		pr_err("zero sized device\n");
+		return -EINVAL;
+	}
+	if (!dev->read) {
+		pr_err("no read handler for device\n");
+		return -EINVAL;
+	}
+	if (!dev->write) {
+		pr_err("no write handler for device\n");
+		return -EINVAL;
+	}
 
 	/* someone already registered before */
 	if (pstore_zone_info)
-- 
2.25.1

