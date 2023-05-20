Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F398AC77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 05:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjETFbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 01:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjETFbE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 01:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5ABE40
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684560622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TsQ6Uoi0PuqANQq9Dc5Rtf0K/7M0kh0l6yP5OO5e04=;
        b=Tm8DGurV2nj3COff+TEd8K1xbiAKxiVPLVseTN8iwjQH+iOpkRGjwKA9I718Jgqfe9qiub
        NjnfHXetYFLZwXhbQwyRGaRjvf5IoEtQZ9xqOOJr0dIkQ4zk+zEe9RNNmyZclDp1YzZLd/
        cW3mkde1jFmJ7gj+Z+iQmiSSwbdHCtU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-p4ZiTDkbM1ic5tZhkoweUQ-1; Sat, 20 May 2023 01:30:21 -0400
X-MC-Unique: p4ZiTDkbM1ic5tZhkoweUQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-54fb26bc1dbso2671509eaf.3
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 22:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684560620; x=1687152620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TsQ6Uoi0PuqANQq9Dc5Rtf0K/7M0kh0l6yP5OO5e04=;
        b=f2qleUZ6nWaAJtn5vUL9gCGO15Co1rmGu4CiGW/OOA8z2w21aDvrEse1wbwyDI1MVB
         2RsPa8qAyDIya99RC2A5eMZtCAxlc7ryFp3kkYV78NhyZzsbKJm05KYDCFO/VXXTiBCu
         TxX3PP6EIwFomTFD2TI8IJD06Q+m41CdqkPxAr1s86nCUbLPIEGA//O27xoOEiNbAA0k
         hwBiD6lWflWCExmGijfbrzNUYDciDLzoe4x3Chj/LlwakeC2bPWslEnL4wyXAifbwlJx
         CaTnqYzBYJZmKpSU74cETTKgj+Dl803QuUu6+G5QRdtocVLhUPOGEDv1WPPKyo5Ncuoi
         IOgg==
X-Gm-Message-State: AC+VfDzhM2q4Ty26R3vs+/W/Ryw4Jo9wUWU586p3CSBeUjttPrrYjIOs
        GVvkhXlAfe1hABrG1NefzcXZp5GD0kDnCKtNOhtp1XNHDSDi58tTvTcrbktu0S8qUKpyNUWq/96
        92oFeGVIKfwN6GbctH5rinKw=
X-Received: by 2002:aca:1010:0:b0:394:a7b:5974 with SMTP id 16-20020aca1010000000b003940a7b5974mr2092074oiq.10.1684560620339;
        Fri, 19 May 2023 22:30:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7r8o3wAXxkFwKzZRhhNq/6TMpxr0tH2OIEhgZjpDqAjFAlCZk0yeWNiLsVzZld4cbpTh+kow==
X-Received: by 2002:aca:1010:0:b0:394:a7b:5974 with SMTP id 16-20020aca1010000000b003940a7b5974mr2092068oiq.10.1684560620161;
        Fri, 19 May 2023 22:30:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
        by smtp.gmail.com with ESMTPSA id j14-20020a4ad6ce000000b005524555de56sm365494oot.36.2023.05.19.22.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:30:19 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] blk-mq: Change request->csd type to call_single_data_t
Date:   Sat, 20 May 2023 02:29:57 -0300
Message-Id: <20230520052957.798486-3-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520052957.798486-1-leobras@redhat.com>
References: <20230520052957.798486-1-leobras@redhat.com>
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

This is proposed this way so it avoids doing 2 cacheline bounce when
running a csd request.

Changing request->csd to the aligned typedef was previously attempted in
commit 966a967116e6 ("smp: Avoid using two cache lines for struct call_single_data")
but at the time the union that contains csd was positioned near the top of
struct request, only below a struct list_head, and this caused the issue of
holes summing up 24 extra bytes in struct request.

The struct size was restored back to normal by
commit 4ccafe032005 ("block: unalign call_single_data in struct request")
but it caused the csd to be possibly split in 2 cachelines again.

Since request->csd was moved to be always 32-byte aligned inside
'struct request', changing it to the aligned typedef should not cause
any increased size or hole in the struct.

Since this is the last use of the unaligned struct outside smp code, having
this changed will allow us to change smp_call_function_single_async() to
only accept the aligned typedef, and avoid undesired extra cacheline
bounce in future code.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 44201e18681f..6033ef8eb4eb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -107,7 +107,7 @@ struct request {
 	struct block_device *part;
 
 	union {
-		struct __call_single_data csd;
+		call_single_data_t csd;
 		u64 fifo_time;
 	};
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
-- 
2.40.1

