Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2F2D9792
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202939; cv=pass; b=HfCxL7s3P3nut/f1jjKrZnFunKCRa3hyuoKbhG7xYZJ2yqL107HrJc1RF6O79S138wwZRveiRMd60enNsOei/2RCJSNtCt7nfFtSh/+CwhvLzviPBZ5u0wMHTGfGuLqFnk5tqZ5/iccvzvXqIQXXLHwdAoi/VXUEHWwpRMc06dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202939; c=relaxed/simple;
	bh=zTnTEoXTuFEFA/C1D4ThX4Y+an6VucxyKo4Nr/GlcI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grUkD6Nhb12taYyKHA02aZ0dwOsQX8pLPUZH6kDqvwZY/4AHi9skXQnUnXFg74lbyS+aUVh0gsJg1chC7/9xxyVdUF6mSd/tjwzD3VcC6Xa2Ay5ugfZlA/wkDwnqsFcCpiDfDrThqwPCXWF+QIOkq9VgAHnusbFNtEsOWCOr3hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pR7HueMf; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pR7HueMf"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c4436d02cso10342231cf.1
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 22:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787202936; cv=none;
        d=google.com; s=arc-20260327;
        b=NRsnIi2JSDVdWHv7Zp7Uru7aHD20xyp2NcLxEHQxpwOAB+rW26oXgS9FfacHU5sxZ3
         H8o/U3keMqIqvgFwHxFnbSrPu+E+eDZ4n8bxGi5c9o4TL5RtLJ3Bw9srsA5bTYEkeS9D
         BJFjQbUiUQJGVHHwLhCr9pI4L3fo/XO8f+JgtPytrfXoJUsZ+fWuT/FJdOcblVQakL0J
         YxGFkeNqcDlxGyH10TtaIB2kwa2J2BWKOWdgmFZe0uZm6VjGw1HYHVkk9InsRrbv6WKQ
         WN8Esl/R0aCGUhFdhAufF2ikZwGNbj6BZKzkd9+xwZxoJdt/Z1z0fVqFxDKPDEXB/BdQ
         pReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i1qzFHY4MADO+pKP/rYIVSKWuTq1hiwkVURcjqrdi5U=;
        fh=gP3NxASj+wAoEQu9w1YAxcMHKTjD+s2qTH3kR/MzDNQ=;
        b=rlzJ64aZRpwSZHor6WWndsGV6mXMr4trXOJoOBnwpPqUU37BfU7kvw3ohUVCcct+f9
         IDT2ZGPu0oU9z5amBqk7Fw6iTwWEfHxsz8Wf4h429ls51Wud9D7Iv/gMNVPhnx5aTpV5
         7HDfTYQ7Dr18VO7LnQf6T57ZuhvRP/ohZ7zfJ+GaqV7rL9HL45ExSWe8Yz9Ip/+fVIKW
         wss/Kko0sTyhV/T10SSA3mulOBcIQ2Qln35TmDEjo0rT0c68VBvxV/KSy3ccdbMAl6gL
         4Lpdm1SNcFhdPHPJe+Xx6xyEHau4kVVvwohQDgB5tEyxJle5Iw0dq/o5rFeID0iWr1/k
         oOoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787202936; x=1787807736; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1qzFHY4MADO+pKP/rYIVSKWuTq1hiwkVURcjqrdi5U=;
        b=pR7HueMfPp5SsP/6XDPqV3w6AakvsUCG6mW9WHE221/ExmC0JJyUt0eAXIvrBlIQce
         OaKeZJhSE6nLUxf6+5vvg44lt0DdRb4U0zCmhK/+AkGn5ccbepOfonR+P6DPnXkjCnYO
         sQ5S7Nerxn7s8+7Dlj91Qv9cdLg7CjgI//4G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787202936; x=1787807736;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i1qzFHY4MADO+pKP/rYIVSKWuTq1hiwkVURcjqrdi5U=;
        b=iph26pQisuTt1m+orriy9+CEm7yE3+vr/Z3dGIWgksmo7eUzWf3RfveKjtcFcddkJO
         OeSh3CH7Hwf6jhUyldKrq52Q9q/BJVXaq1v9A3M/Bb4ur382sZ0qJXUMNfuuguTCf0iF
         jtSaWcp/Sd77MlVmeLVX9EJami4wYNzkv5h/WRBx8MbhIJEn/K67cM+tuq4lhbAVEuAm
         yqueaBjud4ODhF93tLJlyVtV037m8ksvx7vmCxHK6QpdBMNkEZhLOOWvWBvw75r39wd1
         YIRKY9m6mWxsKRMxcgNKTllwf9hYB4F54jpoc05o9kPoY8By9zfC7BfOoWamXITkrCmI
         LyJg==
X-Forwarded-Encrypted: i=1; AHgh+RqQrOEslEjJvqiX50IThMz9TWjNDxTmHdP7gQEwScQCGtO44yJpb7JclinUqCGyWIR2eE3N26hDp6zdCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ76qgXdAX20YbC0It1Ll+D6abdbCYJvsI8nxnXrDdBVObtHrn
	/CogvVbQNv/Gne4hooOWO78pGRqpAatR5gw30SQQhKqWVCuhNbxzzLCahBeDgyyRiwoGsqK2FIN
	3bxQxCww2lrcggwdVW69vW00fgRhpqhp0OuPFIvpC1Q==
X-Gm-Gg: AR+sD13n6ssGqcX8MdmYfXbsBDhvLojdBj4gP/rBFQZzGZaq2uWbpw4n8MAs53ZRAfP
	zOuboGYEXaa+dCH2DudhnhRpciMAkys6x6ZYt8LZGJh1+J4oenUvNEtyOSoksTFfsiXMCFFV5oa
	z2srSqEU+8euzfRMmbKw3nzx5Dh6oFbydWLcLzA5HlDwcgY+I30M30jAfHu574nq4LjxdM+zKIO
	3dwp19Rc8/bKfS13GxAxgu5wzapA4C1Xk0DDEUchHzJRn0hlqXe1Ws6xCMOzf2XVfdLOb8TgKbj
	goNGPYkB3TQyFrhD1NjYLso+ivisi2bP0gHwNTCigSOC4pexO04ffcCG3pcwfntdH+Ff8HYASzX
	oaf+KSvecJto=
X-Received: by 2002:a05:622a:608f:b0:51c:1e2f:1281 with SMTP id
 d75a77b69052e-52dd5e1114cmr96727921cf.42.1787202936231; Wed, 19 Aug 2026
 22:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717125538.508925-1-joshi.k@samsung.com> <CGME20260717125627epcas5p3f5ad1cf917d563cc061e571b2f932319@epcas5p3.samsung.com>
 <20260717125538.508925-2-joshi.k@samsung.com> <20260721030338.GU7380@frogsfrogsfrogs>
 <71ae458a-a6e3-4c6f-8fb9-7e8bc088bb87@samsung.com> <20260730172211.GF3556460@frogsfrogsfrogs>
 <20260819070459.GA1541@lst.de>
In-Reply-To: <20260819070459.GA1541@lst.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Aug 2026 07:15:25 +0200
X-Gm-Features: AcwNN1XXT5xefF0BXUU_TM3qwY6KZTggS9AZTFDK2j8DH58mqjaIjJ16-hbRpyc
Message-ID: <CAJfpeguAkB01swoTKmqcEOQrej3g8yjr2RZSPQQPeo-4UE908g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] fs: add write-stream management ioctls
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>, brauner@kernel.org, 
	dgc@kernel.org, jack@suse.cz, cem@kernel.org, axboe@kernel.dk, 
	kbusch@kernel.org, ritesh.list@gmail.com, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Aug 2026 at 09:06, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 30, 2026 at 10:22:11AM -0700, Darrick J. Wong wrote:

> > passing through to another layer (e.g. fuse) assume that the third
> > argument is a pointer and that it can copy sizeof(data_type) bytes at
> > that address in and out of the kernel as part of marshalling.
>
> That is not a good assumption and things will break.

Right.  Fuse server should send a whitelist of ioctl numbers it can handle.

But ioctl's are a bad interface anyway.  Why not add proper syscalls instead?

Thanks,
Miklos
