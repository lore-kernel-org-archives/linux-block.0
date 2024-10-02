Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977A567D
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881214; cv=none; b=Di2pI8tdesvXrEk67c8JwGjxwwDWjDvTqquZU+FGzGAc4t2RvodnsDUhGyqzL3NILR0KlHFWxdAKZDiA9rkHOU1fJbXZvfmtDqOD0zzaNR0WuIWIUk1E7dD7/nM4qj2PIohisZCFTMISWCg2+IYtEpmeKpz60meR4tQG8/IjWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881214; c=relaxed/simple;
	bh=vl7wyuQQoK4XYBeXABxAwPJIzjHZQ1aU5cX46VnQpKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnSM2piZBr0/xDHdDup4MQCVXV8NeoL/zbT5zP/P+KaqYtK7wT/angx8GVK08VRI5wEOymJbFwFdJTb6b4nVRtF8SdyZLPNOb1J7UfVEANOqiJixAOnJ7e4/MRnbQMRHHegc05CXh6dVRAwSvEc2xk28MJtmI3ICBhzC3X7+6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IiZlTaLY; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IiZlTaLY"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a1a22a7fa6so3628875ab.1
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727881212; x=1728486012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ATO5nzXBRKuk5zIyka26b7+2X+oqvRAeNDNerUiZPQ=;
        b=IiZlTaLYj714KdThD/EflxMCjc5uKOh5DKebGte87JmacTiyDGXsPPN7D3PJvdyO8q
         JARrPVJOad7bJWNJPgHGtwxJf7eI/FDg2/SnWZ9mV/cHF1XNM4fJ4IH/YFhXvEhqj6N0
         4Ktcn714j3DiTxMy8Dtl0fb9TU2D3gOw7hsb/Gko0WQHuAmR9sddq819jAnXlA1vE5sF
         JRdwgRZ3EFhgh0alCdkpMYZvu+/DnDgpsKyCcQZh1xm3AmN8wy9fxDnyE+M407Xxz2eY
         37LenNAJ9SZkcLJAm0CC7eBcVv0Y5ke1taAan3PqWldz/y5m443l3U9K+eO2VnWrWbmk
         Ssgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881212; x=1728486012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ATO5nzXBRKuk5zIyka26b7+2X+oqvRAeNDNerUiZPQ=;
        b=KshqXEmwSH8+BuIHJPRRzaUqJx39t6mpoR7qAhXh3vRhZ+wkSKPQ6tbwHOBPrahXF2
         os3rJ1+GHwy1vVgFunRy6bMftbymb+CO41N3HHM3Eo5fjE+4DNTNSHJis5X2gEH50Uuz
         XOe7sD0ENwRI4oYoFo9ZlwMFwOlt+INOV/Ke+woFYUX+rGLeMY1F+uGXg00fYBlFFL2J
         iKxrnYvmnygfrehp1FVOCEKh9Yxod+VzJ9UZDh6XPZjBJe3j8yu/0IpX2RELdPmBOTv2
         P8Fhf+qKrvYEejAdoH0XhIEpnadJs9C3BqQo3vhAWnyLjhMDoeL/0Yio3krOwgAQo9Ui
         e/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWARY0mOD3SVtGVjXDEnh3OdwzCqVu8dqkWOZdtOywf4x4U7kzPOthpQ/Q8ruU46x+Mk8qLoPfbvi8obA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnf2WjPNY2azaNLjK3ZSmmJaA4Z0YCSJjnC0OyH4WQYZCNT9v9
	8yKesnq4n4F+NraCwx31AAQZnI7BAvpjzz08VR0yTI9no4IWQUhCAiPXKjDnH8M=
X-Google-Smtp-Source: AGHT+IHex8HS6m/uMgtGBHqHA7E/dbDjbWiTPY1GdyYsbd449LVjuZyZTpNsMhmhRF47klqBZJ3/jg==
X-Received: by 2002:a05:6e02:1a4c:b0:39d:3c87:1435 with SMTP id e9e14a558f8ab-3a35eb0211dmr53524285ab.1.1727881211298;
        Wed, 02 Oct 2024 08:00:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9d33sm3158793173.163.2024.10.02.08.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:00:10 -0700 (PDT)
Message-ID: <397fe31d-413d-4ef7-ab56-0a7b3b51d79a@kernel.dk>
Date: Wed, 2 Oct 2024 09:00:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
 martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 bvanassche@acm.org, asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
 <ZvwiD0v3ASF8Hap2@kbusch-mbp.mynextlight.net> <20241002074926.GA20819@lst.de>
 <Zv1fC3qYVDfxn3lQ@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zv1fC3qYVDfxn3lQ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 8:56 AM, Keith Busch wrote:
> On Wed, Oct 02, 2024 at 09:49:26AM +0200, Christoph Hellwig wrote:
>> On Tue, Oct 01, 2024 at 10:23:43AM -0600, Keith Busch wrote:
>>> I think because he's getting conflicting feedback. The arguments against
>>> it being that it's not a good match, however it's the same match created
>>> for streams, and no one complained then, and it's an existing user ABI.
>>
>> People complained, and the streams code got removed pretty quickly
>> because it did not work as expected.  I don't think that counts as
>> a big success.
> 
> I don't think the kernel API was the problem. Capable devices never
> materialized, so the code wasn't doing anything useful.

Exactly. I never saw ones that kept the stream persistent across GC,
and hence they ended up being pretty useless in practice.

-- 
Jens Axboe

