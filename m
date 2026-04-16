Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48B303A0A
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776323285; cv=none; b=FwScIEX/bVbmTLNmA9tvi4kTMjv8qh66USw0BkNW6F9rLqJ+9CcfiONh23zZVlEHuFXGAboGWuUXtvsgndJVEnjTo3X+5UFC0UmSVJczyYig8Oy9l7EcqDhyVxi8D7Nkhq3ebpLZrj8FOIoCEadGa4PGheBO3tvJexnvI08FwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776323285; c=relaxed/simple;
	bh=bAphQT/frAJ66aJxvN3V0iUcLODceJw3lz9oXrdkZII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbxb24KnCzlR6sT8hjM+1jM5Wa6VVrOi38KKCmV5a3E2gcJ97FCw/G5gYo70MlNE7SIIjhSc12BxVuHxZPWica1ZFIz6Kbde3BYiAj3+S2lqKPFF02VyXuvhdnNoPWP1aiejChJGvqEmTypm2y3wfGrf9ZCtkZEk/r3kjru0llQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TGpBn7oy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TGpBn7oy"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f41fce3e6so2044124b3a.1
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776323283; x=1776928083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAphQT/frAJ66aJxvN3V0iUcLODceJw3lz9oXrdkZII=;
        b=TGpBn7oyHQGQ64Nfut6ZT0dnKSsOMifJZ9fKZw64h4FnvH9c4l1dwkx3Jjg/fj5A8o
         /jXate/99pA248GKYA57HeHMVmE8udOQaaxxmSEVuXKTubA0hBfu44lorfVWzwBvd6OB
         whMi78L2adqHZT+ku40D8+4QAhBMtIdkCw2NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323283; x=1776928083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAphQT/frAJ66aJxvN3V0iUcLODceJw3lz9oXrdkZII=;
        b=IZLq/kIrIdxQxm0II+2+9juzTNbddYrwKnuRRQ1OA2Q8MD6flOwkE4VOkpemPjbf9P
         t5IRL12oafOxUZwVqEO6rv1d+m2pcGaBxIuV3gySA3W/8KWnPFxKHlyXHHFmub7QfLsF
         BnN0stGgtnz6LRl0ImtZVBuuO8zHFCvhSMNUv9zSABmgkSvYSnN3hO8CWVXZuBTAsGRh
         1LI+QKHHs/f2ypuWPIOwkbJJecGiu5Hx6to5hlBGRU1BCJjjjdo9XfNodATAO2ZiN6mc
         92JdwvTe52xcI5PTBnzxQI+Yet2Uh7+Wn2pH4bSVeAO78vkAJRK7CXDsZu4+buwnOrmf
         3QGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9P4dJDNGP6TdFN32RghgdsN9CU/KDNvjw1KeoCAUWRM9urn6EZg7Ynor0d68exDDTC6cqM3f1OdQgGPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wnzVkhs+IfZ9i3gr1zNRIhBBSwJIaYb509UmZmx8vFTCe9Aa
	I7abYNFotBfvacdZ3ROj+MDW0SNlJU+SkKT3gZ6fUKMbMjj/Gs7hM7oaG1o2gVVO9A==
X-Gm-Gg: AeBDiesPWknKOzl+p9+8FwF3CiQpym5IMAuVNyAiM42noZ1CfZ+TFDyvq++JmVUvI49
	fQAcqvoF8MiuFWo7HK0UHvG67DG+QN6mTIjPoHMoB2RhMqS7/y0dBx9X81ULnI0AvOxx1dlpkUp
	JZvu/KtVKaC+gmsV4rkMf5M2bVZ/CtZ3Q/fGSdfBH6pxkDJdA1npxRMevYvKH96y4S19ikNqU2Q
	LxxbpPAZ27kKiy7V8T1J6D0MzwwwwoMXqPAbleRBkALGw5pRbuBJUklTAYpbkjbSP6V5r02r+Ie
	v0Luoy24JLERh4ArDgJ0KF+4nGprB05mLO6lL2bGXPV23a7exA+59TmBT4VbPb5AKvqu72GhsQE
	eknETjP4wXWRyFyNGRvXthRFL5mLNTt+yq5ZE9ot8uuguDbFKg/RdtmXjY4cPiXYxIrSPJQ72H/
	rWkVLCg5HNud03SpQewTUWBNGCMaeVQ6pe57b53bzA9Wz8rvUuNcAPDE4Gx0oyumb0Y/5G+47FU
	w==
X-Received: by 2002:a05:6a00:ac03:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-82f0c2f7acdmr26693843b3a.35.1776323283603;
        Thu, 16 Apr 2026 00:08:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:63b6:f9e5:485d:ef04])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6702f8e9sm4102080b3a.5.2026.04.16.00.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:08:03 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:07:59 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: senozhatsky@chromium.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH] zram: add accounting for incompressible pages
Message-ID: <aeCKbSou1_JZw9UK@google.com>
References: <20260415104356.82248-1-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415104356.82248-1-qiwu.chen@transsion.com>

On (26/04/15 18:43), qiwu.chen wrote:
> 1. Rename write_incompressible_page to write_huge_page since huge page
> could be recompressed with secondary algorithms.

Please no. "huge_page" is the most confusing term that zram uses.

> 2. Similar to huge page, add incompressible_pages accounting for current
> incompressible pages, and incompressible_pages_since accounting for
> incompressible pages since zram set up. The accounting value can be showed
> by mm_stat.

What for?
