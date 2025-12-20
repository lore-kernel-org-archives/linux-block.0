Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107A2F7444
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766229270; cv=none; b=kGQo4NlVdlH6Pi+smgJQrHQD2pJLbe3clzSFbUw2WaIWKfb3YYGSz0LRVMGwlSUNyHe0mQ3yrYIZfIIEjZY1bu3Rf4HOdJUQMig02FBWd9K8dV/pY9LTgyersPrFLylZEgU+0j0u61ACZqhq6TE3lpyebojULaaxC7NfmhBQjjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766229270; c=relaxed/simple;
	bh=YBLpmXKK0zr8H2bOVICDN7aFV0qJJhhK4BjTnVnMHiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr+Xi/DRbhM5VOBH2RoLanwP0WBIA6gClUt7Vd7m++hPIyrNTvt6n+Uv3NdhswqK1Zh3jSCfm+lRzZB6o+ompQKR8XGBoX/6r+mkJ4HbhW9FzCHbU+ak8ZlXsBBn76hu9hJXXUX975GKXTtCAHzBYhbvA25ZaQQYR/xkcUU1oJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PbeXKkOB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbeXKkOB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0834769f0so25194165ad.2
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 03:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766229268; x=1766834068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SF3o1aalVLNFjBOXFJUdn1XZc+ZoVvEFJMYXgQhGBU8=;
        b=PbeXKkOBvvYAO9WrZISo5zwyf9zDACAzxkncLX3dyPSY+N0hmM4WMvp1RuAqcW5bu8
         QgSdICj8eQidiaKGYlE14LClXpvWbj7UnBQfJ95u7TeynLo7cKtGXQFJinMHAETRWQ95
         uMhCMiZqWZpZDVEXLQpkQ7j+RECl5oMbjjAMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766229268; x=1766834068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF3o1aalVLNFjBOXFJUdn1XZc+ZoVvEFJMYXgQhGBU8=;
        b=MHi9IxCdVqNcwE7BTG5wwRwRYriOSABWBAx2P/5ScYgcq0mlXKbKgcklfX5QbpQ6G2
         VP1mIg20l5/FknUoyrCuE+KmBW7PPmnni1coK13fFy4EpPF1GG4c22K0xuTb0A3mxPoo
         bvUR7M+q4l/oTitn4tMlrTkPvzjgQ1IIkhdYQ4dbXVuCOpWwg2B/Llr2ZYLW/tScuOza
         Jr2BhSvHyT9d5UpLhu0w/fXhKN6w2nMsmdb4y/1wJDGGos3ZkZ3tIjgRH2lDh0q3/5ir
         GAbg1wZB5e2iiJmht8UcQzD66tzMtZmci/T0zVRCrdv5dQQZk9owdw1qb5DeovPDVHZi
         UNCg==
X-Forwarded-Encrypted: i=1; AJvYcCVXW5+wlB/pp1BYp3LLU3n443cPLmXmpk1c5hOL7bIyKRo8Xief+82hyIDo/TE9ti54MwAZOF/ePA0GeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLuaquvDA8pvHqYvuF5y5E6rC2S6tYlIJKy0kekE0J6JF1ju4
	jczxjfRLdUHZZ8irRfFuRFUNbKVz7Y672z0pdSo8ri+n2AhMDxRTseG9Rtoo/9/OAw==
X-Gm-Gg: AY/fxX7LiH9w4wfSG5+QyJfJB8OPwTAUjj6nOwGQ62fgx1OZUWoroeucuYVHEa1A72R
	CfALIN4dPWVW3qTdT2JptMtdBO1M3YluaJ1wVzVXK+UpoZoTmCSXZw+BjvqZqcXf/j/6tKh3knC
	KEDQBT4Y8Vu/Yz/LfH9SSkRKaI2vfXQamd9uyyECjDe9SfVwUzJo18jBbsF4bsY3ul/swSm88F7
	fvxoKZqIMKxPLtv5PKLym9vXc0oeWOGO74UXx5kwD0TtB6dD1nGAuvvin01BbrwQ5f+f7KjqLzu
	7UY8FHC1o+U49CZZEru6LPgB0EetcRzRJeZUgBWcR/eqWHNzzt/pTCiaKhyQzjKYPg8kldbGCBH
	xHjT+bFbZ1CBJOF0QwtYv5AxoYo5ySU5SmCiChC2Oj1xCgKMWftmyFflH/r/IpQ8/aa1dHtmtTd
	Q/T/nWhLRcL/EBbWwW3mLEvxLvffSN5uW6pMzEqUrGq6I+eoOrCQk=
X-Google-Smtp-Source: AGHT+IGiIb9ii7ebbHld1WjZPoc676UwrBtAENP5eu74kP0jFRqrVFrl6jLzBTD6h0o2zW69ICI+/A==
X-Received: by 2002:a17:903:2b0b:b0:297:dabf:9900 with SMTP id d9443c01a7336-2a2f1f72b44mr64415225ad.0.1766229268418;
        Sat, 20 Dec 2025 03:14:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:525f:ba4f:fd0b:71f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82858sm47280545ad.29.2025.12.20.03.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:14:27 -0800 (PST)
Date: Sat, 20 Dec 2025 20:14:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Message-ID: <qn4kjdsbi4h4sw64epms3sne2xua4ucpx5p6wkwbuxt4ihhwfx@db6fy33jmwqt>
References: <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
 <tencent_D7ED79431EC0D75957539121B7CC7897EB06@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D7ED79431EC0D75957539121B7CC7897EB06@qq.com>


Fixed Subject line.


On (25/11/24 10:15), Yuwen Chen wrote:
> Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
> 
> On Fri, 21 Nov 2025 18:12:29 +0900, Sergey Senozhatsky wrote:
> > I had a version of the patch that had different main loop. It would
> > always first complete finished requests.  I think this one will give
> > accurate ->inflight number.
> 
> Using the following patch, the final measured result is 32. Using 32
> here might be a relatively reasonable value.
> 
>  /* XXX: should be a per-device sysfs attr */
> -#define ZRAM_WB_REQ_CNT 32
> +#define ZRAM_WB_REQ_CNT 64

Sorry, do you suggest to change default value to 64 or are you
happy with 32?
