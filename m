Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA83B71DC
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352742; cv=none; b=ZANo3kEs4fgyi1YNnRXKeG1HWt6otvCxLrNCsCAg6mbqDT3yTDfdRHoVl1IecS+D6inC8yMcnPe7vIOtOQ63Ch1rGOxHVhG7Dfx0f/Nd1EBM5oOienhpsDPzmcJeaQJMmhVvEUzrL5M+vGThSxiJh93l1vmv69RDvU4ED8hHiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352742; c=relaxed/simple;
	bh=nAm+AaubmVJCxA/cyDcHaFkSO0RiDodDXMzyrjHbL/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYlVWka+e29qna9PTGPpo1kEupNaKKkcbSXyiZeyLT8TM3df5vFwwtCI9bsPTalogFe0c0dLW6TzVqzqHZMQFTkMv1u22ONM6ZazwyBhmIWAjf8M04kViBDpiNQ4MjEUUg8RUNtB6LzRBq7ndR5Arpjn0/C0H8smZqRm2mgFbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=SIDqjUjC; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="SIDqjUjC"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb9b427da2so47665a34.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785352737; x=1785957537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jqt83cqxF1IU8PaFS5z1qjSliqQHp1IdJNxNs+7YlvU=;
        b=SIDqjUjCR49oTBtR0Hm4Bu90IXFvjYyBYSldzP+nGgLqWbvvD4B5Plp0xihHmDx3Pt
         dkl3XWyb3i0datBmkdd2f2lC2H2MJwfQWI8l/RbGMcYsNzdc5HR6pxKh4IW9A/BF/qjf
         0WTSuc+8QWM/k3aNAea0OW7z0q4CXn79L+sYpoeQAeA75vBxi4l3LU0cynMbKF7yEZ8o
         MFUtRXHSCcXY7PqfZNHWtNv2vKWBcfMlUVAb0rzh07Qh9hHgAnQ8xuAFC01D3e9EmPaz
         cXoQlJwezp5WuCiPiHK4E2gyFlTsbKJ1p4XKuzQInanmbW7Q9aDMBjQgb60yCrG3poZT
         Txnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352737; x=1785957537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jqt83cqxF1IU8PaFS5z1qjSliqQHp1IdJNxNs+7YlvU=;
        b=E2Vfg+hkW4L/KLYgjEfib5WRc8e22DGXENLivq3lTdSvMw+62bCfScmE1thSdandaH
         yrH2WVzE9fWPJJpUZopGriOauFUnqUh3vSctwY2vGEuCxR758Mrp8T6QZu18ZrpyIPv2
         i8ZZ4dWA2M5/0rezPfIeLXARh6zMi5f5GMrKW7zhBoTWOUN2DIH2LPqnEpUoyDJKz6k/
         k0uAR8gBaqNhxj+qF8vD8tFtlkqnXG2Lz32W/a2W83x8PuOyobyLlQZPotFmaTrdh63g
         CO3MBoSGB6jJg/rDcKwzwDuAQ6QojVD9WQVhrPVHKcCUfQoqOYuRsI2p7eEkIgot94am
         ImOg==
X-Gm-Message-State: AOJu0Yyrq35JyYafh/yeFVQ2ReOkCn+IeuadiGUrDVK0qPfUaVhoq1CY
	USaRgMKbU6cOZ+O4rqTHb/40/dZBCeW3PvrH3ExOBE2q0kZBPMkv8oZTD6FOxJToydA=
X-Gm-Gg: AR+sD10L/NJ1omuZJHlkUfV7RtdVivOcBbQkI91CoUoQHWlE7yDMLpu/xidPTj1TqH6
	p2g8WaNphP1G4khgmKjAMEkDDgYKPNnQqt4Gz7/FMr0hYwVmtOc0BDN/AhGH6bcTo8Td34/36F8
	A2sFYc6Xkn1d0R5GPVlRORhHz+DityeWpLIEZGWyxVSZN60wCsd4bq372OmtpEjWQKrvB5hkDW2
	UG0gYgRvUNp6PuMy9BWSIzSoZKP3G9rRU+auHPTug15FEtr7gTsYhxNn4+Z7pDbgis5UQNDKBXc
	3zXEcKQd7Pp4cdnDG0LKP3kEDssvj3KHcbOXpkn+DODQvg9b4UUFGK0lxt03JIb2hU4md6e+NlN
	XIyPH60tcMdX174hly658uPY8H/fa4BjjKEdwtYfG+/DtnM+137JJBjuoPtJG4kwiSm7ap/Ug7R
	I6VE2E4AOE2sPFNjjJOQxEmKVCYXGRoQ5iYbLldiS/0HQj82Z90wn0AmOK9MmS08U+pXmHE01az
	r94aX2UqRPwVDw=
X-Received: by 2002:a05:6820:160c:b0:6a3:d8af:6b89 with SMTP id 006d021491bc7-6aca9962397mr1376206eaf.28.1785352736967;
        Wed, 29 Jul 2026 12:18:56 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aca528b2b7sm2488573eaf.7.2026.07.29.12.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 12:18:56 -0700 (PDT)
Message-ID: <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk>
Date: Wed, 29 Jul 2026 13:18:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@lists.linux.dev, hch@lst.de, brauner@kernel.org, djwong@kernel.org,
 viro@zeniv.linux.org.uk
References: <20260720201057.1862857-1-kbusch@meta.com>
 <ampRQyXDbGgeg49V@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ampRQyXDbGgeg49V@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 1:15 PM, Keith Busch wrote:
> On Mon, Jul 20, 2026 at 01:10:52PM -0700, Keith Busch wrote:
>> This addresses the misaligned direct-io problem behind various threads:
> 
> Hi Jens, have you had a chance to look at this one yet? This addresses
> previous issues with certain device mappers under direct io.

I they look fine, but at this point we should toss them into 7.3. Yes
I know there are regressions around this, but from 6.1x days. And the
series doesn't apply to the current block-7.2 anyway.

What do you think?

-- 
Jens Axboe

