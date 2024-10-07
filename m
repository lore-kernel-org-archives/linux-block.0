Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED171D4159
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310003; cv=none; b=lHHwLKf6PtbgS4F+BtlmL1MriNKX9FhGMs/HYAkBUFZrr5+V5hkcZgWMRwGRq+8Hwu0kNVARzT9Ps8YcgDD7wIvTZbq1wYe8TxR194XPXIGcMJpXTjM+2NqiQwYwG5W4RHk/2wCbshbEwje31qg1hjjBkTQe80c+Cn1uru0u23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310003; c=relaxed/simple;
	bh=Zw+St1S3HaAxdhlWUH+h4rGhg6ZNujDpbcI/dBOFtWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DL9OyUEt0tzJQ3CUAMkmqKHzo1uy2Ze/ZDFHITyauz4xD5NNdkuxhzUNbzdr9J1ew/MJRXHl3ROgrT4CVkIijcTYCBtLQYel0yt5onp+E01ONifbijIbMJj6sfBVPeQXxXbVVn5sTimUKhZk8Fo6RRVhGUyo2tQl1Glxlipsjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bU+lCWed; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bU+lCWed"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a344f92143so23922455ab.2
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728309999; x=1728914799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arIAYxZz47K33aPWOj97XFx8obpL/OetnzHlDezlYuA=;
        b=bU+lCWedMDwdj5QCP1ObpqtB/1XD7PA+l/PG6szXfoZrvwagAp+qKSnGWFhCOhIXIQ
         LCdX2+LVZCT398zbZjF8KNJ8yNZqWoh8Egms7pRzP4QuYk59e/NltUDIwWy0Xa54+j8K
         JyJspPq3B3j6xD45gvnyoBs6/9q9Enpe7pn005EPEWkM6YTYFkCQ+e8muoYV9O+Nomg/
         S8TZoKenWuKVXv+TM3QLdcxqPVEpBRJXpBqEwUnOzzIIrItEr/cT00WVjfrv6xPbwrAx
         iJmVQjjIvhx6Xd3OpH3ZtlVY7Z0HXlr7DMU4+24O2UAuiswoi7xcA8u8wybV4nOg5vnK
         qzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309999; x=1728914799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arIAYxZz47K33aPWOj97XFx8obpL/OetnzHlDezlYuA=;
        b=mow9pS27UZqZldfoAglOoJqUrsDy8ulgmtG57JyGBefrK/fAT2T3r86QR5hGn6Dfkk
         2e3jFNGtkc5tbjrWDPOQMOxxhl0aiXlCJVzYCx7kELGbzWJrH5AT+GOqwPiKaxKbliUU
         Po1e6Tnmj+JUnmnpq315Pv9Nme8Zdu1RIa3XDnZQRY6WFWnTMU6ZAU+JBzcZdFlr2ZfR
         l0qRdNJTcGuINilxu4Zraw/dlD82uFR42+dJglfVKB2w2Wbj44uC5HxzOQfIDIXH0iou
         P6NPHRrPQ8oB1c18x0DXvBHVhYRJyuFoWqTpLS2cyV/dbrboScpsOwuk3ae47M9+7H2t
         uyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1wv3mJxQAOHs/oz8kCnK9ysXXVWTbYj0VlDazf5DD+XTXb1ixUdGXK1avqPA14BRxL93XwGWx+OQVpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4brOfUIoSQESUus9Ux08XRN6vGR/piW6TT5o1ynt2Y6quHmRR
	oHSKT3plFw74W4M2wfmJsaCkBCJ+i3FhlMgOwTe38Qbshi5O0kFMcTfy+WUeRGI=
X-Google-Smtp-Source: AGHT+IE0SDKK/K6oarl51Emql91aqyRs3ALNWJUsBG62flnxNKu2kKU6oH0gk5qHRo8SHwY8bFz2Iw==
X-Received: by 2002:a05:6e02:12c4:b0:3a0:98ab:793e with SMTP id e9e14a558f8ab-3a375bd2bacmr92249655ab.23.1728309998917;
        Mon, 07 Oct 2024 07:06:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db8544f2d4sm529400173.6.2024.10.07.07.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:06:38 -0700 (PDT)
Message-ID: <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
Date: Mon, 7 Oct 2024 08:06:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Still seems way over engineered, just use an atomic_long_t for a
continually increasing index number.

-- 
Jens Axboe
