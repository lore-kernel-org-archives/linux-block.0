Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AB45BD4B
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626119; cv=none; b=iL6g683IBqW5uvN3yfnNkqlejD+DYAh61K9AMAESv01dwaW6tQlH6MDaYHQLkXdeBZ8dKAMiMwaG1oxdZM6mlreeBrczbKiXP9olg8tJdmyUUOxeV3i+bibg2wNP/+A2CkL9HOuudsT3cpHgd1xr4PsO9bTmHxeownQGxDVEhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626119; c=relaxed/simple;
	bh=xlJh76Md8wkh/Fi92cqhV/YXIDPiy9Lp3lrOEOU0ABc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RojlRiH53yWVAnkarzW6dYVUbA3G2bPp+levARHht42r0FwwkUrVZ2qKf0osKZdamNK1OQtYlvYA8xTrWunYrbPt4rMGB93Tv1olph0pUuFv0OfkT7F3FQiCnmn8KIbxwUZ+fm+83AI8RQFcmslUZK7k8XWF9Dx1yyrDnTSL1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=S+8WAkJS; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="S+8WAkJS"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-441b5b4af7aso2405955fac.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781626116; x=1782230916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzIt4F8uHY1gHbYSazgMbvRJiX7QgA75YFrjgD4jGLA=;
        b=S+8WAkJSCL9n69uYD7Pz1n2z0es32SQx6FJybPbUwamCPEcqvXdM+JXJeCFlpfNVEY
         ++ObBrFQNcE5TGDEEueZqAtbOP9tgqaCHfLOjADTu2EJ8bRWYSU09tdNGC/Axo2sblgj
         +e9m1T9hrAMicAYiN+QX1tfJa5oTGjA3seSUSWloqzUFJOMuThX8fkQLgVMjOWyAVHKq
         BAvw9dGdIlL3KLmr32HKa1YiYfqboXrwRDnovhGAWE0WWeNu9UFw8aNRuw2chg9aZdgj
         KWE49WKZttRoFIcgN6ZUc55Xmx3yBfOi+qceHCgoQB4Uop9Is7gVMKk7qwwj8544SPC/
         E7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626116; x=1782230916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzIt4F8uHY1gHbYSazgMbvRJiX7QgA75YFrjgD4jGLA=;
        b=dgWmbRaKvuIF/jPomRk+dJHJ/Cwgz62J4TH/3qktK9nbvdLBLnKymITRR1TftX7Vmn
         x9QXE0Q5GTGOgxQe/Myv7CWrglPC91iLVkS5miYqVi2DfzDcXwyQZC36yvsczqBv6Mgi
         f9ZNEdOjNPzYl17D50B1EEoeKbFnYNvRZsllBzCbtDArW1ZK/R+q0OQ4xb4bq7KaPMiD
         WV4+dGPwb16d359GJX/4LvmrZdGMXz97AHXTI5qvCPAwuNm3rIZjziBzkR+KrMm+H1Mw
         xJ+E9KFw80k1xv6Yb9wIgMGDSFprxjKuINSKSV8V0w3QJepDkndKDkbzB48LJsiBQdl+
         GeCQ==
X-Gm-Message-State: AOJu0YyoJozQIXHeRS+mLZ9OwgSl+CUqojeLxJ38eP1cwVLdZWjQPgJY
	gqmjkgQxU1uAAbGfJlWUzbZ2MrodbzHtcCPAEut68u+/FBM51EyXwNv0Wv2Y5494HhDJe9SvdoW
	c3T8qpWY=
X-Gm-Gg: Acq92OHB6ofRtHQ9LoUKbsW9qOUfRCPIvxx+DCbgJ8y0FqL44Hmly5K0FglUQrNjr5w
	SEeYLELHBK3fRQxI27s3zsFLo01MMREFmST27kEYTjwmOMu67hb25NV/3/P/t7sOLGkKP2NAoJJ
	Ficnz9VSLwEfbMGEtXhNpoBbt6JfqgwrpgQVgOEaBX+NQVF0jIrDjJqM/emSN8YsU3GEIZhe+QN
	R0z+3Ftgg9Hq2E7TolD696aJaPdWW9hZbcKSYIKUf2Omw54d2uaWk1srwjD3GoXNV0FOnT98DeY
	GY6+TOOyuywmjcY9yxb8ctiJWUS+crn/GiuXpZgKkiLS27UT2iZQoSnAAkyrh2gy4xz5ZOAypQn
	wSQX5WW2KRdtIL1VsJJf3dzp99182ywizc/GRyeJop6iyqRDO2YoRXaGlHHHkyEvsfrrtMWR4Bp
	7lS/7tnFkyx2cGGqbzauY37IL8e7J2SCX5JUVknDcMAm89nYrrzA4cY47TT+WQoBF29LI57rAGR
	KdyXPk9qsA6JtM=
X-Received: by 2002:a05:6808:50a4:b0:486:a9d8:cddb with SMTP id 5614622812f47-48942b488d3mr229217b6e.27.1781626116373;
        Tue, 16 Jun 2026 09:08:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd9fd3sm4631101b6e.7.2026.06.16.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:08:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, wenxiong@linux.ibm.com
Cc: tom.leiming@gmail.com, yukuai@fygo.io, stable@vger.kernel.org, 
 wenxiong@us.ibm.com
In-Reply-To: <20260616143121.878021-1-wenxiong@linux.ibm.com>
References: <20260616143121.878021-1-wenxiong@linux.ibm.com>
Subject: Re: [PATCH V2]block: Remove redundant plug in __submit_bio()
Message-Id: <178162611541.2191657.11227673326428110022.b4-ty@b4>
Date: Tue, 16 Jun 2026 10:08:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 16 Jun 2026 10:31:21 -0400, wenxiong@linux.ibm.com wrote:
> The patch removes the automatic plug/unplug operations from __submit_bio()
> that were added to cache nsecs time when no explicit plug is used.
> 
> The plug mechanism is most effective when batching multiple I/O
> operations together. Creating a plug for every bio submission
> provides minimal benefit while adding function call overhead and
> stack usage for every I/O operation.
> 
> [...]

Applied, thanks!

[1/1] block: Remove redundant plug in __submit_bio()
      commit: 9cbbac29d752fb5d95e375fa3685a359b89caa0a

Best regards,
-- 
Jens Axboe



