Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3DB1CAA79
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225906; cv=none; b=cpvkWdP+D2NDnbpGfZjPqHZkBXR9/QFE+pKEvDJkMumUinCEIjH4hGTzd9KusffA/gd6EYaxDGTMUrio1YUptuLAblIFyIcJbgm1Wyi/XN6JPaRjerX9BU5zJ3OfXBExAp4CkvpYxw0GOiD4q5D3iOMXku6QLFdExKGefiEFOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225906; c=relaxed/simple;
	bh=Hc0p4esjtmP0p0Q60Jby7tjJS6WFKbZCOGIaX6HPOA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUOeNhUIx5ajjNAmAZhaCq/qBnf1PSq58I/dbePuWX3esd2qYf8rEyyhfbClkC9aStYUYJsh41msnvc0hYZeRfjgTcibCdI0SJzro825BG+hfsWzu8ZCizI95fzkpf5TrXZevhdnPQ6Y8fmo2jD7xB3xQeLRLKf+gnCsvYznDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iZGfrRWm; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iZGfrRWm"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4042fe53946so926421fac.3
        for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 19:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769225903; x=1769830703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HrqLaMllGTcSoVAzXQL65lpnvx8tOwwlEPBowcJKyc=;
        b=iZGfrRWm51VwDygP4Bb/VfOKFRnwgEN4AQW92WsSAFRMMtFkRPJFhGV+mgQCC3kW9U
         4R8TiDdx5bGD9V6T4Z7FC1wuXdwtfU6DipYWGi+fKxai5fNJaXh8BI9LOMB7lcB7GVcA
         VozK2BPjF82JjmWfWsvFV0iS084Bg+Wf+yvhtOsnPxN4O6A/9IhtjiPRhabeBY2O7YRL
         AJ5acf+sVhbrq1s8TqMeHblpA2Wm87i3+LlXyyW2dUPaCtQiipx3DJHZzTKea8d1ySrF
         zV86UenN0KBDZaNc/WMjJI0GJHjk/CGWsrVa1B61miHM4zeNic+ZwYJiAi3gL9983xzc
         TBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225903; x=1769830703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HrqLaMllGTcSoVAzXQL65lpnvx8tOwwlEPBowcJKyc=;
        b=fn5rswXd5ZyvI/CoYae2kQ0skiMuy6CNgLtATg9Kckadt/YMVDZZnvmLC2DYbxtZIi
         sWiR1FJcFjF0pQn0Vkz6REIPV/TzXVeYK3uxdqSjTIK1nRnOD+jxLE6gwGUyhUJkQiMs
         ffEUJu0rLLV1Q9OPbs9evaZCZZevgXFItMMg+H+xLy4FhveUsTku/kbz4u2AsV/My62f
         fGMNoNX5jj2gSU2j9MLnll5kYXeJNGheNyxpFYEyW/rr0ietynqxBCYWFa5G2sH9qDTP
         VMWifkOoWiiD1riJr2tcBXzVW/NkjPftIgsRvV7zI4YE5hbO39pfubO6wAXRKNe0q4rE
         yd8g==
X-Forwarded-Encrypted: i=1; AJvYcCVeyG7mDQjkJhZt+v4NVgSQ/tyyzYyFHLLHJ7oCcIsyrF4mYpkviOIygMoWCgGqNrmvJ/p1Tpwgv5T9YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCFCIeEwcT+IRhpMjy7T1KfAV+qUZkc/vipHBU7am+kHeev5N
	NAGDBLaLz6U41g00Bc83pNas8uaOsae9XZms2JQPygSxIXYDpe0tIZ3TEDEa5xvwn6s=
X-Gm-Gg: AZuq6aLhXGa8N14AA0HBrMuE5sD0nYqB9D0JJNKjmJynpkXey1vSie9NwlWcOZn8bd6
	VlkcgVK9GHcVdGBxKoZvthJ5Cf/kVFKLnQIDdvJvf2O+2+o7PyEfBl6mh+nR14lcY2X//zlgTrj
	VgmMBTK71OlTjkDm6WvF/ZcbVzTcPVah5Gc8JbPDwR3CiCylRVR2uTPIYVWd0XNKRVaF+i1HbT2
	RSxI6OmUR5jgWQGaMhJlhpV+5EtipOBeW5gWpr6INRQujnl2U+UDmeqZFcuJXv4IMfWPk/jVvVd
	+pHMrafXop0bEVmSpp6KiXgUXWPhnrGRR7in0XNvkVen04lQJ44rcP9jO/RZ52gisNpn4mXcnJg
	Z0ESnL2X5kY3OGJoDrNjaef1V6A1wdjVRrG6c3WxIWzuHGN0UZtcFKK2MCkD6d3+NZntx0hPobB
	L/q9F0HZ4G09efSX8iL44oPpXfeKxKRQ9iZW/2rjtt9P/RKsJfd+fOCOPAFkcFNaT5asm0Zg==
X-Received: by 2002:a05:6870:214c:b0:399:58c2:2e5b with SMTP id 586e51a60fabf-408ab837981mr2301633fac.51.1769225903105;
        Fri, 23 Jan 2026 19:38:23 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af7ff54dsm2679799fac.1.2026.01.23.19.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 19:38:22 -0800 (PST)
Message-ID: <c3d421ba-0151-4a1b-b4f0-6d3ffe4b7d1f@kernel.dk>
Date: Fri, 23 Jan 2026 20:38:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] md/md-llbimtap: fix two corner case problems
To: Yu Kuai <yukuai@fnnas.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linan122@huawei.com, xni@redhat.com
References: <20260123182623.3718551-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260123182623.3718551-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 11:26 AM, Yu Kuai wrote:
> Yu Kuai (2):
>   md/raid5: fix IO hang with degraded array with llbitmap
>   md/md-llbitmap: fix percpu_ref not resurrected on suspend timeout
> 
>  drivers/md/md-llbitmap.c | 4 +++-
>  drivers/md/raid5.c       | 7 ++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)

Is this just for review, or do you want them picked up off the list
too?

Both look fine to me, fwiw.

-- 
Jens Axboe

