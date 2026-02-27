Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13233446B5
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210916; cv=none; b=AF7B9+RZ+rBTeG+OMP6bO6/S+MXhpYuON3N58CkOCU3IvEs9B30+1VJVp78jDaG5dCUHbyHBkBi3XLvO5U0EwiVdXv+ArE3rQeSb8x/RI7WX96Ho6TdyKtNv5acE2yck4JaXR2Y+pFyDBdY2U4DU1APhJ/WepIaf+FgpDuGDCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210916; c=relaxed/simple;
	bh=QW5TwqXWGV3wyZ1o8DqpOoW7p2LGvABwdIKFBtgrz9Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MHaxu/5dVdG+hRkF0DO6YOIT/bq6ajfaNbVZ1KIvyAOoXwG+VfIFDbOEciQbVyFHqqE37b4n718oA48LcaDs0JyZYEx38eQ/bFuma76i3j5H5k1rkUCQYs4h5tUmzl0p14MisdCj0E17b5ygNv9iJxUoCSJYJi4aG+MavPultx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bHAhqgPk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bHAhqgPk"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb420f7500so211009785a.2
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772210913; x=1772815713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUCcTS13gqM9wet50xftFq2W4jVHNT7D+6rY3w/B14M=;
        b=bHAhqgPkuhKmu9SF0ONEIjjplHMEv1B+VuBgLBPv09ieoOAW3h976mAlkUYSNjHANb
         egU6HT6m/kJdkedt4DX3Av61zAA/RBw7BYSBfcBjd43SXBOYgzbqfBqfmnm1pKnWQFPz
         k2BUOdmgqFaV52U0w2SGEVZF1SSBKe6uGvMO0BQpt+W6UwrECSOkxkFx6+PylzUweuh5
         3GKKvF9YyV1mE922FT+e3HOQxrW/hv3OsQ4eqj/Kcvkdz99J2OJp17cfHKx8L37qKk0F
         MnAshx1dY16032fn10caT9QstEDm1NhCdybWpILnYea4DxmnBDydvm7x8c4VUhrWaOiH
         BUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210913; x=1772815713;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUCcTS13gqM9wet50xftFq2W4jVHNT7D+6rY3w/B14M=;
        b=XBMhpATtebiNTP6SuJJPDHX9SHhRjdHXLHG5yxUmmti/1b73lPU6zrDuSmTmoRlUiM
         hQy1xIreOLS42kkUzyQK8wOiQycgs+gJ7maQTy9w1v1oVz/WoGiFse+rzDzxvGff97vB
         XPx/v71p+FIYKSo/GwuTq9wnUIOnu4ADsmMJxjNNaCOGceL7BZZdAHQMQsKIU012wB/G
         GBgtWtUD5Wl7BZORc0xCvxGAEMvfJtHR8rhCX/AwdtXqMkBJUMhqVsHV0DwxIaATb3Cz
         92qXuUe/smSUdcc0jnAISQWDH8Ls9f4PBrliM6GOBgx36f9OF4MAcfPBRXIIz2JJ4oXI
         K3HQ==
X-Gm-Message-State: AOJu0Yy1cCtJRWJdxhMcodOwk2xdhi0Am03bphHjEBNy2Vnuue/EipA0
	uGLh95HhbzDbRGzMMDqSbKmOhF6h9Yp2dZQv4DRAcflh57WdUR52cUWP3N3FI/Yz8a6Xkr4lNMM
	IjlcD
X-Gm-Gg: ATEYQzyXzN005oE6UuG1JgAYzTvyxjqdi0DtSW7oa6QEXRVihRWyIqF8CIS1sl3SBXt
	mFMG9vFx9scT8QDTSqj4TfA8sZrl1ADFuSiAB29KmOC11sFDGKA0yRfZ/y1zxupjzm0uNdbM8Wl
	3ZgjSWZao0vwTFrWkYZXLhGubw9JyA1pkNIjOkQvfZK8VsmUfyL9gyRZc0CvKfsuh0ElmtFzsj8
	1i0aszQ3/8ufmh3cptAkY8vENi5I5jtKN2zLZ/vUfB1WAJzhE7620HIFiKO/6FGRq/77DqlhoRu
	VnnP4rI/MyT0DvFq1lY0UMPX9jgOhERXOBRgatM6Jm2zt09/4+sl2R/Z824gyw72BXqqxFL66t+
	gRvnvA9PbR+TwDd9HaJYXWWVMnP+wg03BhYwfQyJ3GMuHbReAf4yLsBLBmmpvKFK7kn2439RtOj
	DkUJr7X0inl8eR0Xfc2iFMEsOpNXcisFsomArUxvk6TE3sLStJVkAUYa15NPv+xYoDfRsqIHVU6
	kQ=
X-Received: by 2002:a05:620a:1a08:b0:88f:ee0a:3d66 with SMTP id af79cd13be357-8cbc8e42748mr383236585a.80.1772210913102;
        Fri, 27 Feb 2026 08:48:33 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf67814bsm610771285a.17.2026.02.27.08.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:48:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260227104438.1646405-1-john.g.garry@oracle.com>
References: <20260227104438.1646405-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v2] block: Correct comments on bio_alloc_clone() and
 bio_init_clone()
Message-Id: <177221091192.1150332.12644419415837881931.b4-ty@kernel.dk>
Date: Fri, 27 Feb 2026 09:48:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 27 Feb 2026 10:44:38 +0000, John Garry wrote:
> Correct the comments that the cloned bio must be freed before the memory
> pointed to by @bio_Src->bi_io_vecs (is freed).
> 
> Christoph Hellwig contributed most the of the update wording.
> 
> 

Applied, thanks!

[1/1] block: Correct comments on bio_alloc_clone() and bio_init_clone()
      commit: 6d13f8ca6428fd5c24f5d83da37a8f297419d273

Best regards,
-- 
Jens Axboe



