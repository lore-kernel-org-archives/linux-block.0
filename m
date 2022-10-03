Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21608C433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 15:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJCPfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJCPey (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 11:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D887E0D7
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojCbGuFmiyLgdgSBf4HLyZfSJMuzgvdBj8Ilq3qJPwM=;
        b=f0ng6bSQCAhh0vf/xhbANNUJ9eS4A0JArZE9VRV0lcgMWxcEm/hdJGPMGfqKST6VN6UwO2
        njI6yI3/2fGPw1X1MX+N908d+tmKaN2iSQPokBTIh3DSgJnSzjszVjmRc5mnmZ82u7EcPy
        DtBGxMhHjPTdbHOm+u4kchVr6smhvK4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-bp19qoVrM9WGUHIMhhozcQ-1; Mon, 03 Oct 2022 11:34:48 -0400
X-MC-Unique: bp19qoVrM9WGUHIMhhozcQ-1
Received: by mail-wr1-f71.google.com with SMTP id d22-20020adfa356000000b0022e224b21c0so1531524wrb.9
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 08:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ojCbGuFmiyLgdgSBf4HLyZfSJMuzgvdBj8Ilq3qJPwM=;
        b=H2Kk+trJ+SwmkjkV3aZm6H5gXHI3qF9qE8uM7fgCDif51ZR6T83xxkOc8f6fbIacon
         CebyTo5CzONbm2tXqgLhHyZh0iHkVpV9/nDECuJk/i0oJJVXlPKA0e8FCGHXqUASC16c
         eBmE0EI+sZfc6gJh7zDoRZh+ocmylIS4fuJV2vsNHaEa17D5tJTcR4cMiYQHavwgZvu0
         Sbshj/BLka2yI4ka7RTEXT4efVVKxBHeO/enxTkguCJ5PE/B4LvTLvihjfmON8jU32p/
         +9kt2aq5lLnhig4jyXvAlx+5cL5WhuW6mNbjiO+bLSsBrf9w9U+9dYqFiOyqfKxf+71j
         lmXw==
X-Gm-Message-State: ACrzQf32QKN7LPisxkGyNeV5Y5K9b+vaa2/89GxN1+H8e3wrZ1BGlsGa
        1CBW+HJrM8ObpXhxKj4bq3JXX7+pMnaNKxJfCm3uW0y6oqwbaLX0dWLeN3+adot7nxOs3FSrUoB
        l6xLECiyK5AGTzRRnQN8isTfFuXrvHeVCjl43aFcintBzCwNm0PL+Q6lbLMrLe4NL8+gHdpJwXA
        c=
X-Received: by 2002:a05:600c:3d0c:b0:3b4:c481:c63b with SMTP id bh12-20020a05600c3d0c00b003b4c481c63bmr6941554wmb.147.1664811286863;
        Mon, 03 Oct 2022 08:34:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4DC0p2uhrZdvpPbhbvwisJCgZSihR5TsChXOyUBUKDJL+xI/cPY6MLHDizyk+JnQ7+AazWyw==
X-Received: by 2002:a05:600c:3d0c:b0:3b4:c481:c63b with SMTP id bh12-20020a05600c3d0c00b003b4c481c63bmr6941528wmb.147.1664811286530;
        Mon, 03 Oct 2022 08:34:46 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:45 -0700 (PDT)
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
Subject: [PATCH bitmap-for-next 3/5] cpumask: Introduce for_each_cpu_andnot()
Date:   Mon,  3 Oct 2022 16:34:18 +0100
Message-Id: <20221003153420.285896-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
References: <20221003153420.285896-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

for_each_cpu_and() is very convenient as it saves having to allocate a
temporary cpumask to store the result of cpumask_and(). The same issue
applies to cpumask_andnot() which doesn't actually need temporary storage
for iteration purposes.

Following what has been done for for_each_cpu_and(), introduce
for_each_cpu_andnot().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/cpumask.h | 18 ++++++++++++++++++
 include/linux/find.h    |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 286804bfe3b7..2f065ad97541 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -306,6 +306,24 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
 #define for_each_cpu_and(cpu, mask1, mask2)				\
 	for_each_and_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), nr_cpumask_bits)
 
+/**
+ * for_each_cpu_andnot - iterate over every cpu present in one mask, excluding
+ *			 those present in another.
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ *
+ * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *	struct cpumask tmp;
+ *	cpumask_andnot(&tmp, &mask1, &mask2);
+ *	for_each_cpu(cpu, &tmp)
+ *		...
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_andnot(cpu, mask1, mask2)				\
+	for_each_andnot_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), nr_cpumask_bits)
+
 /**
  * cpumask_any_but - return a "random" in a cpumask, but not this one.
  * @mask: the cpumask to search
diff --git a/include/linux/find.h b/include/linux/find.h
index 2235af19e7e1..ccaf61a0f5fd 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -498,6 +498,11 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_and_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
 	     (bit)++)
 
+#define for_each_andnot_bit(bit, addr1, addr2, size) \
+	for ((bit) = 0;									\
+	     (bit) = find_next_andnot_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
+	     (bit)++)
+
 /* same as for_each_set_bit() but use bit as value to start with */
 #define for_each_set_bit_from(bit, addr, size) \
 	for (; (bit) = find_next_bit((addr), (size), (bit)), (bit) < (size); (bit)++)
-- 
2.31.1

