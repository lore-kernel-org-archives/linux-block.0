Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248124CEE47
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846819; cv=none; b=SBZEY458KgeZsdTTABVYrD/1mmcoq7Gr+5BvkXHvVk1FCn3Cka6ZicdNoOo/DcpciwRRzWJ8AiKSjwtm4lzm3dBCVbusmBN2NxvRyvhD5nRvGmXgC15MlUysoBsszdLvmMa2Q8o74XCBpQLH/MCrfxYUtuY1WnsUfw0cRqonTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846819; c=relaxed/simple;
	bh=9+09TMmkqPd8XV+CQZAUSYrFzRyU+gP5BOnYyuehyb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHsqn6MRbuPjMXJtZiqcLWLlgTMU1TkBkKLZVEuveXUNAuPvYm/GSbX4aB6y4Lfi9YjzAjmSjGSBt6zjpYPpVF4D+Sb4t0SetQVkxpTENkQK2Pt0wvXcxa/sE1h+P99nKRRA+lrVWVfjbw9aRXyAjxfROYNVY19PNbOEiSx0lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itRpMD1h; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itRpMD1h"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b02c279beso202441a34.2
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790846811; x=1791451611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vh2jiIbia6eRFOfHm82FIh8xzcPZydWxSZdH0BHLn+Y=;
        b=itRpMD1hY/YafuayfbwqexJD16qIo1YYCMyxJZiYEXQ/r36w0T7yyW0Bpq3t0rM2bd
         6b09BnW9IsG4XGJcrngz1iB4R2+lgw1U1ASaHZt2bMxi6ch/296ShirJKdw5VgvJuFmR
         23XDvpPKeQFrosIlHtsR3KVIGUjkGIW0Su/QsvX8mgOKJhoB4u6P/RNoJ+wO94DWMOv+
         y85GE+OZIqaStAKYoaPGuzRCABpNm2QaFESsvn19HPPa4GqcxPUqhZyUPulDjLiGh/wR
         4FCR+WWgcF8aYC67x5DkcXvoX13Ry/zSoOZcHt2Pv/aj3SycJcvLcikTNL3AyOYUOc71
         MT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846811; x=1791451611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vh2jiIbia6eRFOfHm82FIh8xzcPZydWxSZdH0BHLn+Y=;
        b=wan9bxj1oM/p67UK2xw152vYIn0k8aXq4vazXaNBTBPX/T6xyLBBJq7W1L9AmrLAuN
         NT0VvDpzsQEr4F9rXW8lDQGHFSYHfAtowWCxT87kW3fRoY7WPCphyihgRMET4Qpq0hhu
         O3cYyP/5OpgpUvlPyN+tqZLRId7SF6ZwF2uzVX8AzXcg/SA6PD1Ojuxch7gOzBERJzMk
         vJhw+ts0FbpxXuDfKruAo1rDlw62REe41N7UxbFUb4cSge8sQOO4i6bHo6IeW2SrjZpo
         kFGBCI/XR4c3sdeuOC9pMZUUQAD0T0h67WI4X9ET1S0+CODfCLn4lU3JSAYKiIhqpWyV
         3Xaw==
X-Forwarded-Encrypted: i=1; AKwUvByuhE8NN42u90IB7VzRoUsomfPhxsuk6jomS53WDfmQnUXgjLgAL2zNEYqGWS6UxG1wUrRWtR1+Xn6a+w==@vger.kernel.org
X-Gm-Message-State: AFuF++mWNuizgK3FDQKV8F4Pzfi2xKVsA9Zut2FIoCqRbxhFW+lyiHH0
	tUXy1PzeGkm/67z8Kh0AVH1z02/7cbGZ700d+2j/RwRGHbO4iqkZ35iT
X-Gm-Gg: AYBFou3Uv8sieHeVnkI7KopQouXNFVjYsPA3ryfetj44xZFViTQDsudN4CnK9rJC2nC
	nLFNZ5kUyp49mmplDFIRSVPF29dqvYt8LAI2osOYrwf9VAknfAKUwyj7+jQvVUikHUSRgHG//IQ
	UiOz7ClyboHVdcYCQRL3nodRJmIq5hLHt1hWKPm23MsduKDbE6Gic3r7qJxj7Ui/ILR4YHBtxG8
	OyRWLE2aDO4Z4GICDlb5rG2OpiSg7JniwJtrB/WN0zPKWzuGJd6uGbvlhfsDB0sWYBHrnjfxktr
	RdZPjvQdUdKNFWgiaAf7GVa26vRfu5L8HPtfnvfl4TxaJnMV2GRVvH8nwuhfZH3kCCEq77M/IvJ
	4LWHsZm+DAGPbwfIQzTy1uMy9Dz+nyHBIu9b2s/u7GTVQxspSPgV7i1/CInB30zi5nll4gJKnN1
	fEzhwm5dhIn6gyv9NBghdkS6wHj2hJQqWADJ9IQ9u6a6Stq9IYSWkkmanVkZZKOPFwpIlnhroBO
	fmC+j1mP+dpCiQHg7InbxYofCCHPk6IkQaka3gLB5GWNBreBZea0nMRxRqLOFuREFayGK/0ibbd
	2Jg=
X-Received: by 2002:a05:6830:d15:b0:81f:8f5f:f1dc with SMTP id 46e09a7af769-820491154f2mr4634046a34.8.1790846811279;
        Thu, 01 Oct 2026 02:26:51 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212a413937sm2252075a34.8.2026.10.01.02.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:26:50 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:26:43 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: don't use an I/O scheduler by default
Message-ID: <ar4nU5bVWKdBZXsB@fedora-laptop>
References: <20261001-bug-ublk-no-sched-by-default-v1-1-0bc91b6f075e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-bug-ublk-no-sched-by-default-v1-1-0bc91b6f075e@gmail.com>

On Thu, Oct 01, 2026 at 11:10:40AM +0800, Qiliang Yuan wrote:
> Requests of a ublk device are handed to the ublk server through
> io_uring, and the server does its own queueing and ordering, so an I/O
> scheduler in front of the device only adds overhead. A single-queue
> ublk device still gets mq-deadline by default, which costs throughput
> on every I/O and an elevator setup on every START_DEV.
> 
> Set BLK_MQ_F_NO_SCHED_BY_DEFAULT so that add_disk() selects "none", as
> loop does since commit 2112f5c1330a ("loop: Select I/O scheduler 'none'
> from inside add_disk()"). Doing it in the kernel also avoids switching
> the scheduler from user space after the device has been added, which
> waits for RCU grace periods. A scheduler can still be selected through
> sysfs. Zoned ublk devices don't need mq-deadline either, zone write
> plugging serializes writes per zone in the block layer since
> commit fde02699c242 ("block: mq-deadline: Remove support for zone write
> locking").
> 
> ublk null target, single-queue devices with depth 16, fio io_uring 4k
> randread at iodepth=16, 16 vCPU KVM guest:
> 
>                                  mq-deadline       none
>   1 device                          111K IOPS   342K IOPS
>   4 devices                         286K IOPS  1070K IOPS
>   START_DEV p50 (1000 devices)        8.53ms      0.36ms
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Default none does make sense:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

> ---
> Zoned ublk devices were not tested at runtime: none of the ublk servers
> at hand (ublksrv, the kublk selftest server) serves zoned I/O.

rublk supports zoned:

`cargo install rublk` or https://github.com/ublk-org/rublk


Thanks,
Ming
