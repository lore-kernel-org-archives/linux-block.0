Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD1146A7A
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895081; cv=none; b=cS0711OlEwYrH8tlQK+F0IPn/OAJJNUQVh+CpARwu7JNCQOochP/Yyek8tYC8BmYuGK3iD265fzhY+kKki+Dxcb2wSZnnkFLacZc5/81ts7HHir7+pw0wJs9wG0HP0ivYHBhFIB3dnORwrIv2dfNJ1fiqOlidY/lSNy/8FZO7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895081; c=relaxed/simple;
	bh=qvSY2i69MHb2x8oZak8wedpIpV/DBYzxn1FjcWjYZwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u8NvYy0cFi8ccgAot1pWg1yLrdUT9Fv6Q6BjdFe7X1c9wKwyFSugx2gVFLCZB0FrxgcSiaIUAlHsHcZoqvN4eauL1Z6Lyk0+46UkJgJxODrO76dLweGrNNBPAOydxfWPoNx6oHJz3sLfPGFlyxJeyrg69d7pUkjLFuOecwa6gOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PoNLums7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PoNLums7"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so1436303a12.1
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732895079; x=1733499879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1jTuyrQRbvH+yCK9VE9KV/8tpfabseBlwcJXAjgtbo=;
        b=PoNLums73prWAsMWvcGjbJPuzDIT6WSaa1m6if1T00CGGDUkzZvL59hWIflux8aC+K
         +SlM1gSGFQZI9ORKBCaBpGj/7/kL1r8GLW+cM4aQG8oxxz3RYaltaJv1gG907phDCFju
         1jbGhcCwXekAb7FGxblVh2sRlHcf+TVxPha3ecMaPDfoReW2rBChAV8P8LmRR6NkIieC
         7+PDs51//0IKKSi0q+FdGrjpbogDmXDb+u6NhzFuaquEiU0xxGoAlE+BSeSY5cFKMIPa
         y8bxzmcQ1RJRecUOHzEJGOk8SAR3G9bxdijNAv+gac4Ocfj3cXdQrei7LTY3UJBvIDV6
         H44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895079; x=1733499879;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1jTuyrQRbvH+yCK9VE9KV/8tpfabseBlwcJXAjgtbo=;
        b=B/3WvyfWHkv07S5+OXzMZZwibPA5dva13ClaE/w6D5EsLBlDbKQzhIgGct8Qfu5QGe
         AjwMUZ4AsBLrhyzj4+ZA5WTbE8Gpdj+Xm1h1xq+bPn4SsOJ7TMzlix5uahwh64hTIc+z
         8RRkBqZCQDHYKGzUxYBspi/G/RuFmt3jZTtpZB7fVJwr1tAW78G/gvgxuI8bZ6cvbEtK
         e0M5LDiDPWs/PgfndSzB9j6dLzd5jKwrCIhxnQRjg5aw2EmOKMqGJUJyqJeVa8Iudabc
         V4Le/ZurbfbFE6GM2XNLMtio5ipLJnQYlgPCSGqRMmYElXnOED6GXAEnUVfuTWQS1YNN
         OviA==
X-Forwarded-Encrypted: i=1; AJvYcCVzx6phT6WIq8BUUT9DYCmAH2qDu3CsHIGbVaGvW+GB+MGWh7ZVt3Abiz8IRJJfIbKGNHj7+KZg1G8Scw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IXTkyeYI2+Z7d7OJgZYPyojtTY14vnOeI9rc8eN/s1Gi48l/
	YDZCFathLbUU9qnUF8h4mJA9yzDuPocbzCj1tOwAmKFQYgn1QSgJ9aedsq/5mDM=
X-Gm-Gg: ASbGncunLdYLcGH6NWU+cq05DNRp75fvAGJ1k2DR+yIn4co5Xe253DjepZ3ZevWeld+
	uOw+je7PimFzesapEUVl90xmbVOi9FNlvfB+2rv2jx7MqFMfpzLF3rDjNfp03D3Qs45PRbiZvwc
	Toco7Qi3UA3UfH1ZKQAhdaRhTpPK0D4QKAuRB9VYSgwe8U9dK76kqJR8sxqELqmnJgU+wQ4XYWf
	ZxjPUSixwtnR/C0OxaaFqmQId22FN/eZ2IvyL4U6g==
X-Google-Smtp-Source: AGHT+IEg7NVeKyqs0K98sbBSIkDWmQBzPqU2qFmbzoZtZ0e/ryuAJg8ATsu0pnHJH8SpjnApLDf61w==
X-Received: by 2002:a05:6a20:2583:b0:1e0:c8d9:3382 with SMTP id adf61e73a8af0-1e0e0b8c5d1mr17335080637.45.1732895079241;
        Fri, 29 Nov 2024 07:44:39 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c385484sm3252382a12.59.2024.11.29.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:44:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: long.yunjian@zte.com.cn
Cc: kbusch@kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mou.yi@zte.com.cn, zhang.xianwei8@zte.com.cn, 
 cai.qu@zte.com.cn, xu.lifeng1@zte.com.cn, jiang.xuexin@zte.com.cn, 
 jiang.yong5@zte.com.cn
In-Reply-To: <20241128170056565nPKSz2vsP8K8X2uk2iaDG@zte.com.cn>
References: <20241128170056565nPKSz2vsP8K8X2uk2iaDG@zte.com.cn>
Subject: Re: [PATCH] brd: decrease the number of allocated pages which
 discarded
Message-Id: <173289507804.165299.4802226376466238974.b4-ty@kernel.dk>
Date: Fri, 29 Nov 2024 08:44:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Thu, 28 Nov 2024 17:00:56 +0800, long.yunjian@zte.com.cn wrote:
> The number of allocated pages which discarded will not decrease.
> Fix it.
> 
> Fixes: 9ead7efc6f3f ("brd: implement discard support")
> 
> 

Applied, thanks!

[1/1] brd: decrease the number of allocated pages which discarded
      commit: 82734209bedd65a8b508844bab652b464379bfdd

Best regards,
-- 
Jens Axboe



