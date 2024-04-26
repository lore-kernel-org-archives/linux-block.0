Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34376147C7D
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138893; cv=none; b=dlLRIysMeAWlQ667UxIXLGdkCrEn3Oo6OnWV/mmkkOkOUa6D/hRdHjzOEe6LBFmlnaf9giXR5d0VAJF3Rxl9bRdKk6iAv3cugyM7z0sKkRD8vfwBqr4iDLQtEJk1BE9njtr5VDfme4wigh1F0qA3fCzTyaXp/WTFq6l4Cr7jVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138893; c=relaxed/simple;
	bh=F9fl+qAuKBl8c5dtpUksdJ39HtNhjXgY+f1Jj+R/xJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Loq2Kn+i8bq7LZuhE7kSye+t0n55uoT5t8nspje+Fvd51M+/2eMC4An3Vy2M9R0UI86O55lWZu7kQRgqjd47bNHq3QcFBq2/w2yqI2EE1LAKnUqsyi2m88ACeJ4bU6Sx0tQWg1flvhFXEpK2mzNSImGUZwrCURPnABL/6iVVHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iF6OT+A1; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iF6OT+A1"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36c2cf463e3so484745ab.3
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714138891; x=1714743691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MW5P3eh5immMHhpJeOXdSmkE8R2IfZGDz7ZFESxxerw=;
        b=iF6OT+A1L8V7FDrNcxEgIDnrS9pDur95aRXH2K9d7LenNwuZJKw8tg0HhN55tW7Glu
         PlGD4GxvgLoOL/cj6oz2gitxe3G9Yq2arpuJf3MjHXmiQ83Pf0q4Lf1w0snzmXldw73z
         ghfVuWbGMeNciCivMOgQ9PWcDuMWlSNLWa+WcZU5EGIzRFMJYJQnM+mbMCoAOY0JXDnD
         p5Gl1pF356EyKhnKMn/9djXKJiT6+OyQBvDp8oxaAJN/WyAUuXpwAhoAWjqLLZjeq8sb
         ghmC8mYURDGYdeGnFnFNnfkjdftaQH1KWsOKeKTDI2b35XoSacfmFJB4bhXnYd2yttNp
         DIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138891; x=1714743691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW5P3eh5immMHhpJeOXdSmkE8R2IfZGDz7ZFESxxerw=;
        b=YBbqOTaeZVRr5ADWO+xp9WTckYtTdRTriJDDYmEvv8R12jbsYVkijtpqGWsT1j4kal
         FBOu0M/+pTO7YTQhEvalNNjiHKqViwbclLQqvzHY8rDT/PTkIe0g6eiyGA1YxXI8aCPo
         sikp1cACtIPc8EohPDtXGsMsAL3M1wQ4lZkpuGvE+lr0pmsqiINF3dgblwwZSKo5zV6I
         Fhi3AcQWejIpyI2OaLZ8p3yHKOVvL6vCIUIYcPt+VTb/Q2LmsISsnNnoXGHUL43wVDqO
         YG4PBn+E/fRhKH0zxRJX+TerhqH1qgiqiCep9C+J9zs8YW+3vWpASgkmGjEDhdRNPZuM
         pDUw==
X-Forwarded-Encrypted: i=1; AJvYcCUqOb1ByonMdmOcu3vgy+lETlU+rzGSuCpr78bIhu7cfdVSytF56j8ReweZ15DSY/fSRghhYf/OkTHNVZr2eU1Xzg8RIqG19n4D2S8=
X-Gm-Message-State: AOJu0YzXlPxUtzxsBTOkTB4FUy6+kYQKEz/Jb0qd9GyFUq0mlVf2cr8o
	DW7LIsIHNn4mA5GS9JWYlAKeACdb1xrvbfTNfZuSNlQqFhyzBS0BtYhuPfgqd/4=
X-Google-Smtp-Source: AGHT+IG8rjUV9ghcwA5zGDKApvtIXKb9CN/7dGdnc0TtxIUPvQYJy77pBAxJ7A1PH3Zn9gWbXK3KCQ==
X-Received: by 2002:a05:6e02:1fe5:b0:369:f53b:6c2 with SMTP id dt5-20020a056e021fe500b00369f53b06c2mr3275503ilb.1.1714138891168;
        Fri, 26 Apr 2024 06:41:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x6-20020a92b006000000b0036c01d9ae12sm3259904ilh.46.2024.04.26.06.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 06:41:30 -0700 (PDT)
Message-ID: <aba5fed0-9f0c-4857-927d-d2cdccf8ca88@kernel.dk>
Date: Fri, 26 Apr 2024 07:41:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bio: Export bio_add_folio_nofail to modules
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Sterba <dsterba@suse.cz>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-block@vger.kernel.org
References: <20240425163758.809025-1-willy@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240425163758.809025-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/24 10:37 AM, Matthew Wilcox (Oracle) wrote:
> Several modules use __bio_add_page() today and may need to be converted
> to bio_add_folio_nofail().

Confused, we don't have any modular users of this. A change like this
should be submitted with a conversion.

-- 
Jens Axboe


