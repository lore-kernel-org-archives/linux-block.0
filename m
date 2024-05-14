Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4344B653
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715658503; cv=none; b=Fv+YKNVbx3H0/0KR3q6u2sZTssg41CKEI2GmWgqIkca5QMhhkluNSlY/+A+Y9TVbI29/V2nDSP4wgP6bm6JPCedX1sF9U4XpZ/OMSYrwSHxalrh8NKI5jlef97Xpp0QUyAvgW6Vn7xN7Tl4Thz3agYIRozKEOHx7JzAHtij709M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715658503; c=relaxed/simple;
	bh=KqDa2ScQA5UPp1ZRj0yl5RygTHFZN1yOchvHUh3c/P0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LgnCXqH8vcGZVe9J6gmJfREoMi/y+4adcmr7GiNLRoekJgO0TZ0O8p+6HHd9mIjA8LWx7TRaLAp65OHsAxzxM+fWLNjYkCIpoMYsO2xcia7rZNILNTyrjxpPMn5okNsP/xEgNWrqtNwBGtjGheyhTnPz+FQC9WUyDa/gqpbgfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O1KZ8Bul; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O1KZ8Bul"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b432d0252cso1281339a91.2
        for <linux-block@vger.kernel.org>; Mon, 13 May 2024 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715658500; x=1716263300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peYsg/YUnELwKP62MLPathqFR5UneY1DGWncGhnYgDM=;
        b=O1KZ8BulzLdhyPAwgjx1t/o+Ph68jD9iVR37+mXjfgTkxJLlmCB39bodxltG/7oUSw
         RL0kCVNhAQY2HiEuqQsgdy+dczybPHYYkV9BpiseeA+vmlWQUSsH+8wL3iaHe0/WfOIW
         p9HRN7qOP/UYjdAwJM+PQzUOI4uUjtrZuyhxN+6qgHBZhROATbfET7W5vDh6G+tuJjKL
         9LDke5Mu7eEkWVXx1oq4kJ7tFZIK7o34M5NkifBRX7lRc68/MD9EsIQaKrobQNBPloUa
         kDsZNnzq7RNiQjBZhVUgXeqKf3MA7COlJw/M24T7e5HkHv+k3zerVKS3pY52WEKiPW0K
         OBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715658500; x=1716263300;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peYsg/YUnELwKP62MLPathqFR5UneY1DGWncGhnYgDM=;
        b=rehP02JQy480Q04zPh8muPAIhVzYAr0SrwUQvqkfG34dmWljaXbrGkPPbPDT8chg9+
         JjvJNJXhSGYdxlEILvgZnJPm1WBjWrYP6GKPKfycO/MvyGXyl+1g9CIQfFVMdxiT3cWE
         F0mGI12yHgAj/LoHiVDBGqt8flFbFYzX5gKTiJYZtxaXisZhMk7v5IH4kPLiPLFzX4L8
         9PKKT1BkpecgN6G7Qk9fDa4xPxOB+mZbPPar663f9JdgaqTJjoP+yy0cfBXv8IXEcEZs
         nyk4CIgLxEihxZ9abZQr2rS2zLyly94vOvXTJS68cJLQmDNaUtwKoIQDCNRoS4uMS4ti
         EtHA==
X-Gm-Message-State: AOJu0YwKesFa1J3/M2DpvoSs4cseYSsT2CX8zfif6TntIiu0Tvy76jR/
	U+x1ljGV/LOYKqAbxok7vG7yMd/d5Z1X1Aguoxgu6746BeBL6a/+QUxPqb9JJY1fjeVzTeb+QsJ
	Ig/U=
X-Google-Smtp-Source: AGHT+IGi51unJ5H4uNDgq4XGmm8jPky+y87ln++w2rRNkULieUj9IX/Bm+y5FyQGpAw1KtnZHKG8mw==
X-Received: by 2002:a17:90a:ee45:b0:2b9:7dd3:a86c with SMTP id 98e67ed59e1d1-2b97de2eb56mr818604a91.1.1715658499818;
        Mon, 13 May 2024 20:48:19 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:755e:1dce:4b17:18d9:3b03:407e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126add4sm8672921a91.31.2024.05.13.20.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 20:48:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20240429102308.147627-1-kbusch@meta.com>
References: <20240429102308.147627-1-kbusch@meta.com>
Subject: Re: [PATCH] brd: implement discard support
Message-Id: <171565849854.5897.16749670445299003017.b4-ty@kernel.dk>
Date: Mon, 13 May 2024 21:48:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 29 Apr 2024 03:23:08 -0700, Keith Busch wrote:
> The ramdisk memory utilization can only go up when data is written to
> new pages. Implement discard to provide the possibility to reduce memory
> usage for pages no longer in use. Aligned discards will free the
> associated pages, if any, and determinisitically return zeroed data
> until written again.
> 
> 
> [...]

Applied, thanks!

[1/1] brd: implement discard support
      commit: 9ead7efc6f3f2b46c4ec68209bca4888cfbd4c19

Best regards,
-- 
Jens Axboe



