Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48939C433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJCPfD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJCPey (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 11:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A4E0BC
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arpFl93eCu4VRK8HZxr5R+cc0l1GALQ+UU+vo8Q36Tc=;
        b=E8L46M8xFNyjN2Qr9c4c8hrLyy9f636dN/BUWTcfZFKdqj2FwLYul2BFpnjmjALYDArRA2
        ecdu/MihLUjHwBwNeLC4YZ7wmm4NNS8K6V7pcejASXDYlWy+F3KoBV6ney6wicghbJSkFb
        xMJvon6BCPs2EP9bDYstGeal7kcaCYk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-118-wfCtX7bPM5OzAWLat16njg-1; Mon, 03 Oct 2022 11:34:48 -0400
X-MC-Unique: wfCtX7bPM5OzAWLat16njg-1
Received: by mail-wr1-f70.google.com with SMTP id d22-20020adfa356000000b0022e224b21c0so1531498wrb.9
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 08:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=arpFl93eCu4VRK8HZxr5R+cc0l1GALQ+UU+vo8Q36Tc=;
        b=qQNcrch/A6QcY9MwylRNPOJKKuen7WsGZACc+TJUAUBY2AnE1Ilmw3aJlk+NsIOfAC
         T8zzdTA44A9NvFMgmMdNXCJwwEa7eFmFf1wi75lx47Y9SA4XPPlRE+uUv2II7CcBKz+c
         60+Vdbf5P/IMjd4n7Pj+k8cevDzENCjH5YVZXYuDfVZKZUNxltnRh/dS5YT3XxKigqq+
         JGTh727Qbfkvn6zs/PUek8RaZExAz1eX5YnFz5oV8kiX3oRNNCKzDwcSXFV+twS4GauU
         /P3XJXxm2KAnJ/+vAkRAFTfNjnD/T7lQX8gr2kkZAO/EhPvbmjex5kP7h68TJedpw7X6
         3Sxw==
X-Gm-Message-State: ACrzQf2VYYZAzKGY7hHyhBqndjhBk/u/LKYdrQ+UwcXFayCnWgyPvmv8
        DWv/H7zlitH9pKSyPhlCC4Gi0BqGJYHOf47xPeBQNAs3H60dgLvocmLqGlrlYy+welfJQ1AfbZE
        kx0VZL6d4H2wrpj46+7pHv2WWJXCL2Y0oZbzBjYI7jH9Xssl66TqlNCqTl3fqa1ya11FMPp8I5i
        E=
X-Received: by 2002:a05:600c:4fd1:b0:3b4:c00d:230a with SMTP id o17-20020a05600c4fd100b003b4c00d230amr7086599wmq.62.1664811285194;
        Mon, 03 Oct 2022 08:34:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5HFAm+wSvaJDfxQ4UcUyn6T4neRKzOgQk7Nth3fuyLRYFQZj5JvPP9+Ll3a76uaMR7QmiqBA==
X-Received: by 2002:a05:600c:4fd1:b0:3b4:c00d:230a with SMTP id o17-20020a05600c4fd100b003b4c00d230amr7086570wmq.62.1664811284906;
        Mon, 03 Oct 2022 08:34:44 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:43 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH bitmap-for-next 2/5] lib/find_bit: Introduce find_next_andnot_bit()
Date:   Mon,  3 Oct 2022 16:34:17 +0100
Message-Id: <20221003153420.285896-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
References: <20221003153420.285896-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation of introducing for_each_cpu_andnot(), add a variant of
find_next_bit() that negate the bits in @addr2 when ANDing them with the
bits in @addr1.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/find.h | 33 +++++++++++++++++++++++++++++++++
 lib/find_bit.c       |  9 +++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index 0cdfab9734a6..2235af19e7e1 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -12,6 +12,8 @@ unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
 				unsigned long start);
 unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
+unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
@@ -91,6 +93,37 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_next_andnot_bit
+/**
+ * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
+ *                        in *addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_next_andnot_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_andnot_bit(addr1, addr2, size, offset);
+}
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 25609974cbe4..18bc0a7ac8ee 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -164,6 +164,15 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
 EXPORT_SYMBOL(_find_next_and_bit);
 #endif
 
+#ifndef find_next_andnot_bit
+unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_andnot_bit);
+#endif
+
 #ifndef find_next_zero_bit
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start)
-- 
2.31.1

