Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425829CB24
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493797; cv=none; b=htD1gADksSqukcw/dbOgg1QCv0ROgTfk28TgGH6WcEmInQ8CTsVPm3AkRkMSHzyvzQINlZXOpLUNM1/NX5HEvFm1kEP7RR6Llu2bvJfqEOam4E5MjVtRxy8pcW1uETYzG9ame0K9wdrPjGobf6CRQEbiqQSUfTiabbmroRmWXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493797; c=relaxed/simple;
	bh=dGcavx7UrodWer0QdWY2F63tlFT89MHjt//FwJsLDmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1TK5VpmHE62h//9nG2ej38B18wr5ezkInmcbhqXBTMmE2Dwn8muCGpYvIVjw0NLTaXeQbHgCJWRzOPg/ZqD0WrBvfO8tOagvhnlPY7SNhQ9h7A/E+dyoEJELDyhLXP8v6LEQ7RNqmQGTDk7u4iyCXrVIcW3Fxvujo7PTYemVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VHvdDpY9; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VHvdDpY9"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d4436ba324so45606575ab.2
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 18:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746493794; x=1747098594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIM80LTAYxLAKFlA6Pg3nN11U5GRI56w1GKJqqZITXo=;
        b=VHvdDpY9CFxVwvxFaTvW+BiB5HBKcCWopTKgAoKc3yO4ALw0fTO0uVUZY2Q+JWh3Bb
         MHSTVyK1GNvxRahSjvKtD1pMLNAaKt2sggA1w9MTEmtNNPNvuVcw7rMv39p7zSM+Od5E
         u5rhuXj210NriRxA2QTkwDU6oKJMoXYTQv3ZZ69Du+ObUSxm2lTYi0m4+R2/PNWMdLwd
         GzWx/Yjz4jFtDjy7pJ6w6Zk/6gmQoLn8+xNyHE+h4rHO0ymbsvllWa0qL5C83g0MSzbg
         LnDFHWkad8GZC20g7+JkHXemhFxc3N74ngbMzUH7NyfyL+qj/d2fzCZZ5w/FZynsChYn
         3Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746493794; x=1747098594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIM80LTAYxLAKFlA6Pg3nN11U5GRI56w1GKJqqZITXo=;
        b=jURVp6M035pCa7rQJf6j+JlGHJNAYkAKLIfTqlt5/KoYKQKLFqffLFKGhNc8MKxMZs
         7AB7UiFTI5OC7f8udVT2d/OUf+gCr/CaHoyxFc9wONhlVAYpjeB7nxkdTOWlM2qWNdzC
         WgSpKH3rUo8eR5szXE47T6ts8WquInA6E7p8p4mlfKKUe74337lFqtCZcWki3ddJRyCq
         pk9sMbjWL15hryo3HVTbEAzJDpm7OG3GP7+e3lvGqIYeKFOYnIT0kXiaR0l3IOJu8oTu
         9jKG4f9FytCGAbmCZ1yBOZ90D6T0ACf3/xd4VtRJIqnr0bVV1UwgvN+gk/j9b4NjhfkQ
         qHpA==
X-Forwarded-Encrypted: i=1; AJvYcCVYwHbtOIxrMbnzPtHXfpmfz9r0LAqvfT4XRorCJIwwb6FcGyuxlXDtiAmNmV+9SUZ9H8sVfWp8pDIxGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn68f+abCzVgR7OcLFF6clv6D1D2P3moXeHJYw0/so0oMaC+4+
	R8KCJzyCfA2YzDfVBXFdIHmxiYe6tf/Nl2Xd7bfGBs9LEH0IgNJcE9ukZ7Xet7U=
X-Gm-Gg: ASbGncsgMZP5HVYeITEd+R8h1asra1lfb4a4h6pKCk/26g/9XJ+aRwT7aEOTnkmnms0
	qhMQEPHZVQc0Ie5Pv6pofOOKuoMqRbt07I2PlppXSvCnQS7cNL7PdlI9Kst2KeRuhSmt45Ucr5P
	wsOqVFHoJxE1ENvAi68Ta8aJhwvI/VMtTNZ/lIe6QfGb0GtjQLAy92JYYWQK4I89PwfIxdVEhGN
	wX0QPIT0gBtVLhImyFlwzpyM8krfM87ZiJm3rnH1TDbEAzPzKG2c+GxlY98Lnxtbw/hiCz7gFjj
	tPLVV+P9LwbymP52dj6naZ3gCxfVa/mrmp3sHg==
X-Google-Smtp-Source: AGHT+IHX6JKq75WUD+qIdDrodov7tOkSw235cd9jVcmaFA6/OcLfijVwYEvytEdRHK+OO8glM71tdQ==
X-Received: by 2002:a05:6e02:2787:b0:3d8:2178:5c76 with SMTP id e9e14a558f8ab-3da6ce071a2mr16329265ab.18.1746493793779;
        Mon, 05 May 2025 18:09:53 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a91382asm2024968173.32.2025.05.05.18.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 18:09:53 -0700 (PDT)
Message-ID: <0f5ae9f4-05fd-48d1-924a-66ae159389bd@kernel.dk>
Date: Mon, 5 May 2025 19:09:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/7] blk-throttle: Split the blkthrotl queue to solve
 the IO delay issue
To: Zizhi Wo <wozizhi@huawei.com>, Zizhi Wo <wozizhi@huaweicloud.com>,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, yukuai3@huawei.com, ming.lei@redhat.com,
 tj@kernel.org
References: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
 <7df3b05d-0e44-43b5-9d79-687e6297136c@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7df3b05d-0e44-43b5-9d79-687e6297136c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 7:04 PM, Zizhi Wo wrote:
> friendly ping

It's not applying to the current 6.16 tree, please resend it.

-- 
Jens Axboe

