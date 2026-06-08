Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC33F7AAD
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931101; cv=none; b=ur+MrzKQUKWNVw9+yhLe8d9u+O8xKtrljeI1y9szvlwtDhjFwFJgEEqalgMz+Da0jyiTLF8qAIuoRwq234bsernHyBocs0CuJNDVZ8S3lP7I+8U/ymJllnYd3HjqH83JJTnE+qdX1mb9xMcjvaQJFEK665gvJpEFK1c05iMB8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931101; c=relaxed/simple;
	bh=7SeLp95Vfk6snL09LkKinxfI2r/8HHgazzYIPOcq2EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQlpfcnc33VvaAmOYTaNOaGUHnMfKvn+8Hxy+f5mc0BqWlLWyfND7pbWEv198zR66nys8nV50u/EIrRl091HolZtnD9OPOtts1BnCR+ZUal3x81QLFZ9so/6Eoee0mgg01LLH8op5icOz2Hep211EW8HkJ+oVUHPTw506ymIdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn3Wy2Pw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn3Wy2Pw"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7ea6923cc94so44190747b3.3
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780931099; x=1781535899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYVqYxcJfgMHzsP2anvp/RrbkY5FndehAHOdAqsvlis=;
        b=gn3Wy2Pw2ZdWI7IMKuAaJSK4gUXzp5i6SvTl6+k+QmSTeCgyeNSPDDuIs4O83RQOc+
         vhLc3l+sDgmyPjkM8CJtpeVxGtvIGBY9SC4d0wujhfLBAnAhb3/2fjnYf42HOWaNHTMG
         189fyeDLy/6NAF/Qt2VJZHVSWnD0rLBp0pYu1BQ47/hMjwxWJZieBP7T52aZAz+Q3mIH
         4DOLeN4Cs/6Uzw3dGNNMRTuzC0ryWePDyq2CurHDhwlpK2x7RGoEFRwBsC90lfiF9ped
         Zo8EziUYAarG3PQDvZ1Yurrfh++sug218hKdA5DLHgRYfomp21YdfFojnc4L1mE4VmzT
         WhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931099; x=1781535899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYVqYxcJfgMHzsP2anvp/RrbkY5FndehAHOdAqsvlis=;
        b=Zj9xEvvlFIbVZTHDRxqdpnF6XZAAr5pNFLj0gb8NnxDQjowBLil+dQcA4Abt/722C5
         bOSDeN92Z9qQ9ZR8BEMw6IoTIbTKIAwzRT6q+dwKR8U3HZ/1RL3wJy/+LWjsAGi2eDMu
         pLiTqBe03yyT606SUphnUwqGz683F6IYZMVa7+rkgB0NMyOWjwOxbtOrP7F5A5wHp1C+
         tBGR/7QC/C6EAJtnHOrYTVmbdxj9ckKdyQHM5/5gXbRXQj4LW2QCa9A8CCxrkMyLVlpY
         xABGs7H2/YBDgwO5nFoBGH/EE1ZACGBcajGu0MlBQd3Kka0Lx4owtWqNCzkPHylmOyaS
         XSzw==
X-Gm-Message-State: AOJu0Yy5bz1vH+n2T3+B5U/r0bAuh1XCdOZqMcUffvwh77ucTsVmh5vB
	LolyE/V3lbh+jaMWvX3TG7VgwUEqYOD1oCBpOSERaKG6f+yRfWCAiLnI
X-Gm-Gg: Acq92OEgVooFNbD695y6+KYrtIbznrY+k1ZwzQxpU+fRFNVdYFjSah3l4NPQzhWN5BC
	aD/nsaTY1c15+TerNCToil/3YdgoKYkxN3X5yIEpTYp8cvke+OEi8S4JCgjGqJWHG9Ufev9PIG8
	sEwiRrWs2T0p1GU/nLPHc/+ZK2KqCnpjFvbbvfNsZJWR2DvEdhIp+FtlhEYCnooiK6euKO0MYnS
	KlG18AysQlegNwGpC0XLK3en5a417G7bE+c56LTH8FqpFmfPhIG0y3XtGPnkCSxIMOVohcfz36r
	GGFH2pWmH8dRrFWxhw068wFC5We0A2WKUHHfq/ExH2EApoEBuKJ3NRxUa/xE4dq0yvEPfck66PQ
	6Gdvy1qkzsPA7gVcbwAEsxP3r8zJrCSFy9SLO8hK1IWezAyUY73/hmMmxwMKhc9Rod0ERzJANwD
	DCrWQdME8yVrVdDs++1rbEL9cCUOweR4Wd6kxw9iEyGZ/yN+nU7nWLPnt+Kr0rk64RC4ypYD9/1
	1tUvGZTN8XPlmgk6dQqPBt3rCM9Tic+
X-Received: by 2002:a05:690c:3349:b0:799:198d:8c5a with SMTP id 00721157ae682-7ed0d1d9ccamr158780637b3.34.1780931099494;
        Mon, 08 Jun 2026 08:04:59 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a9946bsm84389287b3.37.2026.06.08.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:04:58 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:04:51 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: wenxiong@linux.ibm.com
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai@fygo.io,
	wenxiong@us.ibm.com
Subject: Re: [PATCH]block: Observing higher CPU utilization during random IO
 testing
Message-ID: <aibaE-1IARUyTWTg@fedora>
References: <20260604162709.3006327-1-wenxiong@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604162709.3006327-1-wenxiong@linux.ibm.com>

On Thu, Jun 04, 2026 at 12:27:09PM -0400, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> Hi All,
> 
> Our performance team observed the higher CPU utilization in RHEL10 compared
> to RHEL9.8, observed the similar issue in upstream kernel(v7.1-rc6) as well
> when running FIO random IO tests. Random IO tests are more CPU intensive
> than sequential IO tests due to several factors: more context switching,
> interrupt Handling, cache Inefficiency etc.
> 
> Given commit 060406c61c7c ("block: add plug while submitting IO")
> causes performance regression. This patch reverts it.

One thing is that plugging should be applied in outer io code path, also
it doesn't make sense to apply this timestamp optimization for single IO batch.

> 
> Below is performance comparison with the latest upstream kernel.
> 
> Iotype  qd   nj    rmix    mpstat busy        mpstat busy
>                          with inner plug    without inner plug
> Randrw  1    20    100       53%                 24%
> Randrw  1    40    100       70%                 24%
> Randrw  1    20    70        40%                 24%
> Randrw  1    40    70        60%                 26%
> Randrw  1    20    0         14%                 6%
> Randrw  1    40    0         20%                 7%
> 
> Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
> Suggested-by: Ming Lei <tom.leiming@gmail.com>

With commit log update, this patch looks fine:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
