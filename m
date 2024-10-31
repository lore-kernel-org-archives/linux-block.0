Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF213D886
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382078; cv=none; b=Tn7eJOJNnctWBVbghRZfcwkkCxEWoXnn3Y1nlXKKSsGaBuetkdNWGRVTPtB4N1v0rC+X+fjshjZQCACxxxZhD1XsxDTbNmjBGjmbErAocfon60LZBY71dHlmjZ7NMOGHgSx88PLXsWErxVXR6wAt5pFxiVc41sSzydfWofBYDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382078; c=relaxed/simple;
	bh=ed4Wg7ChDp+fa+eaplrqu8BLtGjvIfigzQcIm6tTa7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVtCp3av4CbjBAYLQ9CGzko9ZqJ1zZtQJS/H9H6ADdhP0U2Nm67fd81Fj2TBqy6uoJdpYq8423A0MP41HqDzc0vup9Gaca8ZTwnQn4/a3AQu3Sxfr8hQBXph9LnVfzJlKOjQSSBX/FGfVhE9eyQMIoqtT6z9pDrPyqxeRF3Mq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YEBIQzIA; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YEBIQzIA"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so36545739f.0
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730382074; x=1730986874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOOv7L8MC3OxOQAoTZDTPbNBXSiL1IilKh3Z0BAr6cs=;
        b=YEBIQzIApW9YWoYYLpzWjtB6+yV0YOlzZR9PMMnlYgsW+RuSVurrXojdjYEKbUD8Ld
         waymoF3o4PiDZoCmsG9Yi/6xpHZbZUHEHSGu/pmc8YoQjRpE18zGHT6vB4CmZxQ99f0i
         VZepGi3CfW35+h4O0kqW+fRijEOQ8l+zORLA9lWNDMjAvPfrIYnZknvV7ujXqLDyYPDW
         AML085AwU7jfUFmhnOxBeWOUln628+tHFJHXKTCXQu668BWLDcFvA1QtqIe6hcAsdglV
         CM5qtYoNsK4vi09dy3hRYaEySqH0CSFDhQbPgcpnlQPNc7HIwTMHbDahG13Zr/lXsdOI
         mqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730382074; x=1730986874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOOv7L8MC3OxOQAoTZDTPbNBXSiL1IilKh3Z0BAr6cs=;
        b=ocspqV7N9nu2u1l/60KcW9nMo6rlvAq4NKiYhCvRCo+8HNXej505IIllIjyRSU1ltc
         FmmCIcdWwcjCl68Ku2I3c1bsAKeaj/pR3gd89ElvoFu9bFsFgiCb0ipZLJCzerChBILG
         QQ+d2fuuhirlP44d1bBvH/GRgDsH8GubJooDX1k3UTS9UoT4nMynVATblo1bfrJaXYdu
         dcVL3YhopiwLPoagoPiPnFPirnc65tgt+a8EznEmDoMJqPruUVvK8UWQJoRxobTy3m30
         /h0mv04Kf9QetsDIQyXPks2ced/Z0ipN1qbAW8qRI6DCfc0rAIWKedTQFxMeaM/wkg2c
         jaGA==
X-Forwarded-Encrypted: i=1; AJvYcCXflL/GPUGI/64jvKTjg0oSfEPk4lfCjD0LsxwGjJ9/mNybkfIBfx6XXK3CjDFkLoKrA4NMfikcXdcTcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmuyKx/EIF5tjCMfETE3b7o0F5D92p/rwyS18nV/WJJZEdo8cm
	O7QMo0wZ34LyZ6EDcWnq87o9d+Os70QyExkYNoKa4M2rzVszGs6sKpeZNnQE6K2umKrPQfF/eZV
	p94E=
X-Google-Smtp-Source: AGHT+IFD9f8m0t3EDdI2rv5j+2TnmpO0owAD5aAGz6xNqtgVHHPs9zv8DISUeJD4d5VNPtmD+GtTyg==
X-Received: by 2002:a05:6602:2c8a:b0:835:45f9:c2ee with SMTP id ca18e2360f4ac-83b1c3de174mr2047846939f.4.1730382074510;
        Thu, 31 Oct 2024 06:41:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04acaa42sm291187173.179.2024.10.31.06.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 06:41:13 -0700 (PDT)
Message-ID: <0f78ae82-73b7-4665-815c-c2f9f85e4b8f@kernel.dk>
Date: Thu, 31 Oct 2024 07:41:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/iov_iter.c: initialize bi.bi_idx before iterating
 over bvec
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Klara Modin <klarasmodin@gmail.com>
References: <20241031110224.293343-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031110224.293343-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 5:02 AM, Ming Lei wrote:
> Initialize bi.bi_idx as 0 before iterating over bvec, otherwise
> garbage data can be used as ->bi_idx.

For some reason this wasn't on lore, so manual reply to say that I
applied it.

-- 
Jens Axboe

