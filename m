Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207600;
	b=QhyHwjJYonBMceqxzWjo1hcPXZvAiuaYYi94WnM502OpBRpDm2SpVghqb9BUsDUoFz0K
	 xKPsOZBkNVtf6aenvf7ggvU/sMgbdOg+ROS0ir0UpoTkoP5NY3iI5rs3+E9juWsR96kKZ
	 JB3SjUdbI5R9of4WqWx9WLYFRrT6heMZWKWSYFzPSpbSBKq4+/lDoQC3hd1NnrumKTDB0
	 quRFrYuru6H/uBJV723cUFBciLDX8nHtmKzBsjpRkAGVewxkQwOEfWrJGUnBrMcpiut6k
	 b+Dkuf1dk+If579etUWRWaT/jGijDqLV08+ja+KMBm1ots2RWJ0fTTk1XSGcZk5DEzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KdJb1+otHKbAY66S5TWXTv0isFFDzUNZ4HEtijKmReM=;
	b=PWBby852+SO+89tYWCHbh71U8sq2WL/5uAS1WjyB5HJBcsLehQUX1IQobABtippgVDf/
	 7fHH/FUQMJE7fZQc3dJeiNhXYPZ/FajjnI0yM0MYQ/xQ+Z/ztkqoI34qPZKd9/rM9Pl6E
	 RDPyGg2h+Su+plbXUyY0qTMW9bM4xWaYAKqt29oOvZz1IWW5KK01FvLeJ5c6V3uXdVtlf
	 vM3wwhhxB9aDvJrGrveYatZwOYfr8cRAgfZuwqm/3x0jMMGrcwhVSmC4M1lXZanSrR7H1
	 LRiONTtAxpw3aVlHMmti1P+2sjtrFWw6Vn/9orsoGtPacPSW3epzT349sx8yARNkEHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K6oM50Ys;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F0606A31D
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 17:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 114F0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K6oM50Ys
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4a76f63b243so1767959fac.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793207598; x=1793812398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdJb1+otHKbAY66S5TWXTv0isFFDzUNZ4HEtijKmReM=;
        b=K6oM50YsyfDRlcFGLUcDwC0eiTCTtyJqsRGyIajd/jrTsqwR9x7uLIHyBlpA3ORxFJ
         Jr1d9DSJDwGsULGS0ow97GNNj8Lc50YG3uTMf7D+NMKCSLzbXX9wEpia9oFA73jwhr/b
         wMD12FEsZ6vtDFxvYK5v0fRXT0AVYX3mNjKAIdWDBKBwC1wkyac2CmJKBpSgBpf1ANoq
         Oh7MlwzL7F+39jEcSSnrSZeE59O3HhjEUSUgCVTzJE9NUzYFRyF2P/tF7tJrCYZuYgc3
         G9/MTEfc6T9njwzCpcr699pBThutnYVyLW/CBqS+ANdjWBpi8NERkF8W3LlCoXr24PG5
         pMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207598; x=1793812398;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KdJb1+otHKbAY66S5TWXTv0isFFDzUNZ4HEtijKmReM=;
        b=vdB1nE+Xh5sSxromj62AWWMnqu0Ox3o7KuKPtIQx5JUgT6TqJ4cqxmzj8T56+8H5ui
         Q/21VNxFd4ISiXBRYQHeqUQjqwFmGtn9YjSnq52ETrpCZ2ly1kKOOnxO336aQv70oRtJ
         gNiMmz/w1jbykHVvVnV61iuGZsPy6XRmGvGKD3yOj21l+HzdwPgZLFkJT5lYWOHzk8yE
         NcD24XJkijtnhEPAgy1RoXlDc5nbr75nIscnILFDxdjh8jMD12SlOp2N58yqmhCx4qPK
         imw3K6lhNweKQ0jr8QKh9c5JNX2guA7lgHBJ7b4Y7B0TG7TVzyyVCRxZCClzgvV11ujl
         k3Sg==
X-Gm-Message-State: AFq9FYJuL+mH1eXDzOne22raa6r0yfkyiaNuctk+klbgMVU9MxZU4D5p
	6O1kWrVGmWGrlqMlw5Pn1EOvrJLEAGhsPb3VM7psnCx+43qkrVpLEi4Ov8A3KiagpWzQofxuEwg
	fWaRa/1Q=
X-Gm-Gg: AYBFou02kmO9UheVemqA7KLh5/UjonDpDRyu1DFTn6xv7fdna1lNfK6wSeElMuu4YRq
	oGkf1T0IJH3GD1Fk72xAADhWjEC3hJ/lQI8DPgIYDwRQBQe66bksSLc1Ev64c0HH1Wq+G5bCZ0A
	f9I60qFdZ3ByN2J76aYLpS0yMKVIoltsq6iA4tz/UO876IYOhMr+0k07peiXD8RS7hxjmjICW/m
	/Tvtae88UOfxugl8+WAi9mp0zCKeRMxRZC17bacSAxuv8RnoEQF4GKg5CBRHea8AxEU0/l4OSDd
	mcrmW+LM0ItnWXbnhRQTzapJ5jNH+OW7W4X3MNyncQbaoVUg/5y/WVkX4fk5ddu1cglNJldLD3m
	A5nAbBCNoxlVw19x9S4IpUudE2ZYfwFyaFWUekn+QXo2nqPPqvCUKPpK4u83v2agoq4Cu/hBcRw
	atbnJp0X+MooTm11mRMeDziA9HF/reSy29YgBZgaIssgLPvbY99Ab698SMVlcs5QJw191zwQ9oB
	aleIz0a3F/h6RD7oPPa6dSkoKh9at5skQL9gGosENwqUgKhE7OSyoYfzims1ovf77b7PGVput7c
	1upCQ0HOa8D3uxfGRif/gBoPcaKygPbTX3hHd+9darhma/4UsJRs0VOHHyWIjXxXytmNUsWqgwr
	OsDpiM64xstDWIfBvTNhPCAa2nh1yXuM=
X-Received: by 2002:a05:6870:2194:b0:48f:e0f6:bd52 with SMTP id 586e51a60fabf-4a8e0ac1574mr89101fac.39.1793207597767;
        Wed, 28 Oct 2026 10:13:17 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b74c0a38sm2825474fac.1.2026.10.28.10.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:13:17 -0700 (PDT)
Message-ID: <b7d643bb-77f7-497d-8a08-06643876721b@kernel.dk>
Date: Wed, 28 Oct 2026 11:13:16 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/98] Various block related fixes
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <auIsvfMs114ndVjT@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <auIsvfMs114ndVjT@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 11:11 AM, Keith Busch wrote:
> On Wed, Oct 28, 2026 at 10:41:03AM -0600, Jens Axboe wrote:
>> Got a giant pile of stuff dumped on me, and went through and did some
>> vetting and, particularly, commit message rewriting to get it to a
>> somewhat comprehensible shape. If you're CC'ed on a patch, please
>> review it. Feel free to queue it up, or reply back why the particular
>> patch is garbage, if it is garbage.
>>
>> Thanks!
> 
> Neat! This looks like it is tackling my top complaint about sashiko: it
> flags pre-existing issues only when a patch is submitted touching code
> in the general area instead of proactively identifying and proposing
> fixes to those pre-existing bugs.
> 
> Patches 66 and 93 have identical commits from other contributors that I
> have already staged in the nvme tree, and patch 54 is fixed differently
> than proposed here. Pull request coming this afternoon.

Ah excellent - I have no issues dropping whatever patches, just wanted
to flush out this queue.

> For the rest, lacking any block layer dependencies, I'd prefer splitting
> the nvme subsystem specific patches into their own series and they go
> through our nvme tree.

No dependencies between eg nvme patches and block patches. For nvme,
ideally you just grab all of them, and I can drop them locally. They
only exist locally because they had to go somewhere first.

-- 
Jens Axboe

