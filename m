Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9832548A
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356325; cv=none; b=WdiECTWnoNIz14VeBR0ufWu1vdwu8dZPaouk1yh5ZuGqCxzFK5WEfwPhrdJOq3YBp4ycf+MyCfAtrho7pHKi12zpgvAZacu1ace6HU2WU73ChzCt6AT0O5ug9sl6p7HCIDkfleuYHF1DTXKn+dIjW3z4ZsTxqPDxmIfu3NSsz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356325; c=relaxed/simple;
	bh=jVa87eKGqVF+l20ajBfd8ThYEZLpCOEp5uPFz1FOVig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvm6vqyQ6r3j00HSNBbW3telKIATloITerjGD7oMUp1vUFWtve9uc+YARQBjGOMLufGUwJPA4N5m9HAxhLRXeP3lrqJS1mYuSbphSjKSF94HLRIZg94NuwigDNGQPHtOutgXRkIbwysvCU9Nb1qoXbaSmisMs5UsKcQW3X4+b/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SuLYuNMQ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SuLYuNMQ"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4331b4d5c6eso18847205ab.2
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762356321; x=1762961121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=487sI5AbJzpMbYjr1CjDcFAjiYiuuI8y81LMpEqcmVA=;
        b=SuLYuNMQsvW2Wzy7K4mLUkR0AoGJNXWXa0P0gDdbBgbZx3j0quIPnpr3upInBfCwFn
         RPwNLHQK5wV356rmAywxjbeB9tJDB7v1cnTrIkA4STiha2ORKBmLmOQApD4kxn5kuFCQ
         4QGrxLeifnYktJ67DjF8XFqNvklzewbeDSW3vKwsBMdWVgq9GETI6XOc72jOBotOHN13
         OmCd57PuNi0/2jb9ryaH3q/6zjtXi51CwEQe3Cg4rCnYA6J/gGVEMpj1XD5gZ5x9ZjIL
         kRwcPBtDaPLpwInKxWRkZnnIJs1Ej/SarM1CXuLUfvUsyKg2gbiV/lldR+HSu6QIDW6z
         fUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356321; x=1762961121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=487sI5AbJzpMbYjr1CjDcFAjiYiuuI8y81LMpEqcmVA=;
        b=gtzB9UF6BNPcD3UzVePBejSBeS33xRBT/AhRsuTIq7BxNxNUNyDvZn9qoawSeQGGci
         yVk9iDUijZPl9n1r21tObBxSvMY6OGGWH7aGpsZFFxP+EiebwKOAJ/HfKbFCYHVpXQDg
         nDIUyEAz281MgoyCoySvmsXB6AgeV2ScbG4p5+a15IxB6eqEZp38B4QFOfxDMkUrNVZt
         MvU0yMZasrt4EI6HKMLkTazwbNDbtrUinbU8zZ7ymdEXF9h0/wd5uGN+V+EuckYdxmVv
         CemGFakpOBMtX8RYClEMum6bWnjx4ZR2FCy2SZmOlvXcZUFKl8ef1EfvR3nIn3mC+l2u
         CMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpbxgGeQdBR/cs+UToqSca/VSZcvSlGPK4fS/rutpKVZRKakIKJlw8s3CUci8TFJAWNhim3jSH7y0JCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyohswbcBh993VhXPKCwNzAs5QcjMIZ2V9ptmuQ5dD+u+yU0FH4
	qpqX6jyQvpRyRDQzxpTYEuwbgN96jDABIjTvGW4pSBDfV3t27BPElz34uACFGG/qX1mgBSoHQch
	0GEan
X-Gm-Gg: ASbGnct7kFmCg1Yd7/RuESN7l+79QUY5K6hRxWc0ftZzY+d/rbL0Fywnnlue9QM2Fr8
	ZzyGo2F0U+sROtP4WiDnZhxuzOQ6mBoVV9yetr8pWCY6eT5bbkvEP/ijFrO/3znXK65QVuxbWQJ
	++K5jjlKl2EfgZiTUj7T+nQIMbskb5lvJ5VUCPPUBSQXpj6IPY2bwfaq7K+GzSydZ+lxkHS3O79
	AnUuYLjmfGvYeoNJaymj0Uwi4arV6BlFYYkbebbDA9zaIj24KGYr2KI80qvgJ4hgxvYG2re6gv3
	/uc6cjklo7dfJ7XUqtjUZfKDewjorQRNEJrH07Qzu6rlrypdTZ6Ss7y0oOmYJRJt0C2HtYZjQTm
	x/T8cMi3DkgkFqRX1cxeqAMMoblGoSzPjuBLExjnPSvkLW7W49s5zvGsIP47RcSWSccbOZh6K
X-Google-Smtp-Source: AGHT+IGc9ECZf5jYK1jLXUdJ3FXQag+q/dzClLumbg8vy2PbyYvXZm9bHKrc58cJrzWZLVcyD9QYcw==
X-Received: by 2002:a05:6e02:174b:b0:42d:8b25:47ed with SMTP id e9e14a558f8ab-433407a705bmr56303455ab.6.1762356320939;
        Wed, 05 Nov 2025 07:25:20 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d620sm2536362173.8.2025.11.05.07.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:25:20 -0800 (PST)
Message-ID: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
Date: Wed, 5 Nov 2025 08:25:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] zram: Implement multi-page write-back
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: akpm@linux-foundation.org, bgeffon@google.com, licayy@outlook.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org,
 richardycc@google.com, senozhatsky@chromium.org
References: <tencent_85F14CD7BA73843CA32FF7AEB6A21A6EC907@qq.com>
 <tencent_25F89AABFE39535EF957519750D107B7D406@qq.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_25F89AABFE39535EF957519750D107B7D406@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 11:48 PM, Yuwen Chen wrote:
> For block devices, sequential write performance is significantly
> better than random write. Currently, zram's write-back function
> only supports single-page operations, which fails to leverage
> the sequential write advantage and leads to suboptimal performance.
> This patch implements multi-page batch write-back for zram to
> leverage sequential write performance of block devices.
> After applying this patch, a large number of pages being merged
> into batch write operations can be observed via the following test
> code, which effectively improves write-back performance.
> 
> mount -t debugfs none /sys/kernel/debug/
> echo "block:block_bio_frontmerge" >> /sys/kernel/debug/tracing/set_event
> echo "block:block_bio_backmerge" >> /sys/kernel/debug/tracing/set_event
> cat /sys/kernel/debug/tracing/trace_pipe &
> echo "page_indexes=1-10000" > /sys/block/zram0/writeback
> 
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> Reviewed-by: Fengyu Lian <licayy@outlook.com>
> ---
> Changes in v3:
>   - Postpone the page allocation.
> Changes in v2:
>   - Rename some data structures.
>   - Fix an exception caused by accessing a null pointer.

Please either finish the patch before sending it out, or take your
time before posting again. Sending 3 versions in one day will just
make people ignore you.

This commit message is in dire need of some actual performance
results. This is a change for better performance, no? If so, you
should have some clear numbers in there describing where it's
better, and where it's worse (if appropriate).

-- 
Jens Axboe

