Return-Path: <SRS0=L9ug=Y3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34BCA9EB0
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518362080F
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 13:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jl6cm1NA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKCNwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Nov 2019 08:52:55 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41767 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCNwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 08:52:55 -0500
Received: by mail-pf1-f182.google.com with SMTP id p26so10350266pfq.8
        for <linux-block@vger.kernel.org>; Sun, 03 Nov 2019 05:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=npJAZwa7jO+vJ5i4Dcw+v6kRT6Yp9OJ4hdaDfGsvxjo=;
        b=jl6cm1NALSrVgHBHkpPzitWjU7FN5GUqQC4jO132XM7LNDtZpVk+QQN06TcMiGNIZu
         VnokiYEA3m6SX4sCxqgN+NJtzxqjAUvcQZKb7ycsfUoyvssuvUdkNCHteCnU6vZ/Vhyu
         4ZlKKpo+3tXcdk8Kws13m694LZZ3r4qSSgg7NG5YntRoEItKoRUfvKQUav9pIRqbGp35
         +K1c6y23qorkXeW4W5JfOjTYQ81NF7i6nAVsil00QdzDwQlHdc2uZmn+T152sNtl5spo
         8+oJPtiL5BP837XBpX9KKT2YGqTPiLRR8KvnqijSi3MzkS8+pCCFZW3vZFmOXDQXd3T0
         BdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=npJAZwa7jO+vJ5i4Dcw+v6kRT6Yp9OJ4hdaDfGsvxjo=;
        b=JxsvNFUkeXWSLE9hGnKt2x8AxpZL5xGxOpQx7PAnkusS9oCY4Wuk9YkriS9gKhml/5
         VEs4iFmRD/qZ3vwho6sbq5QBn8IDwBuHMMDjfbErvjFpjCGyWJuwG2drHBoM1zQ1pxF7
         +HqN3e7V196nchkJEOEN6dDPTqj1gAPKNr+NBy51rISi6eFM1+1DdeDR9odCUfKCV/y4
         CUc/7mWDPsthH7rNnkbFQw9LDNdI5EuUpJiVNtdWSYlnm4+euDAZiMncK2szln1SUtaS
         I46ZWpEoL5jiielFXYt3ceKnD0qi5bIr014KC2ItnKteiWSj6Pg/GlISFnD7ydpvRVhm
         qSjw==
X-Gm-Message-State: APjAAAVHMzHAWbtSroCl42Akk8h2nWEtn7ERGF38IiptXW9UI1KgFDPH
        jVh3zvl2w7YTVyRD1olQb01oUw==
X-Google-Smtp-Source: APXvYqwIcGSuZEuxfIkTKArWK/cmcSsCxoof/rPAcMRh7YO+o75Ao26u6GCMn4jqsdnk6VXlP1R2Qw==
X-Received: by 2002:a63:1c24:: with SMTP id c36mr24451571pgc.292.1572789173966;
        Sun, 03 Nov 2019 05:52:53 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 193sm11162981pfv.18.2019.11.03.05.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 05:52:52 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: add completion trace event
Message-ID: <34cc75d5-33d8-9dd5-747b-2375dc17823c@kernel.dk>
Date:   Sun, 3 Nov 2019 06:52:50 -0700
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

We currently don't have a completion event trace, add one of those. And
to better be able to match up submissions and completions, add user_data
to the submission trace as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a520c4262d85..3230a4a278b4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -592,6 +601,8 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 {
 	struct io_uring_cqe *cqe;
 
+	trace_io_uring_complete(ctx, ki_user_data, res);
+
 	/*
 	 * If we can't get a cq entry, userspace overflowed the
 	 * submission (by quite a lot). Increment the overflow count in
@@ -2733,7 +2746,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		s.has_user = *mm != NULL;
 		s.in_async = true;
 		s.needs_fixed_file = true;
-		trace_io_uring_submit_sqe(ctx, true, true);
+		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, true);
 		io_submit_sqe(ctx, &s, statep, &link);
 		submitted++;
 	}
@@ -2913,7 +2926,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 		s.needs_fixed_file = false;
 		s.ring_fd = ring_fd;
 		submit++;
-		trace_io_uring_submit_sqe(ctx, true, false);
+		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, false);
 		io_submit_sqe(ctx, &s, statep, &link);
 	}
 
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index 8f21d8bf20fd..72a4d0174b02 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -284,10 +284,43 @@ TRACE_EVENT(io_uring_fail_link,
 	TP_printk("request %p, link %p", __entry->req, __entry->link)
 );
 
+/**
+ * io_uring_complete - called when completing an SQE
+ *
+ * @ctx:		pointer to a ring context structure
+ * @user_data:		user data associated with the request
+ * @res:		result of the request
+ *
+ */
+TRACE_EVENT(io_uring_complete,
+
+	TP_PROTO(void *ctx, u64 user_data, long res),
+
+	TP_ARGS(ctx, user_data, res),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx		)
+		__field(  u64,		user_data	)
+		__field(  long,		res		)
+	),
+
+	TP_fast_assign(
+		__entry->ctx		= ctx;
+		__entry->user_data	= user_data;
+		__entry->res		= res;
+	),
+
+	TP_printk("ring %p, user_data 0x%llx, result %ld",
+			  __entry->ctx, (unsigned long long)__entry->user_data,
+			  __entry->res)
+);
+
+
 /**
  * io_uring_submit_sqe - called before submitting one SQE
  *
- * @ctx:			pointer to a ring context structure
+ * @ctx:		pointer to a ring context structure
+ * @user_data:		user data associated with the request
  * @force_nonblock:	whether a context blocking or not
  * @sq_thread:		true if sq_thread has submitted this SQE
  *
@@ -296,24 +329,27 @@ TRACE_EVENT(io_uring_fail_link,
  */
 TRACE_EVENT(io_uring_submit_sqe,
 
-	TP_PROTO(void *ctx, bool force_nonblock, bool sq_thread),
+	TP_PROTO(void *ctx, u64 user_data, bool force_nonblock, bool sq_thread),
 
-	TP_ARGS(ctx, force_nonblock, sq_thread),
+	TP_ARGS(ctx, user_data, force_nonblock, sq_thread),
 
 	TP_STRUCT__entry (
-		__field(  void *,	ctx				)
+		__field(  void *,	ctx		)
+		__field(  u64,		user_data	)
 		__field(  bool,		force_nonblock	)
-		__field(  bool,		sq_thread		)
+		__field(  bool,		sq_thread	)
 	),
 
 	TP_fast_assign(
-		__entry->ctx			= ctx;
+		__entry->ctx		= ctx;
+		__entry->user_data	= user_data;
 		__entry->force_nonblock	= force_nonblock;
-		__entry->sq_thread		= sq_thread;
+		__entry->sq_thread	= sq_thread;
 	),
 
-	TP_printk("ring %p, non block %d, sq_thread %d",
-			  __entry->ctx, __entry->force_nonblock, __entry->sq_thread)
+	TP_printk("ring %p, user data 0x%llx, non block %d, sq_thread %d",
+			  __entry->ctx, (unsigned long long) __entry->user_data,
+			  __entry->force_nonblock, __entry->sq_thread)
 );
 
 #endif /* _TRACE_IO_URING_H */

-- 
Jens Axboe

