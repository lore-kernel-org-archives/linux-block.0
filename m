Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4902E820
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609369; cv=none; b=ETs4S8Gu9OtwbPDeOBrQ6ky47JGqROzHV/ON1bC9PmVlzYGwY4FXOMTdVjvc41ObRTXoxNkawsziUzD/r0Ca8MElsg6vfbd/p4mdxAKPzvQlALOMyao9DuQ+gENfAYHbyFmU0icWdnnga7Lf+PFYFOcV3qsBabZ0HRP7G3BGRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609369; c=relaxed/simple;
	bh=0/yo8LHYQFq33spx9yfzd8+mCK8PI2lhE2GFZc9eIQU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TlkysVfhs/tAjkB+sqzDJExNecavb0z9/If/NsoFHVdn+arw3a00/ueM9+dr6sgC1j6f1Fu8hr29fNBXcnfC0CuA2fOWNqgrhNmm6boktewOnYrvxY98JQqDhZQOoTuwUmUHp6bVjfokD/lm+NAGs+fWm2QtleawdqZVScnImV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HehDMZNL; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HehDMZNL"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bee01886baso715639f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 12:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705609365; x=1706214165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESGKayx9JW+ADD0aYy93pZDrn8Ax/uELnUncqR3mJM4=;
        b=HehDMZNLZ5EODg7dzeAo/B9x5Iy7+8tD8VJcb5IRaezPj1HZYr7YdYITZBSKa6MGwk
         aIV9CBqihjoOG6mYhmDCqfIYKG0Dq5iHjqlolrVZoBtuqccc231T2GMBVZJIHzTQtTpt
         FnuC9KmstcjnZRIcmnYGl21Yi0WcHwEuUGCulkzJzKKrj3hiq6OYFNosbC7BQDPbpy/i
         ghvue0hfG7dFJ/gSb1EPOUpXeRyQwPzIzjCdUZwdvS47AOU1h0KtsRogheYIJ2YcCZzw
         GcGmZXS7BevZMciHncClsmNJiQW1Ad0BdybjhfnO7JfBrtzz1NbIMIr/TBM0XjjDMeif
         SSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705609365; x=1706214165;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESGKayx9JW+ADD0aYy93pZDrn8Ax/uELnUncqR3mJM4=;
        b=kTsW9fsnfLEK2DvL12HRW9KacQKnCTE5Z3ou8APHXqilUVmDRawsF7csNN1mzhgHUA
         0LpowzF9TP9yLxK9UxexpndxZaoKG5gU1Wi87QnSEdy00BqYR7yN4dhNYyIT7gKNEcXS
         UyLfi4czGFowKwqIV4TpVP01NW3fwiDDjYwfF63UTZjGVSWkIU1TtDdyQVt+W+9cpGJb
         ntMXkolnSYpzXiJaAYGGyAlGSh3h4Ho/FKf6OnnZ7xXXeqqx+/auBtL0YCYmlr3i6emA
         ekdsgcgi2FGD06Foe8N2UYY3vF0PTHuwsUVZNSLBTfq/t5LF6Vw/0kArYDifZhH8fhqr
         syyg==
X-Gm-Message-State: AOJu0YwGUtAo+jrEts8xuWFEv0Y8vkINkN2Wf2hLHQ62+rriTasNiUSS
	xzQ0CMguBaP0SFXTlO4wNcoN60Bq3k+hGTiYc0Utdful8NkTa++TNcJpKoRJB3Z8V83Hg8Jxp4B
	XJGk=
X-Google-Smtp-Source: AGHT+IGXpPfApBll7Lcu26TL1fnY1W56ICZ1N7GYfggmRgp8kAZBi7JgNGwHWqSarPrDZHzjeTSXGw==
X-Received: by 2002:a5e:8302:0:b0:7be:e376:fc44 with SMTP id x2-20020a5e8302000000b007bee376fc44mr513956iom.2.1705609365368;
        Thu, 18 Jan 2024 12:22:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x7-20020a056602160700b007bf0e4b4c63sm4263224iow.31.2024.01.18.12.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 12:22:44 -0800 (PST)
Message-ID: <7f1f90e9-d034-48da-8149-73a6dec20c9e@kernel.dk>
Date: Thu, 18 Jan 2024 13:22:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET RFC 0/2] mq-deadline scalability improvements
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <ede4179c-8fa5-4496-ac21-4e3fda41df81@kernel.dk>
In-Reply-To: <ede4179c-8fa5-4496-ac21-4e3fda41df81@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 12:29 PM, Jens Axboe wrote:
> On 1/18/24 11:04 AM, Jens Axboe wrote:
>> With that in place, the same test case now does:
>>
>> Device	QD	Jobs	IOPS	Contention	Diff
>> =============================================================
>> null_blk	4	32	2250K	28%		+106%
>> nvme0n1	4	32	2560K	23%		+112%
> 
> nvme0n1		4	32	2560K	23%		+139%
> 
> Apparently I can't math, this is a +139% improvement for the nvme
> case... Just wanted to make it clear that the IOPS number was correct,
> it's just the diff math that was wrong.

And further followup, since I ran some quick testing on another box that
has a raid1 more normal drive (SATA, 32 tags). Both pre and post the
patches, the performance is roughly the same. The bigger difference is
that the pre result is using 8% systime to do ~73K, and with the patches
we're using 1% systime to do the same work.

This should help answer the question "does this matter at all?". The
answer is definitely yes. It's not just about scalability, as is usually
the case with improving things like this, it's about efficiency as well.
8x the sys time is ridiculous.

-- 
Jens Axboe

