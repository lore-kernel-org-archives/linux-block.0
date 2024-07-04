Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9F1A0AE0
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080406; cv=none; b=FCCb6YA2iSbfJLNYr7JgFv2TlRtomfzfx9Vo2xYyuHxQkyRaxDFSIBDtbA+ZLy48tyAPg7+MUePguBATwDj6n9ba68PmDc2hx40RicYWojCMkIGIZ/gXs/mypFkFa9YkPwfaKz6iFOCmd4WNiQ8HcCS8/1IxZxOQ3YQvUhTWdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080406; c=relaxed/simple;
	bh=w8MZ8H52Fv+SZ/uPHRzZ+T9ioOkCHwzyZssE88ShFN4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X1evbWdtq+C5SPYAyM19SHmRzg9RybSHCydymfXyDaOltKH+O3o7mpzMA0WJcVT0ZmTl7lLpgby6/R+41PhyKFxizkEQ9VxXdKeDvYFxuQ5rgT/EX/0LuF2FNhKg/xVlySNz/nXzDfw+HBcXGgQBIeT/wNku9AZuaQUOBm+vGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IAvqZ3Tb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IAvqZ3Tb"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58afbc33c6bso55586a12.2
        for <linux-block@vger.kernel.org>; Thu, 04 Jul 2024 01:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720080402; x=1720685202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t+aWEbh6epdNsq5FsRzTDew1FayQNGBq4zv1CRvemE=;
        b=IAvqZ3TbZSFv8F3NyvTwrjpsWzA3GiaJse6FZLXANGU2i9NGQ+td8rp55+QpDsHihA
         jPzQQJeCuFoD8dPlRKXfiPdO3cCOCr5YPNoCyiBLqxTbBL15BfuSn6w2Cxno0CiZ4FVY
         +MJiGIVhxV+o47PkiZLUlo+lXD+sVTIALb8o5j7lfPnx1PSyuiwJEm1asefkdfIPOTw+
         uzzsnH/qdFmQlYMiVaCSlBTfLxnP8oIpQ3IN2Pr7LuBPSNk4+/7d8EhgZZyYjyhqkeh+
         PG4Qw1i+Y/K3UBc/yCiOXfAIEiimmGjAnxI+HQxiH42EFqoqNQmZ3/UDxPsa7fKSjU1W
         8rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080402; x=1720685202;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t+aWEbh6epdNsq5FsRzTDew1FayQNGBq4zv1CRvemE=;
        b=bUbkqDil1zJycbtMYlVmoZmRoUvVEG9WUOW95McCw/tvM1CSM9WPvYvRzUn+v2Q+GZ
         JhtFLcdbX4LcYKMBg/kZBOT8Yt44/qG6jQW8WE3T/3H17cPdGM7BUK2Pf6wtJ0j69fHK
         C5NrTOA0+TA4yZxrhAGh1kCxBrJpDyZXBdcyaCRnNerhUsvnBI3XsoIDKkM/r/0jsSai
         CnQKdoWFao10QBrBukctp/IUt+SjiZIsT2/PlZHpNlRgxn0aErg/tqyTAqV4zsftVZVY
         VFvLo2Tk1t21XMy2R2o/OrnxNYr7y3UDI4bK2HurTe173FIuRg6lCxzFkgnHIuJ8XnSi
         dkEw==
X-Gm-Message-State: AOJu0Yxg1pVtQXaoi6lJBqc0O2i7N2UEzPhg/5/dIVbGGUCgdCP6j0R2
	oLjrG/EcrwDENu2h9tWHHd0n95T3uvgxpz6t5PO0Rark4z6gM1iDa/tVnESzGZ5+tOSMIQUAK5I
	0BI53Ig==
X-Google-Smtp-Source: AGHT+IGE9SVXePbGb6vhxC9zWOtPC7YoUlhotgRY+sMK3lAraNmjnx4Shvij5ZGHbqZRuml9AfuwuQ==
X-Received: by 2002:a17:906:3b03:b0:a72:40e8:553d with SMTP id a640c23a62f3a-a77ba730038mr56978366b.5.1720080402202;
        Thu, 04 Jul 2024 01:06:42 -0700 (PDT)
Received: from [127.0.0.1] ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a752d528ee5sm299311766b.212.2024.07.04.01.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 01:06:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240704010638.324349-1-yanjun.zhu@linux.dev>
References: <20240704010638.324349-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] null_blk: Fix error "ERROR:INITIALISED_STATIC: do
 not initialise statics to false"
Message-Id: <172008040015.235003.3789218318478703854.b4-ty@kernel.dk>
Date: Thu, 04 Jul 2024 02:06:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 04 Jul 2024 03:06:38 +0200, Zhu Yanjun wrote:
> No functional changes intended.
> 
> 

Applied, thanks!

[1/1] null_blk: Fix error "ERROR:INITIALISED_STATIC: do not initialise statics to false"
      commit: a18df07b7d3dbfa7ae54962cc59569002eaafd6d

Best regards,
-- 
Jens Axboe



