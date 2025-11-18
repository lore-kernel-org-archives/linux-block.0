Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F8537E9
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487077; cv=none; b=KgchaiY0Hglxi54AF/AvBDv5dVTXmnfPg+CFrRJaNo9YSKbfzdjaZhBl1jIsEYxKVIokye3nV/NV/2Z4qEdS6uEj9VggyTLd6jg+mplF88R+mJu/U/OKZoFRy6GmX8u4d7lH+3RWrA04F6Ki/IUrfbNC4A9CcitlkpDrCPVYXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487077; c=relaxed/simple;
	bh=nhASVdDt4OdAwVAANU2bomnv6+IJT33HttvU1MpH8Lo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=SSXgcL0vReWWWFNsrvQpj5yQ1ZYQP027cWn1yTywTJgMOApmGFoRJWLmJ8nrmBvVYXQZcTYQmFBci85GYUjunfAoqIwk+kZ9SKBvnbMAr0qapP6HCR4BqWnXVz8cMXc49Qm2TCqEO9CKD2Z5duWGl7/yzyUVALqAs8B37GQufCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLoGzHJf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLoGzHJf"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34361025290so4412983a91.1
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763487076; x=1764091876; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJZHPmpfAYK3kOvAYzdDDouNFc3+GX3mg/4dP4wkGpE=;
        b=NLoGzHJfgXsbAIpeLOuT6H6thcbOWsDrkYUlxHE9fk3EaW4cGSmISVyDK/gU6ynD88
         N14Z9t/iBYvcVGGUJmeap1tNlmbkLAjhKlO+R0Dgqq2Is/zEvq+xKgVPOz5ZG5yPGTNM
         ubaLmhdYov6TNgBBIgKY995lAQtqIcbwfnFAi76HWg7vURciDFf/clqnmsX/E6xwn9ys
         HhzeJjSb/w6tbMbCjRS5qTE6A3g4D5uSTi50vWEpjslAIkTDywlrFQRmUKQfGoaiFbgV
         Yoju0NimoDihKurn/a1/7eNFWW7gMu4HWdBJazse1O9QWcZTXqRrQHyNqfB+W5W3kNjs
         8KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487076; x=1764091876;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJZHPmpfAYK3kOvAYzdDDouNFc3+GX3mg/4dP4wkGpE=;
        b=obb0U6Y5eJyMFXp0hucNM3GqfQOoqZB+LIuB3wgV4vOuRXe5Y2/w9ro/t6VGk34Nwp
         fS6kwi805ItFxp6uz0DuOwvvK7ZNnVUh3dOrwohqA1rqtEcoyTwRWLvXjIqmOM9RHIE2
         x/a5QsZAErPCnSc6jxs5THP52COXROKsb9QBBOh5ntVicUHh/7348Wk0ewr45A3g1ttZ
         5Z39wQMiseoTAAOMF0Xa2rNoT6WYJAOOOPsGTBKs+bThBgXFz3wdUwBqJCzm1O19kRsL
         J+ui7LJgFoQAzLhA2cYzYP0X/+qRvxj4d1GzH3G8f9GWCrD+q6ZenQVedgcBwGj3O0Fh
         uFSA==
X-Forwarded-Encrypted: i=1; AJvYcCWaCY2DsNE3xW4K50ekMkatBRzeAWvE7EbYvqb495J+cnkHNTfmSrRuMzYtwQvybts2bJJKrBjxvMc1JA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XhQBXLPMce83OQJW9PkfhlUGGSpCl4CvHBt6TiBnRy2mb3AP
	+O7rbW2zlQqM0EEnKFfaaV3CgNIDz35/ZzuTXjhC+sPMoDy2mEy3yavX
X-Gm-Gg: ASbGncs39hOFzcCLtkhWKZU++Go+iO3nj4RUfVkmngFZyZ57C4JYJ5LmvV8jXyBPqvF
	+FSTIWq92LlfctxIdpCMxLe92r5zHWHH+yjrp8AuDXqQlKFXDhcrNv3R4ljwysuFluk7nCYnugU
	r5fOQKwNp/6b6JSo2E+aucTn09BzZPmqOycSYqh2XJwKSniOkwxSxTRZ7+tb+Pj06kSW0FltzoA
	UDgHClCKV0sDUsKXXEoTGi5Yy8RAeUjt60uRMsu95e7BRV3DPqZLvTbDrJNp3zdtVmANAEjGPIk
	U7HF4fNCcFKEC7gbTOX7GhmyuHOw1uGNahzZxMzCn5I8y8f3je3rlfifdnUUH1YnDPgA4SrrJU9
	iFbwG4SGiJza6tO14Ji6anj80G2RW+LTjUd1BvOZPAp9d/lhbRtFNhvD3MM/MvX7ObAqwxow=
X-Google-Smtp-Source: AGHT+IEQrU5uwPDP3B0D60MQHHmGXSAeXE5fv7FgIePf1xPikPaNbxxiXR2fp/Zl+qVssNoTrpyjFQ==
X-Received: by 2002:a17:90b:3843:b0:330:7a32:3290 with SMTP id 98e67ed59e1d1-343fa751ad3mr18844371a91.37.1763487075532;
        Tue, 18 Nov 2025 09:31:15 -0800 (PST)
Received: from dw-tp ([49.207.232.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm1694884a91.0.2025.11.18.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:31:13 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
In-Reply-To: <aRcrwgxV6cBu2_RH@casper.infradead.org>
Date: Tue, 18 Nov 2025 21:47:42 +0530
Message-ID: <878qg32u3d.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com> <aRSuH82gM-8BzPCU@casper.infradead.org> <87ecq18azq.ritesh.list@gmail.com> <aRcrwgxV6cBu2_RH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Nov 14, 2025 at 10:30:09AM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
>> >> From: John Garry <john.g.garry@oracle.com>
>> >> 
>> >> Add page flag PG_atomic, meaning that a folio needs to be written back
>> >> atomically. This will be used by for handling RWF_ATOMIC buffered IO
>> >> in upcoming patches.
>> >
>> > Page flags are a precious resource.  I'm not thrilled about allocating one
>> > to this rather niche usecase.  Wouldn't this be more aptly a flag on the
>> > address_space rather than the folio?  ie if we're doing this kind of write
>> > to a file, aren't most/all of the writes to the file going to be atomic?
>> 
>> As of today the atomic writes functionality works on the per-write
>> basis (given it's a per-write characteristic). 
>> 
>> So, we can have two types of dirty folios sitting in the page cache of
>> an inode. Ones which were done using atomic buffered I/O flag
>> (RWF_ATOMIC) and the other ones which were non-atomic writes. Hence a
>> need of a folio flag to distinguish between the two writes.
>
> I know, but is this useful?  AFAIK, the files where Postgres wants to
> use this functionality are the log files, and all writes to the log
> files will want to use the atomic functionality.  What's the usecase
> for "I want to mix atomic and non-atomic buffered writes to this file"?

Actually this goes back to the design of how we added support of atomic
writes during DIO. So during the initial design phase we decided that
this need not be a per-inode attribute or an open flag, but this is a
per write I/O characteristic.

So as per the current design, we don't have any open flag or a
persistent inode attribute which says kernel should permit _only_ atomic
writes I/O to this file. Instead what we support today is DIO atomic
writes using RWF_ATOMIC flag in pwritev2 syscall.

Having said that there can be several policy decision that could still be
discussed e.g. make sure any previous dirty data is flushed to disk when a
buffered atomic write request is made to an inode. 
Maybe that would allow us to just keep a flag at the address space level
because we would never have a mix of atomic and non-atomic page cache
pages.

IMO, I agree that folio flag is a scarce resource, but I guess the
initial goal of this patch series is mainly to discuss the initial
design of the core feature i.e. how buffered atomic writes should look
in Linux kernel. I agree and point taken that we should be careful with
using folio flags, but let's see how the design shapes up maybe? - that
will help us understand whether a folio flag is really required or maybe
an address space flag would do. 

-ritesh
