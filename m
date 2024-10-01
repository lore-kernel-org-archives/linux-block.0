Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4401CF5E4
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799525; cv=none; b=WHevzUKJp8DKp5qa332enl1uBpIpyvSXeawm8lnEmIVkcDRSdN9dpFG9GXkAwmfr37/DWW+TZ5f5PzRII9DdhEBQLaF3R/eq5WSpSF/VU3mSgBzWQQF4qWArXWn6n8i6NqrkrKRPDBwblbR6OqQZQNf+uJteUzaT7HOvdzYcq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799525; c=relaxed/simple;
	bh=/6sa7hWBGz1r0Va3Qz2rpYvKdO98ZVVHU/A9tn4VDrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMDGjYy4wddZGsd5bD6HavPI0Pa2SY64flKTZlZnWUWoRKF1LZThLdIaJCccMULga8IYlGNJ7mKRgcDx9sUQ8QEc9fSLvbqN5qX7unJ01azTQp2Uhg14TsiOB8JCL1to3yPkC39rIXkZuSLdvBFOp1hOSMtnrdC595xjfkRNMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JKGO9QDL; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JKGO9QDL"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82aa6be8457so197009539f.0
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2024 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727799523; x=1728404323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAN9+Fgd7PdcO/S9osl9BZBdIn0Oo+OHK8n02sQXHo4=;
        b=JKGO9QDLj7i07HmCccv5gAYqpmYQMHo7jxnKGnDeWV8yrNsgCwOMWAjtneze2CqAGu
         GIIDsMeslQQqYMQbheMADr+KKsy0c+pAP6ljjsdXvKBZ4WvEzVFz0xl9SJbUhIsRnIrW
         8HydhoI9VHKxcotoz6knfieAKXXGGAR3o4Qp0e5T8YICpr0ACKwYbMjr8jS3h+ob0zIJ
         AENwceNP2vNFJd9QSH+1+5t/5ypXSjgRwJkZRB+fcu+fJwdt+HP7BsG4HTs5fIDO11Ve
         8wwIEE9JFpG4HD7bDa67x/cEP1FJdOuOpprHeBUh0LJIZ5Lc10+q4yY9R8ZGqUNJWvMr
         NPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727799523; x=1728404323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAN9+Fgd7PdcO/S9osl9BZBdIn0Oo+OHK8n02sQXHo4=;
        b=LZU2iy+RrP4Sk+vrcNLS/8YVsuhf/upy5qTpyMpoq0NRZcPu/A4WyJBQkjl8tn924Z
         ++YaVQ6aJZjKo2Oieemk+Xba4AB1GX9lcCeW5MoNjp+BQcXhxWiEb9qIQb3ZbCD78tkB
         y32PBrfT60jSVL8CxiZP7DSRzsel0KYpxW7xMOoj3mFRS2INLJYN/rBFnM56tdMYzOlo
         d0z0gC2zsVfW0jOmJDPENRsR5Nv2Gqc3ujoZ4hAQPHVHV/e2HSUXoMWLnCtNGNFd3+mz
         ZXtIUttqT7jQOESw7o0op2lw7yseLozB6krwpzACm7IikDcaxwJg+CvNtv1W9oo7JrDQ
         4Gow==
X-Forwarded-Encrypted: i=1; AJvYcCXHPD0WUpXPsF4QZvOkFg2Cyc7TYFX5Qf3lLO1xJp00nqj1gSKookdDhGmQZNJtWnbrUziMC5kpGdiIjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyst9YGdZa9EOwYSyInndy345MJZYa4P9I39RZ9n8zzrAHEOfk
	PgsV3pJqiGwUzGiXZm1KCfNOVW9bSM0XJdzXpcxrT1WNfBawxXsWip2t2Wq8rFY=
X-Google-Smtp-Source: AGHT+IEVRPJ/uF7tZwik0ff3xUr95buoTs5S0Hs3+xr4rSMiaRrnSDjMAIRQglj6MrbFnKyykiXTPw==
X-Received: by 2002:a05:6e02:148a:b0:3a0:cc84:9859 with SMTP id e9e14a558f8ab-3a35eb6177fmr28452955ab.10.1727799523118;
        Tue, 01 Oct 2024 09:18:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c2f4esm2640662173.110.2024.10.01.09.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 09:18:42 -0700 (PDT)
Message-ID: <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
Date: Tue, 1 Oct 2024 10:18:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
 martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 bvanassche@acm.org, asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241001092047.GA23730@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 3:20 AM, Christoph Hellwig wrote:
> Any reason you completely ignored my feedback on the last version
> and did not even answer?

Probably because he got a little tired of dealing with the bullshit
related to this topic.

> That's not a very productive way to work.

Have to say, that neither have your responses been. Can't really fault
people for just giving up at some point, when no productive end seems to
be in sight.

As far as I'm concerned, this looks fine to me. There are customers
wanting to use us, and folks making drives that support it. It's not
right to continually gatekeep this feature just because you don't like
it.

I need to review the io_uring bits, but that should be the least of it.

-- 
Jens Axboe
