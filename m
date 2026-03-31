Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA993C2773
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942655; cv=none; b=MoNWC1/bDjqMcJUlVoeGpiaZH4Ia4DODUNoQiam9QV4e9yioHzxPp/1arXyOhuDlSL86faHvu3kYOeeOdnernQkISzr6LJWMmFxgMBT1SOtWBz/mdfwlMoFuQeHhvSeoYOWTUWTfXYgDvt22vk4EkLnaY+IwDrcQk/OduxNYvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942655; c=relaxed/simple;
	bh=UbgMLASRwQbZyZit2H0gM9HVYkdmwAaM5UIoBpqJsoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCPPKOBCO0UIL8hCJbNdnHIq6h1r7iUeDnOf2GUs8Qr3NGvxis+BMNHhZ33cRY3kFh+3B/kdsqyE2WAm22/mCVJzXbcM7HjR03g9BerccB6Pv+4pTUenwS8CfgMxeYBE9XN4Wd9Z25LVtJPeyTZWTsNCvs7EUc0A/f13blcD2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f0B761vB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f0B761vB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b24fede2acso13455255ad.3
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774942653; x=1775547453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zB4K43acGXLF9/IX+A7nsvuZUclZzkurqbD17TuUhE=;
        b=f0B761vBopPQqdsXuprJwXezBdIbs1Rog89kv/ZkpkgiG6WvdxUauN24v2wI9ptDsl
         TxuiOVaipYeg/z6jTxKbbShoMKJd5xbfG7Ek4EMp6s8sjKqdfX5eKHu5AiGI03w9xfh+
         SjvP+C0Y88PbL6PKGkQuGZ+humwu4D3VEaVBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942653; x=1775547453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zB4K43acGXLF9/IX+A7nsvuZUclZzkurqbD17TuUhE=;
        b=cJ6GKyet4xS8hD1yAkM/p0uyQUgSijvofs0BH7BZvamPt5A4nr04N2vqkEscu7+YIY
         GXKyEh4HG0KJWKNJSsUG4z/2lYWrjKhSfh4v0gYmDqukkoNnZ6tAp3UgGIj16BvRhxKw
         jH5lMIGcFJM2u8c7+K9EYoP577V/Nj55nqZ80PqkArqMWiEeBhbi9hg/j6fLLbWp0LvE
         Cv3AxXOlq4CRVEVbadcRCAEMfKTPRZpxxgg+VvAKi/I4HMdcE0wP+5d1JvR/W7h8wXof
         uxVPP65nPOxjVQ3irCDkZmlcZICEaXT/myYUKfxWDHQ3ZotJBXkMIzw7mJv8tybL3ARL
         gJVw==
X-Forwarded-Encrypted: i=1; AJvYcCVUjMdGTCYxL/69ZhmWhpdh4pr94Fyt9XMAK1WTei6b7NslXYIXm69Vlz91uDQk7/R6LQBm+pysX1LrGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAByQWe6p+PMwtTyreWJhKuufUd7T7YSXx+c545EBrjVv1DUev
	poMo5gEdCOjhOx9Y8Chh2KM4eQpljXyuBLzusP/CVQ1fqi2g0uGVK0iGpo+3Jf0G1w==
X-Gm-Gg: ATEYQzyqSK6zbpi8DlekxQxAHhamRJAp/+kB1iCnKw938mpPVHLSMK5Vlb5YoaNFB7P
	e77zzcIB7IjDgszu/bWv4yp16LmQpOQcmJQx3fw8hhub99xV6Tl4b7u4C3Um49nLvnPy/rak017
	4Rqsswsza1Zls6mHjDSZ3aJbfoNBjNSfTy2KY7CbxdVmqIPPHYuHssI17Ajfmmf60yFec8e73WV
	xM5RvBoLenf8F+gPrg29HkpumE8Rt8jhJQBNzx6Z3/2TNfP70MTxCk3yUe6pLFZwodDV7KDNktI
	/I0EL/jZH1nXHEN+ZfX2PKYJ6WDYZmAvPaHwYYwIgUBZJtvdduD30ZXctWXg9RHwBTQTMRC5DFw
	8/f1y5lBkod5VMX7YGvsZj96K3DXoLpjGPtbo439zSneUJBpWWZI//s6Wzr+zyskvJMs1cCgSrY
	TG9gmk9TfxEa5Ie/+pXd0OWmhSBSzZG8sDJfk02ZdA8xgO0N5wocW0pyUgH7RkzRM=
X-Received: by 2002:a17:902:db0f:b0:2b2:50bd:83ac with SMTP id d9443c01a7336-2b250bd85b6mr76653425ad.40.1774942653595;
        Tue, 31 Mar 2026 00:37:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242690e60sm102404315ad.37.2026.03.31.00.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:37:33 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:37:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zram: do not forget to endio for partial discard requests
Message-ID: <act5XhgtqrtN1zdY@google.com>
References: <20260331071537.706139-1-senozhatsky@chromium.org>
 <a6b566e8-5808-4244-bcda-5612760bde3b@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b566e8-5808-4244-bcda-5612760bde3b@suse.com>

On (26/03/31 18:02), Qu Wenruo wrote:
[..]
> Which is 3 times slower than regular block devices.
> 
> And after that short fsstress run:
> 
>  NAME       ALGORITHM DISKSIZE   DATA COMPR TOTAL STREAMS MOUNTPOINT
>  /dev/zram0 zstd            1G 271.2M   10M 20.4M
> 
> I guess this time the overhead is just in the compression so that's
> something expected?

Yes, pretty sure that is compression overhead, zstd is not the fastest
algorithm.  If you need something just for testing then lzo or lz4
should be a better choice.
