Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9AB674
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756618; cv=none; b=m7kJDbvbBn1305NN79Zq6CqBojDZgt9wow3I2BjVwK5QF+93G/WJ//7zRDMWx98DQxiFS1lqM9IMI9ROx+6flPyCrZZLdtbuGzKW6PpQjAWsrVThADPZpSsNtJ+e7eMFcX5AzCJsoVMS/uHBo46grp0m1ZMqs7HvZxOpvvu3L5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756618; c=relaxed/simple;
	bh=xvZII4caJcgeweZF6xeJaPYQ9qDMCjswfFfgR+4FA88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwUo4+YSNzeLhPxYWv6LBM7XznOFUKbya1ihNZElJlQrab2/R5WpfEjh6/di0+OBkOZwYyIvawQ/yub0/7FRIKljhat3YHr276sMT7ScLp8J4dE1CrjzRQuQOPUQulSv/jU2Y72nNf+WY1SIiOT0Krtar9WKgRmjvCQv7Ws/rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IgFW6yYU; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IgFW6yYU"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70942ebcc29so4913062a34.0
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724756616; x=1725361416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQEy8T+wkN9m4LdWnvomQCPHiK5omwEOBZ8H5VISVpg=;
        b=IgFW6yYU0rLSLhTJEYPvVYLGL+RDHctUtvoojqVr3vAZZ4f0+he45o/A3Dq5CaRUEM
         4upYWOse2jKVQtcrTlnhFRR5qjluZ4Hkh8bwB/eY6C5m2IZ4TMbNp6FZxKTbTHDEWqlq
         GRj40FTUhxlsEOK/WvrdXwjuv/ajBUnyFvaFzrnCPi5117nJozJdzN74VkZ0jm8YA19y
         pOAHS1IdiAXvuHGG5dWES4+M5P/sO7aaWLLhCub2KPWtnFd5+e4A6hhNk3EOyKN30IJH
         3NYylReh60wvPNLscGqLS25dFhENj/WpMcmmqA2IZzd/m+GuJfAZz8TYuqIw10w7InG6
         SU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756616; x=1725361416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQEy8T+wkN9m4LdWnvomQCPHiK5omwEOBZ8H5VISVpg=;
        b=LGt8uCsKIX5K0T+Eujj9/CHIeMBK82z/RxXSPfXohK/grQ46oCyCFKJXLdIji1Na/N
         2NCsNmazzZLZ+w64qMYqZ65uMvFmiz2AAUnbs6Yuks0HGdCI4gN0gSJtOBWmH5ZDJ3q/
         QAz2vv1jW6t1PQdMF50DdIe1cG57F6UqPjRYqr5OMygPiQgBQsbNo3e04Ktff3JKSrfi
         onwCScnRnpa9V0KXVoO3JPzuzjVm4DgrnwwIbM4GYQwtDgIQMqxRP3Uz6nIc9s2vxeJd
         AUg7ija/FbmKzBM1EeemGNOim3gjdKuX31aEMVeN4dLbugVIGjIm9d+HA2+Ok1YrybQJ
         Qb1g==
X-Forwarded-Encrypted: i=1; AJvYcCWp8U6qb1Fk21fc6n9+1zy9K3awAF+qwvgzVBxQUODiBGzbiXBsPW3wEszxFOMqeHsviy7z+zpDtZJARA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC09fWTvtN4wQ8TStI4WW7CRGRkYV0IoPueb+37XspofO7zgEx
	5fzhh4lWovU5s1aBeSo1SVhmqjk5Iy+2i2YgWRjtRmttRtRBfj+QcgXHaQ8CkHs=
X-Google-Smtp-Source: AGHT+IF4qNHXWkmCySjIoxZw6q+2LEaErol9CphZ5YD0qyPKn6n7vFU0PYNhP5cbC3GrrXP25hlwYw==
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id 46e09a7af769-70e0eb37e5bmr16117729a34.16.1724756615938;
        Tue, 27 Aug 2024 04:03:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d21710sm55059366d6.11.2024.08.27.04.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:03:35 -0700 (PDT)
Date: Tue, 27 Aug 2024 07:03:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-block@vger.kernel.org,
	dlemoal@kernel.org, djwong@kernel.org, brauner@kernel.org
Subject: Re: [PATCH][RFC] iomap: add a private argument for
 iomap_file_buffered_write
Message-ID: <20240827110334.GC2466167@perftesting>
References: <7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com>
 <Zs2wl4u72hxRq_VU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs2wl4u72hxRq_VU@infradead.org>

On Tue, Aug 27, 2024 at 03:55:19AM -0700, Christoph Hellwig wrote:
> On Tue, Aug 27, 2024 at 06:51:36AM -0400, Josef Bacik wrote:
> > In order to switch fuse over to using iomap for buffered writes we need
> > to be able to have the struct file for the original write, in case we
> > have to read in the page to make it uptodate.  Handle this by using the
> > existing private field in the iomap_iter, and add the argument to
> > iomap_file_buffered_write.  This will allow us to pass the file in
> > through the iomap buffered write path, and is flexible for any other
> > file systems needs.
> 
> No, we need my version of this :)
> 
> http://git.infradead.org/?p=users/hch/xfs.git;a=commitdiff;h=84e044c2d18b2ba8ca6b8001d7cec54d3c972e89
> 

Hooray I'm not an idiot!  Thanks,

Josef
