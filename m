Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71281C43332
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC3764F40
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCBXry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351277AbhCBWic (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Mar 2021 17:38:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA50C061221
        for <linux-block@vger.kernel.org>; Tue,  2 Mar 2021 14:36:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso1882920pjk.0
        for <linux-block@vger.kernel.org>; Tue, 02 Mar 2021 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Mir62bOXnIH92T0sLRTFyT91DoW8sHfVsY1HtQPZomc=;
        b=Zb6RtjXU08p1l0ippNC0Ipnm/Aq/CLUPktuCCBksFhco91hlwTCjfCErH28oh0E9bx
         93a6PrrHx/fiC+0EvaWHLF26uJvYSnq46dQnlW5GShf2LZI+WgpYvwNLat/YJ6pQSTs4
         hMJcGgKNhO971/gKMJ7xNCBsgNh6exUv9CMR4RGp8U59lGYH8KprZk8Wv3qdiva7ZpNo
         B4/N1QWyMlJy5n6T563L5T7VhOKniyOhihsU8MnsbE+yd4KwYpnqqt2Lko/AEUdAtY3p
         wAvZibidLSVZxfllvunsAQb00Bn9p4njY/gc+l2xZQqtFq0eJsQsiKI8d0MAaUf+k5aF
         qkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Mir62bOXnIH92T0sLRTFyT91DoW8sHfVsY1HtQPZomc=;
        b=RNcHxaQSR21CKiSIe70gnZXlf8LocUNjOYcjOPSGIDFEkyCYWzGQW8BUKZd8b8j1IS
         iPynj5Nxs5imvBh0OB4UlNnhLmUrizQM66pmYXOrmfuVxj1LIvk1OPHy0wlF1rbBGD8w
         zeSUOGTNYcjYGV5cUE/3W8FUDGne0i2oUCg2N0qCQ5vlcrqHgChSr2kK4yYw6qZ2yxWe
         Mc5DB267LZDaS4gYA7sDZkun4zU0Fmg4ChtcMtEpwVtP6OZrITixuXgSarD49/ma/s8F
         5If5kDYdw9sPXhq0cDx+JmYPfC1uf8HPhx1xfVhp8ufBEzh4URsJybpUsaM4nD+KbeUU
         PB7Q==
X-Gm-Message-State: AOAM531rNvIUkxEJDOM/uQVIEIeCLwWY3gII8byZjvOHKjxveMtT5iN6
        c0FnNk29+Lkw2Oh1GWF6el/ilg==
X-Google-Smtp-Source: ABdhPJw41pdUbU2zAiLhZneNiwheggwVDMC2i4BRcFNz6QP8YyiqjsTzy3fZEmbcUnULumBT6/Pf8A==
X-Received: by 2002:a17:902:e5c5:b029:e3:cfac:db3f with SMTP id u5-20020a170902e5c5b02900e3cfacdb3fmr5458845plf.11.1614724582889;
        Tue, 02 Mar 2021 14:36:22 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d11sm480663pfd.43.2021.03.02.14.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 14:36:22 -0800 (PST)
To:     Linux Memory Management List <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] swap: fix swapfile read/write offset
Message-ID: <6f9da9c6-c6c5-08fe-95ea-940954456c40@kernel.dk>
Date:   Tue, 2 Mar 2021 15:36:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We're not factoring in the start of the file for where to write and
read the swapfile, which leads to very unfortunate side effects of
writing where we should not be...

Fixes: 48d15436fde6 ("mm: remove get_swap_bio")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 32f665b1ee85..4cc6ec3bf0ab 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -485,6 +485,7 @@ struct backing_dev_info;
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
 extern void exit_swap_address_space(unsigned int type);
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+sector_t swap_page_sector(struct page *page);
 
 static inline void put_swap_device(struct swap_info_struct *si)
 {
diff --git a/mm/page_io.c b/mm/page_io.c
index 485fa5cca4a2..c493ce9ebcf5 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -254,11 +254,6 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 	return ret;
 }
 
-static sector_t swap_page_sector(struct page *page)
-{
-	return (sector_t)__page_file_index(page) << (PAGE_SHIFT - 9);
-}
-
 static inline void count_swpout_vm_event(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f039745989d2..7a8636c6c9ff 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -199,8 +199,8 @@ static int discard_swap(struct swap_info_struct *si)
 	return err;		/* That will often be -EOPNOTSUPP */
 }
 
-static struct swap_extent *
-offset_to_swap_extent(struct swap_info_struct *sis, unsigned long offset)
+struct swap_extent *offset_to_swap_extent(struct swap_info_struct *sis,
+					  unsigned long offset)
 {
 	struct swap_extent *se;
 	struct rb_node *rb;
@@ -1858,6 +1858,19 @@ sector_t swapdev_block(int type, pgoff_t offset)
 	return se->start_block + (offset - se->start_page);
 }
 
+sector_t swap_page_sector(struct page *page)
+{
+	struct swap_info_struct *sis = page_swap_info(page);
+	struct swap_extent *se;
+	sector_t sector;
+	pgoff_t offset;
+
+	offset = __page_file_index(page);
+	se = offset_to_swap_extent(sis, offset);
+	sector = se->start_block + (offset - se->start_page);
+	return sector << (PAGE_SHIFT - 9);
+}
+
 /*
  * Return either the total number of swap pages of given type, or the number
  * of free pages of that type (depending on @free)

-- 
Jens Axboe

