Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165E220680
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596650; cv=none; b=Q7kr1S7kXc03J1UWzc1NRckWyMrUF7TLWzzYbM2DfznS6wW3cBP3wYYoe1ERWfRNGDthHWLjpL82biloYtARbgAAkPPAXQ59lyolO72kS2dPE2ZGl4plZ5R+DIXsMIeUYILZc9c7oJsJRWuGP4BHwW7YQId7TzfBwmtDGdsNToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596650; c=relaxed/simple;
	bh=SZM25R8h6MyQ0XZV18tqDb9d9snCFa1SEAZAE0HUMrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxiOPxjn3baHik5kPHODB5Zf6LtelqJtw2nM5z3EbGC1O2NX1oHUewYlQ3GxTpcNDcivheSS2ZzB8SY4dl7tkCyPYPJNEkp3G+PzVH32fLoK0waZdBH55OBKzeJnbSahutcn6k8B0FJBg07Z/f8XsGp1aRgUC+UELvNhcCiNwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Rn8rZTgo; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Rn8rZTgo"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso690255ab.1
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740596646; x=1741201446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rB4Eah3vxU92S35BcxthA4vQ5D4JS2TWUNxGQ43tWiY=;
        b=Rn8rZTgoJz7b47v5DJpzNFODzuCdlYwg9XvrWm8ia2PalIPtLB7KnZ1uOprl7IxP7x
         khLKzicxKORjxOIQkpQvrAbitVAIO4ROYT+F54O8HOgv8GOG2oLNuSyaRfG1cBGnpUcl
         HsjYeV3E015A/MJNk7kmsTRi5vRHxpaG4w9wHsHRq/qPvlrX3QkdcNW798P5G5NvGx7s
         nKlbBnVxco/UEi/xtUlr1G7mq+2CST5TnOf6R9y8fqWgKWyFZCQZQFIfOA44vA6dhrRC
         MBhqdw1ZC7geSGRk5f7vKErtGAwP09Rsg6AMjXj5pdfrXWKbDMh7wWCFBS6LjoWGmdVj
         w5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596646; x=1741201446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rB4Eah3vxU92S35BcxthA4vQ5D4JS2TWUNxGQ43tWiY=;
        b=Igxf4S5GRjH8PAtcHvlMmoHh5qHX/IUj5OTYm5D0JhzRmCLyZ2Kzo5PY5xgPbuxh5E
         /gQMUUKAguTBkcxwHpeWKTOlR+OURhosI1SKE9vxAwhFnbn+yIu+GKuFT/m1352NqMIC
         ZvkLfhSGcAJ9OqufK9ducZKHfY7bPAR8dFURef7Crt3K3V8M2SU1I1Qi1yYBOw3FjUfY
         IV5tzt+qr3h7xjB2uCt7y8qmgDvzPY1NRpbh5nA84IMSRuSxaYo2TPpRTDiA0I0//UEl
         Uaf0rQxOTNCkfW40pf84+OWwc3zLcE3ryjufRPl8ghYvNpusgSbQJdORW5Ej5fJPV8Zy
         CBrw==
X-Forwarded-Encrypted: i=1; AJvYcCXaKsK8rH01oCat3v1vg8cHbK4CGI0DXrJdvWP49pVcc6Wnjt0vjMbUkqnKgdGnmKZyAKUQd/q/2d4ivw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LvdgdxjvTTSP0zWR/gYzZt1kz0lx4zwFMD3uqFmwa3CKyCTT
	G485gcdR+4DE6seKi61j/eHP7dZ7sNLFw+Dls9I3jvgWKlAH2DCOQWqsTpyR8+o=
X-Gm-Gg: ASbGncvPVm/uh4gmvxzmFKsZTuoSh+msAtF7Sgo2OJaN++jntCClp3c9dvCtPIvNSg2
	V0Qi30tmK7+YZcq372INRaf1jMgE4uEkPt+aDJWSq1qmmMwKZ2PkJzB8fK2J63axrG1RTGrWJnZ
	I0foiE2+4m1ja/ik6xQMs4t3fkWAHQKrXe6YTSsk4raTi56oDsAAHXBn9Ug70FBtU4kB29CWxrJ
	EmNY7Q4H+JqidO3IASiJ/AQ5bJ3E3j/8flf0k6dKt+WxoIUmsvdX0nRhSIicwrE6x6aQO3WfVfF
	nfZ5RRB76RreOIEQRzOnEA==
X-Google-Smtp-Source: AGHT+IFGdm4gUg27Qjv/O1KCfXKyBBjOxuXWvgOi1stUm7jgCxRPXQd2w1RcykLJRLfUsqV6LYlAUQ==
X-Received: by 2002:a05:6e02:3f10:b0:3d3:d8af:6f with SMTP id e9e14a558f8ab-3d3d8af0135mr23418085ab.8.1740596646247;
        Wed, 26 Feb 2025 11:04:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3d93fa494sm2117805ab.35.2025.02.26.11.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:04:05 -0800 (PST)
Message-ID: <8b65adec-8888-40ae-b6c8-358fa836bcc6@kernel.dk>
Date: Wed, 26 Feb 2025 12:04:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 1/6] io_uring/rw: move fixed buffer import to issue path
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-2-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:20 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Registered buffers may depend on a linked command, which makes the prep
> path too early to import. Move to the issue path when the node is
> actually needed like all the other users of fixed buffers.

Conceptually I think this patch is fine, but it does bother me with
random bool arguments. We could fold in something like the (totally
tested) below diff to get rid of that. What do you think?

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 728d695d2552..a8a46a32f20d 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -248,8 +248,8 @@ static int io_prep_rw_pi(struct io_kiocb *req, struct io_rw *rw, int ddir,
 	return ret;
 }
 
-static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      int ddir, bool do_import)
+static int __io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+			int ddir)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	unsigned ioprio;
@@ -285,14 +285,6 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	rw->len = READ_ONCE(sqe->len);
 	rw->flags = READ_ONCE(sqe->rw_flags);
 
-	if (do_import && !io_do_buffer_select(req)) {
-		struct io_async_rw *io = req->async_data;
-
-		ret = io_import_rw_buffer(ddir, req, io, 0);
-		if (unlikely(ret))
-			return ret;
-	}
-
 	attr_type_mask = READ_ONCE(sqe->attr_type_mask);
 	if (attr_type_mask) {
 		u64 attr_ptr;
@@ -307,27 +299,52 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return ret;
 }
 
+static int io_rw_do_import(struct io_kiocb *req, int ddir)
+{
+	if (!io_do_buffer_select(req)) {
+		struct io_async_rw *io = req->async_data;
+		int ret;
+
+		ret = io_import_rw_buffer(ddir, req, io, 0);
+		if (unlikely(ret))
+			return ret;
+	}
+
+	return 0;
+}
+
+static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		      int ddir)
+{
+	int ret;
+
+	ret = __io_prep_rw(req, sqe, ddir);
+	if (unlikely(ret))
+		return ret;
+
+	return io_rw_do_import(req, ITER_DEST);
+}
+
 int io_prep_read(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_DEST, true);
+	return io_prep_rw(req, sqe, ITER_DEST);
 }
 
 int io_prep_write(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_SOURCE, true);
+	return io_prep_rw(req, sqe, ITER_SOURCE);
 }
 
 static int io_prep_rwv(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		       int ddir)
 {
-	const bool do_import = !(req->flags & REQ_F_BUFFER_SELECT);
 	int ret;
 
-	ret = io_prep_rw(req, sqe, ddir, do_import);
+	ret = io_prep_rw(req, sqe, ddir);
 	if (unlikely(ret))
 		return ret;
-	if (do_import)
-		return 0;
+	if (!(req->flags & REQ_F_BUFFER_SELECT))
+		return io_rw_do_import(req, ddir);
 
 	/*
 	 * Have to do this validation here, as this is in io_read() rw->len
@@ -364,12 +381,12 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 
 int io_prep_read_fixed(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_DEST, false);
+	return io_prep_rw(req, sqe, ITER_DEST);
 }
 
 int io_prep_write_fixed(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_SOURCE, false);
+	return io_prep_rw(req, sqe, ITER_SOURCE);
 }
 
 /*
@@ -385,7 +402,7 @@ int io_read_mshot_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (!(req->flags & REQ_F_BUFFER_SELECT))
 		return -EINVAL;
 
-	ret = io_prep_rw(req, sqe, ITER_DEST, false);
+	ret = io_prep_rw(req, sqe, ITER_DEST);
 	if (unlikely(ret))
 		return ret;
 

-- 
Jens Axboe
