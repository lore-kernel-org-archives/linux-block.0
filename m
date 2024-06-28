Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADA7BB0A
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606956; cv=none; b=dpmwR6s9SwS2VKNozRCHHERlBaxlyKIOqiyo+UGPzNE0JS24s5iwWPgk7wcwcob4YrNHnU5Ufbp7GLUeW4rh3hM4DT0QuS4DU+Q3UoHDPnJL/lVJvUxId0EVbwgz3X5/6pfO03HTOgbiLWRcb78z0HioHtzEbeHym/DTiQIJEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606956; c=relaxed/simple;
	bh=2nK2ZjmuMglhk0yaxdHKn3zTOaIl4xSOLewXX/lrfIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kdj7+7XVbgNuAqHKd0wvmZ2Wxr1Cu9GQLzTTeVVB8ieYuznEyukQDduBozi6gAMuFl6VwDd2OpexOwCxYG2Ewv1urSymgZhUM2N438bPgSV4IHVfRDzYPX+PR40q3vT1xom/ZrYYc3p7r937K5gjlCKDTe+4mn1Y5fCNKsj5n44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZdWNNS6Y; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZdWNNS6Y"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25cb022c0e6so140125fac.0
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719606953; x=1720211753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knIuVjnXEJJ+j66MeUZ5fq37co54uOPBN7W+VUSdPRA=;
        b=ZdWNNS6Y4sWEegiSiVGc+tAC0AXgr2h5kIPlCVj2/VdKSAHWccBtYJ0RuCqz5arL+Q
         p6HNY6osXGaFmV/K5vybhFXfOapRAh+iiaMO1CXfJO+q92g5QNOUZfN4g4e9SP1W90PN
         CIbNVv2llJlmPJKBUGiGLnJfNqVmNO4tm2WMYdhMfsI9sjWSapkt6/iB3VrcZKlLK0Is
         zBi5lvOHH9EaL05V5J9ug7wqtVGhrqbsdkxWGs+bbaMeB3hVBuqXnK6zR9m5DV0+EbIZ
         1Kfo2pO+4xNkDvZnAtNcvTSR6nzWkZns1KLjAiYVEd+X2u3bjJhg+JbQrb5Feh5stQpp
         OJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719606953; x=1720211753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knIuVjnXEJJ+j66MeUZ5fq37co54uOPBN7W+VUSdPRA=;
        b=AgMqKMxtc70KHzhHjTKqb+CYjse6EeeHJ5OIc0PSuIXgjaEcareNxNDaZ7bO6bMn02
         ZsiZ4gfdkcDNaqy7wqGeOA67B8ucQimS+hOt3UWaC870z6A0P+xBU1D7pzvhSUNQuNJ9
         V4sDKbzJl2Vcfd8k6nfcTpEMwoQE3Z0dPoemzUfPQH/tbbCK/wnaWCDf+SfE48pEsxdL
         U3dPXT0PaXKnhR+wQUNYJ9YStNoWG0i1ohihAcXr6EShRiRctoM0alW60JiqKe/mRVAq
         3eZKea89kHrgdMHe2KcybeVDVX0S6JrZXZVajpYMuS3HxeEcgigKBC9YW4MapZcggX1+
         2V5A==
X-Forwarded-Encrypted: i=1; AJvYcCXQbcDwr7pt+spjeJ6HiJUIyFswEV9suM8355Yd0QmZ1qu62eaSFR9Gt15GCp6kNOsxyFi4gTZ8UuGpatJk19ARhwbCYXbGXTu+RjE=
X-Gm-Message-State: AOJu0YwX4yuN2tpRygENZ/r1x7ET5wiZ1mBisY+lH5TqoXopdZc6T/X+
	pFR6WWpBLgcZxG5wj73zDZi0U5kRJKLEUJ1XNcv2Ng2y542ohrl/VxGm6HtjtaQ=
X-Google-Smtp-Source: AGHT+IEb27cDCyXqmGni9JEqeFfVr+iPwZqfQQ0Azcu74e0UA/6M2OvYs4xelVHD0QGZqahyFDcDGA==
X-Received: by 2002:a05:6830:3d87:b0:700:ce5f:968c with SMTP id 46e09a7af769-700ce5f9712mr10578115a34.3.1719606953383;
        Fri, 28 Jun 2024 13:35:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7a98f39sm438118a34.3.2024.06.28.13.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:35:52 -0700 (PDT)
Message-ID: <0d5d9177-8e3c-4ee2-8a77-8bcd59920118@kernel.dk>
Date: Fri, 28 Jun 2024 14:35:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] block: set bip_vcnt correctly
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, asml.silence@gmail.com,
 mpatocka@redhat.com, kbusch@kernel.org, martin.petersen@oracle.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20240626100700.3629-1-anuj20.g@samsung.com>
 <CGME20240626101513epcas5p10b3f8470148abb10ce3edfb90814cd94@epcas5p1.samsung.com>
 <20240626100700.3629-3-anuj20.g@samsung.com> <20240628060444.GA26351@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240628060444.GA26351@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/24 12:04 AM, Christoph Hellwig wrote:
> Jens, can you pick this one up for 6.11?  We can't really trigger
> it as-is, but it would be good to get it out of the way and avoid
> someone else triggering the issue (e.g. Mikulas with his dm-integrity
> work).

Yeah done - worth noting that patch 1 in this series is already in
my tree as well.

-- 
Jens Axboe


