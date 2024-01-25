Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AEA1292F1
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199221; cv=none; b=i4aOAPIt6wOjEvXrbVyp+s0ozrlYaUbrtq5zxsICo9BK/FkwLbc257Q1ZvaZUv5yEb3FMy+aw2EB/NzyGThoAVXIeCszc5Ur3GjfcsR7F8dDSt8029q3WUKlEdFHeE8XQHAf5CWXVVYEQJHRYNF65M7EUFsqJxDd+vTLtf1ni+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199221; c=relaxed/simple;
	bh=2WKa9upsU01rKQEE3pfd64lsMOLUYKGGxXVIj2owvow=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LhgE+V3yjY+0YR5EPRuL543XICM5qW11YmAgtB6Jnpbm1KOkR/U9GIAGHTSj/CZDGr0+Qk//vy5tEAQcPG2oYaCn6qlyg8UZ6cS4sfTr1Yaz6CDw50rGJCkhw8wmTsfkD6ydMn3/fvdLMHinlPdJ1iwj9k1NS/jDzWVOGoBGz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=11kTOu+h; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="11kTOu+h"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bee9f626caso94429539f.0
        for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706199219; x=1706804019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HAkOTZIz5lxs8HKEuq4313296H/ZzDgpO7vgoAQKpT4=;
        b=11kTOu+hnxRlX0lrfdDWgNFudIP9CKRbQgDf+pvqFsI6Ne8Q3sc9SgDI2ur9jgd62N
         fBw0HQexZwccDopIyk8nq+VbQtGgdLbWzD3eLu4O31OzyqBIo3blJnNu8oEaeZvi4DAj
         Bp7X+6cDcvlSQhdGms95boHV+tAL62OF4AWiccmImeMfHR3ItnvKh3t9LX+uI5BwNMyO
         mVNeoVdJjRgzZ0z0H1X3vLSFuJftSGKJq3GcsVa3284h7Av+mGiaxVJ98g3fP3TTitsh
         nHk6JrjULIyFWcjsfTUbYym035DogfkOV13eAFPFfT5IdnjHFnjCq4FdjLCuk+JlZgy9
         rA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199219; x=1706804019;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAkOTZIz5lxs8HKEuq4313296H/ZzDgpO7vgoAQKpT4=;
        b=C7jc0yXWVW5TNhH/l1Nmvzo7moCOkS6gdCswfXS8UVxGyiw4RpPhl9PPJhbRMWza0c
         m3pOGqX1eROfNwGqe9wZuWBp7uYYtBDo1FGn4zCr0CXdaNwwB8IEX9eGQXcqQgp1lOQm
         692dghCIOs1z4hDE1a0davHAa4K/41pP1u9hSt0SoHO+g6SbHosVQ2tKETMXugig35Ve
         PEzCrNdvHTc2XA9IEKNi2SeOrb0OChzSXOhHBzyijov6Ube1/Cx5mD5Bec66v0+VFLl5
         lHo7HQboqVpcGSCWgWc0VDeJeVch3mHaPdRwBcZqkFdhh9IR9hUeVRFk0ZO2r+/6U46a
         vA3Q==
X-Forwarded-Encrypted: i=0; AJvYcCVv5ufuUDfEvbg9vO/X5Orbs+YPG3/DHSg5SkOdc5NfraUiFGM+byExZxO59Jj89n+rabxq4hshqB+2ZEcZ4uXQA09/XcqEkMNf+SY=
X-Gm-Message-State: AOJu0Yw9FrgZGsp4byQvHvq4IlOIaKNAWzhtkY32E/9wQldN69dyF+Ci
	m5LKmAQUC2tOOO07+SXLZqC5e3WX1o1PN3YFsLELWTvOQ0s/7Z04dpKkUqTKMk4=
X-Google-Smtp-Source: AGHT+IGxmHdLcWxr2mQPouIDjWNx7Kev4k3u8IORuaWbpZv1GYb8yieuqEh/afnZO7lUdPnu5h+QoQ==
X-Received: by 2002:a5e:d714:0:b0:7bf:b770:d4ed with SMTP id v20-20020a5ed714000000b007bfb770d4edmr10280iom.0.1706199219230;
        Thu, 25 Jan 2024 08:13:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y13-20020a5ec80d000000b007bf4f95cf85sm5785870iol.37.2024.01.25.08.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:13:38 -0800 (PST)
Message-ID: <6c4a4cf3-c5ed-4236-a6b2-9d53e927f979@kernel.dk>
Date: Thu, 25 Jan 2024 09:13:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH, RFC] block: set noio context in submit_bio_noacct_nocheck
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240124093941.2259199-1-hch@lst.de>
 <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk>
 <20240125081050.GA21006@lst.de>
 <07de550c-2048-4b2f-8127-e20de352ffde@kernel.dk>
 <ZbKIN5tn4MqHzw6U@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <ZbKIN5tn4MqHzw6U@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 25, 2024 at 9:11?AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jan 25, 2024 at 09:09:44AM -0700, Jens Axboe wrote:
> > On 1/25/24 1:10 AM, Christoph Hellwig wrote:
> > > On Wed, Jan 24, 2024 at 08:40:28AM -0700, Jens Axboe wrote:
> > >> On 1/24/24 2:39 AM, Christoph Hellwig wrote:
> > >>> Make sure all in-line block layer submission runs in noio reclaim
> > >>> context.  This is a big step towards allowing GFP_NOIO, the other
> > >>> one would be to have noio (and nofs for that matter) workqueues for
> > >>> kblockd and driver internal workqueues.
> > >>
> > >> I really don't like adding this for no good reason. Who's doing non NOIO
> > >> allocations down from this path?
> > >
> > > If there is a non-NOIO allocation right now that would be a bug,
> > > although I would not be surprised if we had a few of them.
> > >
> > > The reason to add this is a different one:  The MM folks want to
> > > get rid of GFP_NOIO and GFP_NOFS and replace them by these context.
> > >
> > > And doing this in the submission path and kblockd will cover almost
> > > all of the noio context, with the rest probably covered by other
> > > workqueues.  And this feels a lot less error prone than requiring
> > > every driver to annotate the context in their submission routines.
> >
> > I think it'd be much better to add a DEBUG protected aid that checks for
> > violating allocations. Nothing that isn't buggy should trigger this,
> > right now, and then we could catch problems if there are any. If we do
> > the save/restore there and call it good, then we're going to be stuck
> > with that forever. Regardless of whether it's actually needed or not.
>
> Nono, you don't understand.  The plan is to remove GFP_NOIO
> entirely.  Allocations should be done with GFP_KERNEL while under a
> memalloc_noio_save().

I do understand, but thanks for the vote of confidence. Place the
save/restore higher up, most likely actual IO submission isn't going to
be the only (or even major) allocation potentially needed for the IO.

-- 
Jens Axboe

