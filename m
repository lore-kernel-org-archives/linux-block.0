Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71B1EFF93
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085304; cv=none; b=hKu9l1g3yGyk9kG+bBn0/FZHpINA9IrD1/lzvc0hDzM9xLY+/8umJO/XCZ438CQVinQmfQmLEFGmW5aG4XnQrYEziSpX+4rrOVqkyjDR/X97b/U27OQ7pXpb3qx8c1NMMntSHn00OsDdSEAYqHoyHi4hApn5KaA/3l3iwg7yPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085304; c=relaxed/simple;
	bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGMJZ0OOWhiigChcCZnK+xSSVqMwoN+VWKygy/CNnmL1H9wJu7YZFFR06kvPntfXlYgZGRmnfjQZYyb+4037VIhqIveL14+nwXrGH+DYHH6Adcihvjdi99e5O0BcUkK8Wc/yjTPoh2m8sZPmKRFkwPwQjUW/YYJbFcMz/5cNlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv8HTK7q; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv8HTK7q"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dfc6be7df3so3558143137.0
        for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767085302; x=1767690102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=;
        b=Uv8HTK7qjktLHc0cgnsvJu2893x2Vp/xh3BrR1bKSPPAg5OD7lUyCAnrm3OWA0NZpb
         ZjmeDdjD9ir2CC4hGefLDYxh8swzzFC4Qn4H5v9eI8KjUGps3FZfnS3goGEjwkSsl8cA
         bs6OE07/4xALgmS1S7OWI/GhqazPvMbWv5K2N0NzeOLCEcZBIGbVqkvbv+NOKmaVe48f
         gF+2BTADqvqU38oqu2fM7zZ1gnfbNTq7Mv8JC30WeCEcdVmadtw3UBXAtUcmZAEvhs6H
         2/NK3SZ+iVqNCmdYTap2UKvZPkemWukCYepYMmdJzrtm9BJAZhHrjp8G+pGxx6UIB19w
         UfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767085302; x=1767690102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=;
        b=OY5ZZAvuLCJYd3QYQL4JgTqm2SvB5seCcgSQhvfjyftPxR4OjGgYHc0Rxiom7gJe2w
         b8DZBQcHbVy3Ol8EOjwgzmbZ1aqpPYgD1HHKJA2GWE0fj74FwW4u/iSZcYlmnEJEgHwT
         52gkLZcUE2WNYyy0GfGQW69tbapM2nPxY4YofWIM3rtTQHtZzaunW8SPYMf7Ec7kwaMt
         vOGQB5gftuNbA8XSiM55UbTYDEHBF+AO4Le41YugQoPSmzUX1R7qaqqmJtYQO9W0ptNn
         KaqSmv+owROuU8a4vsdn/TCG022uffCoA9aKge1BaXoNLnFUPrKAoZCRn2bdwKDjY/Eo
         Q2Iw==
X-Gm-Message-State: AOJu0YwuEN81ocJoFhEghpD9mVZE0AzMa29THfrrJBWXy+2A1yPWFRlD
	l4KfAeNeQTsPw+pUkAdmfFFO1sjZLZCVLl/X7p9IOp+ZYV1qaoZpb4Qa5AFF/0PaAEeBsibgvUO
	A60umK8mQOaMZQ5c3aavC9hfGbWyAnt8=
X-Gm-Gg: AY/fxX7ye1Gr3UJQZYCfuXPBu2/9sAxI7jN92FlmVHfvS3Wa+2YGp5GruDNCl329CaU
	DVGYSPcamIL6I8CRWNlXdI7FXD1o2m8AG22ZhpPB1RW0b3pP8AH0/9n+oDbuximmlq/NfawgNBv
	qkHq0gbO/bsGqX7XquM0cyeW5rDsm+Ivj5SPuwaTuaMEh5CvJCt6DL5pASyGfuBwGa2CnaEep7y
	QcCO2W1LagHAt8Rzg6qfGxKnNAljxmt0Jkf7cQC5LXAMniegXrh9zow0CfE50Tz/5aSTUoH1tBx
	yDstYyhbyKczEowo+yyMiu8JNL4=
X-Google-Smtp-Source: AGHT+IG2VVd2ulHKPqepblT/dcXUBuIzAvujT/19dGd3qTOe0K1RCNJYxzEAIxGbD6sVUVs0vdR/LkZE5bbIY8gLskw=
X-Received: by 2002:a05:6102:2b9b:b0:5e4:b9ff:3fae with SMTP id
 ada2fe7eead31-5eb1a6171f8mr8982040137.3.1767085301799; Tue, 30 Dec 2025
 01:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
In-Reply-To: <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 30 Dec 2025 12:01:30 +0300
X-Gm-Features: AQt7F2qmQ9Z-5a8F2Rg29NY-tgt0ZGYPV6trfPXjMIRVYLRN4aNMe6W6AAufCfY
Message-ID: <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I think that even with the 2^N requirement the user still has to look
for boundaries.
1) NVMe disks may have NABO != 0 (atomic boundary offset). In this
case 2^N aligned writes won't work at all.
2) NABSPF is expressed in blocks in the NVMe spec and it's not
restricted to 2^N, it can be for example 3 (3*4096 = 12 KB). The spec
allows it. 2^N breaks this case too.
And the user also has to look for the maximum atomic write size
anyway, he can't just assume all writes are atomic out of the box,
regardless of the 2^N requirement.
So my idea is that the kernel's task is just to guarantee correctness
of atomic writes. It anyway can't provide the user with atomic writes
in all cases.

I see that xfstests also check 2^N and the check obviously failed with
my patch, should I submit a patch for xfstests first?
