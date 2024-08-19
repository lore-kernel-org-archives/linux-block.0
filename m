Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050153BBF2
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082561; cv=none; b=FaMJSMwntLR0jngbm26V9dxmuONfY/xGLaUop824KXp3c+j/z33j14dTRJz7sYstAxS8uTXBq5gpLQhAWU3MhWuPImhzypG5twkOFXN3O1pVk0I3JlQj3lmuYvurtb6VEWN7awshxnXQQh1lsWAkhpAQMwdSojSts7uXjoU0auo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082561; c=relaxed/simple;
	bh=6kDDCtpXiLhNI/TMgjIwjMgTnkUhRipwZYaSHP7w2Nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cZkN0MS3avC9xAY0+qZQzh77ei3Z2vCHmtlmN6/64FW4AksRxHKwkC5Kh2Y+zI+7irFk0h6R3YIzsPF+L5L66PoarMtqdugwdtfK+aRtbJ0Eaw6+iSix2Pi9oZjzVDfYN9gC+Thob7pTh63DsoX4uGJDDXOkZWru+hApH/yQZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lARN3y4e; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lARN3y4e"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70e9545d8b2so380012b3a.3
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724082559; x=1724687359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WA966VQZgqB7c8sLm8da1uwobLXuTd2z6VXDAwtp/0=;
        b=lARN3y4e4QkDIMpNvz295jI+NDIrojXa/1Y1cVJN5y5FwiMAlqREMEupJQFK++wsLx
         W0ze0fvPY+HNNkVf9MIe4Bshn9B+aaR2eA1rWDpSidYaXGaLdPk1aveEkDcBT9izjroV
         h8+gb1BwO1C24ZKbij65xzhR5V4A1/o9Zg39upghU67R4+yec2F4MCOQy//6w0my5UiW
         PtfGqzJXH4thtwDOoIKVEVxMZPsD7130CHnsKKfFp26JsymYVWn5gHK5+AyQCWobrFdv
         UDjAFbKKy45CcVZe1xXZg7ePwsFaZbIrL95EdVge1OPccBF2UFiHdo3YL81IpHnw/ibm
         Irug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082559; x=1724687359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WA966VQZgqB7c8sLm8da1uwobLXuTd2z6VXDAwtp/0=;
        b=LcsbSfWd7vbDPuOU0g/G9qCj3XYbk9ew2Hc9K9XCppY7ku0kgn4Fe5LYCoYVXEq0XY
         RFzjUDed9OiPrb/GQBcC8gBc1IxE8tCqHheBfmdQlETKg8IOE3+eXTgXXHCMP/EbJcWY
         kAAfTKRu0aaLhD95FKWQt54g/3D/T8tRKTgI6TwXVWDvewfhif3ZPVnRRmRxjU54TwH2
         Cr8zsv+I2VW4+KeR2gTryTyMN5AX7ppeaMhaYanlvmRVospn0Oi+QQGyaCqFkIB56z9i
         xYpeLsXo3fQyE59zd+8iqY3c0qbo1rELKwbgPp3zu1/13MmTyATNnxza43Wy0pSwbB6W
         2ZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCbEOR6o42XQ4PgAtLcUw5a9xHG2u2LEqF1Kuy4BNXP4VZCIw2dyWwdC9/ARSxfze6/lf54i+gA2dF33MrvvQbpHGFXoDTnQcFlyQ=
X-Gm-Message-State: AOJu0Ywv1J7wZ0QurLrw3ps83v14mAwyMNIBASYOT3YluydQ2+rq1R51
	tEVx0GIyfxSB5Mqn3dKrl22eGG6fMe6hzXcuIrzA5nmURtqjyguRVFyRfdkV26c=
X-Google-Smtp-Source: AGHT+IH7PI31JpTdXS941t6JyJCKj7xPilWnfcf6bcU4rwA03vgbwz8zewXCKmtlfbeHj/e5rvT3LQ==
X-Received: by 2002:a05:6a21:328a:b0:1c6:89d3:5a59 with SMTP id adf61e73a8af0-1c904dc0c37mr10216437637.0.1724082559330;
        Mon, 19 Aug 2024 08:49:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0f224sm6710827b3a.79.2024.08.19.08.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:49:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org, 
 kbusch@kernel.org
In-Reply-To: <20240815163228.216051-1-john.g.garry@oracle.com>
References: <20240815163228.216051-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v2 0/2] block: Fix __blkdev_issue_write_zeroes() limit
 handling
Message-Id: <172408255838.216250.4350755745939185685.b4-ty@kernel.dk>
Date: Mon, 19 Aug 2024 09:49:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 15 Aug 2024 16:32:26 +0000, John Garry wrote:
> As reported in [0], we may get an infinite loop in
> __blkdev_issue_write_zeroes() for making an XFS FS on a raid0 config.
> 
> Fix __blkdev_issue_write_zeroes() limit handling by reading the write
> zeroes limit outside the loop.
> 
> Also include a change to drop the unnecessary NULL queue check in
> bdev_write_zeroes_sectors().
> 
> [...]

Applied, thanks!

[1/2] block: Read max write zeroes once for __blkdev_issue_write_zeroes()
      commit: 64b582ca88ca11400467b282d5fa3b870ded1c11
[2/2] block: Drop NULL check in bdev_write_zeroes_sectors()
      commit: 81475beb1b5996505a39cd1d9316ce1e668932a2

Best regards,
-- 
Jens Axboe



