Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E6CA9ED0
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2734121897
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 18:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dlo+OrYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKASq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:46:27 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:45687 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfKASq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 14:46:27 -0400
Received: by mail-il1-f173.google.com with SMTP id b12so9456415ilf.12
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2019 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=aJk8LNC3w04VF3SeX7pVMoQTN40exP5dY/01eW7i8Y0=;
        b=dlo+OrYZ8+CGG4YrggpS9xVNk25HlgDTEA6mFulDnfr/m4ILrqUBat1IWmPd4w0V4E
         eHMadJD1mz46I+EVOISK1AAkcbpXD5mmvoxaRP6VhXGF5qFijtErlXLhfbDEBeSqg3vn
         WR1bNvbx+oy+t5ZSpVyuhje7Ekpma3MUowpfQBV7OAzhq8/3sHpgGlGuRl/IfLwUXxcy
         LnS5Xap4hX3EGGA3o0GP7gP0fnSb4UJcJMa4D0h7sVn1ZjvJv6I40Fmtc9uT0hqjYs2T
         A7oy2lup2TiczyVDYFjjdhQWC8IIkcfHWDNnu6XHT3Z1Ab417LTyVOOV3pPATjATU5tL
         c62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=aJk8LNC3w04VF3SeX7pVMoQTN40exP5dY/01eW7i8Y0=;
        b=crNQsQ/U+X2jkCF7O7ZkEqQ5I78011wCIM98fYKcVVOzKEMujsZWheyl00kXTWc0ZN
         8VhfqiQjeuyMPKGFI/HCmmH3d9Gt5ikGSQW2Cw3SJpxJ9Uq3jA/xiBPi6zFomv28y3IW
         txxpobE64TJeictAdy5GOm7GSV8UbtsQEls6drEQmB62ev84FnmzljNh0+NBheCaxnN9
         I5VhawyYHf65ICTVrY1HG9eT3DRvwGQvlU4ifg5K+BChKrsfXZDqIOf3FRzrm5DOzwYq
         tJM7XuTQn20QbGgOadDUAWY3m0t2aJ1qvmavqtczs4f0YZ3Evaij+FiCYqMd5VowIP0F
         HMUg==
X-Gm-Message-State: APjAAAW+HA4fC7IeI9FSuP2erK1aUBopM6UeWuL6wq0wLq6JdAQTv9ls
        R8bR3VtLmbgiZV+W5gswDbNrYZX20fs1sA==
X-Google-Smtp-Source: APXvYqzpScgf/01RdgvOHRfhfE0unK+LS30yKlEv7uwiMHUdKu4uouULMB2m+Y3XY99akKbrqUxhZQ==
X-Received: by 2002:a92:46d9:: with SMTP id d86mr13071676ilk.253.1572633986564;
        Fri, 01 Nov 2019 11:46:26 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v13sm1202108ili.65.2019.11.01.11.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 11:46:25 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: remove io_uring_add_to_prev() trace event
Message-ID: <5faa3d2a-81db-bba5-a5a1-560c907220c9@kernel.dk>
Date:   Fri, 1 Nov 2019 12:46:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This internal logic was killed with the conversion to io-wq, so we no
longer have a need for this particular trace. Kill it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index b85255121b98..8f21d8bf20fd 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -227,35 +227,6 @@ TRACE_EVENT(io_uring_link,
 			  __entry->ctx, __entry->req, __entry->target_req)
 );
 
-/**
- * io_uring_add_to_prev - called after a request was added into a previously
- * 						  submitted work
- *
- * @req:	pointer to a request, added to a previous
- * @ret:	whether or not it was completed successfully
- *
- * Allows to track merged work, to figure out how often requests are piggy
- * backed into other ones, changing the execution flow.
- */
-TRACE_EVENT(io_uring_add_to_prev,
-
-	TP_PROTO(void *req, bool ret),
-
-	TP_ARGS(req, ret),
-
-	TP_STRUCT__entry (
-		__field(  void *,	req	)
-		__field(  bool,		ret	)
-	),
-
-	TP_fast_assign(
-		__entry->req	= req;
-		__entry->ret	= ret;
-	),
-
-	TP_printk("request %p, ret %d", __entry->req, __entry->ret)
-);
-
 /**
  * io_uring_cqring_wait - called before start waiting for an available CQE
  *

-- 
Jens Axboe

