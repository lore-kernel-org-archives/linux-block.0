Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957527587D
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233378; cv=none; b=REGnl2l/X/YQ4ZSFXB4+7XGV8rd7A5c/TWBDr6G0madZHXzNjfIxe8ZaDTiuBUnzehH46hEm1kXp50It7lWsy/Z/d+DKTRU0NasmrQ0ZTTPunD68TpmpeVuf2Q9KA6EzZqUWAXBd+ZPAIyLMvIa8zm9/j9wYVsZkelnXrqJSBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233378; c=relaxed/simple;
	bh=q/iWue3prEhxHB5fYbkb2zeoMdzj4eaDLnNTKOQpX/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dujrITrQAZcqzqbGmrzZidwi6r57KzuuGBfdap0kFWFrryivMvKyeY/nqtqC9+2e7oBBxlG7lXqwUVeECCB+CJtHJUgMq01LirQqdU8Qcb6BbvJipdNyuHMo+1fkaql0qkHemKmg4XajQKMTYxTXUncjcgWyqyFJx522U5GcjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ejj3V7mL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/OqT7Yb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ejj3V7mL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/OqT7Yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773233376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q/iWue3prEhxHB5fYbkb2zeoMdzj4eaDLnNTKOQpX/s=;
	b=Ejj3V7mLUWH+eNJHq1QDxi/Q3pWohT90SEIOZXnF6Zl3wXg5McqClDe21HclH2D4pD9NUc
	9cip0Qume09s3dQkRt8Y1we+GJrKJ7Qb6gvuRBtfw819mC9JJxI+dik1UBBcVKhxmqdHHj
	cgD9BsDGjHRB44yLoK8bU4Jf/CRJ5i8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-ohMApYNMMe6Lap33LMS2xg-1; Wed, 11 Mar 2026 08:49:34 -0400
X-MC-Unique: ohMApYNMMe6Lap33LMS2xg-1
X-Mimecast-MFC-AGG-ID: ohMApYNMMe6Lap33LMS2xg_1773233374
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48534941525so36518825e9.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773233373; x=1773838173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q/iWue3prEhxHB5fYbkb2zeoMdzj4eaDLnNTKOQpX/s=;
        b=E/OqT7Yb19Z29HNrq0jfoXLr1xXZ7VPVP7xk87KHoii3ZgjjDtvf1O140U6anBIrx8
         1JHFbgA1mlPpqdWJnIiknoUF08ymZ4Rt9Unb9Ax6Pdfebn8/FKyNK8obZkltUFxSb6Zy
         S44U8aACTc9FTe3RrTi/4Y5Jzj2XiJBjOpVy6caNI7wbeMC2H5YNtoliareDnGmk80YE
         2thXGeMXhowVOiiv2Ib7XtLJpWyaqfthKPRjlC2wiV3HanbHQqF6IYCVFnsEEfNRqnjs
         Hfyma1n12RMsPZF/zk1R4jMxwoIr59TpWEfXf2pzFUDd8/ZQN2SiKjdONTvm5e5owaLt
         zRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773233373; x=1773838173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/iWue3prEhxHB5fYbkb2zeoMdzj4eaDLnNTKOQpX/s=;
        b=KPh8WIHbi4umfKyHaqj4PpXWh3fy29CbKZOz9VGHKtP5itToIoZFZfIErEk6aNb/WK
         8fUGCD5QuXLWaN0LqX2jvTc76XcQVqExR1CyNU0pLX64KUEoUdEjZQIjpdeyPbRgPYFa
         lJKwan9YQKC1Zlgh+66+atSnw3nLn80gMo1hLJmMMuVdaxYGEATeYoqkD7wLDMVsI/JT
         uYifXN6IK4YIiXb5EUmSrXTS32SiTGaJyqjpt4nGw6a1RUPl4QntLWAm7bxENQtmr7uQ
         i0sRRFlsi3qdxAn2Gs+EfhNPDFzNgN1sZ3Pef+kXwdwQZerry0WQ6513Uysfj2985YAX
         npyw==
X-Gm-Message-State: AOJu0YybPxeXwaocQwzqsq480IIi8s47oq/8ZrOvo2vvIZlUhkU59XTs
	1jNASSOR5IdCp667EopkCgmGzY7EjQHS+CIxG2ijJ2GsEOhkysHs8UAtYy+xRUmgVETv0hl86WU
	18rZJKPZop4Aa9EahGHrP1CcpMS2mcrG0EitsrG4Hy0Viwjy2zU982SzNIhROYTZ/4qYgMX1ozq
	BWDe9fKvmDb2gU7oTVVlJ+6WG8Sri8S7ElCFW6M2/d6DR3jg==
X-Gm-Gg: ATEYQzzdVyPs6yT2Hq8QXMS5/smIsVSSol7OV1Nanv2qkt1pNzQivjeCGDELEyo+7/F
	Np6PKHinlxOzKT3bKKRbSoqYx+CpyYMbboUXvQsqDGA2jVGrz/6LRFzTdeX3RTcSiI6fSiyHvT7
	RxL0kBSY2PpvBclXmUPEeNYx8VIvQdaJvm7yrtK6eAFWSNaZrn3yXzoK2fHJCF7+gRFrP7Atdoo
	P7n2Sy6EWF+3s0Qrc2STFaSArMnOcZD9z2Gm9+fS8J4OpSPv0/kI1GauGaq0pvl6uPnSNhFIile
	s5JxCrjpZ3MNZ6rz5NjLcbo8l+2fppX6swPHIhiKI+GzBSpR4FYQ1ty4AH+RhlRm22MwwTLABqR
	3UjX2pQwZFGA=
X-Received: by 2002:a05:600c:1f10:b0:485:3d00:efd with SMTP id 5b1f17b1804b1-4854b0a4a87mr45632735e9.7.1773233373391;
        Wed, 11 Mar 2026 05:49:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1f10:b0:485:3d00:efd with SMTP id 5b1f17b1804b1-4854b0a4a87mr45632275e9.7.1773233372830;
        Wed, 11 Mar 2026 05:49:32 -0700 (PDT)
Received: from [10.43.17.192] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0caccasm39463725e9.6.2026.03.11.05.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 05:49:32 -0700 (PDT)
Message-ID: <5b65b7ea-722d-4880-b853-fb5c720b5c46@redhat.com>
Date: Wed, 11 Mar 2026 13:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sed-opal: Add STACK_RESET command
To: linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, axboe@kernel.dk,
 Milan Broz <gmazyland@gmail.com>
References: <20260310095349.411287-1-gmazyland@gmail.com>
Content-Language: en-US
From: Ondrej Kozina <okozina@redhat.com>
Autocrypt: addr=okozina@redhat.com; keydata=
 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
In-Reply-To: <20260310095349.411287-1-gmazyland@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2026 10:53, Milan Broz wrote:

Reviewed-by: Ondrej Kozina <okozina@redhat.com>

With regards
Ondrej

