Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2A3B2FCC
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574509; cv=none; b=Kw6+FiERiICf8S0nswOqxby902gPF6ljgHl98lbP+3frWXuoudMKYcYIdvhcsqH3MO4W1J5bINQta3nf9ZttorI1llYEMkPIteC2sQvvZyxvInpOLHQ5F/sIgJlh+72EV2Jq+RntNjk+pRBPeYGpBHdjnJcnBpJVES3cLWx/vuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574509; c=relaxed/simple;
	bh=iMYszCd2Q2GkfRGunaTTlbLJABOPePOXot6uhYku9yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csnJy/A8hWD/TDYE2szwSzcVmCK14oSDjqwtbAyy+ONhVd7uvl+PzYWsYoljt0nt+M04/LcOGUH6dzHFnaUGXAumtQyYL72Hg8YMvUD2ciqjUS6objZoApJ15CRDaBlbMMpHNXTaxkfTQcg6QdI/bZKR+6UGWy5PsgJ7kjjpLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxSu473o; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxSu473o"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so1309320a91.2
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790574505; x=1791179305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kWV/wHWLQfhp6L6mSocYwp2pbMQ9zmUarPxSrrFDYg8=;
        b=bxSu473ocLXfE6sENO6UDQCfPbZYu9DTkKv7SzG0U2ent1wE55DvXVZrKbPwgxoTSi
         HFx73BSqIiVKSUS7gxUnPTz/Kkc68NvdKaga6clGtTJ/PFcrNDAoFOz9HrToRPEuY7JB
         w5SzVZBiHKy3ICHS569p+1/EZqyvkGv23nnzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790574505; x=1791179305;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWV/wHWLQfhp6L6mSocYwp2pbMQ9zmUarPxSrrFDYg8=;
        b=milj9igla7GYKD3H4utPb7jONkxEHiQYKHkRfuOSjlSJd0zjOG5HRNaxGbCVT8mqQ7
         5c3sCz+gy3shjHkHDwnGFUgf6LxDlRInfIZcGaPsDjpoVgndBlWJyKScrnxwx0hw8syO
         Dh1xQmHTwk82+j8emgDIk4Su0srrVnzmL4zrXvYbD/s6+sAW8+0FY+bJ0a909qK56mTH
         vmKejFQzdGWRSaFUyaEQYoE/8ysa0LX4gVuhph7kevBZwQPNvroLkUHwWLPoAtSRlcHp
         /lTzH+/MFGPHfmvbhRSs2P89aXfUCW6eI5cjpJvFsBrfc8EYwK72eKDVoysjt7rYx28k
         h+hg==
X-Forwarded-Encrypted: i=1; AKwUvBzIxAWq0rfvMr/vSEgY4tMBR80cVX2KnFfXaQ1sOxVwM10mWEoNY/jFJHJbeI5Sw+RcqfkF86OvpKEPcw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJqsqyRK3uLeT3HXSmIcvy8BtUAt0Ifuya186RQzv/VbShJRV23
	yWA/6wd9fIfJnI6f3ovzrpgKwcUmOYfrAFr9UAuabDCCCee610Dek7UtbczwB0PAUQ==
X-Gm-Gg: AYBFou2+pkngSeST9kbn488VeVMBKZYU/4CAs67kmvEkgGJ6c0S12u7hOQ8cX2WZ9M2
	IGuFLNYu+HbYOkG8msGruNGIkOKPjrAN8GlEdee9pcD9+GrD1m3Fa8Sl5yTrybJUVEvM0ohViSN
	+cEjqZvanBpGl8oqHEAs54XSCi5K4PiAwdiDSOhcPnG6zJSKj4jNc6/SIZOs0UocK9xpcXEJtLV
	nqe7+D8lGZe4T3MvhJzVVjshA4iFeLbCyeEdbiIPpM+H2W6aYKgG1Ev3k/zvUngieoR4YVgz04b
	+vP1UkhWnApv9eeuDF6IIPw4EYitbpolN8cPlOxyBqPXMAXWSQoHXkoQ1pUKVDwApEBngdIXCSb
	FrHyd41VWQ2BuN8Urcds1Eh8nXAu4eXJEguLn5NmNfSjmamPjeFQ5RSNu3n5QDnjpd8QhwzbEvf
	V+pjPXM8qL88ruCnetbSzB4EKXpyDhKs2FkAVpvT8HNiuI44zHDkZHePxyJyyZUJl2t26wZltLh
	BlJ5QMZ99oMSw9iMOJboh8Tp05jVruBcoFeMHyX7Z2oTZcCag==
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id 98e67ed59e1d1-3a0cc3324ccmr6256726a91.6.1790574505299;
        Sun, 27 Sep 2026 22:48:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm17853889a91.15.2026.09.27.22.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:48:24 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:48:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Russell King <linux@armlinux.org.uk>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-block@vger.kernel.org, Yann Collet <yann.collet.73@gmail.com>, 
	Nick Terrell <terrelln@meta.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Sungguk <sungguk.na@samsung.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFC 3/9] lib/lz4: add the build environment for the
 vendored sources
Message-ID: <arn9tK5MxxxfH7OW@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>

On (26/09/25 13:27), Michal Wilczynski wrote:
[..]
> +
> +/* LZ4_decompress_fast() and LZ4_resetStream() are still kernel API. */
> +#define LZ4_DISABLE_DEPRECATE_WARNINGS 1

Is this upstream code?  As far as I understand it, LZ4_decompress_fast*()
deprecated upstream and are strongly discouraged.  Do we want to suppress
deprecation warnings?
