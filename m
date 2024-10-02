Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1971D014A
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881406; cv=none; b=SFj4qFwUtMgM/fiOudcNuLzgLpqfF6WaEI4jJwwxtMuf8C3IPjFukla4u1WstMY2Wk0XZPIUcniZpbladTkF7SiSTjjJBtN2VhCpgtLq+Nk4kA3VDnTRpdbPS5+hQu5cXXiTY1GJHH8RJNxNDy+8GadO5ydsl6ZpE2IpEenqWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881406; c=relaxed/simple;
	bh=A5bkOqDxFmnjWOcQv7M8QGENshtutAhVmgSm7Ft1O2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAxf5/+cmmuEHUbLlpSm1Za+I89dcOLICjYhedmHFIpEwF2b8x/R/ajoPKakjCLvtKwi5BCDyjT0cV64jupdcOIvQPghpaJz53+HQeGniG1IahutRHGaWMJgxfWkK8DIl4tANYaEGu8nkEpOKsKXN7iDlPyRjE0gF6X9uFdxbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xGLJdNMe; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xGLJdNMe"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8323b555a68so418621939f.2
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727881404; x=1728486204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN8tLxTNLoc6Z+6iyULY22+FNGpb/PmZBsYC0aDr5nk=;
        b=xGLJdNMeYj1JJFCK5pq/+u/EqfTPs2viaPoMJX76e+b6EtIzioliSstzI9B12w5/e/
         C7vHhzNJ/AXyhBVnvDyNlTbKfwdd8AQnn0WgmUgSAG7F9xzg2FvZS2hYUi7Z8J8m4P+A
         Fm4nxBK/NHZQJOML9UgGK28nAT0iEj9sBAgkjHL+Tqhwo9/nvW8zcAMHEWFHjJP8qTH+
         I7rUI0zQVqtgJFj2g8Ss0mM8up848OHXG2rRMp3YxlUd9RqaX/l2q41M6nCJsBIi/2fo
         4QZtmAeIxZh7PXIn+UAELBbSzMIu4NL11WT3V9gDMCufWpFbhF927tUrqyU+leXObu9n
         AzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881404; x=1728486204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN8tLxTNLoc6Z+6iyULY22+FNGpb/PmZBsYC0aDr5nk=;
        b=A5kjWH24cL+8CPv6snYoqi3vqLARkCURG6paDKBghZuRQsVRc0Hd0pdd7lhGVtFxFt
         uzksjOdndUagsLEdu6dEX0z7ld7mIS9hOS/kutGCGoFu62Fa1NbQwEyXCheMItbBNhzx
         cuzEpH5kYLYQ4eM7kqtP3QBo7lOW7yRKCTZQ5xsl/jfiI5D5RcQ7XbGxctLxttOz+If/
         86Nq2PjFM9g1vUl1Dc/lGPpwqDnjNvf3yfPlm7bQzIsQvC8jYuo14kVgSI1iVI2LX6Sg
         rFlqDHKlk5wo1+igyBwoe8b4qeWeVzGDpEp/Z8qaRHPyOjUOWAb3kz5meTFhKucyG4fo
         BAFw==
X-Forwarded-Encrypted: i=1; AJvYcCVX5P0QZ2W32gufCAd0cw58IePAgMoFlJm+gsSqgeQtyO5wtc46LDVSZExl0yiyu7ETqQjsx+MhaUTqDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRsRqHlZKPeKuyKoRTGM44HfqRZzUJeMP6o8JsIX4jHFpX53RX
	RFYNLwU5KzuWYWuMqjhf2ZTh3y8Xt3TWDz9AfPOQMARJRpPRZ9v3HFjA2qDFCDs=
X-Google-Smtp-Source: AGHT+IHxepFVron7PObO0zlx42lsa/dU5NCcXVtGwmYpMS9i6sDKEx8F2iCKxC41JSaFOYey3Om7Gw==
X-Received: by 2002:a05:6602:60c1:b0:82d:8a8:b97 with SMTP id ca18e2360f4ac-834d8519045mr390417439f.10.1727881404221;
        Wed, 02 Oct 2024 08:03:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936c8597sm334094439f.16.2024.10.02.08.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:03:23 -0700 (PDT)
Message-ID: <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
Date: Wed, 2 Oct 2024 09:03:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hare@suse.de,
 sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org,
 dhowells@redhat.com, bvanassche@acm.org, asml.silence@gmail.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002075140.GB20819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 1:51 AM, Christoph Hellwig wrote:
> On Tue, Oct 01, 2024 at 10:18:41AM -0600, Jens Axboe wrote:
>> Have to say, that neither have your responses been. Can't really fault
>> people for just giving up at some point, when no productive end seems to
>> be in sight.
> 
> I heavily disagree and take offence on that.
> 
> The previous stream separation approach made total sense, but just
> needed a fair amount of work.  But it closely matches how things work
> at the hardware and file system level, so it was the right approach.

What am I missing that makes this effort that different from streams?
Both are a lifetime hint.

> Suddenly dropping that and ignoring all comments really feels like
> someone urgently needs to pull a marketing stunt here.

I think someone is just trying to finally get this feature in, so it
can get used by customers, after many months of fairly unproductive
discussion.

-- 
Jens Axboe

