Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC4208987
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237203; cv=none; b=dAuuIQVi8m61SNOhK0fvMWlQRQLTuLed35eekG5Fl/ilki+PlqGGGYyiOPtWOehupYCiP5lqVK3UQqm3FiSi4AzujZBnHan8vznSCa0ChItNZWvoHE3c8Brdzy2NapYcUAIp9kY4IoOuyZq9te9q6XUiE96KtGm8Y+ZaxvBDUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237203; c=relaxed/simple;
	bh=PmbVHbQqaUUh2dd1LpC0jq3QZidZvxbA/ddCQUltq7Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HsOvr+eyMUrW9DRCJDp86Vl6+nDaCjqUlnF6QJBdm12k/rs7G6A+A2H/RKsplNrgeF/7hFaViGNr5U6pxyQemj2nzsw00WZmsi58hbN0FCPrz8w+WneTVJRG1NxeeU7JnnVRXoXzffy9jNOSxQz0mr/Hb2cHDw0BT3hAv1AJfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hMMJhlEt; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hMMJhlEt"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83aff992087so229351139f.3
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730237199; x=1730841999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gBLWyasJkEL9TLK3gPM3oVbgquu4aPKxqisrIj+Sxg=;
        b=hMMJhlEt5jcciZmLIhRlTgZvYzX5GOAYVQggtfLvCttA56WG+pxUx2iOnK6ZhixhrQ
         5/+I/wqEvNpraA9k+xHLlMoyf4iuNxtCATYVjzp0csE3kYBePLjp54HqR4QCg9v7I/jG
         6ra2Y7HVl2dn+F9EgkSxba15dFJGqdvglOB+XX2mcAWUwToHNX6Lk84A3H5rE5CYJ8ix
         o01ABPn5UXN5N+FFnbNK11LOxb4gXawDxqn8xea4xz/hvzMI4OAi2enNC0lopQkkCjlr
         i4FV1s1ln88NCcM3Diml1BJJgT6CyMhoa8b+jKF547BvKGl+V5Q45D+YwMgY1n6IiXlC
         oMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237199; x=1730841999;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gBLWyasJkEL9TLK3gPM3oVbgquu4aPKxqisrIj+Sxg=;
        b=UBXensDvwkMJHCvUuxFGo985rT4Oxeuc/usmHo/SfAVdr1Xy+MBZsYvHMiNPBP/sTn
         /GNZBBU4JhK+ylt8dhM/oKxkqeVMDQdRt8pfPjwa55SyQT/mxCvuOomg2Er1rDzFwdWI
         4XI9qR1oxCGFmaemUPQ0+3iHv+XuJ4jCNs8SwJxWeI6mUNYvHgWzdaz3ue+3EfDnSkBp
         wzJeoa/4zf6az+RdfB401tUMN2MC7qh3PiaLh4v0+HXjHkYUa9hTUgG6IPxczN3yRbAb
         LTBvR2CyCOvGNQAtIB8Sed6+Z51toZ2lZzNH/eJmmUzq9E292IhBXDM7dP4xFkvVbQGR
         U8VA==
X-Gm-Message-State: AOJu0Yxz2Ojto8de+ZHCA4glxei4GNteO4FEnseGbj9w96SIFJzvwltA
	gtofZ4AtYT9+UDAYNErYawsFmfaEBDZqfJxgcU4rUruq8oNAe6C9DoqZEm8Nhk0=
X-Google-Smtp-Source: AGHT+IFZfBlRDBfo2PgzGBk1w474xBvmIyLDWU/OTH8E8VW14lu97OKP2CkurNuRLbRPLiSByryxKA==
X-Received: by 2002:a05:6602:6419:b0:82a:ab20:f4bf with SMTP id ca18e2360f4ac-83b1c3b8a4dmr1268551139f.1.1730237199276;
        Tue, 29 Oct 2024 14:26:39 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc727514b4sm2598865173.105.2024.10.29.14.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 14:26:38 -0700 (PDT)
Message-ID: <f51e50c8-271e-49b6-b3e1-a63bf61d7451@kernel.dk>
Date: Tue, 29 Oct 2024 15:26:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 0/8] io_uring: support sqe group and leased group kbuf
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <15b9b1e0-d961-4174-96ed-5a6287e4b38b@gmail.com>
 <d859c85c-b7bf-4673-8c77-9d7113f19dbb@kernel.dk>
 <bc44d3c0-41e8-425c-957f-bad70aedcc50@kernel.dk>
 <e76d9742-5693-4057-b925-3917943c7441@kernel.dk>
Content-Language: en-US
In-Reply-To: <e76d9742-5693-4057-b925-3917943c7441@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 2:06 PM, Jens Axboe wrote:
> On 10/29/24 1:18 PM, Jens Axboe wrote:
>> Now, this implementation requires a user buffer, and as far as I'm told,
>> you currently have kernel buffers on the ublk side. There's absolutely
>> no reason why kernel buffers cannot work, we'd most likely just need to
>> add a IORING_RSRC_KBUFFER type to handle that. My question here is how
>> hard is this requirement? Reason I ask is that it's much simpler to work
>> with userspace buffers. Yes the current implementation maps them
>> everytime, we could certainly change that, however I don't see this
>> being an issue. It's really no different than O_DIRECT, and you only
>> need to map them once for a read + whatever number of writes you'd need
>> to do. If a 'tag' is provided for LOCAL_BUF, it'll post a CQE whenever
>> that buffer is unmapped. This is a notification for the application that
>> it's done using the buffer. For a pure kernel buffer, we'd either need
>> to be able to reference it (so that we KNOW it's not going away) and/or
>> have a callback associated with the buffer.
> 
> Just to expand on this - if a kernel buffer is absolutely required, for
> example if you're inheriting pages from the page cache or other
> locations you cannot control, we would need to add something ala the
> below:

Here's a more complete one, but utterly untested. But it does the same
thing, mapping a struct request, but it maps it to an io_rsrc_node which
in turn has an io_mapped_ubuf in it. Both BUFFER and KBUFFER use the
same type, only the destruction is different. Then the callback provided
needs to do something ala:

struct io_mapped_ubuf *imu = node->buf;

if (imu && refcount_dec_and_test(&imu->refs))
	kvfree(imu);

when it's done with the imu. Probably an rsrc helper should just be done
for that, but those are details.

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 9621ba533b35..050868a4c9f1 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -8,6 +8,8 @@
 #include <linux/nospec.h>
 #include <linux/hugetlb.h>
 #include <linux/compat.h>
+#include <linux/bvec.h>
+#include <linux/blk-mq.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -474,6 +476,9 @@ void io_free_rsrc_node(struct io_rsrc_node *node)
 		if (node->buf)
 			io_buffer_unmap(node->ctx, node);
 		break;
+	case IORING_RSRC_KBUFFER:
+		node->kbuf_fn(node);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
@@ -1070,6 +1075,65 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
 	return ret;
 }
 
+struct io_rsrc_node *io_rsrc_map_request(struct io_ring_ctx *ctx,
+					 struct request *req,
+					 void (*kbuf_fn)(struct io_rsrc_node *))
+{
+	struct io_mapped_ubuf *imu = NULL;
+	struct io_rsrc_node *node = NULL;
+	struct req_iterator rq_iter;
+	unsigned int offset;
+	struct bio_vec bv;
+	int nr_bvecs;
+
+	if (!bio_has_data(req->bio))
+		goto out;
+
+	nr_bvecs = 0;
+	rq_for_each_bvec(bv, req, rq_iter)
+		nr_bvecs++;
+	if (!nr_bvecs)
+		goto out;
+
+	node = io_rsrc_node_alloc(ctx, IORING_RSRC_KBUFFER);
+	if (!node)
+		goto out;
+	node->buf = NULL;
+
+	imu = kvmalloc(struct_size(imu, bvec, nr_bvecs), GFP_NOIO);
+	if (!imu)
+		goto out;
+
+	imu->ubuf = 0;
+	imu->len = 0;
+	if (req->bio != req->biotail) {
+		int idx = 0;
+
+		offset = 0;
+		rq_for_each_bvec(bv, req, rq_iter) {
+			imu->bvec[idx++] = bv;
+			imu->len += bv.bv_len;
+		}
+	} else {
+		struct bio *bio = req->bio;
+
+		offset = bio->bi_iter.bi_bvec_done;
+		imu->bvec[0] = *__bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+		imu->len = imu->bvec[0].bv_len;
+	}
+	imu->nr_bvecs = nr_bvecs;
+	imu->folio_shift = PAGE_SHIFT;
+	refcount_set(&imu->refs, 1);
+	node->buf = imu;
+	node->kbuf_fn = kbuf_fn;
+	return node;
+out:
+	if (node)
+		io_put_rsrc_node(node);
+	kfree(imu);
+	return NULL;
+}
+
 int io_local_buf_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index be9b490c400e..8d479f765fe0 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -11,6 +11,7 @@
 enum {
 	IORING_RSRC_FILE		= 0,
 	IORING_RSRC_BUFFER		= 1,
+	IORING_RSRC_KBUFFER		= 2,
 };
 
 struct io_rsrc_node {
@@ -19,6 +20,7 @@ struct io_rsrc_node {
 	u16				type;
 
 	u64 tag;
+	void (*kbuf_fn)(struct io_rsrc_node *);
 	union {
 		unsigned long file_ptr;
 		struct io_mapped_ubuf *buf;
@@ -52,6 +54,10 @@ int io_import_fixed(int ddir, struct iov_iter *iter,
 			   struct io_mapped_ubuf *imu,
 			   u64 buf_addr, size_t len);
 
+struct io_rsrc_node *io_rsrc_map_request(struct io_ring_ctx *ctx,
+					 struct request *req,
+					 void (*kbuf_fn)(struct io_rsrc_node *));
+
 int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg);
 int io_sqe_buffers_unregister(struct io_ring_ctx *ctx);
 int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,

-- 
Jens Axboe
