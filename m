Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB13C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 15:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjAaPhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjAaPhD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 10:37:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8851427
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 07:36:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m11so14559981pji.0
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQY0o2qkAKYFH7LWXdvXFVGAqLi+sKaNC+LqwIIUvZs=;
        b=fDdFeQR7aga3Mvpbjdn5BMRfIUa9WGkRrnp/3BaPk5OCOCRntiI2RQBBmupmnHxtbV
         /9ZkeAKJuemHbqzNl0JOUVvItnex8KdwqlGZlvAGa6HWbTyOvi2XeCMSUVx9Xurfcwzt
         YGq3fMG3VWd8Rdrt7pqldTYVaaOiR7/WMGk8aN5eZ31oYNHbOJLyS6tQs4PwRX1DYYfs
         C1i0JwRtm9994RjRYeCXo09BPQ7440tV/jk3BKSsyPapoO1YKZlyIys1K/74gnCFObYJ
         jXdy3B/UubW0Xk735auyRVglaXajPusx5bOnxTe9u/22OGHLINRcWu2ph6bVsCoNcjDX
         IBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EQY0o2qkAKYFH7LWXdvXFVGAqLi+sKaNC+LqwIIUvZs=;
        b=AcfWDuf+DJBCkE32e5ri03CtVmdOfv+cx5WO/vubxuHG5BAv0cJKqtFyrZsK96SNuo
         /vdwqNR7ASic9Yyy3Qmygt6OCKVLb9cqhoj2JHWBsmpAed59trgYrfqqDAokG5h4qMKX
         p+OvwZf1MLYiozP9DOEuefU+Cemwgz2Jpsm8W40DdMvd8yBT5HYve0xty9HRYEf4y7pQ
         VEheVbKfo2M9Lm+QWYGMNiMH6odcjfNnS6jMtcoBKZXeBLKbDaRP5EoKWjjg/Ui4BMiF
         2Wpw5ytnIy3zUsJzBq3jhDLVtl/OT67EBf4djswymaCSj3pN6DoJFHHG4mWRegER7ag+
         IoDA==
X-Gm-Message-State: AO0yUKXa2kh/6dZt3s6DSXOttFMxm0Aw4BF6QcCzdISR5LuPP1nvqmT4
        GCwbgfBSM0fU4+f1CtVjim/YRA==
X-Google-Smtp-Source: AK7set9xzGsvDHDfGnInyRCfENWzJmt90g2AlvtJtH94RCocYUsoAiR/Ep4M4tSg3ju6CCwnbPRd+w==
X-Received: by 2002:a17:90a:7c47:b0:22c:2483:2401 with SMTP id e7-20020a17090a7c4700b0022c24832401mr6802571pjl.2.1675179418822;
        Tue, 31 Jan 2023 07:36:58 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gf17-20020a17090ac7d100b0021904307a53sm8917119pjb.19.2023.01.31.07.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:36:58 -0800 (PST)
Message-ID: <54b0b07a-c178-9ffe-b5af-088f3c21696c@kernel.dk>
Date:   Tue, 31 Jan 2023 08:36:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] mm: move FOLL_PIN debug accounting under CONFIG_DEBUG_VM
To:     David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using FOLL_PIN for mapping user pages caused a performance regression of
about 2.7%. Looking at profiles, we see:

+2.71%  [kernel.vmlinux]  [k] mod_node_page_state

which wasn't there before. The node page state counters are percpu, but
with a very low threshold. On my setup, every 108th update ends up
needing to punt to two atomic_lond_add()'s, which is causing this above
regression.

As these counters are purely for debug purposes, move them under
CONFIG_DEBUG_VM rather than do them unconditionally.

Fixes: fd20d0c1852e ("block: convert bio_map_user_iov to use iov_iter_extract_pages")
Fixes: 920756a3306a ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")
Link: https://lore.kernel.org/linux-block/f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

I added fixes tags, even though it's not a strict fix for this commits.
But it does fix a performance regression introduced by those commits.
It's a useful hint for backporting.

I'd prefer sticking this at the end of the iov-extract series that
is already pulled in, so it can go with those patches.

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cd28a100d9e4..0153ec8a54ae 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -195,8 +195,10 @@ enum node_stat_item {
 	NR_WRITTEN,		/* page writings since bootup */
 	NR_THROTTLED_WRITTEN,	/* NR_WRITTEN while reclaim throttled */
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
+#ifdef CONFIG_DEBUG_VM
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
+#endif
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
diff --git a/mm/gup.c b/mm/gup.c
index f45a3a5be53a..41abb16286ec 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -168,7 +168,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 		 */
 		smp_mb__after_atomic();
 
+#ifdef CONFIG_DEBUG_VM
 		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
+#endif
 
 		return folio;
 	}
@@ -180,7 +182,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
+#ifdef CONFIG_DEBUG_VM
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
+#endif
 		if (folio_test_large(folio))
 			atomic_sub(refs, folio_pincount_ptr(folio));
 		else
@@ -236,8 +240,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 		} else {
 			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
 		}
-
+#ifdef CONFIG_DEBUG_VM
 		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+#endif
 	}
 
 	return 0;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1ea6a5ce1c41..5cbd9a1924bf 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1227,8 +1227,10 @@ const char * const vmstat_text[] = {
 	"nr_written",
 	"nr_throttled_written",
 	"nr_kernel_misc_reclaimable",
+#ifdef CONFIG_DEBUG_VM
 	"nr_foll_pin_acquired",
 	"nr_foll_pin_released",
+#endif
 	"nr_kernel_stack",
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	"nr_shadow_call_stack",

-- 
Jens Axboe

