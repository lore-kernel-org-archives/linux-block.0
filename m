Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96637DEAF
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772601308; cv=none; b=MtlTXlZ+6bmXQkLSg5lUYmx6O+w9VsoMv+FFUSij7ZVsFMc/iL0OakLdSxtxRa5tdULEMAWlsS3hEYTM8ZI/Z6bSf91/xH8QB8XJf9FC73TAc9jWr7m89Im9luCDUhaLy4cuxjlbmP121EKhu8Cv+q+EMyvORw+ickRCPWgJpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772601308; c=relaxed/simple;
	bh=+HK1VcL4ACd098XuVXpDjTaXJba7czI9J0aOsg7Y3Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t8EDumAcfKk2MABmYmvdC3b/RomyVcu2nC+0sQOn6xcTFyt8TJwzar/ExRg69qsqzZmxwsaaKppMF2NjXMn3s7HGDUv57az4louWEf7YyDH+DvgmN2GJ6ruCum2z8/BDWcrGuYKgFtjSiM/800yp9CARix9U0a6mK/tp7KlYLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JYQyR7GA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYQyR7GA"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso3576326b3a.1
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 21:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772601307; x=1773206107; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KaxuFPOuVbrS//18Q3BNFuHwa485ma3N7D6ogKqzaE=;
        b=JYQyR7GAwpqFqT8ilCuK0jLmIOetYZtbVurT6TB2aNX6s8juVhFSu6obRLdQChD3x9
         M5ZozI+pJJPF2Rf+kqvOzgMMIRcQnaFbTyvGVHPLUXX6R9KJwxJ1ozJAwyrbtWFVzeRP
         OtGbP3eOMQ6Q19dHnn0YLNx83MEpvSQjEBNHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772601307; x=1773206107;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KaxuFPOuVbrS//18Q3BNFuHwa485ma3N7D6ogKqzaE=;
        b=BgQsdjd337gXWR1n6Cg4BPcqtsZbSzsgjmYbKCst79k+D3fLA6mqqdlfDn0sycxsgj
         x4PLda1gNHOjaqEFEcnax6INIlKuXZoGDyhGkSx4X64lgL/nMKRvI1Msxj7uRS1rOhI/
         IxUWxUniJDc6GE3DF9fPZT4zoZi45kWXjzc6em8yDIFMyJp6xETOVF58jsPgsor7RxsY
         33VDVhFTMzlloNjkl8xtTKzI4n3aUOAwAIacnSVuo8H5A30G8v0BEU9FEd3iaGezCT2s
         O+3jUs5J9E5WlGS5l1u6SCRxj2kBInGzOfuJUlL60JVahq35dAcMRAYwI3J0Nd1bjiYl
         fb4A==
X-Gm-Message-State: AOJu0YwmTjAA7APRbF6RuxzwEpKHWmcas5nWOsQ1y8NN/gDKbcNDAskf
	XuvlHX2C5jOU1QEezuP6L05ujdkgTDQo/IfYE9J/APLyyQvdk/IGvjDGB/0oAzHQKw==
X-Gm-Gg: ATEYQzyvgjLrna8QjcRB5Awf6YAfP31Eqf9wXTDiSD5T/+AjIps2b10FC8sztkBq0Dd
	24Xb/uxfgoHmOOwefXlB8HUfcB71aLncRaMMhgVRqOBmZ4QiCYd4lAheg3IjgTDMWU7XjbULSK/
	KLJcvflYSThEIKLElj4m4yNjuy6nx1CQLXDMM6AsXZegS0N8BugrekE8pUr6B2fuER/W8UAxrQK
	28IQ9ZNcVylzDdEboYJrwbvz0o0tda4jhT4AhoKpkE4JlAwe2dNSLydGpg7qtWpjf78RujKDi67
	jrvVRVWw+hRfqmAdS9FNZcxVx0URvyApLH+Ieq0ePXQ+G2MROWsErfWj+kt4z0XOEx71Pk8uHMo
	98ZKno2Ap+diN5cy/bXAqr+AWK7goWPPSjZ+LLU+fFd8GdAC8v7FmS9isYKcGvwE8bjBKs+6Ix6
	gwkiT9UR0YUWEcesfthWBviGWMCTYM1noH+gKWNh98cLVedJQbvI7xaZ3A8D+aK+o=
X-Received: by 2002:a05:6a00:460a:b0:81f:5acb:55e5 with SMTP id d2e1a72fcca58-8297292ea6emr744575b3a.2.1772601306775;
        Tue, 03 Mar 2026 21:15:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:7218:9151:d36e:8e85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a05e831sm17697953b3a.58.2026.03.03.21.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:15:06 -0800 (PST)
Date: Wed, 4 Mar 2026 14:15:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC] zram: sleepable async read bio completion
Message-ID: <brqb2utojkegjv3vz542y6fz5pnkxngknaofz6ll4tviy5ljpx@fjvdjtr3tzfv>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jens, Christoph,

zram supports writeback, when "idle" pages are written back to the
actual physical device, so that they can be free from the zsmalloc
pool.  Previously, zram would write back such pages un-compressed
(raw), which made async read back rather trivial: just sibmit bio
and return.  However, decompression of every writtenback page is
expensive (battery wise), not every written back page is read back.
Therefore zram now also supports compressed writeback, which means
that async read back is not trivial anymore - zram needs to decompress
the page upon bio completion.  The problem is that bio completion is
called from atomic context, while zram decompression is sleepable.
So at this point we have to deffer the decompression to a workqueue,
which adds (painful) latency to the read path.  We clearly would like
to avoid that workquque offloading.  What can we do about it?

A wild idea, (I know it's not perfect), it would be nice if we could
decompress in the same context/task that submitted bio in the first
place.  Perhaps via addition callback:

->submit_bio()
  reads data async
->post_submit_bio()      // random name
  decompresses bio page

Is that too ugly to live?  Is there a better way to do it?
