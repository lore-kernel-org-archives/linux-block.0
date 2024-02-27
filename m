Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3813EFE9
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047005; cv=none; b=KzeairVr8oL4CpEx3JqZE4iULpimUiPeCVmNYGm/v5sEJaSXnadPGYZDq/7EuE+411vBgf39wHEyKfQSfICFWoBw0UbbOQQbS5C/Fz0MF+adBl7X7h0zpHdIZJ7jQ4EEpdpnX91qQTdc7e/35udKqt9/AtnFyGoGV3AYmvjXplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047005; c=relaxed/simple;
	bh=1TjOgn7EZpOUEEsdqxGzzOJEHrIXNZsYpIJc8flVC+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPKUKc+uTBZfRfDd4yRH50KeM+2ZZdnfRGFbQwBzh6qVwic1hmtrXH5yfh748p3rIxXnKh+fwQiDo5l1XA6+XteWZssKD6iXUZUJ0wIdMkOxtJoVT1rKHW6o1nwlT8G/jTXUjwtdnfEJ97x9NtnM+BdJEfvTBEYuPTWYt0D1PlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42e8a130ebcso11567251cf.1
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 07:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047002; x=1709651802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkw57nIPcfh6PkDenfS4Isf5pAlTCASFCEKqDWK0EfE=;
        b=Wtq2i8odja7icLC6wxyjciOg9/IaAp6iITq2IMDtvrrFnD5Mh0SdZUW7UlGzrZgIH0
         vkt2xVbRtmdygoxKMwIwLzEP7obxvAikIvZzq34Bb1fgJjxFZxwE7ddfYoo8/8Ir2vdC
         IS3qAbTi3ojH8ImO6ha0VZSoRy76m5SjWj333Kqjm1cwED48XZIU83cHuTHs6VwVDtcP
         1Ba+8PAFFVNPZpIz7WOETWwbRYtywu4b+Nj/c516gjKAPkPok0w0k76lXLRp41yAUv0n
         3V6l1M/zFQMMhTLB4d6ha9KSPXwLoA6EtflgKp39YXqkC4jPTEGaahBtBlE680OWwpot
         pxHg==
X-Forwarded-Encrypted: i=1; AJvYcCU6OSSDXYxyL9WateSYfvFNx6xsywH4c1T3JUeuqcF/PHJSWr1tykytGSoDbdU7CepDWPkJfNJxsdklyNrXMjppZUOrHBtdZheJaIg=
X-Gm-Message-State: AOJu0YyH1Xn5cgSSFaTLiwJhJ9qOYb9CV/lwaeiOtljtrCvFQEwFGFws
	9hsYLrsYFJZPOhOVUXKWFVNjHkHL15DJmB8VUAPh/h5NJ5WQBZ4UEqbGmC6YOQ==
X-Google-Smtp-Source: AGHT+IF3OX3RYDmLw5Xwj18/cLQPLdUQKcDoUQ0MjVBxCwuhrwbbGKCfPKDKriEFGlBfhfC7wVJNEA==
X-Received: by 2002:a05:622a:293:b0:42e:8114:9469 with SMTP id z19-20020a05622a029300b0042e81149469mr9852481qtw.10.1709047002287;
        Tue, 27 Feb 2024 07:16:42 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id y19-20020ac87c93000000b0042e79e54811sm3071786qtv.64.2024.02.27.07.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:16:41 -0800 (PST)
Date: Tue, 27 Feb 2024 10:16:39 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: atomic queue limit updates for stackable devices
Message-ID: <Zd38193LQCpF3-D0@redhat.com>
References: <20240223161247.3998821-1-hch@lst.de>
 <ZdjXsm9jwQlKpM87@redhat.com>
 <ZdjYJrKCLBF8Gw8D@redhat.com>
 <20240227151016.GC14335@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227151016.GC14335@lst.de>

On Tue, Feb 27 2024 at 10:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Feb 23, 2024 at 12:38:46PM -0500, Mike Snitzer wrote:
> > Also, you can use the lvm2 source code's testsuite to get really solid
> > DM test coverge (particularly for changes in this patchset which is
> > dealing with setting limits at device creation).
> 
> And that one runs fine, although even with Jens' tree as a baseline
> it hangs in the md code when dm tries to stop it.  Trying mainline
> now..

That's the mainline issue a bunch of MD (and dm-raid) oriented
engineers are working hard to fix, they've been discussing on
linux-raid (with many iterations of proposed patches).

It regressed due to 6.8 MD changes (maybe earlier).

Mike
