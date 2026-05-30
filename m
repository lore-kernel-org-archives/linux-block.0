Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C232017A586
	for <linux-block@vger.kernel.org>; Sat, 30 May 2026 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103464; cv=none; b=uPGB5F5RGHinBOSsVUwfDngL3Vbf0ZXQFBsU8k2frwJMwlV/AejpnSxJ7mvuZoaeA86V3uXcOLQiUL2aHArOpku0q3ZeRPPPBweQM1vn1YTKgHpsS96oI8g6QQ4CuPdDv6+3Bbkl7IlIEU4xEFznlqr6wPlWdtBi/sFsn9HfI0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103464; c=relaxed/simple;
	bh=huxSrCuG0FjFGfixqDEb+YHlO7aMFs7aDt5bE22YDhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTNK77b3BsR4If4PtjQHADI8gnVLgyAQAugJQAqG/zn2RpJY0BLb3CKjzSi9NvDwOM2ezlsY//47yYMl2LRGCTVXyMclNbgZgEoYkBWACwfsxRTOpioJri9jLtbyzCjeBqxdKn8FKCl1TyvxL+1cwvPENPfnEGSBpBq/krdU+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6LZ2CYg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6LZ2CYg"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516cbde40f2so93205931cf.3
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780103462; x=1780708262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwbrM6sSXb8vY5axfHVECFP+564P0VkFU81XzT6eU3g=;
        b=s6LZ2CYgHYroKZQldbNezk/W6+Ve43rjtdr/ihA2vC8wv3h5ZZxSBt4YFI4JuXsAQd
         ypGXmLuR+vHjk0NFu/YuoyJ8MeE5CIiQxmuzqAD+onu5miXdT4Kz2724yDpa5Cs5g8OA
         DKjxAFJFnR7w3l8oPQxPrGuDgB14f+yPx4IB/YrC56GtandSp9WL0GD0Bqq8J1OI3L5k
         CApV3sAYFYf0mN44jnEKR/WIPxniKB98bzHApc7NCFwHBE0sILG9iBA5UgQoLqBxrxwn
         eRb+GXgjEfVCiTU42K2FtO/P6xfLJUlzqMJzcKnLgbGWGwfncHKcEZBzDzkUiu3+BB0H
         r29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780103462; x=1780708262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwbrM6sSXb8vY5axfHVECFP+564P0VkFU81XzT6eU3g=;
        b=kj74HKo9NyZrNAdC/tDy3CqB2ZZ2s8dNXgbGLHMKNgIHZPFrPa+D/RHicBOIbkRoGo
         O2nd3+f8NOkPeLPZ8IVm0jd7fmSlBI9oT0fxbKM45i6+FKeh5zkuC9oyjTrz4L30UFFr
         BgZCtggzVnrS8HjylpEJ3OXqxem0Vm+h4GIzGd703ZbC/dKWUuH9IOVAeVUWwwFpiuvN
         F6/Bv4jCBQD0Uqjj8cEtkDztlSzSePauuX17cLo0DiODQBdLAnDrYLcDoxianAmQoua+
         ri+mIHIoXBXfgrzSXqRNpah/x+40hIpZz2kyKZ1C8p/ZeD8ipfWRN1E1lYSWIhy8dM3k
         E7Vg==
X-Gm-Message-State: AOJu0YzRd4loUvKUTjRa8jG22//3W7Ih+UaCZnmnALwLfR7Qb3XjvrtM
	193YClIMHabGHBlrCn0DjrgFJHzt0zif0lIBWyvRo4uSS7EvN97NhEcs
X-Gm-Gg: Acq92OGz0sL/jjHgFWoE2CiLNfiBN3wOfXZuNHkXI52ITfOuFwsYMy9p35BXQfswfbL
	vJUHJm58EVNJaX0YeTJgGEbk3EII7HTd5CTz1A8pJoDLfx03cknVxUDGmVb1eUsqWZHhq/c80Di
	DPZ7MDp8pUAPEwDpy/NIAR1WzuwhzbwBSlnRGqoAy2TuZ1UnjOZvlu2hej7QGt7naofXBbSd2Uo
	2h6vysL9CKJs3/i+MOXsyq+TLxgOkEq1ktU1LZlRBFwADrDtv9NFVZ0WEsRpOufNSwfjJ9SpC8R
	YACeYGVYs6A1Or50OclxRHHH55mGQuGnup9E9b6WyKHrrbzSFWVivtSO7q+bd9Xzo+YguaeCHqd
	k7M1/nsWtE30Zvq8cNvHIhMFS2bcfowD28jO/HDvZGjM4vZ0VDJZs4Pwie3EnjVsopi3wNRDWn7
	Z5i0XV214evk2sq7//iFltNLUpXT8MwfvKrJ4seVjqnkCn+yMnxHvghgn73ZPLokzka0MVykB//
	meWPUvsxkYfeSGUzpUXuX3CuEfOaqJg
X-Received: by 2002:a05:622a:8309:b0:516:e7d0:73a2 with SMTP id d75a77b69052e-5173a70f246mr24523451cf.15.1780103461838;
        Fri, 29 May 2026 18:11:01 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172eb3619bsm36386881cf.14.2026.05.29.18.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 18:11:01 -0700 (PDT)
Date: Fri, 29 May 2026 20:10:55 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, jmoyer@redhat.com,
	Gjoyce <gjoyce@linux.ibm.com>, wenxiong@us.ibm.com
Subject: Re: Observing higher CPU utilization during random IO fio testing
Message-ID: <aho5HxLsWMEpbUg2@fedora>
References: <338169f719c77e4afe58f42e9760349e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338169f719c77e4afe58f42e9760349e@linux.ibm.com>

On Thu, May 21, 2026 at 02:44:22PM -0500, Wen Xiong wrote:
> Hi All,
> 
> Our performance team observed the higher CPU utilization in RHEL10 compared
> to RHEL9.8, observed the similar issue in upstream kernel(v7.1-rc4) as well
> when running FIO random IO tests.
> 
> System configuration:
> 47 dedicate cores
> 120 GB memory
> PCIe4 2-Port 64Gb FC Adapter
> FlashSystem: FS9500, 12 LUNs/FC port, 100G each LUN.
> 
> Random IO tests are more CPU intensive than sequential IO tests due to
> several factors: more context switching, Interrupt Handling,  cache
> Inefficiency etc. We found out the following patch which caused the higher
> CPU utilization in rhel10 and newer linux kernel:
> 
> commit 060406c61c7cb4bbd82a02d179decca9c9bb3443 (HEAD)
> Author: Yu Kuai <yukuai3@huawei.com>
> Date:   Thu May 9 20:38:25 2024 +0800
> 
> block: add plug while submitting IO
> 
> So that if caller didn't use plug, for example, __blkdev_direct_IO_simple()
> and __blkdev_direct_IO_async(), block layer can still benefit from caching
> nsec time in the plug.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Link:
> https://lore.kernel.org/r/20240509123825.3225207-1-yukuai1@huaweicloud.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> We reverted above patch in rhel10 kernel and upstream 7.1-rc4, saw lower CPU
> utilization when doing the same FIO test.
> 
> The patch adds plugging in __submit_bio() in block layer, maybe cause
> performance degradation:
> - Random IO tests have less merging, flush overhead.
> - More IO scheduler interaction, forces requests through scheduler instead
> of direct dispatch(direct dispatch to hardware queue)
> - Poor cache locality during plug operation

Yes, it is expected to see regression on QD=1 workload.

Adding inner plug for caching timestamp only is not good from plug function viewpoint,
because only the outer code path(io_uring, libaio, ...) knows exact IO batch size
and can decide if plug should be used.

Given 060406c61c7c ("block: add plug while submitting IO") doesn't provide
any performance data, maybe it can be reverted.

I am wondering why not move the timestamp cache into 'task_struct' and get wider users?


Thanks,
Ming
