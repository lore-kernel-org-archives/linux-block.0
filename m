Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418A3D6B
	for <linux-block@vger.kernel.org>; Thu, 10 Oct 2024 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588689; cv=none; b=UwYOBTalyyG3mqPylDqArHosz9k6t0Fqo/CBD0r+tPGJ0h3S9QWoOBgAXcaNApAlY/u4eAPRd91skY0C9Q7xEucKxzxDijW50zGmTof4I+QYeJpToxnv7znWDAMeJVbZWtJXMQYEIZltY4q672ZrjmCnrL7+qsNYPx1BmVQH/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588689; c=relaxed/simple;
	bh=12QdTrNcCiAoL6tcG+CpDGmDROSVd3cKGB/868m13Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+hPgj6pucRmlCj/lnsmfhNNc9OczLTPtnyXywGYq9G2gAeN1EO4xz3qqOxLBkYS+PBXY5wSESnPiP+h/WSDBIeUxtF/FNl4OGq00t7ZMvtsMAviOeSY3wrq/1FPmScKkbnyC56V7V09khup/J6KJVj7Z8n69LjmCVoLWLdy0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KDbVKdW8; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KDbVKdW8"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8377fd760b0so14714939f.2
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2024 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728588684; x=1729193484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spnUaRSzdRBnptMZqzssihls7EmfH7EgrK6Ami2ZaaU=;
        b=KDbVKdW8ceIcXCjmr0icp6OFrGy5US8zXGxt9+LBrwKWrw2Kjn+iKbIWVSvC8vWMRS
         y0A5gOFxlbHN+ZnsIQ+VIKWseeAqOzlWY8V4cNNWNZK46hfRc/neXwR9DieFgoH8SlPW
         FJ+9Ho5IhOgtSRHoOphe1+XAL+WuQgNSEkroyQn1MKpgHcrmbgwnzHvhqgqZ702zbYj5
         Gic9sTIKIs6iBIXm4vu3D6PC3RsOM0PNLMExM48oNY5Fxe8YRb6kND2EIj0F9akC9nov
         MKtpmQGHEagM44R1nEkYUy1t9zeY+7wMUM1cGGrHHG9kf9+NpPJY2hxfw3StK0v5XffT
         wDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588684; x=1729193484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spnUaRSzdRBnptMZqzssihls7EmfH7EgrK6Ami2ZaaU=;
        b=Ppa9JQcJ75tB8tWvi/wLM1+7O9MAvFgJdymTEHBaPf9DC1M1n8oKDFAvLbX0ptjyqi
         69GnwWnuKKchfESYLuMBZ3qD8HvAaROaFfxAXFjqCZdoOyggi6jhkbB/kVP/nvLgQ+Du
         vgBVx6HhTf7PlIXXvIYiHLARvUwgncSEojT/Q55J+EG2F/e5jNvNuSSC93y4Hg2TOiVD
         mZ8IcQS9FpgKYObzB8r0YE9nyhyCQ+TPpC7fuckj02u1+LsaIhzS35LG/ADYGaTKofY2
         xAOun8S/qVPob3WZJCh05AtPvjP0M0oUdQg88aV42DdTOYRcLM9OQeuJRPvzmjbTsd/k
         J5bA==
X-Forwarded-Encrypted: i=1; AJvYcCXNifJLIvAif+O9RVJZUjo5qnHZfhEnGGN7JStNQ2bouTud6npF3aOLcaKRXJTYFDVD3VuZAIerfV7DHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QTOfr9PNR5bhB4OXAEIRcHD1hKndCUTKAVIt9giCSskA5N3r
	hCE7tR55qB6yQ6Nh+YkNxSDrJRs29St/PUguUOFxmwTSyjPB2eueZq/dwKHckA3BYjNDOAHwHwn
	sGd4=
X-Google-Smtp-Source: AGHT+IG7QjsSxwt8l2+Tvy2EYNGV2L0M/5m6cRB5kDmTmxXmoUGWLaS4uG+b8eG6jt4jFBZeDCxBDw==
X-Received: by 2002:a05:6602:4886:b0:82d:835:e66d with SMTP id ca18e2360f4ac-837932dc7cemr5370039f.9.1728588683752;
        Thu, 10 Oct 2024 12:31:23 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada84b54sm353318173.110.2024.10.10.12.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 12:31:22 -0700 (PDT)
Message-ID: <655b3348-27a1-4bc7-ade7-4d958a692d0b@kernel.dk>
Date: Thu, 10 Oct 2024 13:31:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 7/8] io_uring/uring_cmd: support provide group kernel
 buffer
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20240912104933.1875409-1-ming.lei@redhat.com>
 <20240912104933.1875409-8-ming.lei@redhat.com>
 <b232fa58-1255-44b2-92c9-f8eb4f70e2c9@gmail.com> <ZwJObC6mzetw4goe@fedora>
 <38ad4c05-6ee3-4839-8d61-f8e1b5219556@gmail.com> <ZwdJ7sDuHhWT61FR@fedora>
 <4b40eff1-a848-4742-9cb3-541bf8ed606e@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4b40eff1-a848-4742-9cb3-541bf8ed606e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Discussed this with Pavel, and on his suggestion, I tried prototyping a
"buffer update" opcode. Basically it works like
IORING_REGISTER_BUFFERS_UPDATE in that it can update an existing buffer
registration. But it works as an sqe rather than being a sync opcode.

The idea here is that you could do that upfront, or as part of a chain,
and have it be generically available, just like any other buffer that
was registered upfront. You do need an empty table registered first,
which can just be sparse. And since you can pick the slot it goes into,
you can rely on that slot afterwards (either as a link, or just the
following sqe).

Quick'n dirty obviously, but I did write a quick test case too to verify
that:

1) It actually works (it seems to)
2) It's not too slow (it seems not to be, I can get ~2.5M updates per
   second in a vm on my laptop, which isn't too bad).

Not saying this is perfect, but perhaps it's worth entertaining an idea
like that? It has the added benefit of being persistent across system
calls as well, unless you do another IORING_OP_BUF_UPDATE at the end of
your chain to re-set it.

Comments? Could it be useful for this?

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 86cb385fe0b5..02d4b66267ef 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -259,6 +259,7 @@ enum io_uring_op {
 	IORING_OP_FTRUNCATE,
 	IORING_OP_BIND,
 	IORING_OP_LISTEN,
+	IORING_OP_BUF_UPDATE,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index a2be3bbca5ff..cda35d22397d 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -515,6 +515,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_eopnotsupp_prep,
 #endif
 	},
+	[IORING_OP_BUF_UPDATE] = {
+		.prep			= io_buf_update_prep,
+		.issue			= io_buf_update,
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -742,6 +746,9 @@ const struct io_cold_def io_cold_defs[] = {
 	[IORING_OP_LISTEN] = {
 		.name			= "LISTEN",
 	},
+	[IORING_OP_BUF_UPDATE] = {
+		.name			= "BUF_UPDATE",
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 33a3d156a85b..6f0071733018 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1236,3 +1236,44 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
 		fput(file);
 	return ret;
 }
+
+struct io_buf_update {
+	struct file *file;
+	struct io_uring_rsrc_update2 up;
+};
+
+int io_buf_update_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_buf_update *ibu = io_kiocb_to_cmd(req, struct io_buf_update);
+	struct io_uring_rsrc_update2 __user *uaddr;
+
+	if (!req->ctx->buf_data)
+		return -ENXIO;
+	if (sqe->ioprio || sqe->fd || sqe->addr2 || sqe->rw_flags ||
+	    sqe->splice_fd_in)
+		return -EINVAL;
+	if (sqe->len != 1)
+		return -EINVAL;
+
+	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	if (copy_from_user(&ibu->up, uaddr, sizeof(*uaddr)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int io_buf_update(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_buf_update *ibu = io_kiocb_to_cmd(req, struct io_buf_update);
+	struct io_ring_ctx *ctx = req->ctx;
+	int ret;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	ret = __io_register_rsrc_update(ctx, IORING_RSRC_BUFFER, &ibu->up, ibu->up.nr);
+	io_ring_submit_unlock(ctx, issue_flags);
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return 0;
+}
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 8ed588036210..d41e75c956ef 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -142,4 +142,7 @@ static inline void __io_unaccount_mem(struct user_struct *user,
 	atomic_long_sub(nr_pages, &user->locked_vm);
 }
 
+int io_buf_update_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_buf_update(struct io_kiocb *req, unsigned int issue_flags);
+
 #endif

-- 
Jens Axboe
