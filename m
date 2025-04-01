Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58981D619D
	for <linux-block@vger.kernel.org>; Tue,  1 Apr 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513758; cv=none; b=j+0kufydeXVY38q6fA3k8la/3dfaytU5KwdgmYRgrr+YF/BirDokjwii9fUMwtcAMXmNMDLUWzL5jGM1kBOG9+/z57D3qSy34gff9qyNcizfxqJ4fQfZiwtUObWacVkYq+nSYuY34LK2wPSeRkh8ge7md7sDK8J4sz8LsIhDRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513758; c=relaxed/simple;
	bh=V3R1ZUE92BtECq3vQtoP9DPoenGrta9YEgchIhQk75s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QX0DhdzF8DLCJKRH0uJcy9MrTklzrbvhwIb1TiVz3RUEiecWs4m89tOQi8tGnftjk6L472uWKljM7s2TIk69eHFpNxZIYgVJWL17PL5eOMS/KGRLlgdJfX6OZ59cHAfL4IQSP3bZNTYxUyiZidu2a4sZqmRj7JwUGdegRwqlaH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=usTCdTNo; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="usTCdTNo"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85b3f92c866so75926639f.3
        for <linux-block@vger.kernel.org>; Tue, 01 Apr 2025 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743513756; x=1744118556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0zFGrO2Ikkys0Rc7T/dl0NIA1jh+srXlEKpYZ7MCFE=;
        b=usTCdTNo26I+oBuWK2VBZrdvGeg+bCBjCwtmI9gFJxAVJTchmEsBSJZHyC25ncFeMv
         efYB8dV2qfrSuqEnjciQ3FQgC7cIJuwYi477djQKw7V0Y3H38B05aGoEIxQoqa8zSZO3
         jG4yV3gyj0DNiRSUK+EKCtOFn4czS19/BSfuk9Z3Yufff5k5q9u9wduPynS9qWmVa4W3
         4HCYJtCWlY29HF9LbQF2nfn2LcdGht+t/xmkE+2xLp0XM9Kq4Q8Bl1Idi/A2EgfyvsqL
         Nd6NijJ3DRzyyZrCyEVkk01+oTK8Gjqkh8lto8W3fZlYuMxZF96HVUAWzJgkwz3IesMr
         G1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743513756; x=1744118556;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0zFGrO2Ikkys0Rc7T/dl0NIA1jh+srXlEKpYZ7MCFE=;
        b=keLgk0fCTHdE1+Xwy6PZfRVOmCuc/oo3Yx9K4dIYdF6RGs4TBQO82lPH9nTtl/lGUc
         tMzNh29CFW/oGlkkz/L3tQtWohcJZwrstFsDajLZA7SkszbuIgORPZUD5kMD9l6ix8Od
         2gQdwD/bxbvP8OIgHCYhbatFPVs9R/0IZhLKosjhCAygxTHiKkrwQyFTCQgRkLExI6xO
         dFd2fYCr+qK0zyYNptul4IbVsWfBwuTOqhh/3SLQSi+w1ivKz2eK0aa+HkAms+/9Y7PS
         /4Lu02swtHYMAlL5uAJtBfOzNBfAY8fA3dapTKEsbE3YHJ7akqvvyPZY8U30XVrmBoln
         Ro9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0Atb7zq3IQCFjg3ZZBi9qAZvmVQZ0v7xFXAZ1kNinHgGzAqK/XEKoPpy9MQVphoSrz8V9BWZhHIZArg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXn5br4Jk3ldqxbKdiBTGPbACGW0Bo4qypA0qmZ8rE03yPo7d
	pNKZfzmfTyVzSBHCgnVg9antZt4CpHj6FO3+RQuNX/8C/Ab4NkJvfQPQN0qoQ3A=
X-Gm-Gg: ASbGncuKMyohkYCAbDM8xC3HAPrs0XnK1hPczV3SMBmlppuClSO0CgXmMsx8Ml6HBOK
	OnGaNxcXp/DUdePoViWJ5V9R/87Yf81JnuX6Txdj+KZG3ld7CfHH9RetT2Qu2uW3jW4uj8m/Upw
	opMEREp755w+0RkgqCoYdd3us53vWYsZ+odBSIjQmNZipqiTmOYtii7EOuxbyjrUR6YG56MRxEK
	cyCIbhswX3wL/l4G0ihpAe4VsPgfdGOMxJQaQasjXm0denR53iwyBscytSYZxIGaSES6Dgz5h1z
	e9DrFk7YA4rsAZpX4w+M32PYcMfso2yafnkw
X-Google-Smtp-Source: AGHT+IGNY5pU+R5xa5ebhvTFhvKT7s+/hpXZ9cxRFJsXSx7f5YJTZ5eZ8AiUmO0WrFuEDdd3drc5nw==
X-Received: by 2002:a05:6602:4c0c:b0:85b:3407:c8c with SMTP id ca18e2360f4ac-85e9e90e27fmr1246509339f.11.1743513755810;
        Tue, 01 Apr 2025 06:22:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e8ff7f4fesm206605339f.1.2025.04.01.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:22:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: gost.dev@samsung.com, nitheshshetty@gmail.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250401044348.15588-1-nj.shetty@samsung.com>
References: <CGME20250401045256epcas5p47d761c5029394f165bf39e84e1cbbbc9@epcas5p4.samsung.com>
 <20250401044348.15588-1-nj.shetty@samsung.com>
Subject: Re: [PATCH] block: remove unused nseg parameter
Message-Id: <174351375476.1822611.1094463022948716058.b4-ty@kernel.dk>
Date: Tue, 01 Apr 2025 07:22:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 01 Apr 2025 10:13:47 +0530, Nitesh Shetty wrote:
> We are no longer using nr_segs, after blk_mq_attempt_bio_merge was moved
> out of blk_mq_get_new_request.
> 
> 

Applied, thanks!

[1/1] block: remove unused nseg parameter
      commit: e3e68311ead15d8be61e8e1a8d2f0d1773a7ba9c

Best regards,
-- 
Jens Axboe



