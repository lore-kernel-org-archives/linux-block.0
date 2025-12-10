Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7E322B61
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364931; cv=none; b=hwhCgrkJ0ZSsIfbU8DzsYVFnenTSyVlJBBuIgIpE6IOk1dtaBizccCT1z5chAV79wAo1e2l4Wwtk25+9mY4IHvGdXM2r7GRVCfNGf0p6gsMGys5VlaZ2X76oz32RHCRk320+xFI/aXIBwL8rm7jdbxu6V26Rk5+TDZGSpC7CwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364931; c=relaxed/simple;
	bh=xG2LKaFdeFwFddZxuqrbZWFjLxnAoxQlQuYXD8DlDXs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YSoZTnbZOXhzqdlkHdXKiPjvplzaCAHt0D7jh5c/BZdfYSNau/1Y5q8pV7wLueicS6lp7QUIc4OP6W4xGa1a2r0JjA7CbdY7gMr1BT13pE4GGhXe6dcm6Cuynqi0FsYWFXl7vaIoVEVmK6P49OhV1wqf3HLjqA8/SXXvfy37l7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+zxjQfK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfKejryJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+zxjQfK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfKejryJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765364926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbN0X68nlefB3xcMuCNuqErFYMQLXoas1dJiWtK1NzU=;
	b=I+zxjQfKIV+9HxtJsbtBhlOpBq5trB1y0DMZi6QLAN7QN4XFmTGwEYvKucuxVC+fIrmTIv
	WnR0JPbZKcuebmNP9fjumJdzL89ftHsj7Viuq2zPVxqFVJ5AhMZrFmSstgQcyM9JTQfkmK
	X41KhoNrlxdqEeN49wQMuhamT6ug8z8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-CSSN0KHGOAeR9BJDvwSWcg-1; Wed, 10 Dec 2025 06:08:40 -0500
X-MC-Unique: CSSN0KHGOAeR9BJDvwSWcg-1
X-Mimecast-MFC-AGG-ID: CSSN0KHGOAeR9BJDvwSWcg_1765364919
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso83428175e9.2
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765364919; x=1765969719; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dbN0X68nlefB3xcMuCNuqErFYMQLXoas1dJiWtK1NzU=;
        b=IfKejryJ40ndd8zIfiCV5P/kjAB1bxGPWJkArA3mgSn922aYbv5nomsgZm849hvvuT
         2aZ+7CdYCjWJ2wsgZCFq2u/wjv4QFddHuYYzH3QRpahA1qOKFLGD1fj4DF+daiyqlFZH
         QWKe1nPMjWWBnTd62vGD5KZZB+eotmguj5wpL1HGzec50CTNRACrmg9/4/CE/yOQ1YBW
         aA+L9mz8yfkkGwHTiAS4fihf1WEyBLdG7UL5E2tC/tvSmsms5+GJ1IXoKBAsRBHxn8tX
         ZaM/0IKKUxeULCadwgIhdG2r8UmOc2XEG51YKYG65SiTSnw0iBhe1TARYLckdqmixuRF
         nCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765364919; x=1765969719;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbN0X68nlefB3xcMuCNuqErFYMQLXoas1dJiWtK1NzU=;
        b=dobWqqUjRZBNkVTJ5+BFqCT4IFjo+XV0cxmZ3h8IwiS0jA9dCF9VuNrq8N/7SmXw4/
         xTs+gwHPA/SSosbnYT+VB/9gGrctXR0BrCgnjHx+04Xo74NV+Tn72fXevNAiEgrhVWNp
         25kLpWPl5wt8eoHAjGFTgDv5tzXncWKGI7DFqQAVGeoexcYlVEUresxsMlrtvRzWJABw
         DSye0hqmmuLJXpw43gddw/VlzzH4fLFd6Jkdva74PKSGnu8i1SwN4cX6bt4UF39SoOvj
         WYd8i36N0zPzjrBtz//x7LvXfzFPqOPG99cdJ2wvxx3QUHq/liQBw8/xK8cfiQKigkJj
         dorA==
X-Forwarded-Encrypted: i=1; AJvYcCW02JHe5O3TYL9JpZ++Yc2CASi6M2HpCYEUU3ajkRBmc7L6Ig/Zswh/f8dM6qUzEe9WuyufbivtAntMjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAl9adLjyOS0krrI0grR80MkRzUC0Gr4WJ3j+c5KOPU8Intm2p
	/9txb83S8yc/O7JYgNi03XmLW8CCztQDbQY2H/fsvoNhOAoWdhMw8O0aSGcCWGYd/xDjUTPFr9k
	lO6BsX3Dq/T0UZdAO3pOcVDEX7Cw3L/3mryn7a7A0EBYGSPOYUxL8DKY2r3mkw/A6
X-Gm-Gg: AY/fxX49B3psgCx+04LXG78TxGPBew66SYna++Zht3Sj/IwohBIynpA9o1rnHze+cs9
	UVWLiQJWtHJ3/EsY1tWjUppbT/B1v0VsI8ZB/KRNTQBNE7vh3FJOfNROCgRkcF8mELS3KvRVVh9
	hNHLyyQpYxY9XDlQPUAI69QUF3w9yz2P9w9KVq7Ssi1CSX975HxNqzUFiXiN6LWEOPrqHKSod2H
	2PNjfVqKZmnYE876Ed8nLvbGzdo0P0W/LSh9H+X63+Jxpb46D6gtohwR+R7fkvnAhbk8suNgwWC
	uibAGYHGwvXBM0jqeKkEfwlp024BOiDbfTzq6zyLnkV+q4ZtetHwjqJuV55dBkVE3hOA7DgAQY+
	+ZMGaYqpl/3o+h/GqlR2Mee4+XGoPW+qKsWrbyxp7Q5xuQWEWLuKM1CsIpDo=
X-Received: by 2002:a05:6000:268a:b0:42b:394a:9e3 with SMTP id ffacd0b85a97d-42fa3b00152mr2209760f8f.38.1765364919267;
        Wed, 10 Dec 2025 03:08:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0OaN9j3Rde1ToL7S2gPoe2gtnyWZiRtxW5eKFrQy2596pkXnfcwP8FxRZ0y1ST+KG1zmerA==
X-Received: by 2002:a05:6000:268a:b0:42b:394a:9e3 with SMTP id ffacd0b85a97d-42fa3b00152mr2209718f8f.38.1765364918819;
        Wed, 10 Dec 2025 03:08:38 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeae9sm37425520f8f.13.2025.12.10.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:08:38 -0800 (PST)
Date: Wed, 10 Dec 2025 12:08:36 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Keith Busch <kbusch@kernel.org>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Robin Murphy <robin.murphy@arm.com>, Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <aTj-8-_tHHY7q5C0@kbusch-mbp>
Message-ID: <acb053b0-fc08-91c6-c166-eebf26b5987e@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <aTj-8-_tHHY7q5C0@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Dec 2025, Keith Busch wrote:
> On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
>> got the following warning after a kernel update on Thurstday, leading to a
>> panic and fs corruption. I didn't capture the first warning but I'm pretty
>> sure it was the same. It's reproducible but I didn't bisect since it
>> borked my fs. The only hint I can give is that v6.18 worked. Is this a
>> known issue? Anything I should try?
>
> Could you check if your nvme device supports SGLs? There are some new
> features in 6.19 that would allow merging IO that wouldn't have happened
> before. You can check from command line:
>
>  # nvme id-ctrl /dev/nvme0 | grep sgl

# nvme id-ctrl /dev/nvme0n1 | grep sgl
sgls      : 0xf0002

Thanks,
Sebastian

