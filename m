Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACA79C8
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324453; cv=none; b=GU91WsaWwJWdpFBBXvbX0STasE1Hd7+jQsWyabpCQ3j5Ick40zpCYL6NDdWit/CRFvEegpQbKsnHi1ZTsczOkPmfupfjz5xdYi/trqV4cRVDNrvW/W6T/S9e8QD8ze7INJRe46YYsOHJKymrT9a51V8zdH2wle1Q9XwEWyEanKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324453; c=relaxed/simple;
	bh=Uw2R24Py98brGt7b/weB6cxxd4FY06m8YxBoSEGLooU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm7cE6pDWTJctu+V1urMWQT4ZtGz4PQHRHv2Mzcy5xS/U2elzgkptVf9e+ZYEXECmD0K34DDZT/o0uPZo5/3PFyuD+7tKuYh30Uy9Plu+9YTL62H3HIgT+Gaj1AoDUyxaLzgWw8NnW8G04L8CQ0jgsnrZj6cyBJjqslXr+F6rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f02c96c52so980485a.1
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 20:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713324451; x=1713929251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtdjqEfW/2woy7OCdpCAz+N9Ae1HYHEY3m85tFluymc=;
        b=X2R6KcmfPR6Xyb19VH71DJlU/qmocszHjX4xG6A6Vou9sWiwmRu6XJJ1pZawNw+Pj9
         PPv3KSVQ3Cpg2aSHBBY/hRF+1Mz8cu4hrvN8fWWVGI76n99OjY+orPobatG9jVWpeiIl
         09+D9dtI8P2A2HC+otzpPTnRxyz5FmO23f0b8kpKl9MGmq+op2Iy5uZhZUFRb6WMZRZu
         aYdUxUZPzm9bPte4i+io/YPL9LHkOdDPyHzRRyZi2WYy2P/b9E4U96ffh2mZaueFuNUm
         GVIlbarOhb3LHStCgptYccodlr/ak/J6pfOnEjtFtWqtxy9PyabJYnOaS6FfEcz1/SaF
         qLQA==
X-Forwarded-Encrypted: i=1; AJvYcCU2lJw26kF/BgePwg90Rv7gBG3K9RlAdDVqKhVSO8FVPy6gd6G+0AgTfsgn3Xmwek3YWChbzdcgq81PdXTH87C1w4hOxxweS4be/d8=
X-Gm-Message-State: AOJu0YyH2eBzDs0NbLFX2XHSzeU0mcz2OKIAyjicLcmW8f0Uv2pkYJNY
	D65CK94etSDIbB2Y5yyN1CrvS4gq6E7xQsskQHapA5/HS8i2kGj6Yhy+c7FC8HHWaNT++FJbIt8
	=
X-Google-Smtp-Source: AGHT+IFhhJCgtb+aKD5SydFS1pgunohDDskmrkf47yrZS5w+D0UxN/7lafCWrHzapkwk+JUyh4goAg==
X-Received: by 2002:a05:620a:1094:b0:78d:5d99:953c with SMTP id g20-20020a05620a109400b0078d5d99953cmr14893635qkk.28.1713324451268;
        Tue, 16 Apr 2024 20:27:31 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a240e00b0078ec3f23519sm7644803qkn.8.2024.04.16.20.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 20:27:30 -0700 (PDT)
Date: Tue, 16 Apr 2024 23:27:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: brauner@kernel.org, czhong@redhat.com, dm-devel@lists.linux.dev,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] dm: restore synchronous close of device mapper block
 device
Message-ID: <Zh9BoXRYu_ZWrOsg@redhat.com>
References: <20240416005633.877153-1-ming.lei@redhat.com>
 <20240416152842.13933-1-snitzer@kernel.org>
 <Zh8mx4yIGyv2InCq@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh8mx4yIGyv2InCq@fedora>

On Wed, Apr 17, 2024 at 09:32:55AM +0800, Ming Lei wrote:
> On Tue, Apr 16, 2024 at 11:28:42AM -0400, Mike Snitzer wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > 'dmsetup remove' and 'dmsetup remove_all' require synchronous bdev
> > release. Otherwise dm_lock_for_deletion() may return -EBUSY if the open
> > count is > 0, because the open count is dropped in dm_blk_close()
> > which occurs after fput() completes.
> > 
> > So if dm_blk_close() is delayed because of asynchronous fput(), this
> > device mapper device is skipped during remove, which is a regression.
> > 
> > Fix the issue by using __fput_sync().
> > 
> > Also: DM device removal has long supported being made asynchronous by
> > setting the DMF_DEFERRED_REMOVE flag on the DM device. So leverage
> > using async fput() in close_table_device() if DMF_DEFERRED_REMOVE flag
> > is set.
> 
> IMO, this way isn't necessary, because the patch is one bug fix, and we are
> supposed to recover into exact previous behavior before commit a28d893eb327
> ("md: port block device access to file") for minimizing regression risk.
> 
> But the extra change seems work.

I normally would agree but I see no real reason to avoid leveraging
async fput() for the async DM device removal use-case ;)

Mike
