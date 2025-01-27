Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC013D897
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994835; cv=none; b=fmjvwRg7e6Iag+Ea3p9flBzZLDMNxjVp76fPpas4zqNrRQh05z69x7v5eKqlmv6uTM+ENPZby4guWJJFX7sNl6VX9LQVuSzmKKUiPYcQe9K36BO2V2r+xaGjSHeHhL/XETCAW66dcpwG+87c7n04vyahFJaYi4/Jz5ETl1XzB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994835; c=relaxed/simple;
	bh=Ov9koSZfTcdIGeeDVzCl8O0eHpNqwOoxqqTLTrVki+A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gIK1YPOQQcFl755aBPyrzwDLV3YaZyp2u21riXkKgNLr3j7TTzfqjVwWjJxbthxU9KIPeIMnBVTttZX6xCpHiHJdHjtU8LJeeeblWMKpMMO3JBD6CFRrTECo9GyExceFxaHjZ0K4SLuLwtGMno7w1r84CJ1Q0+tOfZPUrkEkz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+328YdS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+328YdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737994833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0+RxIObw2p09p97eZKw73ueY83Nw45wFd2xxfl+l/ug=;
	b=S+328YdSzjViOgScijowyM0SSRnosmp/Gmuv2bUBWEqEe7ybYAEI8YM1TXDZRg31+xuVHC
	2yHPsEHicb1nvk6eaMdg/QyJIO2xIz+fGhozTlOXgSs5hSahcQX1Pi2kM96PkSzB9NctEB
	i7Qo6iQbsBIGyrR5e4332AwiPKTf770=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-fNbNp6bnP62Bl_eIkRJUZg-1; Mon, 27 Jan 2025 11:20:29 -0500
X-MC-Unique: fNbNp6bnP62Bl_eIkRJUZg-1
X-Mimecast-MFC-AGG-ID: fNbNp6bnP62Bl_eIkRJUZg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436289a570eso35346515e9.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 08:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994828; x=1738599628;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0+RxIObw2p09p97eZKw73ueY83Nw45wFd2xxfl+l/ug=;
        b=sZ7+Yts0UPthVhu1mudk1zj+6EfIo1EEOF+QlACiJ/Uc/UWEhtCwM9XvAjJaDFnkoW
         1V7a+eCMUOkEAE/TZSVxzhtmyW8ugljlW8I/jA12rC/PrWjvTEOo7eNz5g31vljZHSyo
         xdtiOV32BYSY90JWHWBle7c0BkyjM9tuIZXMnWkNljDWCaVnPR+KwnIAd65ro1eEUV/q
         xQJ+9xw2zF8C5Dc33+KaFjUtEzVr2nQ41uC+Gb9ChQmFrIsXH1oFqX/snqr5ndSEm6G7
         I29unyi+11gex9LQnsD4+NWNz/06yEj2jkyTQ+l70RaVwh0EmwrmFDcA882DbZPkzo/0
         GzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT682RhX6L4kdp3rYWTo9r6wsth6loMFRfHb5VvZwUGdtqfEFTZ7b0qlZsfvEYAxOqH8xZWAibAXIwaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOKDVTKv+/IYgS9QE9piIjbkjJo82DGO3/CQoRrB3UMrLKqR7
	3ChM0GoapmV7Lrcyie/oi80E5t8/eIy8XX6T8mx/9gtEmsuCqXlvQtKbWpI55n4KezAx7U6ELXd
	WJlXT9fNq1Cg5OXo/9MkrhvnpiiUD/3PHiJX6V88Vjnn4NxzScZA39oAYd3Sb
X-Gm-Gg: ASbGncvQG/Q5VLD6Athprn0QvA959XoMuC+2J6GqrwTRqRDA4uguNkuqSYiNKls2qOc
	xs0NWDTmZu59nQLEi+B1gycNXiGEHpMl9SKnf/Rco3KAEalF7o9rxZreSDDlzx2FT+1l8kQ8HA6
	1HGMfTGdAYr/Q+mdWJJmdewh1PW8+xh9J7adVBZopetrRXozxEk+AD7uk8njVgG1WMuE1XBt7d4
	Hjj+QFuIJ/e8CkSvkk63SI0491zaep9YEc2ITzfbFqmpuTAl3Pi6K8K7gNEUtUFD1/xeOTsXi/2
	TDNpU5lHVf4iccmFbkzTBhu5VhJq914QIxq9B+Pn6FZ7FJCQUDRfUh2N95uT1HF9jth8I9L0BKa
	Tyn6m4bgJv9FbZjM2E2ys5AvnraCWnmkb
X-Received: by 2002:a05:600c:cc6:b0:434:a852:ba77 with SMTP id 5b1f17b1804b1-438913f153amr402795105e9.15.1737994827801;
        Mon, 27 Jan 2025 08:20:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUboNd2g8oqjZOxhhwqbQfWG8uXZ2lYOWISdlhGqQszArXtgQLcHIIIXPXKKWrt40jRYEQZw==
X-Received: by 2002:a05:600c:cc6:b0:434:a852:ba77 with SMTP id 5b1f17b1804b1-438913f153amr402794845e9.15.1737994827423;
        Mon, 27 Jan 2025 08:20:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c? (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de. [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f0fdsm139928195e9.5.2025.01.27.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 08:20:27 -0800 (PST)
Message-ID: <503c29c8-bcc7-4a6c-ab2e-ebf238a9a1db@redhat.com>
Date: Mon, 27 Jan 2025 17:20:25 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
From: David Hildenbrand <david@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Jane Chu <jane.chu@oracle.com>,
 Andres Freund <andres@anarazel.de>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
 <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.01.25 17:09, David Hildenbrand wrote:
>>
>>> If the workload doing a lot of single-page try_grab_folio_fast(), could it
>>> do so on a larger area (multiple pages at once -> single refcount update)?
>>
>> Not really.  This is memory that's being used as the buffer cache, so
>> every thread in your database is hammering on it and pulling in exactly
>> the data that it needs for the SQL query that it's processing.
> 
> Ouch.
> 
>>
>>> Maybe there is a link to the report you could share, thanks.
>>
>> Andres shared some gists, but I don't want to send those to a
>> mailing list without permission.  Here's the kernel part of the
>> perf report:
>>
>>       14.04%  postgres         [kernel.kallsyms]          [k] try_grab_folio_fast
>>               |
>>                --14.04%--try_grab_folio_fast
>>                          gup_fast_fallback
>>                          |
>>                           --13.85%--iov_iter_extract_pages
>>                                     bio_iov_iter_get_pages
>>                                     iomap_dio_bio_iter
>>                                     __iomap_dio_rw
>>                                     iomap_dio_rw
>>                                     xfs_file_dio_read
>>                                     xfs_file_read_iter
>>                                     __io_read
>>                                     io_read
>>                                     io_issue_sqe
>>                                     io_submit_sqes
>>                                     __do_sys_io_uring_enter
>>                                     do_syscall_64

BTW, two things that come to mind:


(1) We always fallback to GUP-fast, I wonder why. GUP-fast would go via 
try_grab_folio_fast().

(2) During GUP slow, we must take the PT lock of the PUD table. So the 
folio refcount/pincount/whatever is actually sync'ed by the ... PT lock 
here?

See assert_spin_locked(pud_lockptr(mm, pudp)); in follow_huge_pud().

Note that that PUD table lock is likely a per-MM lock ... and yes, it 
indeed is. We don't have split PUD locks.

-- 
Cheers,

David / dhildenb

