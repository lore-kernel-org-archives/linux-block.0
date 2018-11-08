Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541700272.196084.226.camel@acm.org>
Subject: Re: [PATCH 1/2] blk-mq-tag: change busy_iter_fn to return whether
 to continue or not
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date: Thu, 08 Nov 2018 10:04:32 -0800
In-Reply-To: <57c15689-c5bd-be21-6a19-fbf7eb7dfcd0@kernel.dk>
References: <20181108160609.27568-1-axboe@kernel.dk>
	 <20181108160609.27568-3-axboe@kernel.dk>
	 <1541694515.196084.218.camel@acm.org>
	 <8a340d9c-da15-90c9-760e-fb80fb2871b6@kernel.dk>
	 <1541698519.196084.225.camel@acm.org>
	 <c4ce645a-1e09-02eb-ca41-088e83a55cd8@kernel.dk>
	 <57c15689-c5bd-be21-6a19-fbf7eb7dfcd0@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-11-08 at 10:50 -0700, Jens Axboe wrote:
+AD4 How about this incremental?
+AD4 
+AD4 diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
+AD4 index 097e9a67d5f5..87bc5df72d48 100644
+AD4 --- a/block/blk-mq-tag.c
+AD4 +-+-+- b/block/blk-mq-tag.c
+AD4 +AEAAQA -248,7 +-248,8 +AEAAQA static bool bt+AF8-iter(struct sbitmap +ACo-bitmap, unsigned int bitnr, void +ACo-data)
+AD4   +ACo +AEA-fn:		Pointer to the function that will be called for each request
+AD4   +ACo		associated with +AEA-hctx that has been assigned a driver tag.
+AD4   +ACo		+AEA-fn will be called as follows: +AEA-fn(+AEA-hctx, rq, +AEA-data, +AEA-reserved)
+AD4 - +ACo		where rq is a pointer to a request.
+AD4 +- +ACo		where rq is a pointer to a request. Return true to continue
+AD4 +- +ACo		iterating tags, false to stop.
+AD4   +ACo +AEA-data:	Will be passed as third argument to +AEA-fn.
+AD4   +ACo +AEA-reserved:	Indicates whether +AEA-bt is the breserved+AF8-tags member or the
+AD4   +ACo		bitmap+AF8-tags member of struct blk+AF8-mq+AF8-tags.
+AD4 +AEAAQA -301,7 +-302,8 +AEAAQA static bool bt+AF8-tags+AF8-iter(struct sbitmap +ACo-bitmap, unsigned int bitnr, void +ACo-data)
+AD4   +ACo		or the bitmap+AF8-tags member of struct blk+AF8-mq+AF8-tags.
+AD4   +ACo +AEA-fn:		Pointer to the function that will be called for each started
+AD4   +ACo		request. +AEA-fn will be called as follows: +AEA-fn(rq, +AEA-data,
+AD4 - +ACo		+AEA-reserved) where rq is a pointer to a request.
+AD4 +- +ACo		+AEA-reserved) where rq is a pointer to a request. Return true
+AD4 +- +ACo		to continue iterating tags, false to stop.
+AD4   +ACo +AEA-data:	Will be passed as second argument to +AEA-fn.
+AD4   +ACo +AEA-reserved:	Indicates whether +AEA-bt is the breserved+AF8-tags member or the
+AD4   +ACo		bitmap+AF8-tags member of struct blk+AF8-mq+AF8-tags.
+AD4 +AEAAQA -326,7 +-328,8 +AEAAQA static void bt+AF8-tags+AF8-for+AF8-each(struct blk+AF8-mq+AF8-tags +ACo-tags, struct sbitmap+AF8-queue +ACo-bt,
+AD4   +ACo +AEA-fn:		Pointer to the function that will be called for each started
+AD4   +ACo		request. +AEA-fn will be called as follows: +AEA-fn(rq, +AEA-priv,
+AD4   +ACo		reserved) where rq is a pointer to a request. 'reserved'
+AD4 - +ACo		indicates whether or not +AEA-rq is a reserved request.
+AD4 +- +ACo		indicates whether or not +AEA-rq is a reserved request. Return
+AD4 +- +ACo		true to continue iterating tags, false to stop.
+AD4   +ACo +AEA-priv:	Will be passed as second argument to +AEA-fn.
+AD4   +ACo-/
+AD4  static void blk+AF8-mq+AF8-all+AF8-tag+AF8-busy+AF8-iter(struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4 +AEAAQA -343,7 +-346,8 +AEAAQA static void blk+AF8-mq+AF8-all+AF8-tag+AF8-busy+AF8-iter(struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4   +ACo +AEA-fn:		Pointer to the function that will be called for each started
+AD4   +ACo		request. +AEA-fn will be called as follows: +AEA-fn(rq, +AEA-priv,
+AD4   +ACo		reserved) where rq is a pointer to a request. 'reserved'
+AD4 - +ACo		indicates whether or not +AEA-rq is a reserved request.
+AD4 +- +ACo		indicates whether or not +AEA-rq is a reserved request. Return
+AD4 +- +ACo		true to continue iterating tags, false to stop.
+AD4   +ACo +AEA-priv:	Will be passed as second argument to +AEA-fn.
+AD4   +ACo-/
+AD4  void blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-tagset,

This looks fine to me. Thanks+ACE

Bart.
