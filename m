Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D052A23CB
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424407; cv=none; b=alPQc+wWLYNaPWT5wW3wV7v0yUc4AWHUawwaDr+snT1w4Ej0R8UftcZr2Js2WouNixlTrSJibgDzRfzYT5g2G+7/5fnan+1W2btYD3QtER7U+rCaYIPgM1VMKmKwc55+c0TTXEMydsPgj3BWvgia9VPA1yOnW22oHhvaJUCJcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424407; c=relaxed/simple;
	bh=Rv2C9fVB3Cdce9I+HZ81QqFp7zNReMlquLNPPoGp/0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wa3/p06VFD5SLxNRa1aiMDj7LcVbG3MHY3GfUQkVZmAikLErGZz56opyyuw711n2dX4G1Zpw4EqmL/mVvUy2VYDdeyvTfWfVwwUMaPGzDb3YFNTXcVKVAWUhTHPgCELQ41VnvFlUbC0y0V7BkFUpTuiQS82OejtSwHzgjN2ZEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DchJes23; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DchJes23"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8877677dbaeso69935939f.0
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757424404; x=1758029204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4igZUBvroR3WsvQc2thHARJDWhXwMt10oFMUH6Qqm8=;
        b=DchJes23ns+9o2uKaPMpYesh4v2ZaHYppwUIt7fmR3HGK+s7Hzfx/yh4PC/pQcIf34
         jqoz1CPnJfko/7k/ycNIMisa/Jg5Ni4IFlx75ISYdiz6Uf+K7fVldm/B1Uhlv61EC92P
         B50Xr5k04bDb60b6gwnIYS5nvwTY3KYXI9wrnuimhgzPMkByJP/Qx3So/GhDQaiK88Ns
         dFUM0S6APItdSOtPKsZEYX5E92+4o4eEq0jfZ6eTlsV60nCiX4ECk3c3E8K4Qo1ear33
         pwNtPIfnrdFXuJSzxkK0Dk+V2u/1GHkYHG+pgDPZj5WUnktCo3xc/UwfSwqG0BsputTm
         xMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424404; x=1758029204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4igZUBvroR3WsvQc2thHARJDWhXwMt10oFMUH6Qqm8=;
        b=aSGxb+oMkTedRGEzUqNOuZDqlqIR55ZBfOZMtEQAF5R7gwHw5DlHkrLhjMFxGMNoqf
         FdLuWqVl2/G9nEG+P3Inpg/aVe/p1EiLwq4iHwlZKeJ6+CAcdzoE/yxE/xrJDUjxgRQQ
         bGBa1Ge8IFOEUH65VpAUCCwGZ/LkXWMG7ZT70khBu1XSX8YNDPSgll1czLs7oVVS/BuG
         6o2gw6IZxEE/2xW5j9BGhWRzpjlnkNPRXY8Wf3jUXDWZyuPu+YKf7zvKseQszIIT3BbG
         EQufQ3xp4BHrBQEQ8Z1EcF/aOB2sUALk7w7RzfPIjcTTCWiKJlpybxDavSZIcOvjZSk5
         XJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkCY7UwlKk0pn4XzkLzRlJb85GYdZ2oqW2dZva2V0v4sMerQEoFDkLljZkv+VMiAs+LY+byKQdCEzgBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlY40Ri9FDA7S2wnBEfgc+iG0cpE3U41w5mUsIcsvdsfLC7I8
	YqUHYmZM7inVTuZp9VeV+3/nnL3U3iXDJOkHJCPacNRl1OAyyVxQ9HOOnRFHThLO3vQ=
X-Gm-Gg: ASbGncu0med8HVJqfejMPJyRYz0e6WKR+8nI6a5xzjiimYdV5ryg2hm6xMd09gBU9Ms
	pLFNpPw7tcJI67Unil4h7LAPPjAw1TNhOHgFBUDFSVJfUIoh6X2+vpzptD0kUXZkLWt3XX0pPjD
	iCcpx11we2wifK/2jwekMSfAAQvj5w10ye6m0x5Ynpy8whA641x6xvaQAOrQgXTeYzMSaGRzver
	82vpkHGnZsRPr9xyzTN1LznmakylcDtp/LMzTY9be3iizIIZJdqM5oB7Yb8yS7jgvo1plIzfpP3
	5XjaMqV2wkyJfBeuojfU54vAYwQrX+NS7Zm8FCY3jOSGWXtZVcWy77zEZH+AIO6KLdi4ByXOPvV
	JwFfhP1PzSrV9cSx5PQi5bjV50v4JWw==
X-Google-Smtp-Source: AGHT+IEMGG8+Ju0J0DNwbqAklvDTEqGa/IaAQ1iQx/VgQu9y2b/vMJTj8DRKW1FKQn+01Q4CFufJyg==
X-Received: by 2002:a05:6e02:1a45:b0:3f6:9503:ab53 with SMTP id e9e14a558f8ab-3fd8cdbddc2mr149860575ab.2.1757424400042;
        Tue, 09 Sep 2025 06:26:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-40b3014fe33sm16225335ab.36.2025.09.09.06.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:26:39 -0700 (PDT)
Message-ID: <a56b2c76-e254-48bc-86a6-8beb47ac79ff@kernel.dk>
Date: Tue, 9 Sep 2025 07:26:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250909
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org
Cc: linan122@huawei.com, xni@redhat.com, colyli@kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 2:20 AM, Yu Kuai wrote:
> Hi, Jens
> 
> Please consider pulling following changes on your for-6.18/block branch,
> this pull request contains:
> 
>  - add kconfig for internal bitmap;
>  - introduce new experimental feature lockless bitmap;

Can you write a bit of a better pull request letter? It'd be nice to get
an actual description of what the "lockless bitmap" is, and why it makes
sense to have it. This is pretty sparse...

>   https://kernel.googlesource.com/pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.18-20250909
> 

and this is a new source for you, is the above tag signed?

-- 
Jens Axboe
