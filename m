Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BF0C7EE24
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 09:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjEKJAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjEKJAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 05:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA5211E
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683795563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6AHrE7FSTy6kUmyZ67dq18jJrS3m07xwP3WYe4TILY4=;
        b=SZ7souypdHzzn37kdKRISd+/hDl23aGbb14HD3ObEs1FDp9clszXTwS2oNw0JRfq+wMC46
        FgMG3UQPKbupgvdb6ogoitGZDEQQ2TTj3J2q13h0lkrGvfEE1HrbWPqw9RD3hLINf1Zzsn
        p4JKKm2uO7/SC4semOwoBgeONts+COI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-v8JpYp9FOX2Yz9QFI8xc6w-1; Thu, 11 May 2023 04:59:22 -0400
X-MC-Unique: v8JpYp9FOX2Yz9QFI8xc6w-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ab163bbf26so2393183a34.0
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 01:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683795561; x=1686387561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AHrE7FSTy6kUmyZ67dq18jJrS3m07xwP3WYe4TILY4=;
        b=VRliBoXWdqMjmTiAFWL3O3j+eZ/umn5bkN3guvT3ersrQ/ktFjZbZ1ZUM885nqp2GX
         GBdLn8oQRq2XYM2lU9WLx5f9RgYz2K82VbHPizjkSXgNWSLyb6PLFraArKapZDSTXpAG
         ba6th4+/U0TxqZ0MsdxvPHyFSzH3hc+XMUiasrE7Np0WVodt7ap06GGS+Dwao0pBFF+0
         9yXD/scT4XS194BxbWsIu5/nADbzYJghgllMQOigLi1/BmjWZFNWSKDQYJ6zUFt00Obf
         4TxKTHpPzdME3Aif0CQ8h6/I+PrgtSnICfB6HUjzi/8fT49Tm5ddwFFuOhWoUwbKXDjA
         CR+g==
X-Gm-Message-State: AC+VfDxJxWWDNyeNgmZFbXTB0dEdFY561RsrirxyBgHOBzMSGnL7Sxv9
        /OBt2dtyojtru2kqVHN6kK2ERseHKAhdJ/JtZbI/OjghhlqzEUpeb2i8lxPs8/Z6ksonXLjNWPo
        nMrfROMr33w8IERGaH+H8Et0=
X-Received: by 2002:a9d:7551:0:b0:6a4:28e5:8a8d with SMTP id b17-20020a9d7551000000b006a428e58a8dmr4095636otl.10.1683795560944;
        Thu, 11 May 2023 01:59:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7hYgKjhWrnxi/TlT87B/vtWa3wnqQyMjfQtFRTLsUCXdgNlqQ18DB7OkuP/yfUoP6B1s7CLA==
X-Received: by 2002:a9d:7551:0:b0:6a4:28e5:8a8d with SMTP id b17-20020a9d7551000000b006a428e58a8dmr4095631otl.10.1683795560701;
        Thu, 11 May 2023 01:59:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:3602:abec:117:3c19:43b8])
        by smtp.gmail.com with ESMTPSA id d1-20020a056830004100b006a42e87aee4sm1039300otp.32.2023.05.11.01.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 01:59:20 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] blk-mq: Convert request->csd to call_single_data_t and reposition it
Date:   Thu, 11 May 2023 05:58:37 -0300
Message-Id: <20230511085836.579679-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, request->csd has type struct __call_single_data.

call_single_data_t is defined in include/linux/smp.h :

/* Use __aligned() to avoid to use 2 cache lines for 1 csd */
typedef struct __call_single_data call_single_data_t
	__aligned(sizeof(struct __call_single_data));

As the comment above the typedef suggests, having this struct split between
2 cachelines causes the need to fetch / invalidate / bounce 2 cachelines
instead of 1 when the cpu receiving the request gets to run the requested
function. This is usually bad for performance, due to one extra memory
access and 1 extra cacheline usage.

Changing request->csd was previously attempted in commit
966a967116e6 ("smp: Avoid using two cache lines for struct call_single_data")
but at the time the union that contains csd was positioned near the top of
struct request, only below a struct list_head, and this caused the issue of
holes summing up 24 extra bytes in struct request.

The struct size was restored back to normal by
commit 4ccafe032005 ("block: unalign call_single_data in struct request")
but it caused the csd to be possibly split in 2 cachelines again.

As an example with a 64-bit machine with
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_WBT=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_INLINE_ENCRYPTION=y

Will output pahole with:
struct request {
[...]
	union {
		struct __call_single_data csd;           /*   240    32 */
		u64                fifo_time;            /*   240     8 */
	};                                               /*   240    32 */
[...]
}

At this config, and any cacheline size between 32 and 256, will cause csd
to be split between 2 cachelines: csd->node (16 bytes) in the first
cacheline, and csd->func (8 bytes) & csd->info (8 bytes) in the second.

During blk_mq_complete_send_ipi(), csd->func and csd->info are getting
changed, and when it calls __smp_call_single_queue() csd->node will get
changed.

On the cpu which got the request, csd->func and csd->info get read by
__flush_smp_call_function_queue() and csd->node gets changed by
csd_unlock(), meaning the two cachelines containing csd will get accessed.

To avoid this, it would be necessary to change request->csd back to
csd_single_data_t, which may end up increasing the struct size.
(In above example, it increased from 288 to 320 -> 32 bytes).

In order to keep the csd_single_data_t and avoid the struct's size
increase, move request->csd to the end of the struct.
The rationale of this strategy is that for cachelines >= 32 bytes, there
will never be used an extra cacheline for struct request:

- If request->csd is 32-byte aligned, there is no change in the object.
- If request->csd is not 32-byte aligned, and part of it is in a different
  cacheline, the whole csd is moved to that cacheline.
- If request->csd is not 32-byte aligned, but it's all contained in the
  same cacheline (> 32 bytes), aligning it to 32 will just put it a few
  bytes forward in this cacheline.

(In above example, the change kept the struct's size in 288 bytes).

Convert request->csd to csd_single_data_t and move it to the end of
struct request, so csd is never split between cachelines and don't use any
extra cachelines.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/blk-mq.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..50ef86172621 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -189,16 +189,16 @@ struct request {
 		} flush;
 	};
 
-	union {
-		struct __call_single_data csd;
-		u64 fifo_time;
-	};
-
 	/*
 	 * completion callback.
 	 */
 	rq_end_io_fn *end_io;
 	void *end_io_data;
+
+	union {
+		call_single_data_t csd;
+		u64 fifo_time;
+	};
 };
 
 static inline enum req_op req_op(const struct request *req)
-- 
2.40.1

