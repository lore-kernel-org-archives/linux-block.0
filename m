Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F171E497;
	Sat,  4 May 2024 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714864218; cv=none; b=kaFnXpFH6/EQUdffKKCavpQvHyBIUfWZ0u1Wy5y0hy/nlPWN1liUkdMv2FqaPZQRz8JEmCf3bVmNAKc8BFonaNGpoSiRXMYPYKjQrITO+2m1xmuXyWxbIcR+mfRrqO2ygFVbcONzpSsfE+sKVRLERxq59avYOUu5HXqX2B7mZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714864218; c=relaxed/simple;
	bh=FW6qoHbDHK21pEFQTCdCfOoptYJ3bNepxrOzoRzW6Mc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KmWq/E3X66rtUofLihF92QC+LUZxgMLMJS6NluSf+UNDFlwmt1aT1Mtyxf2uoW2XaEBqe63c6LK4UEy2LBDyl97Bxrn0oOw/DU6aE1DxE2V3J00lA9IC1+eeQa9SjcQlKzV/Yo0umFy4u4HnS4MCiMUNiKADf+C22mMq1PQhV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cL68Y2fO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cL68Y2fO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF829C072AA;
	Sat,  4 May 2024 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714864217;
	bh=FW6qoHbDHK21pEFQTCdCfOoptYJ3bNepxrOzoRzW6Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cL68Y2fO9JhsUEO7D7shlWzLxPAMDqhELYNeQWDMw2quJz1ADARZOuMJQU8RTRhJN
	 APHGm25HCCPF9pqXA6rCffBxy5MnZzupzSunL7LONu06Ns4L1VHm2Vcwg1h8S6cnpk
	 2R7n77vlxal9uoveCagkdkEf9tlk93HQVgqGG9YQ=
Date: Sat, 4 May 2024 16:10:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: kernel test robot <lkp@intel.com>, Minchan Kim <minchan@kernel.org>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, Linux Memory
 Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-Id: <20240504161004.f5a0aab5e5aa1033d4696c20@linux-foundation.org>
In-Reply-To: <20240504071416.GH14947@google.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
	<202405041440.UTBQZAaf-lkp@intel.com>
	<20240504071416.GH14947@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 May 2024 16:14:16 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (24/05/04 14:54), kernel test robot wrote:
> >          |                            ~~~~~~~~~~~~~~~~~~~~~~
> > >> drivers/block/zram/zcomp.c:214:2: error: call to '__compiletime_assert_285' declared with 'error' attribute: BUILD_BUG_ON failed: ARRAY_SIZE(backends) <= 1
> >      214 |         BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
> >          |         ^
> 
> So this is what that BUILD_BUG_ON() is supposed to catch. You don't
> have any backends selected in your .config:
> 
> # CONFIG_ZRAM_BACKEND_LZO is not set
> # CONFIG_ZRAM_BACKEND_LZ4 is not set
> # CONFIG_ZRAM_BACKEND_LZ4HC is not set
> # CONFIG_ZRAM_BACKEND_ZSTD is not set
> # CONFIG_ZRAM_BACKEND_DEFLATE is not set
> CONFIG_ZRAM_DEF_COMP="unset-value"
> 
> Which is invalid configuration because it means that zram has no
> compression enabled.

We don't want s390 defconfig to be doing this!

I guess just pick one if none were selected.
