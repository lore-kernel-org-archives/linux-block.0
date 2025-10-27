Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB726F289
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585170; cv=none; b=Xe0KmtCBG0MoopuornYPo5JNDJbDzkQNSaG1oW/w35GeO/JHvGs6YzMKS47e++qUGvdKbYqZDN+Zt2mLoMMC83yDA41XnPy8q0JkThe9WbkIb6gzW3BOUos80MRcC1gakAEosoMY5sTm+yR0/9/h67gnDlkUyAsfFHT1KLAhArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585170; c=relaxed/simple;
	bh=eeCcaiB5m6mBMPE2QFVNav++Juuy6BY9qODhUaJkbbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcNrmQPfJhOv6HimMjiHHwq+1+Bn6HlDzQ8fd6DaG8UscO5ffixijOv2aaQe7Xm1D0hGsZDUhlK6uj5iUBYAjj2vT88VwJXL+GdTGqhOVuYC+ojgCR26WYK4zp/FITtAJgY/qrLfRrEraQ5bfeH3301VUJ/g/3eLpRQBX165BsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3txy0tOv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3txy0tOv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d67abd215so13685ad.0
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761585168; x=1762189968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPy+FHVUTDlqo9kS8K0pwEoZsjWCLKbllIO0a4/trd8=;
        b=3txy0tOvQB9Zzi2DRCgScrD2MNOnRQqPwvbiqFKqkxk9OeWypvULXELoePexHM4xCb
         KzGlJ0QmT2WpG6h1F3tNfpRcbawVVVAUBQIwR5jV8f8ChtCq9L0jtMQOJmOfrhCObz9I
         C/4bjn+Qx+qoo4dJtoQgWN6+/Umt2pJInfypP9QhlxM1X0dEzPrwSPrnQY/+qT24cuEq
         1XRqEbT7a7zFFiC8vlaguLgq3INGB8roO3QVSfHSAdIu4EyUnQXqi9/LBdV31tY4CcBH
         +dGaTepAgZQbAfQ8+HL+tB+/6pxn2waTKnt38HF2kPZ9DrWhZ9/jq+lfLBC3flE44b7D
         H3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585168; x=1762189968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPy+FHVUTDlqo9kS8K0pwEoZsjWCLKbllIO0a4/trd8=;
        b=tnmyY6TsTwhfcBt/8jCWPrwuhPGXTJsNE/FktdRbK4KL12fhpGSiMhyFccKpOK3xMA
         Vq3KmRmNt4y5naZM9c/AbVQ+topvkxFP4m3s1Dg8k1S1M74s9FAC8S9STvh/SGeFIC2r
         b/n2Wkw4lo/wlC9qKE/nyawYhGqp9BibFx5by8E+FTMnCJI0EdFnrJp5627O23+t/sOq
         YeyZC0hGbtEuKoBZtp+aHuWEWfqHH4Jx63zCPSyOk64iFRgqPDapcBQZsDeJodt1ssA6
         wN87s7sj6DsEUnDFR92F38uv8AgCXl99QdwBTMS/IWvN6S9utogODR6nnagEWqsU6yfl
         KsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSZdVXCu2ztpryHi/67SeBxrp2MdoWBrlHNh1RlnPej7eCUtFxHe0xNGbgF2q6qlQ+cBmJpnn1224ADA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkOYgdf5V+VTK9tQ8QAJELi0nxqq1gBMIUxpcUzp8cLVfjzdk
	PBqyvGZMNe0xPOfhyOgmIuVdJkFZakMFtTmOHK8xKdERjmTjWVIvN2zrJLU5BATxVA==
X-Gm-Gg: ASbGnctjlyF9QSW/FStQYut0m62NfA6+MeJ6B3KMGYy6kzoLtOEEg56SVw0LOj7UKQ0
	KFHS3DAuYut8Lmc0zvw6f6vwZJj7w0vwZIdNKdc/Uclqo2smPLtUuGLbAlFLf5VRVURS17r9tA6
	Kr6UyWpFi4FwitqUkTdmEdOnu3f7B7NqgSOPlYeQiovPNBnaZK3wqd48wBldsS9Yo2GMT5C25qq
	feexyVoCxG6RIIV/xr3r3xkReAnZP/7aVBmNKH4ItymS6IIURnCt5/wjJiq1ELszq3zcqHla4QX
	HqhuIxBAALhvogY9CYsy5DnHYIZa+GZ8gyvvL092qz3FEgtCFfwF0ptTJac9B5ys3WlnUrprCOE
	exAuuQBTCNIFvjQM5gdjr1I6TeG2j2h9VgdRy5q8XQXziR9PvUFNetln/IAFqXhYG9s70iHXBi3
	i/aBsmjoKYA8/jz/5DYqRK+1dpHZe4oV5z7l4Am+pByLdbolxbKJXO6fj0QBC/lX4Cu1Q/Ciyd/
	CRfNhKUVzYgZYIyVhSrIiDHYv/o6rEn3E0=
X-Google-Smtp-Source: AGHT+IFqnCggieYC70G3l4AysmlLY9PDhAFPBx/+0lwHkbnuWCU0qCp4R3nH9HyqPlC8U+RgBeixrw==
X-Received: by 2002:a17:902:e807:b0:290:c639:1897 with SMTP id d9443c01a7336-294cca88caemr184895ad.2.1761585167716;
        Mon, 27 Oct 2025 10:12:47 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34028fc5cc5sm32860a91.0.2025.10.27.10.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:12:46 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:12:41 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aP-oCfjViaEIowQe@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hByAKuQ7ycNwM@kbusch-mbp>

On Mon, Oct 27, 2025 at 10:42:47AM -0600, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 04:25:10PM +0000, Carlos Llamas wrote:
> > Hey Keith, I'be bisected an LTP issue down to this patch. There is a
> > O_DIRECT read test that expects EINVAL for a bad buffer alignment.
> > However, if I understand the patchset correctly, this is intentional
> > move which makes this LTP test obsolete, correct?
> > 
> > The broken test is "test 5" here:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c
> > 
> > ... and this is what I get now:
> >   read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)
> 
> Yes, the changes are intentional. Your test should still see the read
> fail since it looks like its attempting a byte aligned memory offset,
> and most storage controllers don't advertise support for byte aligned
> DMA. So the problem is that you got EIO instead of EINVAL? The block

Yes, that is the problem.

> layer that finds your misaligned address should have still failed with
> EINVAL, but that check is deferred to pretty low in the stack rather
> than preemptively checked as before. The filesystem may return a generic
> EIO in that case, but not sure. What filesystem was this using?

I see, so the check is to be deferred to the block implementation. I
don't really know what fs I was using, I throught it was ext4 but let me
double check.
