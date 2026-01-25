Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADD23958A
	for <linux-block@vger.kernel.org>; Sun, 25 Jan 2026 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769361132; cv=none; b=fdKT+dde2A8k2sZ2buBJNRpw4vK7pUXL8wrikdDIcBNSOPW5Ilocb0TwfrjGX3gtPt3z1bY5guWiqHJaLL8AFrs2C4SvUiBpj4yKnESOJeTF6DWYmBZ4Y/qG/MA6c4rIV0v8fUiwWfsKWKzzHSqJaR1+4zEVK7rYZzqwSDbbAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769361132; c=relaxed/simple;
	bh=/QEo7Wqu3iUNMjgPZIJZJSjNsND2rsdpxLPDFpvSVRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cn5P5Fh6ZXx44D6ykkxsawIlsljykUYg4o2Rsmt1j5qtcoURy8lX/bdovrfwk4c0H1Dw9HuWRS6DMK99Eh96MxrlvvTm9ufwoCh8ybWOMzpIJy2YCdsrDWAjzY723bTUAEAtAuj5Q6dtc8sCRfv7zA1+UvYgltzgOuycOR65AGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zG6h2k3P; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zG6h2k3P"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c7a71ba20so1007024b6e.2
        for <linux-block@vger.kernel.org>; Sun, 25 Jan 2026 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769361130; x=1769965930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTG/UusmHhSRHax119uDW0R9FQMeUnyKXFiplnDVLQM=;
        b=zG6h2k3PO+hGnwhfxa2hw73QiE1wpIv6Um8AM3v4Taor85tnUAEVsn9ZLuUulwvflE
         1qOcmebdfsKb8MI2P9qZFBhK+hCiiY3YjdDa9+evPjWwLDYAeUjRRizNKh8B9+RRJjCR
         41SIJzK56YFbUDqJO4SDznjvJ97E5VW6X9wba5z09CDDo3XaGdq/wLs4TdHm4OF6zjOt
         rWghRbNl0c40W7If2uvBUbkMFrlxBhiQrHl2e/wqgTA8NHcXf/aoy+Wevb3KiVw4oqtB
         KXOCyzbquMB1yVi5sSKS64HZ6tUojm+SVof/1Z7Qkoe08VIsqfnuGc/8Jzv6A333+TEu
         zehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769361130; x=1769965930;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HTG/UusmHhSRHax119uDW0R9FQMeUnyKXFiplnDVLQM=;
        b=q9aNAwfdKqheoTr2FaNjWa2et4CK86DNM8uZCanTeSKytABMDtBIZTDfCcCwJK54Vz
         BxhicsG7Abbf2OlYcFEFxw+9B4dPmV7/Nl0SWY6UvtlxTO5Vr3dV03J71b3cvp+jHzWz
         9nqLH6b44kiYscgoXCZKcozBoB9fRGOQ7uZRZV8WYbZkHTtN2EUvY8qIFVbZm+PE1Si5
         dbwugpTIUWcpV3WfjnhxRmsERn5og0Lk/hfiPIZEjxaIbborjiaWQtqY49DVvv9um4+d
         s4f5WAjZP2l21tyByDRpey6DS7sW9/WXQr5fpIZrfni+4VmoG3l5pHRKvZcXMufCy3Bi
         VYVQ==
X-Gm-Message-State: AOJu0YxllefyRxD8w4olUYKaVD+oNH4qK+CSsA47WUDe8Ms1ev6kt/Ze
	HMXCPLmQ9vi08WMTgc2OI9rNppbsNuvRM3s5mHdZtnhYenYCxP9MWSOnZxhzkVUYTv0=
X-Gm-Gg: AZuq6aIiwHP4DifeFXY2f15MGF3UcK0A9i/QE46IJbHzpAAP0uU4cA02ePuGUY5jugA
	QPix8ULOowIhk54ALopoQxAVjXO9JxTizCkST7AmgxbeklOUvIZ9zAd+FSAXC1DsgTrjwWN4sRh
	8ktMJzznnBCCs8i7beB9lvubINIuIkB71m3OtMnNCmyta0kBL4/JBwpaFVmrj7eGpH4tDMt9MKE
	EpmVMPc1GMDO56ycgBlnJf9ICqNXcdJkINNz+q4f7O22VZQ3HHwE9mqwBnFLS+Id5OswW0YSr+Z
	ohT6tYtvI17wM/GsTQI+twrQQ6ZGNVZroFxK8j5oNf7KWwlu1TzdbLd9KkSiu3O+JCnPhaFUtXg
	a+NVBa9GqS/ktaXFw48o7sugY034AqYGorziam3m9l6oR576403Q7zhzTiGH2YXt0DljT/i/1nm
	D5ICBG8cu7HW8ACPRUU5v6V3C5Y/NbbchE9G3TpDIMGqCK1EzZNy6sBWPa3lUTGD8c
X-Received: by 2002:a05:6820:4a8e:b0:65d:163:3e5 with SMTP id 006d021491bc7-662e04616a9mr616403eaf.47.1769361130058;
        Sun, 25 Jan 2026 09:12:10 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408afc0a17bsm5629457fac.19.2026.01.25.09.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 09:12:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Alexander Atanasov <alex@zazolabs.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260125085747.1631424-1-alex@zazolabs.com>
References: <20260125085747.1631424-1-alex@zazolabs.com>
Subject: Re: [PATCH v2] selftests: ublk: add missing gitignore for
 metadata_size binary
Message-Id: <176936112869.8973.14050161093900489800.b4-ty@kernel.dk>
Date: Sun, 25 Jan 2026 10:12:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 25 Jan 2026 08:57:46 +0000, Alexander Atanasov wrote:
> A new utility metadata_size was added in
> commit 261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
> but it was not added to .gitignore. Fix that by adding it there.
> 
> While at it sort all entries alphabetically and add a SPDX license header.
> 
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: add missing gitignore for metadata_size binary
      commit: 8e5bcc3a955a2cc4460b391f55d3b49905eb248e

Best regards,
-- 
Jens Axboe



