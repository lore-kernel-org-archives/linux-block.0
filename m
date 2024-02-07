Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2701CF8D
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280603; cv=none; b=Z7C+IGu/X9mIJGIwyzy7qVQTgNJ/nEzl0S5m1M5nTnvgSaKfKF40TjJ3gml/z3U55qNy2f0i5w4/4vKFUX1geXjInxvval+t1RMANU2qnXiiqWQzj0inNU8XMce4RW1Sedok0duHQlQGbr+Tz81QBFw9VcvnkRIf6Y4DYnq2VA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280603; c=relaxed/simple;
	bh=RtSqp1JYFTovf2zthsrQ+F52HyZRz9QN+jvAQn9sieM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXIQEJhT2YimumUrYFnkbbk3VSOjyQC7+MV2+WFr4a+dM3hIlFkvloBjbAPuqfUr3RsZiRvAGC/AV6ZdRcHnvjwosLBP3g4pgokSoi6obXQGaPzFeU6TCy13X21mcLPtVgKj79ueIKpbIMhwakyyHB6yKAOCeLjrNEcCmq9TvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=allp2fdJ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="allp2fdJ"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2193ccbb885so125944fac.2
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 20:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707280601; x=1707885401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXmL2187gHpmL0np47Ze2nLt0jvODGEfenOxk5qwPvE=;
        b=allp2fdJrCH1so/XYtPVyopJmQCgAhOWERuy44idtWPR+ZmynH64rCiT+YEaFsfUWr
         RukTGHIw468X0MM2rV+LzqQZX08LS8uk/mffxx07kGWQnUZYbtG5ogbqAMkyhZ8fqARN
         3KGbx3xkbN+URHua85nN/KVRCg363DLh500+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707280601; x=1707885401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXmL2187gHpmL0np47Ze2nLt0jvODGEfenOxk5qwPvE=;
        b=vsteozIuWQgeISg4OZs5uEZ4BGHIKKPGqb3aF5hV/6h0RUMJoYYc5Dg8IdgVs32c6R
         wQtFJiooE4ZK0GIDpGeXXN069WWI1Q3e511sc2JFflJ3LaaLN2Q3b0y5Z1c0LkHGJrhi
         QeM9POWMMCOOz5zTC62Bnc+k3gAFyBJZRzhnVxrPVHxPF2ppEXrAcT2ntmnIZMv2A2cx
         OTQMPnxyExsIu53DKRZXREuVS0t/J6Eyg9TCIyH+2O9kudDUq3VG0flU79BW6YG0IDoH
         FJokyXUju61POkLBfDbjF31sLcu/SX13Z3LmBHIAwoC+MYHneKDQjSc7PRANN2zllz4W
         kKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqQpTNMgVCnWOUYdyv6WZ/ZOTfqUkf6dVP07UCZYto75edKU2qTgue26W3iBK7hkqcGkuPryffEwX6CEZ4roxKfvSpcxRfqViKXEE=
X-Gm-Message-State: AOJu0YzzGZIPun4/yZVgoDdQjFhnWtttBty8HTRZBbf13Hay/GOoAnqB
	CNqqilE/AdMmRTaOZqAdl3T/cyYaaWtWom+Q5tQP4NhtF2Crb9R4xg1QYRDBNk/uLkfxIXK7OK4
	=
X-Google-Smtp-Source: AGHT+IFO44dKQJIbmf1HaMA+xo1RI3yTOS1ects1dva6gr08BhW/p1aXM5wyZ+X6kTGvy+2n7wGkoQ==
X-Received: by 2002:a05:6870:390e:b0:219:92e5:8b4 with SMTP id b14-20020a056870390e00b0021992e508b4mr5403115oap.5.1707280601380;
        Tue, 06 Feb 2024 20:36:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPDLtqg4P2TGcdbEEvcr7bpsaydM1bkhMm0f34M1al3KjlWR9Rv6wHLukrXyyJiiB5rsjok7PGeZOdUw54EV9O1QsM/Roo2Pw6pQRxSfColdcfKWorGDXJLP0VkbGPlPsOBIM/DdjvJ0i2kdch5s/XIv3/hiyVGpymPGih6CwH0WFboBO0mkOuo5kX5wtDt0mt0/KjQO7piZY7yfVcWOxsgMS16F5lyrwi713ajRc1Z6Upof8fTsOU3XsQJuvSq9TF2ROBGkO34MqLhIRVZoDrk9WzeneQ47f07w==
Received: from google.com ([2401:fa00:8f:203:679b:7168:b5c0:a415])
        by smtp.gmail.com with ESMTPSA id s133-20020a63778b000000b005d3bae243bbsm371606pgc.4.2024.02.06.20.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:36:40 -0800 (PST)
Date: Wed, 7 Feb 2024 13:36:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Barry Song <21cnbao@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
Message-ID: <20240207043636.GC489524@google.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
 <20240207014442.GI69174@google.com>
 <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>
 <20240207031447.GA489524@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207031447.GA489524@google.com>

On (24/02/07 12:14), Sergey Senozhatsky wrote:
> ---
> 
> zram: do not allocate physically contiguous strm buffers
> 
> Currently zram allocates 2 physically contigous pages per-CPU's
> compression stream (we may have up to 3 streams per-CPU). Since

Correction:
								^ up to 4

> those buffers are per-CPU we allocate them from CPU hotplug path,
> which may have higher risks of failed allocations on devices with
> fragmented memory.
> 
> Switch to virtually contiguos allocations - crypto comp does not
> seem impose requirements on compression working buffers to be
> physically contiguous.
