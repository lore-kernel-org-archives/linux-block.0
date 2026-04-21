Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A731B130
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793355; cv=none; b=FXRTHJLVF12P2lGtiHCL2iyDpNHNF6ZlqvGIHXOmvz8erLWGQ9y6q5i3WKvRRLf9Hf3wQvlIjmIc/9pAQa2lCDEYfWysEIN1+WP7h7v97QtL/vP4Hyf1wdhn66sg209kANOvOXudyNP7/OlmdRSbDgLToJ6qV/CODV+XD2K1V68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793355; c=relaxed/simple;
	bh=xJATjN6Fuwnr8BeTpGcZXWk0twhjlloBcBnA5HcNlpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a3HOXKKOZHcjSGVC1B60AVTCHTyEznuZY2qUIPErmX/xd/4IcHI8mcuo4JoFbDjV/yTk3GrCyOEBZvrqJ5sCD0y2LKZUeM2XmpwGyDaqWIn1Lb7bKFVRtKMrOKF3Wz4Bv93J4r45zwqarmpxNx2w+1/+M0A8xzIrA+84J3qrz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=wtKTaoeQ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="wtKTaoeQ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d7f92bde91so2507375a34.1
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776793353; x=1777398153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cUwwhS+ho+RIyUTmSQCY6Uc+4lk8WVXRSh362LsgZ8=;
        b=wtKTaoeQAyncEz2rI1bnrDka/f56+BznR4xav42FZ5oFtglE4In5zD9cxXa34EGp1D
         6MvOUaLpMpWMNmRu4lq+sU1/z7UWpErJK+GcGfgFJvLlIsiSG+u38gaG7aGxPlv82Rbs
         l1nZEmPSIuPGlDzVQR3mGVmWANQvv85BMFSmPnQx4VBcEcapu4PdhoZ/q8eqEQh9su5X
         KYy2HBV+Xs8Zv6Q6/GljrFIXSqP+QjytzzwxY77CY3Rv8fH8EzY8hjYK80xvDJNxdK0v
         arRZzn+2UPfgaGmgUlXOiiadR7UC6O1HlfCcGZ8UXim5mz1C0VLhyBs/zz6atzJY6ai2
         46BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793353; x=1777398153;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cUwwhS+ho+RIyUTmSQCY6Uc+4lk8WVXRSh362LsgZ8=;
        b=DzN+1Wr8dHNq5K7gpmQ/j5kgSTvbRouTG/OT2Nz3Kc+uxqjNKhJ3q6bpWU6JVmEU1D
         GseLcxmuO2ItPOt9cO5HPlHXh6zoYM4Af6F6kBajigiazZscSjXLbYJSBeWbNdFQEAqk
         bbY+4+WvVxgOL4bw3m1p4S+tVvjl3tUBNiL74MgO64qbjvU3ZueJR0+GcOBkZPgNhCjt
         byvY53JKORbyOZAJAJFJssx4FPCITeHFR0jcsMfcwncTCJJlmeNzzD8dpHlRWzYsSlM2
         C9L66KURallI+R7qrVv4eyRA0ZTsgRwkaWkM+4kw1JU/JKQFU8vqhMWFKkUKqaVUdDkk
         m3zA==
X-Forwarded-Encrypted: i=1; AFNElJ/eK7OFj4aunrbW5HU6omWbzNJhUCdMqycgYmZtHRj6xB7QCByqzc0VB1Fip1zMV836T/OjFONsVexh6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTex9ZnbMBFHIt+pCk0nMakwADBHUuagQ1s00RdHaslRvPCtpS
	iyjkrPA17E0jj9jrte0IZe29v1hUh7mR0FXY6ZId7hIX0yzE8qidNaaU9M5EZcseiLo=
X-Gm-Gg: AeBDieuTBybPSU7dyvGeCJjbcYZiRffUaepBHFdmGWTpHEjTnIW0YxHxXxtQZZQ5vr4
	mfPe31yiA9ZLLT3QtR0AmZlctCmF6Z/ZtXdWJ2sKfklsb7Hi/0g0+WOiadLqzpP+7g5mldaOOJF
	4Y/RERZFQoHRrcjn4cA6VpFCE0ixe9vFjlVnBQvRRH+D5Wv8O8RSrVbS2jtlVlnkj5UAojDluJ9
	JAnhj8gpHZpWuelPdwo+EfwJmQEoKbi7iBxOpICsNNKf3LrhFXCRYip0CEK5aAmYKNr8f/ZOZFa
	rAeI5F7sqNsKFToGogXoyufGNWp6zrYYVSeqehW7zbCsCGPRxbXsd8E1z+D2m/Ox9TlMhOhSla6
	lb07SICodY9BPY9Q8EMBZWIZanbR4ba3P+68RLnRmt0sacZDVJIEm98Po7jMxUeDEq6FVkRdsg/
	XzqzGpCdA83YSFDDr6I9FFFe1A66VdMxbZFvVJM7m45ghnF7SXAe1hl0Vkbu3KU8L/VWbPkPU+G
	/Ji5lPkvoJK4A==
X-Received: by 2002:a05:6830:6617:b0:7db:c162:992c with SMTP id 46e09a7af769-7dc951ca5c3mr13028278a34.16.1776793352993;
        Tue, 21 Apr 2026 10:42:32 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc5b138basm4947556a34.3.2026.04.21.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:42:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Doug Gilbert <dgilbert@interlog.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260415060813.807659-2-hch@lst.de>
References: <20260415060813.807659-2-hch@lst.de>
Subject: Re: (subset) [PATCH 1/2] sg: don't use GFP_ATOMIC in sg_start_req
Message-Id: <177679335205.642963.2140693135718044919.b4-ty@b4>
Date: Tue, 21 Apr 2026 11:42:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 15 Apr 2026 08:08:06 +0200, Christoph Hellwig wrote:
> sg_start_req is called from normal user context and can sleep when
> waiting for memory.  Switch it to use GFP_KERNEL, which fixes allocation
> failures seend with the bio_alloc rework.

Applied, thanks!

[2/2] block: only restrict bio allocation gfp mask asked to block
      commit: b5129bda5bbcceea5b2589c8248d39f77660aa19

Best regards,
-- 
Jens Axboe



