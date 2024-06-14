Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA813CA9A
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343076; cv=none; b=mDBE8qIz+4X/2mOjG79PiVTxbUWJtb9z+0AKy0kO8r2vthkJOoFF+9FNWRev5aCnKceuEjZmdP9NE+K19twt8Lu8MMwiA+AFMd+dl9Sv8sfoYHLakZxL2RgVpQ67Ky2t6ijC3VXadMyemHWXtqv8pVIg0txa2SnAEJiBn1/FSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343076; c=relaxed/simple;
	bh=1FAI2M+RDz3A9KGneIzMG3P4EX7MhLgB78nrMZI1BdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPE4LRAcsxYFecXmToERctmXY6af4eQD7egQqseBetubRbyoG9ukyP+ehfJMl1xxARta+3YDFVN35iw40UFHdtO8CXnDQ++HBCgYda/1x2k9CGI3Um5buMACTqimxgbNXEBKsYPpWINMwLv3YbY4AigrXnqE8A9zSetpGdl9gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hep1KusM; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hep1KusM"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25528eb4078so929270fac.0
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2024 22:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718343074; x=1718947874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAzRVuGiwiPjuyzyla5fhPiLV7P+Mj2MHeHS/YDHrio=;
        b=hep1KusMRCX0NeoP8UV5NsYGSeuqYXJ2QHTXlwcpMi/IFKmHTZ7jTCuD8InlE28VcV
         kvswWZyHi6ZOVEnsh0bL9ihacrIOFugKrD7+NDZJfvL8RT+jSRgHiRmyqJ3wFTp63TRQ
         Yn+/1X5BalFR1JU9KNWUbbesKkIaYGTdQHMzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718343074; x=1718947874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAzRVuGiwiPjuyzyla5fhPiLV7P+Mj2MHeHS/YDHrio=;
        b=rRfjuENLyVxQEv4SfXqEjEjlqzNUE17mvr5vXzMgCnAOG2CLUQ/4xxYHGmztmjhXF9
         Mwm5/PFNcN3xuosLNIpKtHPJ3FI0o886L1a5GBjjHhTwPknVDMbD479B6RaOE+TSBJHB
         n9FLd7DQQdbwPe0fcOUhUwIbfTnU5tYkJxo0UMmiwtH8hkc1DMX0/dYAda6pUrHnZxI6
         QwwCRTfemyMkr7wVosSqrXNF4ZllVcXrXgUaNkscrgpp7nMB6oC/c/z4wbKpcVlAigbf
         h1totDZhtHYepgEtU8mcuw5YNek4QxOJj/dUQuAxWR8JDEh9CdusAOfC5WzO+1uvzL1c
         jKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf8SGXEMQEvam9AG93SvyeBDWnd+TjcW6AU3jLih2y2m0oRAzzSYq5KgttGI+0kqf50GCJ1NlrrIXPUK/+Dr8Zy9X42gy43SHpPn4=
X-Gm-Message-State: AOJu0YyA+c1jG6GvLTqsJMHANJY8HsP1lESs/8xvw9TwFMaArKUWcFnk
	OALgfFT6vSC/4H9PfVm5nG7jlPoOKoCZwcRhZTX53oQnhYkviF8yD1Hb/SjOgQ==
X-Google-Smtp-Source: AGHT+IEPAopWXgVdFsrPU52iQbDb8e6jDzC7bOOXcHsj4ssPn3xyg7Zl+WfquFEcWNc07XkYD/ktmw==
X-Received: by 2002:a05:6870:2012:b0:250:7b2f:f273 with SMTP id 586e51a60fabf-25842c1376fmr1664164fac.53.1718343073742;
        Thu, 13 Jun 2024 22:31:13 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3d3b:dde3:8620:4416])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb414fesm2250205b3a.133.2024.06.13.22.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 22:31:13 -0700 (PDT)
Date: Fri, 14 Jun 2024 14:31:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <20240614053108.GC479513@google.com>
References: <20240613000422.1918-1-jszhang@kernel.org>
 <ZmvUMPc1eEOwUo7h@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmvUMPc1eEOwUo7h@infradead.org>

On (24/06/13 22:25), Christoph Hellwig wrote:
> On Thu, Jun 13, 2024 at 08:04:22AM +0800, Jisheng Zhang wrote:
> > commit 42e99bd975fd ("zram: optimize memory operations with
> > clear_page()/copy_page()") optimize page copy/clean operations, but
> > then commit d72e9a7a93e4 ("zram: do not use copy_page with non-page
> > aligned address") removes the optimization because there's memory
> > corruption at that time, the reason was well explained. But after
> > commit 1f7319c74275 ("zram: partial IO refactoring"), partial IO uses
> > alloc_page() instead of kmalloc to allocate a page, so we can bring
> > back the optimization.
> > 
> > commit 80ba4caf8ba9 ("zram: use copy_page for full page copy") brings
> > back partial optimization, missed one point in zram_write_page().
> > optimize the full page copying in zram_write_page() with copy_page()
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/block/zram/zram_drv.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 3acd7006ad2c..4b2b5098062f 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1478,11 +1478,13 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
> >  	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
> >  
> >  	src = zstrm->buffer;
> > -	if (comp_len == PAGE_SIZE)
> > +	if (comp_len == PAGE_SIZE) {
> >  		src = kmap_local_page(page);
> > -	memcpy(dst, src, comp_len);
> > -	if (comp_len == PAGE_SIZE)
> > +		copy_page(dst, src);
> >  		kunmap_local(src);
> > +	} else {
> > +		memcpy(dst, src, comp_len);
> > +	}
> 
> I know this is pre-existing code, but why do we need to kmap
> for comp_len == PAGE_SIZE and not for the other cases?  Something
> feels really obsfucated here.

It is tricky a little.

If we managed to compress page (size < zsmalloc uncompressible watermark)
then src is per-CPU buffer with compressed data.  Otherwise src is original
page (with uncompressed data).
