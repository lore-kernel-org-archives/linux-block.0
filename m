Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263D18A6A1
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004850; cv=none; b=gXSsCPMETtu3yp0eaCqunPwYEXna6GZ19vaA10hr87aPIk6rjRvZ3vagSK+aHgXfGhSrw/visZGpdShrFOU3a0H+2RdfAS6tuNZPgUChZsvABtpUi1ytZ9WwlYRyhkpYSac8fNP/jyRZUNE6wQBSELdMh2CJn2OoDmBPwDDIQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004850; c=relaxed/simple;
	bh=pGkEuQXy3VwysjIwr7MmmjLQJdVrfw6t2tcN4YH/yMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2UpnAKmf4q9syZWySt/XnJ5t7wGO5W88uU6VFJ+PyXSEHrCvu4A+Qm5Aso5cUmitz5Hm0y95CuWrQ9cUcj0YwB9E+GrEc0nN9gZiRdS0E9CuB6vNZg69nkd+oeTaKy037esX6k4EhSgntcm3Ik/euuzd5o1mM6Se2w+lmsXXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3k543Zb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3k543Zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738004846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uyc6LsJO6G5L79Np/T/dFGFGyW2JSn82k2kpERB4ue8=;
	b=a3k543Zb2y4vlCQlwXxH3JhtYSCcYbkqO4uKeIOxzbPgMex+EcQXEtm1qy4kMsuDKziLj0
	C5dewiiMPyOM7CsL6rceu2EnwbvabeZJPPfgIJZjAT9t1UO+OzCi15TfcNykELIQZ3O7kN
	OPPP4V4hxlnIX1x8hlFocVeh5ss7lbo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-hpgAIH-jPaySJcu9ofQdSQ-1; Mon, 27 Jan 2025 14:07:24 -0500
X-MC-Unique: hpgAIH-jPaySJcu9ofQdSQ-1
X-Mimecast-MFC-AGG-ID: hpgAIH-jPaySJcu9ofQdSQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43628594d34so27594915e9.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 11:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004843; x=1738609643;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uyc6LsJO6G5L79Np/T/dFGFGyW2JSn82k2kpERB4ue8=;
        b=VxRQRLi9NERvmedZhsYimxtafh84F8kUdcRW1Wy4QKcKZRAifGXT2g0Lkc1F///y8e
         eFhNm8b6Ro5ESUMamvS9DidbEvtvMLkkRLkxbwKGxVsy1QSZeCUmt7X0Q3aINHI0lb2U
         dPE2YzEvpp+w/YO0Rq5xlshwEYrIpPFXeCQ5GRHyLNnxXZ1s3a+6BCqxuWj7L+aSuW3Y
         Qiuc74ufk6J3/M+uPkBGFuVajBOP+aWvFhdpn+G5JsQyUWcDlpKkSFb8qCPoTtboWQLq
         nbBKIj3C/tdX4wAd2tqmRO6JI2991S8PQKdIlqpglCp31aMDLEvdyHviM2AKG9n/VVYw
         aV0w==
X-Forwarded-Encrypted: i=1; AJvYcCUDIcB+eot+ScvZ3KBaFJdetxdmYC7jbM4ISWgCvptChzsJTgSx488aMqxlT0kdFYOWyBFdct9633Mliw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyHH+L9Gpz2HtH3tVIIrxYuLbIwCBNjdyedwVKNB2ziSoe5BO
	pmixs8fgBLMueNbqhd3kxPh9vPSxifDAH1nS8s+cM1AgId3nyrXZ4YXAkG0kV534Wn0GVA7B0hB
	61ExaZHjCNpSsSmnnEp+1kUiumpbTFKPt7/cv+u5XndRd4GkY+DwpKJ1eoFNF
X-Gm-Gg: ASbGncvEU/LNEw44+if4mr0Ra3mw8ojzNHkCNb0747AieyQfbTmWSLO14Tg+UtFr02D
	ykonhHTsiq0YpTrDafvGz2pJORqgmfuRijNjEvs55kf06Q4DY78TkYJEzJKZxuhPFqRc4KLr+u8
	YgcUAltaYEujkTo3GFrn/fojDD800e3VGKR2zYeHdQkdLViaiXich63QCUKkjZaW/ZIYRpXL2qP
	H6BaXqchpV3bQqPqemnlFZ1RSy/7ySlfvZA6sKUxdvMQ6zOl0aPyWAiuzkmA7cozrPfD8LiOnuK
	lptN7tMFmA3URyx8YN84KGAyhjQluf6IUQ==
X-Received: by 2002:a7b:cc8f:0:b0:438:a214:52f4 with SMTP id 5b1f17b1804b1-438a2145332mr283852815e9.25.1738004843289;
        Mon, 27 Jan 2025 11:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIZwwQqlpfDcO0LIhEPhQczdmtW4UN2i5WfpIeT5O+BT0FbU2U86NgKeo9p7Ti9SzMoqMOWw==
X-Received: by 2002:a7b:cc8f:0:b0:438:a214:52f4 with SMTP id 5b1f17b1804b1-438a2145332mr283852555e9.25.1738004842863;
        Mon, 27 Jan 2025 11:07:22 -0800 (PST)
Received: from [192.168.3.141] (p5b0c639d.dip0.t-ipconnect.de. [91.12.99.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f269sm143800015e9.8.2025.01.27.11.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 11:07:21 -0800 (PST)
Message-ID: <f9c96dce-1fa5-4054-83d4-143ab6e2175b@redhat.com>
Date: Mon, 27 Jan 2025 20:07:19 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
To: Jens Axboe <axboe@kernel.dk>, Andres Freund <andres@anarazel.de>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Jane Chu <jane.chu@oracle.com>, Pavel Begunkov <asml.silence@gmail.com>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
 <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
 <6ulkhmnl4rot5vrywoxvoewko7vbgkhypcwxjccghdu26kwsx5@bnseuzrsedte>
 <108b6ae7-a272-482b-b3da-60f1fc6617ee@kernel.dk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <108b6ae7-a272-482b-b3da-60f1fc6617ee@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.01.25 19:54, Jens Axboe wrote:
> On 1/27/25 11:21 AM, Andres Freund wrote:
>>> That's precisely what io-uring fixed buffers do :)
>>
>> I looked at using them at some point - unfortunately it seems that there is
>> just {READ,WRITE}_FIXED not {READV,WRITEV}_FIXED. It's *exceedingly* common
>> for us to do reads/writes where source/target buffers aren't wholly
>> contiguous. Thus - unless I am misunderstanding something, entirely plausible
>> - using fixed buffers would unfortunately increase the number of IOs
>> noticeably.
>>
>> Should have sent an email about that...
>>
>> I guess we could add some heuristic to use _FIXED if it doesn't require
>> splitting an IO into too many sub-ios. But that seems pretty gnarly.
> 
> Adding Pavel, he's been working on support registered buffers with
> readv/writev.
> 
>> I dimly recall that I also ran into some around using fixed buffers as a
>> non-root user. It might just be the accounting of registered buffers as
>> mlocked memory and the difficulty of configuring that across
>> distributions. But I unfortunately don't remember any details anymore.
> 
> Should just be accounting.

For hugetlb we might be able to relax the accounting restriction. It's 
effectively mlocked already, and setting up hugetlb requires privileges.

-- 
Cheers,

David / dhildenb

