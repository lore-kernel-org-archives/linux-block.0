Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6A4E4323
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554912; cv=none; b=V+KLbebEI1jsAW/sKkgSJ0FsrNj3V3On4ks+IYYlQwlE5oM6QW97iJKjVxzELTYzBOYxyJ6E4m+CK8+n0smCX0RzPP8dcBochZMj9Guv6dFZ7uae79xVKU0x9iPMwagICSINYrZ9ZdUsMbiGP0ysaGCRs/Pq02Vu/oEN3mC+MK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554912; c=relaxed/simple;
	bh=5mSG/NBC8w5GCzj2/vawyONk6X286OkVdeh9HuVTQqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzYeZmVD7ypmBjhsIT3XtVWSPeJZYHKg5Hpuoj8a2Yu4i+DzjencSkTi/aVcqRyD+8EaPmUjXb2wsd2AS+R9XZv88NaDVKFrRtSGp2gcNSbhuPt1hCsxxe61rVBsdZYSLVwxHGFPp3OzJ4lUdQKjwRBMDsXEp9M92xfbenZUU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHC0hauX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHC0hauX"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e69aa07c3so887936166b.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554901; x=1792159701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UHiu5xDsf5v+fCY0BZIG/GtuTiSDrErnjbooFDt37U8=;
        b=UHC0hauXuv8K6JL3Cz1iG7f5QfHzerrC4XvyKd072iRfK8eq0qziwY1MOZzR3tw50z
         YdFgd457fuZU2Xeo5vVMTB72OKdnHPYKdj+qr93S+P0dZQrciVFVN8CRANIhWyd2grXd
         EEZvkNXPm2GY1Idn2bp4p2VzZStusXv3UQ3ytkAqq/NfZWx9xrRyY1eJet/4q5ikiU04
         9qS8S+P6cPXJYpDtFeTzdETV1+triRbv+esdAZPkVjgNUYeQsli17opltLDDXIfF6Z6k
         acNKGy0dWUEMXlsYu6YdVKivyxCsU9aCj1TLHzO4mWgd4zFi+7NJDJB22pLIr07xJh6N
         /u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554901; x=1792159701;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHiu5xDsf5v+fCY0BZIG/GtuTiSDrErnjbooFDt37U8=;
        b=djN2pn3reGrqFywLqyVnMv7hrUu8+87PF5DMpD3VFMJzxyOB3U+ebHEK+5FfB78v1R
         ey6ZSj5LRU428gPJ9eepeENwtjQqt0ynbMSrP9Qxhi7565EPt6Ov5tDutDC5pxg9481v
         2/E0Nr7suX48NEECQVFDPLp5Ra8doSDfw5ia3IEfonervqm1xOAzzpGATKISM+X33+7V
         Ko0XwkUQ34U7OSl8d2vAVVAlTAyEiN4ciq0QUOvq4O4TRn/bhzDmOZ+OAdCLCTInOzyx
         aiedA1yLINNX3yiJsx8dvftPQgpM5UlA69DDGTUV9V7FjEvR/4OzFLMgs4kdPCQ94G8/
         bMuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaW/eYgmDYRsrDR7A3NWwGSIDBf+7IYe7Ijur4yHtUrqu56wbdsfdnzL0z7xVEXEtkeGhIxVukl8AIkQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLHSz/rPMQf886gempAlAWfteLVJ2r4SNk903+xRBPD44YVQGhR
	1mpNY88Zxf9GahFLsm3+XIs2NcpiNzXnJs/qC+KYO/fz0Qsi1/0jQi8B
X-Gm-Gg: AYBFou0La4H9SuKLoGFUZdbGd8G9z852fcftI8oBceMSosa45OGQxeEDXbPxiyHCB3/
	NY9SRITQkVMQSx28u1FuHuITbLgl8rkNz/QdngOutjZc1nlrPwkbx4IYpaTRO1/QuUSJRB+cEVf
	daNJAw1NNUrOOuCsPlwIdieGYA2ujLe9xE9p91LLletGe0f19/2J0yF+UulouJa1K9g8DUBox4B
	KDKDh9LS7xwNIDUivzC5XVHKGsdnGufNKpAqyG+tz4VYS+7IUJbP7PRZerUWLZ+Ez9BBBdM55QZ
	KWULDErNpvsSJpfjAH+HQuP6ipLzUfrKvEZP5Dtcb/wQ0a18dGmNy4Q3vy7a/QfLhpzdamdOvsc
	k1NzCHpnN8MF6SbLBAMHF+lYfGjvbeyR/iah1v1p99t6FH0rC9/6TQgur/Pf1XU+RSG8AmQ/dF0
	Y0dMohV5a1H015SNUf+5IeocjuvQwTuXocLu+WjQatbIoamxqDLmvgMDC2GcE4IwhegyJpY42hr
	ybAn+OczzJQL9L6PbAtJ1dUg5bXGASnTECUBlSyQdjohbpL6C/MLHHAHYndMAHyaYPSFZAocP9F
	w/4=
X-Received: by 2002:a17:906:c110:b0:c2e:32d3:1b5 with SMTP id a640c23a62f3a-c31aa079e98mr201069166b.32.1791554900723;
        Fri, 09 Oct 2026 07:08:20 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3bbc9sm97535866b.20.2026.10.09.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:08:20 -0700 (PDT)
Date: Fri, 9 Oct 2026 09:08:12 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: ublk: make the fault_inject delay a pure
 timeout
Message-ID: <asj1TNs1XLIAzUQ6@fedora-laptop>
References: <20261008-bug-ublk-selftest-fault-inject-delay-v1-0-a96af7ead06e@gmail.com>
 <20261008-bug-ublk-selftest-fault-inject-delay-v1-2-a96af7ead06e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-bug-ublk-selftest-fault-inject-delay-v1-2-a96af7ead06e@gmail.com>

On Thu, Oct 08, 2026 at 10:45:40PM +0800, Qiliang Yuan wrote:
> ublk_fault_inject_queue_io() queues the delay of each I/O as an
> IORING_OP_TIMEOUT with a completion count of 1. Such a timeout also
> completes as soon as any other CQE is posted on the ring.
> 
> With more than one I/O in flight, the completion of one I/O ends the
> delay of the others, and ublk_fault_inject_tgt_io_done() reports every
> early completion as "unexpected cqe res 0".
> 
> Pass a count of 0 so that only the expiry of the timer completes the
> timeout.
> 
> fio 4k random reads for 10 s at queue depth 4 on a fault_inject device
> with --delay_us 1000000:
> 
>                             before      after   expected
>   I/Os                     2263170         40         40
>   mean latency             16.3 us    1.000 s        1 s
>   "unexpected cqe res 0"   2263169          0          0
> 
> Fixes: 81586652bb1f ("selftests: ublk: add generic_06 for covering fault inject")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
