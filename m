Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A0C2C9
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873607; cv=none; b=p1L/SygRwHxIelSNzTlbQd2UziiWpshiBDbF8F/UIP8cXSRbzK5vMgAGXAngq/69k/wR4OpNtSsawa2Nfpg+PqF7mUlIvoJVnlTivX7NYAiSzHMo0F8UpMhp0JB31XFZy3uk1nvFuiRoilg1o86xs9J0ClLQ4nmz811wmkdrT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873607; c=relaxed/simple;
	bh=VV0k/p4lE70BxAFDLlj7sH+buKjUMQPXfnp+qptqqCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIf+QOGwnS3B1sAILLmLaswfWwfrs8yehToIM3gBW5981o1szXe/ajLfExfeoMbnoRkO+HQLJbuzaXGmDW/MGCUU/IODg5Uu+Ngg655nxO6Au1bt3q2/rwogaExqs2H+heFFBjNnRf3WuxIy0vu5pB2lCJRVUyOl8CK9r9CFu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dhmJe+K8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dhmJe+K8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c7a52e97so2249444b3a.3
        for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752873604; x=1753478404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrDpOIYNKEvR3I2rjvl8PrpvBtE1YFXcEtv1bnvVFek=;
        b=dhmJe+K8KpkpYR1Mj/uVc3l7eIhXM5Fva0/qRMdWLtGLB8Qn8ZhPfJBgpeWlhF2Kde
         GfGa35C4XeWlNN3DLXPo08LMMVhgeMZWdfvuy7zOSJ2y/ItqxysCFPQ8qHynF6hXrH89
         YhH3P7u+T9dFIlL5049BIMDXaonc+KZjWXooo7Dee1Tq3UcoDnaCgowEWo97a1mmndfR
         RFdC018JnBTbyk6eAwxIr3npebr8BFJcwoVm6wugreJy34aMM7FOYVhdENOe6RQv2l3+
         Za4OHxKAMXlZKEOlPFhcvDrZMAYyOlY0SAawbQmA3IJZ7wH38XVcaIn+ritPfMVrvzll
         yOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873604; x=1753478404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrDpOIYNKEvR3I2rjvl8PrpvBtE1YFXcEtv1bnvVFek=;
        b=CQBbUmfb/USNwU4BaUd+J4Dlu816F/wjxVuAYmfG4Rui1orHd1LxoUymODs9Ce7Pwy
         p4JgpImawjl0zu4Jbw1MgmifXv0EsdDfmMVjrtudoMBKWVMMtKegxlGDGiE1iUTN4en4
         qaTMgq6nz264wWlugru8LOtKec6tke5/LUATYuL83cmaalXDuWKEjeBTxm8jLdJ7yMLV
         /CSvTOMbtUCQeIC4PoQ5nab0l3qIsOE3f90smDfHxzaVdVVu9gtRfiGPl+lf4XHO62CM
         gqIHJkuaD78geFh9v8VL2RzsitF2cMxoe21bW84jPIn0jEaS0frD0N/YaVJejSz+WNwW
         7tRw==
X-Forwarded-Encrypted: i=1; AJvYcCVkUVE+dMMsIqrVYDZFXk8Burp20xYr5lG3X53mYZuRdr/rjNPfGk8r7KUXoEX3rRigN7dVVCj9uCqCDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIM8wULmt/P8QCdjFF4W23U7mlxnyWl3EJonE29AqDy2FVsuQ
	LlO/+YCEy4MIv/bWfCmWPNQM9tHp8Gy12UNMJqfBERwfe2/k8DSdjSm5gAFyElKVVqQ=
X-Gm-Gg: ASbGnctNR23ea2OZ+M9R3v2wuZV6apx2vsvKV2kHS2WvhNeCRxEppgormJ1mQv5DVqf
	K24IWEANl4fqNpwkIhMtLRkupk2MLGrCOGY2nBqhc4Hzfju+leLil4rKbLD71yafZWQLT3YEFs8
	VQllnp7qF5YCZ5Px5QXoFp70/dHL8VAHrqBOA+hpqa5EP3gBxcN1caVxvPiS+uVcu8msAPTeCxT
	52s4rsaZBnXiAKfm2C7CwWkrVWB/czEA96HNKc3JEUwFNeFEnK1HjSCBEh/Zcoi6sdr+bDOsXiC
	vCE73HN8h56NmuG2hTMO2SZC63ETi/OmivBSpvUl87jISX8HNkUIrVzNNuPkfCotvNQ4iEJKUjn
	P/yKMItinKparG0qEloIbPM5Kt4CNDuZs0giuSzg7s+Rfacml6I/uBk8I
X-Google-Smtp-Source: AGHT+IGqYI/R7Eyc4bvJSzGt0YxEzaNGG5QDWsSs2xVwN56ZLN0/PxwhjL7o5+Vrjh1/z/pqh3Mexw==
X-Received: by 2002:a05:6a00:1827:b0:749:421:efcc with SMTP id d2e1a72fcca58-759ab639270mr4848176b3a.5.1752873603834;
        Fri, 18 Jul 2025 14:20:03 -0700 (PDT)
Received: from [172.20.8.9] (syn-071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e25besm1730039b3a.2.2025.07.18.14.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:20:03 -0700 (PDT)
Message-ID: <c821c881-76c4-4dde-a208-bb9e8f3ea63f@kernel.dk>
Date: Fri, 18 Jul 2025 15:20:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCHES] convert ->getgeo() from block_device of partition
 to gendisk
To: Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
References: <20250718192642.GE2580412@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250718192642.GE2580412@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/25 1:26 PM, Al Viro wrote:
> 	Instances of ->getgeo() get a block_device of partition and
> fill the (mostly fake) geometry information of the disk into caller's
> struct hd_geometry.  It *does* contain one member related to specific
> partition (the starting sector), but... that member is actually filled
> by the callers of ->getgeo() (blkdev_getgeo() and compat_hdio_getgeo()),
> leaving the instances partition-agnostic.
> 
> 	All actual work is done using bdev->bd_disk, be it the disk
> capacity, IO, or cached geometry information.  AFAICS, it would make
> more sense to pass it gendisk to start with.
> 
> 	The series is pretty straightforward - conversion of scsi_bios_ptable()
> and scsi_partsize() to gendisk, then the same for ->bios_param(), then
> ->getgeo() itself.   It sits in viro/vfs.git#rebase.getgeo, individual patches
> in followups.
> 
> 	Comments, objections?

None from me, looks fine:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

