Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E50221FA0
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995761; cv=none; b=K+YjgTzvTS6MApcLZYFQVBu+gspjJMLSO5li8L5ZC838DvzgwTEfQT8yOpP+DI8fnSksnB5H7P6SQVazqhsw3oSu86SchkJNt3XdCOzibhvATPfslhplAEZOpkUTzudvduVPfWc6Gl1sq1MDoiNpjiQbzdYT9Zu51sY31K6VERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995761; c=relaxed/simple;
	bh=VvDcIIZYbR5ABGWrRAC8KtwDhSXJ5ShvR7mMB076vxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eYoAWVdYcFGHAGpeca5gUN59d9TrFz7jdkWkoeg3hky+6KqqgKvqbQnmXLcYPpseICljhcM7AONgm00pgwjPFo2k5ob+Mb5QvFD4sAjKpmR3/ieLmnuy2D8kgWHUd80OadpFQKwRHK7aH53O/XQp7g0PjWoN1va5z8NU3l/8YlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PqY8nbQH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PqY8nbQH"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-875acfc133dso33538039f.1
        for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753995755; x=1754600555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XsfntcqQ6csvTwNyJAnEEKzN96J5OJofevbNS9mkqg=;
        b=PqY8nbQH9d5A9Bk8kW/YOiUWMTnTsKjKT/PG/cQM7oBiSHLCN0rSr87F+nhNugDo5x
         tKHHT9J4zkFbwELX5X+AYJ6XCIZuodq9zR33gTElKMODPcskWEOB5rH1abX+grf3gV3f
         yVPGN1p1ijFRYdEGdesUTVkCUBt1dxy8e9Cm2qq8jSzezEv1QGsO75B4BY2NRFatzrsC
         7FH+RvWOHs9ixNfQs/tgbPDTTUc4wwmCetAckkj+mYaV4fXq0l/atoULPtqCT6uU0nBT
         l3rgaY/QRioSnILaDKU89I6RJkGGW6fV+fa/J697KSHOlsSCbrKdpUlzP2aesHpdZpBI
         u4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995755; x=1754600555;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XsfntcqQ6csvTwNyJAnEEKzN96J5OJofevbNS9mkqg=;
        b=sdpW02aeIdWrWXJHLdXcnRcVOaP0EDV0hESRbx6cBueaZ/c20OCH5jAHDidrQftZ/i
         +YcEyKG1sQ2SaNbF6YWgPvjixrJ299tzb53XPX8mVgrulN08SlQzmrwCzMSQ3iXsfd8t
         GiyyZhbsGkaNUhZQ1c0o4J2Q9Vz8IOukvMw+UKdjDqIQeKZw0THmkE9vFRunQcea2Uf5
         JvmAp/ABBLsoa+fNGaeqGKOlwPRk0jgm/saUfHn3tajBXJQy1zx2a9oSetAESW8jI96w
         y7Suaa13guF/lf62zkNe1yHocDn35vfL/+Zh3q+rQhsOUY5azzTBr3NEptlJTbCDJeST
         T/fg==
X-Gm-Message-State: AOJu0YxrRHEhEliRfVQKniWMJoFnS8xojA4dAa593ARTxRDjm+YDtqek
	xgB7sjx8fxFf951ub0qKs+b4lhM/SJO5hA5htgzTTRmpmT3zlkgHgYtH6EiuslYPTwc=
X-Gm-Gg: ASbGncvoWDSSw03JdhvMDbEZaiYc6u9yNFUsMGoghjQZ1zA8G2Mh4fqRztsImdP8eWz
	Rz5tisEQc3iGkW0apxVVoUMR39kPI22ICX2Cts+lYPO8RRwKWFsZz35kh6xLMmrSPYhLYKXEl/8
	eOMoV7vwH+mKw5606uUip+8qtU/8qDj8OID76PzoyVb4uzQFLP/f1/057GGGtF67iea2gnOnqjY
	2CbugEC0enjNrW1EkcCCQvjrgBDZo8Zna/2sack5RQMcMpuV/Mwro6JRY2tAud1bazy+tamxHpz
	QrkIvmkr5zxbJcEPQcDp3G8iPA1Z/ft5K51BJdUnHM+NQNgf/n4Ui+pMFJqD9X5i3P2JF0Rl+J7
	iba75cfvh4I5L
X-Google-Smtp-Source: AGHT+IGKT0RgUTn9YYs1F89WnC3a/jmyDkGPckfY2oxUk+gEldlRw4qKJY41tJacKy7ZUvj8P6mzKw==
X-Received: by 2002:a05:6e02:178d:b0:3e3:fd04:5768 with SMTP id e9e14a558f8ab-3e40d65443cmr5688725ab.5.1753995755256;
        Thu, 31 Jul 2025 14:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55df201bsm752208173.109.2025.07.31.14.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:02:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250731044953.1852690-1-linux@roeck-us.net>
References: <20250731044953.1852690-1-linux@roeck-us.net>
Subject: Re: [PATCH] block: Fix default IO priority if there is no IO
 context
Message-Id: <175399575406.610680.10505836643407350567.b4-ty@kernel.dk>
Date: Thu, 31 Jul 2025 15:02:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 30 Jul 2025 21:49:53 -0700, Guenter Roeck wrote:
> Upstream commit 53889bcaf536 ("block: make __get_task_ioprio() easier to
> read") changes the IO priority returned to the caller if no IO context
> is defined for the task. Prior to this commit, the returned IO priority
> was determined by task_nice_ioclass() and task_nice_ioprio(). Now it is
> always IOPRIO_DEFAULT, which translates to IOPRIO_CLASS_NONE with priority
> 0. However, task_nice_ioclass() returns IOPRIO_CLASS_IDLE, IOPRIO_CLASS_RT,
> or IOPRIO_CLASS_BE depending on the task scheduling policy, and
> task_nice_ioprio() returns a value determined by task_nice(). This causes
> regressions in test code checking the IO priority and class of IO
> operations on tasks with no IO context.
> 
> [...]

Applied, thanks!

[1/1] block: Fix default IO priority if there is no IO context
      commit: e2ba58ccc9099514380c3300cbc0750b5055fc1c

Best regards,
-- 
Jens Axboe



