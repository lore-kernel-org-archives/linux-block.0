Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBE23FC40
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785980; cv=none; b=Lc24GgAL6/x0qfxV/lyllSESyMgjjPuidmwDSVUyqFMCNVCLEaIjmHNwCAX1s7PMmVMbD9kXSeUsNULi9yAE9u2FLEO77yt7eQxQK7ivmlkFIitJW5HNd/t6pUiRtGDhQVrhN5yBWeRWpJR9tlQyxMUr8PTFD+B1vtX7aJkz4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785980; c=relaxed/simple;
	bh=mGdvBlcEIvTf8PEBLhAniZ7Ipjz29UsY1/DN7J5+2U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlokVlczj3GG9N3XK4HQkV7sYYAYWKNy/Es+mseueAo18YnanGFYyDZNJAi9I1AUVOeZqblF8BtCsNHqBhOWGDf3/t/UeJy6yVVvPDzxrMRsO/bhlKl6DlYZuJCDKTko0PBBaWDJChkmJiZ+MqkTT5uQrC2Oj0PPNEXHe5boloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XhqhCgRB; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XhqhCgRB"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85ae131983eso465727839f.0
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741785974; x=1742390774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQNkH0qbL2P1M7OrwDLOWPGOm/8Zo88nrh4/+YYDSos=;
        b=XhqhCgRBnTj3RGqWG6ZuQzH1j6KSuRPeR/feprs9SFJxmZ0KKKVzhFPQbSeL6UOubO
         CtiEkZ1ZkVYLk69y9J3xP78WcIY/ZIdxeYOlZmlXVUYtZuGi2zia4jJ8rZWR5G8z8+L8
         3B4vwknVhs/5XO1EadvrKLLwOs+ln488iSxRUBsjJdN2bD72nL7gMHqitvDyFYZcaK6W
         0yzAlUQdkG04RQjcjsrOKd+YRjqOcj6b6Vp5ZoTPxnfjj1i4qhNY9aEAffNQDuDFi57B
         TgaBwpJZI4cslwgq3zGNPCHJwcQKr3C4qC1isfN6n51lWMzmUp2F/66Nk1jd4L62J1G+
         A9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785974; x=1742390774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQNkH0qbL2P1M7OrwDLOWPGOm/8Zo88nrh4/+YYDSos=;
        b=i28KE4THzXuh/ZUCUDDbk0xmSRqhfV+qsBr2DZKa/bQ8UNTO7KnnSPyOa+ZeEIWL+T
         sAVHluLvWn2+oDbNaIvOH5TxqBb7h3TVntxhl+HRaa0yTfAg2xy0jqiizwQBjTS9KgnM
         v33kzdrm3U4WZouDTTTMG0s1T1d6ixpMcbe4+kUkatSItbzERHJ2JFgmYRdaAeq5s1o+
         aPYh7cVa8zCdhy1QOzy9Krd6fMqvLVls0lX8dnx6oTm47KYSeoUa40oY8rW+sr++qoob
         IzeNnN8O+oMnMg6UnI8bi5bZutpmNoHVCSV+oaezxSRD69m/ZH9H2cLAGD6wAzoYR1kO
         GL4g==
X-Forwarded-Encrypted: i=1; AJvYcCWzXScmdbv9MsNbhAhPppzFgjsCJs6qQEOSDRxeUqyyqdWs9YmOCfmrzqx0hPf7nlKCeeBoyPz+ztTovg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCV7BzFp51F/48AFerqBgmFuhZm4sF1av/+H64DJ1YtD0kCE6S
	Y4pU5ZyACl9v0x783oM2eKkwSO4d19S0LiXL9eYkC2AsgO1eZnDxZYHtbFhO6EEpeq+g1NDbueC
	S
X-Gm-Gg: ASbGncsGnGbQ16zP4rdSjRSq1Ps9eK6RdhFZGEK4qIGwUlZqHZ1n1bTBXk411hm2ESY
	ghYXsg7//3eU2h3LSX1N2jnBHibdhFyUtUhPfqKWMCii81gSVaI9aq+O0BHzxGqftByD8QmsCkZ
	oyplh/CHqYpry9OMlNEIhffrHiEa2o9HGlMjL9gdTvCQko67/i0MoMQj1cHQLquhCXjILAtabFp
	fjDWUo0S0MGgxcYX010/AOM+ZLH+dDIvXGfgf5/n9p8ASENBBRFv9oluz3eawxNDC8ALheuvKri
	YqNNXL/0gh23jQgM6EidyZtizJ9SwinNn52JoQGw
X-Google-Smtp-Source: AGHT+IHQX2QIlegcUNOXJoq56kXUfVh6Trna2zvArHAcy+zyuJDu9NvNdwxD8kUGzT7t+HJR5etDLg==
X-Received: by 2002:a05:6e02:318f:b0:3ce:8ed9:ca94 with SMTP id e9e14a558f8ab-3d4689794a7mr78502345ab.14.1741785974657;
        Wed, 12 Mar 2025 06:26:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f23295b165sm1738466173.43.2025.03.12.06.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 06:26:14 -0700 (PDT)
Message-ID: <6f10a6df-e672-43f5-a82d-5e936fcdbba9@kernel.dk>
Date: Wed, 12 Mar 2025 07:26:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: improve kerneldoc of blk_mq_add_to_batch()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
References: <20250312072712.1777580-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250312072712.1777580-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 1:27 AM, Shin'ichiro Kawasaki wrote:
> Commit f00baf2eac78 ("block: change blk_mq_add_to_batch() third argument
> type to bool") added kerneldoc style comment of blk_mq_add_to_batch().
> However, it did not follow the kerneldoc format and was incomplete.
> Improve the comment to follow the format.

Thanks, I'll fold this in to the other patch.

-- 
Jens Axboe

