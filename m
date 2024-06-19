Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F520319
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806881; cv=none; b=FNXeQl8AclRz2RRrhuWGMXUhyT60j6HGDcbJO+EyPCnR6byZoYIqo5jDn/bwn+RVJ79auYNJ3SW++89cLMoYE07Ibhdh12VhbltISDQLbVCsV8/4dsDpalYi7vx+WKGVFzrpNtGAZiQDS72rX31kRPpzo5t1Tm7AWgT51hD6KrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806881; c=relaxed/simple;
	bh=uH4XR4wLXeFFWwFyzqN4liYHhcQFiK7R5SRMOkCV9Yw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f8Lr9E95ZOvWSspU8aU1zMoWfpmQPpnG9ZTAv06tL3aZQX+b/8A++uDMiEU9JLgewjNE3K+Vw1zkubHNojM0/3Yn2IBLjZ7ozlftUrbq4llU2I34u/4UN5famnD5HozJkggQBIpgLkm9ju/Idej39CoAknTQWMpVd54NSvRceaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MbpDiu1z; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MbpDiu1z"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e9a52a302dso332775a12.1
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718806878; x=1719411678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TrxAc+Uu30dWHZppC8CN0wQM7I31e2d3aLis3drkvvE=;
        b=MbpDiu1zr2r5g5/m9IvUWgBKM6djvABnGCxvHPYDh4TDP4qnXnGnna/dIdsmFnyPg7
         w4liQUOt/FQ+qr0Hw+ZWUTlROSL0YefUHUGYwyFlC0wjSfaIVI3D/GV2NTKG5vwUuDeK
         zq1Fm5zS5o1eVp6SF3RvQDn0NjjA9V5EeSZhEWeCm7eeKrJdBPOuB9eLhD7BJYhcA46j
         Rv6aOHiUcExBK0HRethB4PBTKzmUZHWwnZ86g6N72fTdGF0s5mXOQepNR6wxeDIQp+2R
         50mz5w8RyQuGkoAMvNIc+VCIdxWWNTUTxOYXvO4r9L5ldQJ/sML+ResJ/r3VtbZCRWrY
         x2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806878; x=1719411678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrxAc+Uu30dWHZppC8CN0wQM7I31e2d3aLis3drkvvE=;
        b=wtIw3NljDeMqyIw2l5Y1srAN3JtNPIIUAQ1ezciyi+9pVNxPrKRDkEuIwPZEebSj6i
         +Ucj3L8ez325Tw3ETHeiKR+VULnBSEWPDDKEcEqq5r04UlgJd+bJDBPAqFqHaV1Exbi5
         UF4WKoUSA8c7Scd0j7wjF+WhNol02K/tdTLgL7Qzn13vdPybjIyBmLYW581AWgRWju6u
         K+iccVp1YR4ALViWEtNThLXh28mzfOE3PWvqqKssCRs7BLyPIFuHg9gFaqfGnIz7+JVs
         MhnkG7ze0CnQ46DGcqSk2wDuRdMFcE4c5TdJGlift28e4L8eU7QCzCIsl9yEm0OPnHqC
         sX/g==
X-Forwarded-Encrypted: i=1; AJvYcCVOraHoqNuZ8vYCmFdNKKxkXaTO2YfTy1lGO326spf5403e/Uc1NaFMCEh4Z9RkXqierBXF/pZCpCbP8vO2sYd3tSaUwxM+iseOCpE=
X-Gm-Message-State: AOJu0YzPNDkkA3tMmYV0kjoDcWGxqYwVP4DEjUnf026YAmwt+PHM+Y/F
	sXQfzJeJacehlwvJrZDi+UYsvACbHwlzl/eojL7+VGf6dSOZteVUnAfWd8Sgimk=
X-Google-Smtp-Source: AGHT+IGlNYahWungPdY/VG0D2i+/kOzAqG/9vIEbq77BhnEO6pEhdeI5ihGxkaZBKQBmSE54SEc3pA==
X-Received: by 2002:a05:6a21:33a5:b0:1b8:622a:cf7c with SMTP id adf61e73a8af0-1bcbb727134mr2697727637.3.1718806878609;
        Wed, 19 Jun 2024 07:21:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b110sm10739431b3a.153.2024.06.19.07.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:21:17 -0700 (PDT)
Message-ID: <e8e718ca-7d3a-4bce-b88a-3bcbe1fa32b0@kernel.dk>
Date: Wed, 19 Jun 2024 08:21:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: move features flags into queue_limits v2
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240617060532.127975-1-hch@lst.de>
 <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 8:18 AM, Jens Axboe wrote:
> 
> On Mon, 17 Jun 2024 08:04:27 +0200, Christoph Hellwig wrote:
>> this is the third and last major series to convert settings to
>> queue_limits for this merge window.  After a bunch of prep patches to
>> get various drivers in shape, it moves all the queue_flags that specify
>> driver controlled features into the queue limits so that they can be
>> set atomically and are separated from the blk-mq internal flags.
>>
>> Note that I've only Cc'ed the maintainers for drivers with non-mechanical
>> changes as the Cc list is already huge.
>>
>> [...]
> 
> Applied, thanks!

Please check for-6.11/block, as I pulled in the changes to the main
block branch and that threw some merge conflicts mostly due to Damien's
changes in for-6.11/block. While fixing those up, I also came across
oddities like:

(limits->features & limits->features & BLK_FEAT_ZONED)) {

which don't make much sense and hence I changed them to

(limits->features & BLK_FEAT_ZONED)) {

-- 
Jens Axboe

