Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71681940B3
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232381; cv=none; b=kbJdaKq0j5+9zf/J1ijhdrLn15+xyXW3uN4U4ZuthMgICg5NvATcSL6I0Sj6+aC6YgF5Fno3ZgjAn/wOgHNpwJOcU0VG9Y5fLy9rCW9mFAXjc/a1/hz7i+A7XpJ768szNLIU6akpI4oBphR4ujS00GWeaxwy8xM22F97Z/hgxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232381; c=relaxed/simple;
	bh=Q0zY5q/gfEUB4doo9/xB0VlL5+YqmraHt/N8wEl0Fwo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rajpEgzUEPYb2L4tey5xRAurAanjN85mirL0ULU0RzXSdYn7/P9rpOIOZU204LIUSL8y/p61XYvv5AVObOZy/dLzp7jBCnoPu6+HTvk8kOqiSc5d6A0WkghXT4+CUCap2o6AWreW6VHpmvQS3wHjhvbEsC2QNcXXwztECLLuRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B2m/EUsx; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B2m/EUsx"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3b6b281d4so23744565ab.0
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730232376; x=1730837176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ME7EzKC+o7CpjjbIElq0hh/ll5Q0RfHtEHXdb8pO2L4=;
        b=B2m/EUsxk35tUj2lOmauZ1pxi7awL/9NOK3IEHo1/d4IuXO3ImIpifGxpw5Dk0WmaQ
         R5Lqpgqd8ImshwMVrBpy2wcYw6KTYuayxDrFt2O/guvB6TiyQkZXK952/ld0uqP33CCg
         Be46u9E/TWFvXe1nDm6obMBkNGbtF1F/r2q2rNrO4AVO1JC8NXi6I0FLRKyOJyrGqyoU
         /SCChcIcRYh/2eJCaPPns8vv6rsXTAy7JUKcEvepiO4jd5bLJsXTs0gN5ky1c61IZFHB
         Zfl3zBs5GoW44l7/n//ld3ulf/MYgXx8lCQwnaSOh4qVe/kHQGoLSpNoA20rHimSAUz9
         54kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730232376; x=1730837176;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ME7EzKC+o7CpjjbIElq0hh/ll5Q0RfHtEHXdb8pO2L4=;
        b=o3NyjwtNG/9r0u5K8MWvqUxVe42GzHpSvNjdMVsp5wD4SQxMhOaTA5EWE7IJNg8hiG
         mSLas0c0gCTsW4nOKL9108laMHoBsjppq6ygak4XxQyggkKxfBIiPnZu7QyG5+mPZOxG
         9cEh8PlWnTETRltmHXKSflwvld6Ji638sp5wWBpKZ9/ziaNXTuEOutbQDe5vKlImA/0S
         XpipWdsuYBLvUNEsHSRXWhbJTtFOWSH+Q5ijHGHZ8o+SXuXwTN2qFmUzPp2DYqoj89Jy
         DuXHlxW7q0aZsz1WqSwgayMA4FjuJW9dK3mBxTb8d4kSFqEhLM8tTk6x2asI/DcjdfBC
         7TVQ==
X-Gm-Message-State: AOJu0YybIcinq4Nu9UBNEpNYskg+kHEckwV7pjeJPgiQJXzEyCEbzMgp
	o3DytZdv0r4FfX2ArSVy3n5IPi0T5lpL6wV0BYeenhxT9scxw+XeYnHtkWsJYWU=
X-Google-Smtp-Source: AGHT+IFFBdXqYZ0aWKOtqf5/7jjV2BkmS9VSTL+Gap9Z5t0gCkfS9LAa5pUqjx+cOJpf1BzEifFl0w==
X-Received: by 2002:a92:1905:0:b0:3a4:e6f6:4b0b with SMTP id e9e14a558f8ab-3a4ed282bbdmr101386605ab.10.1730232375556;
        Tue, 29 Oct 2024 13:06:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4e6df59d8sm24710755ab.39.2024.10.29.13.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 13:06:14 -0700 (PDT)
Message-ID: <e76d9742-5693-4057-b925-3917943c7441@kernel.dk>
Date: Tue, 29 Oct 2024 14:06:14 -0600
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
Content-Language: en-US
In-Reply-To: <bc44d3c0-41e8-425c-957f-bad70aedcc50@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 1:18 PM, Jens Axboe wrote:
> Now, this implementation requires a user buffer, and as far as I'm told,
> you currently have kernel buffers on the ublk side. There's absolutely
> no reason why kernel buffers cannot work, we'd most likely just need to
> add a IORING_RSRC_KBUFFER type to handle that. My question here is how
> hard is this requirement? Reason I ask is that it's much simpler to work
> with userspace buffers. Yes the current implementation maps them
> everytime, we could certainly change that, however I don't see this
> being an issue. It's really no different than O_DIRECT, and you only
> need to map them once for a read + whatever number of writes you'd need
> to do. If a 'tag' is provided for LOCAL_BUF, it'll post a CQE whenever
> that buffer is unmapped. This is a notification for the application that
> it's done using the buffer. For a pure kernel buffer, we'd either need
> to be able to reference it (so that we KNOW it's not going away) and/or
> have a callback associated with the buffer.

Just to expand on this - if a kernel buffer is absolutely required, for
example if you're inheriting pages from the page cache or other
locations you cannot control, we would need to add something ala the
below:

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 9621ba533b35..b0258eb37681 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -474,6 +474,10 @@ void io_free_rsrc_node(struct io_rsrc_node *node)
 		if (node->buf)
 			io_buffer_unmap(node->ctx, node);
 		break;
+	case IORING_RSRC_KBUFFER:
+		if (node->buf)
+			node->kbuf_fn(node->buf);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index be9b490c400e..8d00460d47ff 100644
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
+	void (*kbuf_fn)(struct io_mapped_ubuf *);
 	union {
 		unsigned long file_ptr;
 		struct io_mapped_ubuf *buf;

and provide a helper that allocates an io_rsrc_node, sets it to type
IORING_RSRC_KBUFFER, and assigns a ->kbuf_fn() that gets a callback when
the final put of the node happens. Whatever ublk command that wants to
do zero copy would call this helper at prep time and set the
io_submit_state buffer to be used.

Likewise, probably provide an io_rsrc helper that can be called by
kbuf_fn as well to do final cleanup, so that the callback itself is only
tasked with whatever it needs to do once it's received the data.

For this to work, we'll absolutely need the provider to guarantee that
the pages mapped will remain persistent until that callback is received.
Or have a way to reference the data inside rsrc.c. I'm imagining this is
just stacking the IO, so eg you get a read with some data already in
there that you don't control, and you don't complete this read until
some other IO is done. That other IO is what is using the buffer
provided here.

Anyway, just a suggestion if the user provided memory is a no-go, there
are certainly ways we can make this trivially work with memory you
cannot control that is received from inside the kernel, without a lot of
additions.

-- 
Jens Axboe
