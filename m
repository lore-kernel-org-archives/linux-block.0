Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273938F249
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063518; cv=none; b=JxdTPMh9XfQwZy2E9W8XsjQI9MxHv5OnLmGnwgDSEjPjR9Ku22OFoE5nW7knDFyvto73ttxHKOryXdW66cEYiwMZOOi020O7scBHR29EEqHNHJCRo6B4gwr2YCdeqB8DmwVx0UPlEV7QiQM73XALTkHdBATQ+o5440/7sZiQzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063518; c=relaxed/simple;
	bh=E1mdxcgyD/iZU2DxJHcjNepNpgIIoS3gPTN+MtiCel0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A2Hc6hOXPnq059X+wkm96sbwOXhJYqUQVhYp2cpQcn4DIdi3fmsD/LNjj8/26LKXZhJOsxhwM+/CDpPulHbqtCu3JXE3tU1hPm1nsa6mzqo87sE/xWiAXofCmWjdw0KmHKo+LyhnF6xPUqr8n38cKAMnLrqricar38yDCllo6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r48cDfps; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r48cDfps"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899f79df682so86441796d6.2
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773063515; x=1773668315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQoq6tP99nW4CDU4xy+wEMBbAS6wTNEor3ejxflc7Rk=;
        b=r48cDfpsKoI53eF0fnWnDTOlvomD27Q5Xs4RYQ8z4Mx4V5XIr1WipXXalTaevSMW9g
         MPdU94rmpObqL8h9pj1BVY11HvFeydYmSCRJhXxeG+saxFLTODdRS6eJoXhB6ai79TUA
         6+eKseXfgFHhx3woYK5KG+/HSJ8j8jPKnEcKYc6DMl6nLUABza6JufiG76lthnImbUOE
         9Ig8JHpGJpJ1OD5WmTC1my7jQ2h/0slqpI89xi1ehJsYKBSi/ombIv7ligGU4L4Y/Ub0
         Pi9ou2lGnZTfwxFlPkLJTMsxPnGxE3K+zBlFubn/gnbwHIsaXElSnSHhsTVIG8qStwBJ
         xN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773063515; x=1773668315;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQoq6tP99nW4CDU4xy+wEMBbAS6wTNEor3ejxflc7Rk=;
        b=TeVxOjGrLcupLlEwGBF0gyCB+/pjaEOw5U3Xn4lvM2h5UodzzTsrvxZBoN5cg0Jzf6
         pzLR5TpDPGyUT9axn+WDe9fSevQQ7/nxxF8FoiTl05LHpL8hqHfQ9TLzN4kvk3fKo8yL
         /tKdSpEonz8W/4dI4mmUOedx5JP7cVu4y1+ED1uuEugcPKYJR9BvtPimZ4OGnRSZG7SH
         3uohSwr1KnFKkNMiqRihXLuK7St/q929pQ2aXSK0OQWGHQA5U6CnQdtY49Z/ujY2ky1N
         uaOCliuKFkpDzuhAIBHxUxVYM5wkw1/1acl5JDAtdgUMbDVoSOMNmZaRitgCDWrJM3JN
         yoOg==
X-Gm-Message-State: AOJu0YyuwZ5diZWSKWxexHUhqJALxIkeDgPGskGyJY7Tq+ohKPk/Ii1+
	+5UyZFR9n0gMZ88UBgGH23iCvbESWH+P44W+/VbGSXsm+oK6bPcOxTYGLWp8e7KRsMvdR0Jgn8q
	bvWno37k=
X-Gm-Gg: ATEYQzwcA7eiVQ+5dk9ppXDnL/vfEah29ZgBufUtQu2qz9tuEjYc5EaRgx6A8fuHf72
	UzJwRoMbnkV8CBwJgW9a+b9apV1vxpuTWknnabbSZnTjYW2JdV6cI8bgCun9NK+M4lplSeCsc5o
	gGqmTyD0cKLYMstXoyr3zVf0N7FDcbDAjXj/cxWnWjxKDnl4TADZBjEHuG/5w8NKZCGiSZi006V
	C/E9beMstyySw3juwjkt5QOiManfyGJ/2VGmMm4VtVNz2Dqn6CflXPL8roBxGj/EQhmS+/Irqod
	9meMtUkplfkrDkzARIIo9yPEafFPYDgLsblJjBQsduVCnedRyrLORY7eJm1Lo1YF9Iu73AubSz2
	hzDP+BflSOvlQd1t+wcGFLANIrRw1gxjF0AT6addA97mctf5zlyP7jLVCNT25niVcsWDnve9oPN
	2FizmIAH5XrfIfVrw+ut710ys7lykPSVqhnCQUP8yKR/JjRGk=
X-Received: by 2002:ad4:5ecc:0:b0:89a:125f:37da with SMTP id 6a1803df08f44-89a30c17067mr172025136d6.61.1773063515088;
        Mon, 09 Mar 2026 06:38:35 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.133.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316d941fsm86102536d6.34.2026.03.09.06.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:38:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <20260308143902.1643155-1-ming.lei@redhat.com>
References: <20260308143902.1643155-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: don't clear GD_SUPPRESS_PART_SCAN for
 unprivileged daemons
Message-Id: <177306350907.13741.6126293817450020139.b4-ty@kernel.dk>
Date: Mon, 09 Mar 2026 07:38:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 08 Mar 2026 22:39:02 +0800, Ming Lei wrote:
> When UBLK_F_NO_AUTO_PART_SCAN is set, GD_SUPPRESS_PART_SCAN is cleared
> unconditionally, including for unprivileged daemons. Keep it consistent
> with the code block for setting GD_SUPPRESS_PART_SCAN by not clearing
> it for unprivileged daemons.
> 
> In reality this isn't a problem because ioctl(BLKRRPART) requires
> CAP_SYS_ADMIN, but it is more reliable to not clear the bit.
> 
> [...]

Applied, thanks!

[1/1] ublk: don't clear GD_SUPPRESS_PART_SCAN for unprivileged daemons
      commit: 155a3bedccaf57c69aa0b590ba3fb579debf3a4d

Best regards,
-- 
Jens Axboe



