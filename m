Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE07A70C
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110729; cv=none; b=KNcGabsj9YfwKDElLhnbclwoLEHBSnz34eUDfXDTiy3JFEGoUt85q4Bp5p3MLa7vvk0kZa+WMMLDAfE/e9ZdGMP3RYdyc4D18oXsAtmvP1jXUJjyXMEzqIFxSfvax2iiwFsrE03Z/NvWUGq057oPoWzh4+PBMuL+FpE/+tKpNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110729; c=relaxed/simple;
	bh=iChkz3RJ/JjX2cGQYmXcqtVpR1TMEMwpKCBiO64owQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D72L59jiSNsL/TU+GkvomrB2Sr2PX18PkPjkxen5lgt3oQMmR/czQYIxRO+frC8A0ev9rgiK5ca9uHYxCUvIP2uZq9ssC/QgZWne+eagXe3kg+6vl+hlTjxNZqlwfcLu7R/SAdeCmw97Jney6MpGGU4Bj8uu9qKDj48TuVpCelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q7iaqQj+; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q7iaqQj+"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-361a8f20e22so348715ab.0
        for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706110726; x=1706715526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imWP3Gp2E6UBnAoIrtpIX4YQW5R0bzLUVdUmcPrzDb0=;
        b=q7iaqQj+buECW7MJ6Du13wNdR2g3nq8qqzgX03Bx/6IuG85T8YjQZ+GxT/qvSC5O/k
         pnuyn4bPjiva+EzCjzk0/2R/A7GrS6LibIh7VXIMoeRihaOsdEvpSRRZnMpPcP3vZiTo
         yQO+tkU+062CSok/3eabjToYIEiC4nHE/leLKRCNOlUC5S9Z9oPMf3w1wKflttg1sx3l
         pqdoqeMqL/94E87mlD0CZQhzqcSTWfG42hy4vmF3VIMD4d25PcE72nDbnNG7oLFVeHZt
         f5P3nPvDisGqLOYhRyBge0olJbcpbQyJyCcUOotbuwYX4y+Z7/3SJX0+i67yxfLC3b4f
         +F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110726; x=1706715526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imWP3Gp2E6UBnAoIrtpIX4YQW5R0bzLUVdUmcPrzDb0=;
        b=ciR1pVi83okHLpXtePUnBrt/DWn8lT0+FT1HyeDzwdNxQewZgJfaL5snhRcYk21EBc
         4rxq1H77v9GzxnVTrFrtkjO9MqdWqWmJ1qnAjSqkLHx7aHLthUJL4sWb6SAnhBobCyub
         5IeNf7pNU42yPkiFpPIyYJhrBEo+A+yQ8aqsy38BWSCVx0Ob/4J7rY7tPSdUlLJ/XB7d
         PWLC4gVy61iw2G2ce24devl3ZlTI38r3uwBuoQqG3J0Fa812zCdwzCzmwWOv8LBr/hh4
         97B4DPf0jsAtsjOt9oC5lhlNzWtkpFKedDhw9a6P6kE0AKS3GhnjCug9ggoEIk1RF1mK
         ru3w==
X-Gm-Message-State: AOJu0YzqVkgFRJ1R5bVCQ9BY8kFNByQfRrsB8emVI7cMtozpA3apIDSC
	D74gZ2rPzbTMYz8cSmyvfoQoMhFi5MRfEizXKtGFwb435Z0KkOceakb6+kfZRKo=
X-Google-Smtp-Source: AGHT+IHGO0OuIc08zB6r28ks8SrIow14ErqMD5ASV5AJmhlU9nV8ZGrHT4H7F5QSgWPC6E2drVxjpw==
X-Received: by 2002:a5e:9507:0:b0:7bf:b18e:fccc with SMTP id r7-20020a5e9507000000b007bfb18efcccmr2266012ioj.1.1706110726558;
        Wed, 24 Jan 2024 07:38:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q26-20020a02a31a000000b0046f1d658f71sm22225jai.143.2024.01.24.07.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:38:46 -0800 (PST)
Message-ID: <1879ce4b-d8c0-40f4-98ef-88dea0721974@kernel.dk>
Date: Wed, 24 Jan 2024 08:38:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/1] block: introduce content activity based ioprio
Content-Language: en-US
To: Zhaoyang Huang <huangzhaoyang@gmail.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 steve.kang@unisoc.com
References: <20240124085334.3060748-1-zhaoyang.huang@unisoc.com>
 <ZbDWSUkT/OjHTe0t@infradead.org>
 <CAGWkznHAi_U5erM0s8vFWwwucRKPoSzimNr9tdsPvs_sApGxgQ@mail.gmail.com>
 <ZbDaq+iI/8ZQWRxF@infradead.org>
 <CAGWkznGibmzH8WT9CjC9swWD3pLyCcWnG29eoj=EQk=Qd=kHBg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGWkznGibmzH8WT9CjC9swWD3pLyCcWnG29eoj=EQk=Qd=kHBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 4:58 AM, Zhaoyang Huang wrote:
> On Wed, Jan 24, 2024 at 5:38?PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> The I/O priority can be explicitly set by the submitter, task and
>> blkcg arre jut fallbacks.
> Yes. I would like to suggest if it is possible to have this commit
> work as a hint for promoting the priority since it has been proved in
> the verification?

We don't add patches that are wrong just because they provide a
performance benefit for some cases. Down that path lies tech debt to be
cleaned up later. Rather, the feature should be done right from the
start.

>> And as said multiple times now bio_add_page must just treat the page
>> as a physical address container.  It must never look at MM-internal
>> flags.
> The alternative way is to iterate the request;s pages in the scheduler
> which has been refused by Jens in the previous version. Anyway, we can
> find a solution on this.

That approach, or the current one, both have the same layering violation
that Christoph keeps telling you is wrong - you are looking at the page
itself in the IO path. What has been suggested is that the _issuer_ of
the IO, the one that actually deals with pages, is the one that should
be submitting IO at the right priority to begin with.

Your approach tries to hack around the fact that this isn't done, and
hence is introducing a layering violation where the block layer now
needs to look at the page and adjust the priority. If the IO was
submitted with the right priority to begin with, you would not have this
issue at all.

-- 
Jens Axboe

