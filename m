Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341011474A7
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895005; cv=none; b=YCrDsOrsO8OHprg0VL1cdBwH8GJUPhnY6E5gYhWO38Bo3jnzx7Ly+cu5klGAjEQbqUEDMurpGmKNUr1R2B2xfSeqwKpzGeFo10aQbTIETIACvAHEkmaWVUmuKz1ahcIVIB+EOGu8peALnQgJ7GGwsNpSz2Z5mqMntgelkbJQfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895005; c=relaxed/simple;
	bh=xYmKIbTZaq78vRUQAQIVFoBys4zuk0IRUj4hNQE3E/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=chj7swGJsJv7LszapogEGgk4a4f5I2/6QwZRIJ1PwNNAbSSVrrr2pmz8/9zcwKfnTHdb9ziPXE+cE/I76d6T3oFRSZidjCBteUU3DSY0TFMUrBhIFuk89RIIP9OqQSwp5SKs6MmiJ6ENA8sLxfHHqhWFCCIUrlhMFmF6KkkCXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zAZucvHZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zAZucvHZ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7250844b0ecso1788651b3a.1
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732895000; x=1733499800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFSYu9Eshs03U3sqGXLiOctfHIogy+fQwZGGk30D5GI=;
        b=zAZucvHZMHHQ9eaW5TidCnk2SkD1b8oS4UMIzkUpTMZBr7uYgDV9V4/ztS3yNmuRSk
         dsupiiplrPwyjk+yBxantlxjJaW7nSe7IoJeXF5LNG1nNIDxQ9VQfF4P5j/QbRABLD18
         tDEx+En84x5WfnnlsJomFxVUkdTm6rh/3JeIWl4awbZ/Vr+OoaYTRQK4qDY7K/JCFaSh
         Q9UhChBDv5wI6l+1zhFszSw1BBxgUlh+oBRO7DUWW1iDDcI2KOPajiqmBWbwQa59/MSy
         /mt/J3dODZu6q83DbYRCQ9dcA620GR2ICTvGsF+QuTuLcXRXqP8iIimX1jHRuRq+D1fO
         NFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895000; x=1733499800;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFSYu9Eshs03U3sqGXLiOctfHIogy+fQwZGGk30D5GI=;
        b=T1dNAAp2/GY4aXjSzj7quR1kjsFUZvG+PFlDPreDPraURkx+muJ2bOk2JqJRf4ZxI4
         PE1bayJKn8HgyTWwCTVIV56W+aIuzKBdbm7IAPSjWRPEYDZ8APmcdZ5r77ORMn7LGjm/
         PNMwePo9xhTOsWEno+suAy0zJbpr/PxG/2VGpZv7lIGDptb6UQ90yFbTiC4Zu7lthXIQ
         nKev5oo4kBibnmHTHXIjzwQendUPQMNcNMftjgDYDvXo+wOp+htnkzaRncnaWl8+md1U
         g9wgY1GDQ/YP8rNnssBG7qIbdhSg1KUhMswbv9fkbfJGQpZQj+ioyJD7ysFCp+pkCLX0
         7Lqg==
X-Gm-Message-State: AOJu0YwKxUc4+JQLjnXRccsXY7lzNv0QCuWGWXgvMnLU0qZcfmI1nnwA
	JUpPeVAhG01nTS7Sv5Ds6OoNjQy0yqVHMheCwR94qOBmArKIUNWBs1Vqc6CJORI=
X-Gm-Gg: ASbGnctEKx0iQq59+yXY3S3RKV4CmlQCmGFVEDixLIrs3KedUL+8q0G/5sUgOzD9qIT
	kzSXVUzY2NC7saNIuoGkDD1oMDyK/cKFMz/BKZwVPoQzresvUXnx+j7/d0spjFfmN6xSEAWZPAo
	wGK1uJ6fgs2Xbb6SB38/5d96lu4IZfKcTUvVzO8poJm9rMTVUGa/itOL8K8oAZBuh3jlHZmCl/d
	Z12oRdkjZuwONgt3p5x8s8Vk7V0UHxmgTubvCL4VA==
X-Google-Smtp-Source: AGHT+IF0JthPLhtQASKq1yS4rBN61qQa/BJ7UOyCLt36fn8KvyOsNxjTguSP7fZBzIjUOX7fjO2Fig==
X-Received: by 2002:a05:6a00:23cc:b0:724:e582:1a06 with SMTP id d2e1a72fcca58-7253003ea94mr15031350b3a.9.1732895000554;
        Fri, 29 Nov 2024 07:43:20 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2e2babsm3218898a12.22.2024.11.29.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:43:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai3@huawei.com, jack@suse.cz, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20241129091509.2227136-1-yukuai1@huaweicloud.com>
References: <20241129091509.2227136-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: fix bfqq uaf in bfq_limit_depth()
Message-Id: <173289499954.164764.13681710232652992672.b4-ty@kernel.dk>
Date: Fri, 29 Nov 2024 08:43:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Fri, 29 Nov 2024 17:15:09 +0800, Yu Kuai wrote:
> Set new allocated bfqq to bic or remove freed bfqq from bic are both
> protected by bfqd->lock, however bfq_limit_depth() is deferencing bfqq
> from bic without the lock, this can lead to UAF if the io_context is
> shared by multiple tasks.
> 
> For example, test bfq with io_uring can trigger following UAF in v6.6:
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix bfqq uaf in bfq_limit_depth()
      commit: e8b8344de3980709080d86c157d24e7de07d70ad

Best regards,
-- 
Jens Axboe



