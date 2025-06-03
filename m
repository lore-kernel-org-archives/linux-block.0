Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21F21324E
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976370; cv=none; b=bMtT7IXrkmLfim39TqAqmSUYhpV8sWXrc7dnBAPtwNjUJPbtbbrvfj7VBws/IYVfniF56povyMhi38ZjK94Ck2rLvXL+pD31Q8Vj0qqVZZ1DMeuV7W7jEkWToo9p2nUdX5cPR8KQs+E5Z3qsA1PDNXbBEjdcyKsTaPg23YeBnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976370; c=relaxed/simple;
	bh=BGGyoOAitopUbOF8JRNp9e7ymTkcBN2zyfb0bX51Xpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TPOV4DWK9I5bPWk1sFHDq4IrZ36rSacfUgyt2IS3bV+GTuOk8obJU9LNdXL3eWkPNMdM9LSjbgW7O0SNHtWyjjBQrYNSdmWhKLty+egAYC2SeYnbOWXNUAwqk39eQDtfTVCnFteeD7GulJ5i6uLmvUyv/d2D1UbvYW+7fi/2gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B7Q7s2Kk; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B7Q7s2Kk"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-861d7a09c88so155861839f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748976367; x=1749581167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytv+YWv+S75md5rXeB13AvL/fqgyAAlIGtDQ7fSe6gs=;
        b=B7Q7s2Kkj6QHX53bh5al5jCj8QpshWVCGlPDoY88fUOhvMtkPbUJc4KyLFj8keoNXM
         w9RixbUMRL+7fB7oyxH8gG8i1P75qaSN6/dN4YVcxULWxXtLwLKv7Ldx7dlOIiW5dC9w
         G1LCzO/dietahsMXcI+PjpYRZQ2ru39oJbclFibP/3bK1KLo1koFwGVDpVt1UGEp0Jsw
         f4INUvbXHt2BTjFWctgxg7F7xHk2g4jV9xGbN7blsFCYkMEUPTM9VVA73EeTNSx+Qiv3
         pbYvSRbki072xIRr+Hk7kEGoms3ATPnKJiOhEI54iWmZj9g9S4hLU6os+F5Np9AUbr5k
         YvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748976367; x=1749581167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytv+YWv+S75md5rXeB13AvL/fqgyAAlIGtDQ7fSe6gs=;
        b=gQe3un9yNEQ2yyh+iL0zWIjKgYOTPO9ygza48uLEIxfuc10pyzPxnGOM6kRHdEi0tG
         JZONun5roRMTIxcXU6DRfQKRmkLU5Ct9aOadxT2mMVy04BnY45XANRFWNgdFHRdU16Pz
         /DGxu9beazoaBWgfYxZamYsPcFqPsSlgEoILIyVU9oq3GZA2jaefLzBEah4xSNSI4oxm
         h+lO++kOAny/okvehg+cmfd0NRMbGhQJv4Xs6+uQWNZ6qSxpygY1GwGFy1CM15XMrVKI
         Yf9akfHuoOpW0zIsKkzt0Yxv4oFK8DcyDFol+C6thw8lS9h3JO9JzdqPiJMvpl0PiPsY
         xbgg==
X-Gm-Message-State: AOJu0YwGOjEcUrSs2jKzfEI7/swPxPGGARN8PYSSFGuSth6ICfXRXyGm
	mWoRXEEDTTZWE8LXMBaxU6mSjttn0p2w0yduMeife05AMqknc9/esfx9OcGpDUljJgs=
X-Gm-Gg: ASbGnctQWwHKIN/Cd7ewHjdqLAVSXrDbeRi5EuM06oBygkwG1o9fCc8NxNvgynin97k
	EmVFcpxSJ59ZkVsgTe2VHe4f1EOzMazXZbAZUw2c4rScivECZVIIoc845Hc1EKtt/KUZF1Xoku2
	2emnGDAu2X9BWH1SYrIJco8+FJ+J29LNNUY38obAPb6YqqvdR5hzHCMoGGol16aq4NnHdHMfd82
	EX316p+pp4SUp72q4MBqJ9p9npqq1dD8Ti/i6if6XrxO1BM9BIR1vldVjKnuiMCoIOELsYhsxvI
	uWqnBvTqWaflrekume231bv15qU7NSCc75xOkE5B/A==
X-Google-Smtp-Source: AGHT+IGQVJBhh4r6CbR3SMBMSOpcdLANMW7TJEkb1UHjw6n0V54ffSovSdkLt6VoVn1npFg4sbriNg==
X-Received: by 2002:a05:6602:721a:b0:86c:f2ea:d8d3 with SMTP id ca18e2360f4ac-8731c643e38mr5739139f.10.1748976366844;
        Tue, 03 Jun 2025 11:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86cf5e51d99sm232212639f.7.2025.06.03.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:46:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603183133.1178062-1-csander@purestorage.com>
References: <20250603183133.1178062-1-csander@purestorage.com>
Subject: Re: [PATCH] block: drop direction param from
 bio_integrity_copy_user()
Message-Id: <174897636598.14684.15850235224325997999.b4-ty@kernel.dk>
Date: Tue, 03 Jun 2025 12:46:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 03 Jun 2025 12:31:32 -0600, Caleb Sander Mateos wrote:
> direction is determined from bio, which is already passed in. Compute
> op_is_write(bio_op(bio)) directly instead of converting it to an iter
> direction and back to a bool.
> 
> 

Applied, thanks!

[1/1] block: drop direction param from bio_integrity_copy_user()
      commit: c09a8b00f850d3ca0af998bff1fac4a3f6d11768

Best regards,
-- 
Jens Axboe



