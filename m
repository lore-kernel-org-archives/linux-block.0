Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8013B5B6
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994205; cv=none; b=p88hkeMm6IZvqn9N8o8PjqHm+wK4ixQBb6QG+83XvPxTmo7mm5SJrRpWxAbsGlfhnoc6iIWKwEELHJMqplulTzSjK+7izGOy+qBDmPemrsqffvHpKWXn3FINzFVNZ3rpdVQDDqKrepQojMpN6gfVfcxpqp89eLGkliU9mgvFsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994205; c=relaxed/simple;
	bh=moPQ3ht04hOY6KU/W3desJBFCXfBp0/4X3B9314EU+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rv2HhK4ZDLRWhXSZE3vKpVwMwMNMMHmRGw5i5gVT0O3iF5OVPxv0KEJ/m5NNeSVzlWmVlojWAuY0tMN/5Rg6nZJ7Ei3zmtPIhIv5H/Z7kQX5416eGbFyj0kjZLaf2zGizYL9BykEJrznXnYwLhxDecg+Mj2EgMFLfyq8tm0L37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ejm8MfND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ejm8MfND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737994203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TyEIT4LNAM3JVRfZ54TuzLiexAOU5f9Gj2ZQl9OYuzA=;
	b=Ejm8MfNDxVhRTCKsyNjuxGYYByg0Iatf4MnjZrX44asZZPMDQBkJebfmAGmR631volPqNF
	RtI2T8jiPwEkiOFOBegXq3EWr6Z1VdsKc+8thOMVoyYPts8UkEOE9U/u5N2XZhXg9klaqh
	tHlxUBB8e8gIypOEEFsTvY0gIzPclgg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-Z-SDtI77MqSnyppKAUs86w-1; Mon, 27 Jan 2025 11:10:01 -0500
X-MC-Unique: Z-SDtI77MqSnyppKAUs86w-1
X-Mimecast-MFC-AGG-ID: Z-SDtI77MqSnyppKAUs86w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436219070b4so21589495e9.1
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 08:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994200; x=1738599000;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TyEIT4LNAM3JVRfZ54TuzLiexAOU5f9Gj2ZQl9OYuzA=;
        b=shU31Ehmethan9q2wXFUUkgD+/2msfitbDh4vpIjJfLzAey+2c1OBiqIGLfe1vREWx
         L4FwhBV52UmfSXtgFawmdHH33pPAXNJ4FndhSW4EuLiNTHVCe4eqC9ZOEVhAXqnDU4rc
         zubml1AI4x4WF4VeZ1agw/Ilyo1HrEKdSffR8oni3/rWzozrbpS2Jox3xLqP3O3gx7O+
         OrDC3J4eleR0O7csGh+CpXJeQQRvdnm8Y+zLLOFsgodMFCnfPsaLi+0kSyV+QtZPK5+d
         CLn8pxH9rbD6fOBY2jOArJXfxizrJ7OQg+qNj0Q24Hn5QNxGKhZ0jQgJccs0WC/IWj6U
         8LZA==
X-Forwarded-Encrypted: i=1; AJvYcCV2cEyZJZa7wlhmm5Y7gBs2rA+DVOn9qGmNCpvBTisroPXp8mpS780mRU7Im+kHEWCGhisV+nP7nNr+Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfba+3Y/sP6rhhZTx0QoIm0bMmwuwTn+2sT2zRu8C4B+dCC0gs
	ijvn40n6EW3cPzHCcIfDfEJ3gvgRtkXJS32/iUUdDbk7TjvZ7vkXBJOdxUoqLjw2sTGN6CyKsyn
	h6dsO9w27wKj5T++/ufDW1dg/HIHEl53sdnpCB7e6iKM4FyYsPrPVJSLOSMFw
X-Gm-Gg: ASbGnctM/cpbfxYqi+afmzFI0I3FRF2km1sjlxbjKYsFFDZDG51ooDnq/npyDOBHV6g
	eETZ9d+dUyt+NUvObME3LvwW5tVsEAGvQgp41D1KTB7V/HugVVuwzMZRabfycvUDx7XcCtj+3Q4
	hE4qS+/dJnMMqWPYpyz9JTJkLl/bdL/JDzLYZezwDry1JUwMa9EwzSw2TiEbLlJkkGJOZsyvsyL
	+mrq4urbGGg2gznlmjqnqwEtY+WgrrrvV0fgX5r2GevuP0UPcJRgYA4IiwTZX38Nvk9J8+Gf4z/
	INjM3cDZLaQMd/haYPE9VRnFyzdHLgLLiKJg8A8D6PMHN1HGJGPxv04J/NEJ19+H5APb9UxD/H3
	/+czb49KKPGRz+i5Z8PwIkaBQEVeAEgxr
X-Received: by 2002:a05:600c:4511:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-438914387ddmr310503075e9.25.1737994200240;
        Mon, 27 Jan 2025 08:10:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjdbd5JciRMUzNLc/2ky2eoreDGAEFkO6XJSNHUXzNK0QwS8Y+vKoITtLJ2zAXYQe9PsLRIg==
X-Received: by 2002:a05:600c:4511:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-438914387ddmr310502805e9.25.1737994199846;
        Mon, 27 Jan 2025 08:09:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c? (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de. [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa463sm137649125e9.8.2025.01.27.08.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 08:09:58 -0800 (PST)
Message-ID: <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
Date: Mon, 27 Jan 2025 17:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Jane Chu <jane.chu@oracle.com>,
 Andres Freund <andres@anarazel.de>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z5euIf-OvrE1suWH@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
>> If the workload doing a lot of single-page try_grab_folio_fast(), could it
>> do so on a larger area (multiple pages at once -> single refcount update)?
> 
> Not really.  This is memory that's being used as the buffer cache, so
> every thread in your database is hammering on it and pulling in exactly
> the data that it needs for the SQL query that it's processing.

Ouch.

> 
>> Maybe there is a link to the report you could share, thanks.
> 
> Andres shared some gists, but I don't want to send those to a
> mailing list without permission.  Here's the kernel part of the
> perf report:
> 
>      14.04%  postgres         [kernel.kallsyms]          [k] try_grab_folio_fast
>              |
>               --14.04%--try_grab_folio_fast
>                         gup_fast_fallback
>                         |
>                          --13.85%--iov_iter_extract_pages
>                                    bio_iov_iter_get_pages
>                                    iomap_dio_bio_iter
>                                    __iomap_dio_rw
>                                    iomap_dio_rw
>                                    xfs_file_dio_read
>                                    xfs_file_read_iter
>                                    __io_read
>                                    io_read
>                                    io_issue_sqe
>                                    io_submit_sqes
>                                    __do_sys_io_uring_enter
>                                    do_syscall_64
> 
> Now, since postgres is using io_uring, perhaps there could be a path
> which registers the memory with the iouring (doing the refcount/pincount
> dance once), and then use that pinned memory for each I/O.  Maybe that
> already exists; I'm not keeping up with io_uring development and I can't
> seem to find any documentation on what things like io_provide_buffers()
> actually do.

That's precisely what io-uring fixed buffers do :)

-- 
Cheers,

David / dhildenb

