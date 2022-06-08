Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE75C43334
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 08:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiFHIG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiFHIFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 04:05:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE623B15F
        for <linux-block@vger.kernel.org>; Wed,  8 Jun 2022 00:36:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h192so11357094pgc.4
        for <linux-block@vger.kernel.org>; Wed, 08 Jun 2022 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9dT1YbLiitv03+PdOtWagge0EdcnKxpI77SoGaYuRcY=;
        b=SP8iQOXw3TyCNNE3e5y15XHPh4wkAzTM4T6CFjlFHuZOTsIwlqatl/sMUjuDNpMCZt
         V3GQpJrRiJpZ546fXVFaonmkMIYX64ZZAaT9a2qJ5+BUEd7IVk+bh3K58dxvoSBHn92q
         k3oIfugG7ZX3poTCMLMZFoDidkgYglLZZJBVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9dT1YbLiitv03+PdOtWagge0EdcnKxpI77SoGaYuRcY=;
        b=KCL4xWEATFIovuSP1H7mnOwB2JD6/MQUvyYpU1rgBjeKApxPbwnDUXHxTL3EvP5xUg
         12uacVk9UzBrnakEbqwZshwEIeIDRKCawJ7ofGCpw8TdTDfA1Spn0nsweYlJJ0w2/+GJ
         F3sa7qseSKTo5TPN5K6VRDCr8R3Z+1/LYhvlzsfhX+7fuLzQhQhw1F2Fv7IIsl+bGkZJ
         JwNh8LjVOfxuZ+O4EoV4tduu5d3c7ahu/GAVvGbf+GdgdChRFry+7q/gavDJE6vojvto
         xmnIacQFWRvUsZhkLn4/FFNXrBOtITb7pEqoi1LaZNM/OL22gl0TqznUot6aTqpaJqlO
         19PQ==
X-Gm-Message-State: AOAM532m2JT7lhYK6Us8BB5Dg4Lfi30UVCxKhVILyobZn3sJI9qBF/9B
        BbRIDMmPdsPP7XSfq5l6fk0l1A==
X-Google-Smtp-Source: ABdhPJwaxdsj6eMQY2PXnXyn7JGln1BneLzhB4mTT8eUahzdJoFLMCIyVlAJyLCCAWjTQesyjDXvzw==
X-Received: by 2002:a63:65c7:0:b0:3fc:85b5:30c0 with SMTP id z190-20020a6365c7000000b003fc85b530c0mr29388641pgb.165.1654673770813;
        Wed, 08 Jun 2022 00:36:10 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:463d:a192:6128:66e])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b00167729dfe0bsm6439373plh.168.2022.06.08.00.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 00:36:10 -0700 (PDT)
Date:   Wed, 8 Jun 2022 16:36:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <YqBRZcsfrRMZXMCC@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com>
 <YqANP1K/6oRNCUKZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqANP1K/6oRNCUKZ@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/06/08 11:45), Sergey Senozhatsky wrote:
> 
> Something like this?

May be even something like below. Move static initializer to cpu up
hook.

---
 mm/zsmalloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9152fbde33b5..6d3789d834e2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -453,9 +453,7 @@ MODULE_ALIAS("zpool-zsmalloc");
 #endif /* CONFIG_ZPOOL */
 
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
-static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
-	.lock	= INIT_LOCAL_LOCK(lock),
-};
+static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
 
 static __maybe_unused int is_first_page(struct page *page)
 {
@@ -1113,6 +1111,7 @@ static inline int __zs_cpu_up(struct mapping_area *area)
 	area->vm_buf = kmalloc(ZS_MAX_ALLOC_SIZE, GFP_KERNEL);
 	if (!area->vm_buf)
 		return -ENOMEM;
+	local_lock_init(&area->lock);
 	return 0;
 }
 
-- 
2.36.1.255.ge46751e96f-goog
