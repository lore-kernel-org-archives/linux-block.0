Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57443154
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108691; cv=none; b=bGTukitgwTN8PhZ5DyHdbT0wUhR24LhCDppQSRob5vV7EOvGBLpsW1oxzwrnWuYCYWNMDDih5goJ6GpNxze2geZXDONKt3D+rGRvx5f1sPIsgmuzJzlAl1SpzotxnXD5tQwwrNxnon9nhsPNSEeaMRnR18maOFy/QD8dD/ch22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108691; c=relaxed/simple;
	bh=UqvQVK2OD2LxkaZ6sXw2a1ZwA5j5dQ9WbqrEdGz26sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAC2tfFzHY2IfXJA9J7GD8F9Pe6yswBa0/eSu4M60p3K0n8TVvK+FxqUUnX0DY2sX1z41kO8DrdAKQEu8hqEo8gGbLQBunO2olTuCeme+B7mckOto+Awj0yc8Vtsp/U4B8Y/TE6ePI0DA7taHq7i8lTRrnkzHnj1tMEivMIIxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n62eSc5z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n62eSc5z"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d74058f6aaso3549915ad.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706108689; x=1706713489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/ImrXRLhVzXulGu2ndZAfk2gq3ebdP7+hVyl9Y6DO0=;
        b=n62eSc5zTu3NBFHTt1SrhhAgH/LMUUO/uxSPP1DxDIR0ZUSMUjbzSpqb7Z/9LvYB0r
         HwTXMnU1UXRqiDPKxsymRum4wR+tfqUX5K++SGnhsqucKZuCUPVGOjPmJXXOlPNXLd++
         Nkkce+QRow+05XqX/NgCfq4Q885E0l69EHYCwtNxug/ovTUvx9FqqHMS5KtUuX3BaOGP
         Hpz+hJRqxSthJdb4mzljmCsLAM/glaVDx4bkGS284Kw9r0/pxbkHbC+FiJIb0zvLrm2Z
         plFWh3usKhGcmv29rhyp6GKqiD9w7yWFBpt3F3HiRyPCqrwitOfim0YdsEbWmyITQpec
         AKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108689; x=1706713489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/ImrXRLhVzXulGu2ndZAfk2gq3ebdP7+hVyl9Y6DO0=;
        b=NGFYnmvneTzKFFpPsrrMMQxCe8uV4fB/rAQ+n+k6VNGgCDlVEKpIH8APIeOztt9+z9
         ejLgEB1tNfmQFDrp2b2eq2p2iUUejkgHOjiZe5zgVXkvDUKeQcrxNw0K8cqZY/Jd2qga
         SML9+xZd8569Nuo9+MtM3hsXhvdbAjim5Whgiumsp74iD2AF3BzkA+sqchHp0H8fOZ1J
         y48JLK1Jvfi83S1c+Tr0M7HBZqc6OPJq+xoDI3lGlTA3GnfATK28vRPLTNPWBwbnPTjO
         xREiJF0YVN35UakB+RkQSgn1rchCJ3RVl1idHgBlsEotiFcEXpzgXSKfd1itSXZFfM5S
         Wm5Q==
X-Gm-Message-State: AOJu0Yz03vEE4n+U4s7e0BcpGR1cRiiooAfscvc8XxNZJ/GGRhe0Qck3
	RRho3roHGhjFV8iuP1tC52g3mYpWkjAkJTnDC/8o/yAgetNAfi23pTvllOETBw4=
X-Google-Smtp-Source: AGHT+IEoBSysEcydmF4weUfzexA/pTRlSiUZYGl9IHS3Yv8khCg4y6ytTMl2Q07KnHbCKwn8LKA+yw==
X-Received: by 2002:a17:902:ea85:b0:1d4:e2bc:89f3 with SMTP id x5-20020a170902ea8500b001d4e2bc89f3mr2556408plb.4.1706108689587;
        Wed, 24 Jan 2024 07:04:49 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q20-20020a02a314000000b0046eef94b4dasm1297197jai.170.2024.01.24.07.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:04:49 -0800 (PST)
Message-ID: <43f10d1c-d386-4ddc-b7df-1eeb4af87db9@kernel.dk>
Date: Wed, 24 Jan 2024 08:04:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] block: shrink plug->{nr_ios, rq_count} to unsigned
 char
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org
References: <20240123173310.1966157-1-axboe@kernel.dk>
 <20240123173310.1966157-6-axboe@kernel.dk> <ZbDYbVhKlqnf6Yk5@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbDYbVhKlqnf6Yk5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 2:29 AM, Christoph Hellwig wrote:
> On Tue, Jan 23, 2024 at 10:30:37AM -0700, Jens Axboe wrote:
>> We never use more than 64 max in here, we can change them from unsigned
>> short to just a byte. Add a BUILD_BUG_ON() check, in case the max plug
>> count changes in the future.
> 
> Do we care about the size of this once per task structure?  byte-level
> access tends to be quite a bit more expensive on various architectures.

I don't think we care that much, and honestly I'm fine dropping the last
two patches. They don't matter that much to me, and we can always
revisit if we do care more about shrinking the blk_plug later on.

-- 
Jens Axboe

