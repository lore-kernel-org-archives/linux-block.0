Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AFC19D07B
	for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300082; cv=none; b=isKK3p+oG1wq68vePpF69ouStGR6mJ3RD79PA/ycPDsCIiuqTPqZ2URUfRM5r0RtKvqvDKJj/mDZ2SELo9TZ6KyuLlAsmQE19Wqgbo4pZu6qY7Qu3WpOKyWhLEYxrkCwoTnU4qKAux6ugTMYXTdfHxDO+MbbERflAFzCYI3WG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300082; c=relaxed/simple;
	bh=0XOOewemFS9VXTcTHe5/CMElWD1zPCipCe8NA4Wxhuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIkgvcOuFrZa92SWj6E5KWCzhvGMLNhcJUD1HDdsIrNmJbAzXyYNEN74B4XnbwxHf09lL0ZpsPvLztLFYmSybW4l3O8nMgoPXkdrnHloKubApi4ZsbQ77yZX8HDa8s2hcyTGZgiDNS8mCYuUBlT60eQFK9uPYtW8S2yWYSK1+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U7BRF3SM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U7BRF3SM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235f9e87f78so3641455ad.2
        for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 19:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750300081; x=1750904881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XOOewemFS9VXTcTHe5/CMElWD1zPCipCe8NA4Wxhuo=;
        b=U7BRF3SM410K2AdRZCSdzpRg4QxiZkElYq9jnA10Di/PZtCsTlpVzdnhzBwxI5JzSR
         aPeAC7JBSEn3CRsZivD5YXLrDaFi8A1W2rV0X/j3u1K1SEewQ+nF/6jI2HnJjSUychjS
         clJnLYXstwlBxctOoyUYefNWE5y55WFSFVZQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750300081; x=1750904881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XOOewemFS9VXTcTHe5/CMElWD1zPCipCe8NA4Wxhuo=;
        b=SS8tRyB4ATJnpRL8G0RxcHx/r5k6cfy7vj+Iym/tKpcaacG3fYUQcALlnvS+bRuYi1
         rlVr4tN0pSUyBm8sSgN79VLmD0gtOmNAsOSWM0F2Ur+2wTmyNtI+bGngBjz7P+JRBxuc
         88lBN307ny7DFDe4adZRgUv3mrb5w42CsY7mwd8rVvd8arpwMpuZIkJeA+z4VjAxwN6o
         6daX7J7ttKrYyWqpj6QRIvmLYRDYdY76mMz4esE4af+UoVBNobHVlYLxHCP9LOIrMEz7
         Vubzwd57s3id8S2cRQmhaF18u4zFW/uMQ5bFjayWacy9rrzSrOMa75FiHC3c0zOqr8Sy
         8nyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwPZnOa+MgPoKsM9bSLuPBOqsvLXDyrI6yFkkup18ZVamdvWNnHvWMFnJYXoFskWGr3AGgfalv/squwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwo9NHHBDzVUbkCawNkRqsIEIttGxcAnJY2r3DVg03CO+fKWb
	vk6gbI3ZH2VeazRJcbGjnwOQXqM+B2enQWZn63IfTIWzN088kgnESdYp+7bjM8wtCQ==
X-Gm-Gg: ASbGncvxjZ3gRqd8rexyOI1Ps7a0UwkIlbXGoOZwEfRzxAspq2GJxBSLVXDSHFQY9Mm
	j5afurzXMS1BBY93TU45W78Y9+cqOm3Bk2pMsq/OZ7gFZWS7MuUAoRTJNxFFWQY5tCm58D6oPqs
	pqT6JLHyiEFCQYx+NHa4CYW9eb3v5B+im0LPeH3dVTVHZMYX9eHaOrPA7EHm1+BBL8qeeHcBR17
	wwogTOSGJlHk7YYvSXanA0OyVk2kOeQlb6ZPT7uUw30mwlqE1UOWp+XZx14Ykbglg7sGjvvNbpI
	d8qakJt6ej9y2Q11IEvPEJq2sVild5K2g1f6zU0QBQRdBMJoqF+uWMl2SacllnwCHvB4ds/fRBQ
	h
X-Google-Smtp-Source: AGHT+IHpEGqZGS9BG8qulg8tyMvVsra6tzb35SteIvB1BAFzpEhaq02ChtIgyrlqAUQXPx033jdj5A==
X-Received: by 2002:a17:902:da85:b0:235:ec11:f0ee with SMTP id d9443c01a7336-2366affb250mr317976015ad.14.1750300080860;
        Wed, 18 Jun 2025 19:28:00 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2366e4e7842sm89401965ad.62.2025.06.18.19.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:28:00 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:27:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, bgeffon@google.com, 
	liumartin@google.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: support asynchronous writeback
Message-ID: <n6sls56srw265fmyuebz6ciqyxqshxyqb53th23kr5d64rwmub@ibdehcnedro6>
References: <20250618132622.3730219-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618132622.3730219-1-richardycc@google.com>

On (25/06/18 13:26), Richard Chang wrote:
> This commit introduces asynchronous writeback to zram, improving the
> idle writeback speed.

Can I please ask for significantly more details here?
Justification, rationale, testing data/results, etc.
