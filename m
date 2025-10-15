Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A22264B1
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536317; cv=none; b=JN/nki8DaNEfnwOBf6bVN/Kx6EQn/+BGe+dRibD88yovGBibn3OYP8k1EpVjczD7TCBhAgs5zr8ko7gGF4TLEtv4ixrKsmUnoxSf++gK0UA53/iP4RYU+0yYtqG6uHNdCi2VpOLXg8lwPWk0wuJjp+43gktpW9T+p88EPFrljpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536317; c=relaxed/simple;
	bh=YJOcdQN00SQlYyHD+ldrVu40/4KDRGZ1yFgHfAt78Yk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=raTn0hfvZAErBUuta0FmknBBMry1B9Vkyt//rZ3vth/pz92Kuj7g5juj4+L4tjHXZ+Z+OQLmq/XzuoDrlebdK7Z+5mzt9fEjjVRRkDlJHpxguot/CnmU6jsZ/0/tOyFqJm5KYczieePNo9P7DM/vGrkt+gbeTNHBq/v4J6qoFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Dp2FJLnq; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Dp2FJLnq"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430af8922bfso2037505ab.2
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760536315; x=1761141115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n89RMjiTmRqy63aKoXm0OCvDdReDuIAe9AoZ6RRn/zQ=;
        b=Dp2FJLnq2o2zC557fyeAZhpz5WY3CuKyGdF/1pKzyEaxewf5bilC4RZv8vPVfrZaGS
         eq+sHOeeqSzirhB3Hg/oSVxYwfT6NGXdG5obI88z8yxmETq9+L3ORI7Dy2dWY2Jdt/eT
         Tm13FHC55R8GiLvSxx1bsOV1dyYjknu6OxJT+YwhziBDi4iRSU5mQXK8/9sgAiGoYBZX
         zUcCbIvpHdLpgCEaLdgddqG6aYrbtRMhEYcCSeAakCnWHJLBzE43hNQ6r6+38yoGqeWK
         ga2nGxMa8Ju4M4gsnySuJtcWd3Ln4vDIxU6FXmfZ15BKcOh8/YOkOef3tjorkcSxbpJB
         Etzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760536315; x=1761141115;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n89RMjiTmRqy63aKoXm0OCvDdReDuIAe9AoZ6RRn/zQ=;
        b=H1xCJNFoxexRln/DvLWp0fXXWhm7V6t4t/3LHI0I/JKePRHqyAtymEs/LJ72g/BG5Y
         HZWrKrOGiBSGjm05a4ZHAHHrJHsk+xY6ie4F1XGvpEe+fHKUsbQ/QvygsFZHAAmNd46S
         VOA2DvfP3z5PobQ25CFFSAvZjDY8o9g4q2sbRnwmSSwwHaNNNsqktDGHvFf90Ft86TKp
         2ZllxuHDe8KheeNzmAaVUTqgS+E80qQbBKJQnOTwGrirPdBQCJ/IBc1tqu/4Fq7svl/i
         Jwbsf4WSSZKFL0N5hfLKHpU5xQOXZJoWE8FNo2M4U5S1phvOwnSblQ1DpK5gTqzyuqCa
         Ozqw==
X-Gm-Message-State: AOJu0Yx5Ke5Cr+y6R8S1eL/zqbn8C9Vg0x1BMvWqAA4qJ3HPt1ZmKcrs
	xf2FLF8QMKP9JRScsDlxmGUNx3hBuHiMi403gq4O6FwPxgGQ9HXH2gPGKz5Z9FIJY0oSUbo1yT1
	5xWFyaKM=
X-Gm-Gg: ASbGncuZs7acMwCpFo3jIx/T1wsgTXHBMGS7UVf/iTVUIENOBkJoRdxedOePbxiipFy
	f9/8vcb0E2pCzbq+dMnQcYx3nLbszmh/JnieoV7At1IC8pbX1glHYt/QjVaC0X6+TGQNYneBR3x
	MtpTuwCbH9kThJY3q34Z93QAKYkSIHqMcds723qIb6SUvOCEgUffE2Z/n2jTla39DLWERbFzGx4
	1vEnUVMLfRGOTjJFO4uIegNldyyCY3NEQI98MFe/nOE7EMhvXGjwKBKNPipsi7H70C+pXKzpR4i
	OWjYBw39HzmBAQ0zJUkr9ZkOrU4Eirx7xEiZfRvKfN/IKx9LPflCH1lMMGmBshFfyCVdbmoxOt0
	xvnsDDt8uLql3g2OdO0lt21VPaFBVQ8FE
X-Google-Smtp-Source: AGHT+IHDs66Zo5Fhjh9eSEpVL+V02Doefk64Z6M+8yb+tEPPVfbRbZXf2a7t3ZC43vyM0jRcNwM8hQ==
X-Received: by 2002:a05:6e02:1562:b0:430:ae14:e2a9 with SMTP id e9e14a558f8ab-430ae14e393mr21337015ab.31.1760536314721;
        Wed, 15 Oct 2025 06:51:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm5942062173.1.2025.10.15.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:51:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: clm@meta.com, nilay@linux.ibm.com, Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20251015014827.2997591-1-yukuai3@huawei.com>
References: <20251015014827.2997591-1-yukuai3@huawei.com>
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in
 blk_mq_update_nr_requests()
Message-Id: <176053631346.30556.10698172716835957720.b4-ty@kernel.dk>
Date: Wed, 15 Oct 2025 07:51:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 15 Oct 2025 09:48:27 +0800, Yu Kuai wrote:
> Commit 7f2799c546db ("blk-mq: cleanup shared tags case in
> blk_mq_update_nr_requests()") moves blk_mq_tag_update_sched_shared_tags()
> before q->nr_requests is updated, however, it's still using the old
> q->nr_requests to resize tag depth.
> 
> Fix this problem by passing in expected new tag depth.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()
      commit: dc96cefef0d3032c69e46a21b345c60e56b18934

Best regards,
-- 
Jens Axboe



