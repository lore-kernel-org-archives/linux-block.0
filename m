Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4910B663
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775350962; cv=none; b=hz5fEl0K5rLO8645kSiuFLejAhM87TRxHwyujUtrP+qi6JfC28t2XoRLTwnuqBS7KM632xbiW1Dq5dQlmmq91EY0v9iA87t8kQSSbLrAQIh3fkK9cRjDQlE85ndMdSp+tSd1PfjcUAjOv/E0H8zo6qKexBY42CuMvOWMPxdLXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775350962; c=relaxed/simple;
	bh=RkkpgAgAsSSrkQx43Xwidf/ttpShpZFawi7OuU9ei6Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=PLdQbbDoi3rzO6z0H+23kCGkWdEA1TJRqPEn4Ro5xJhRHyx4F4juvTTeRZI8/enky3ngrNtg/H6bE3owy0JkprX0LsGe3IpbSfAAPTGaDT7PueHX5kk+9/53TETAU6xZxhk2fF6c/MahXLSlMdBmn9c3VnL2eKctQWVAGcnbXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgCSk2GJ; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgCSk2GJ"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c70f91776fcso1093350a12.0
        for <linux-block@vger.kernel.org>; Sat, 04 Apr 2026 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775350961; x=1775955761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiTt0Fj3wfOXNAWpy/sFPtcd5f5ZN7PSVBwEcFw7PXw=;
        b=NgCSk2GJ8eHC+KRxgGtbB7tjxWBUyIqZQN50hMOrbdBtFrlWxn4wYxFR8xFy4QDbVS
         zE862BT8Cby9YQOYhTxnY6vkWqofRIgUGJVQ695S8P50KxU5/5ZzvAjbyHAAG+ooGVhB
         Y/nHvuJb8Y4B8FzzXUlrmvSr0XUbsz9AzvWUfiEY/1qk51c4xXCa9zb8sdcHIFn8OS6r
         Hooqr44aXe2diEfkawIlIV1pLURVM0di5Vp/dBuv8R5tZH0rYqFpIhbKiGboqCouoc5x
         hlUkFstvYEUlFu2gfKDTax/sylhrdiZelrIY2ovQewkQMY2OIkzlax4qYBOOWt2aisLP
         T3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775350961; x=1775955761;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiTt0Fj3wfOXNAWpy/sFPtcd5f5ZN7PSVBwEcFw7PXw=;
        b=qZPmSMOfeURW4scs/4CWjL4QP1MmxQh4cAHus+jIZJikfqRnvzOqGXwllhkQrDudN3
         d7lxLUXWuqgrdHjXWbUuXJuJI4wpsn4PebWmo49oneMJYuR6MJjPkSFXk67g0vDjop0s
         3dOgq/5y3zDaNff4mXjA89prZFg8ccRrbywbxmGyBqh1JZWJkApgShxMuj1a9dYkzobl
         P/jd2n/H8TerU+Kpbdw3kfbGl/r5REdTgLrwJDyA62Cjg/KVInByKQoclLHu/KM5DUx4
         wb3CKWowSqJKS3gKkI4nlXsqqWvZiR8DghQh9GIXfezfk7lmQS05BT1kfivUHO01/huL
         eW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTZv1cl2iKhC3HLs3WYwUNal3+qHQx3dijllCYQH6mtu1ZDeW37wGIS06m3jDf6VcGRcx0xeKsMQNpCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxcmy0jNvHyxU3NGD3UEYX346FJ14GNQeFZwfwRifjwhOaIOU6
	F9CJlKOWO49Qvl24cDH0Op3GzVknaV1RFOKMluG+aol8x63S6un6CaXL
X-Gm-Gg: AeBDievz9IjVLneHj0r73hjSqCqGWiYYws4OrT7zOryqJF3Dk5KyFUNCjtyZdxMLsZ4
	zTr3PAmR7fnyYOw15JDLfKYsuUlVqBTUzZicaST31YW3JfDEQSwhuBUsf8NrVgTXcZ/dGVFB4qY
	LUgenUbYL6Gd6Hzk/0LZL1b1flo2TxFU0tZjNJ+XAki7fsXSJkCtqPPBXyR+RxFLVoOtPgPcmkH
	2ypQEj5VrEjzFy13B3PQ4d1EtnK33b9PfAXzFOuVr8GCo3Ed6WHuhbhrlmpt1ivhCAyoCbet2UK
	KGAt1c2pCJT7Sb2fESy23bq8b7t6KDVREcP6ymSORKk14noG9u5V7um5iyhYdV2PjceMRlX8NJl
	lnJLAtwZhNSeGsCjUcawDM2fmqE5tK7h6WR803mKchYAo2u1OICnjOWJxNX8B0g+0Ho+Mr2mz5J
	MRJK3dRJfRnUYeyETSXZtzxfE=
X-Received: by 2002:a05:6a20:a11a:b0:398:9301:b9ae with SMTP id adf61e73a8af0-39f2f11b8a1mr8103554637.52.1775350960975;
        Sat, 04 Apr 2026 18:02:40 -0700 (PDT)
Received: from [127.0.0.1] ([142.91.102.47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6477bbcsm8552260a12.3.2026.04.04.18.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 18:02:40 -0700 (PDT)
Date: Sun, 5 Apr 2026 09:02:30 +0800
From: zhang <zhangweize9@gmail.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk, csander@purestorage.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	shuah@kernel.org, ushankar@purestorage.com
Message-ID: <46c04059-03a0-4488-a4a5-4bb93aa46a1e@gmail.com>
In-Reply-To: <adER-jg0JfkE4I8n@fedora>
Subject: Re: [PATCH 1/2] ublk: reset per-IO canceled flag on each fetch
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <46c04059-03a0-4488-a4a5-4bb93aa46a1e@gmail.com>

Dear Ming Lei:

I just looked at your solution, which is to reset immediately after each IO is claimed. This solution can indeed effectively solve the blocking problem. However, if there is a task that is repeated and exactly the same, then the process may run repeatedly many times. Do you think we should add some logic to handle repeated tasks?

Reviewed-by: zhang, the-essence-of-life.

-- 

the-essence-of-life
