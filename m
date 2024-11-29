Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1E19AD8D
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896259; cv=none; b=f4j6qxs/PVG44tJy5fg8ZrE5Xxh7UqSbFPop/a99EDZrwkEEnQsi+VSI+K4HMq0J3vKfnY9nLcUL12haigbHG1OKhNMZAhQO/uKOH1WkWLtkr1KHTDroVqHvKEkXIbHZQ9tDQCEbXfdsXOCg/Lhk5OOt7xFYkMbYbHcpApLElHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896259; c=relaxed/simple;
	bh=oSjtUFsoqxW2jlcfWh83ioLa1cZiBZx1OuGdc1SU+h0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pHC5Jo05ul2Jtu5C7ytcHGjpwlEMUZ/T2dU5ygQCso0QySh+lai+M1XuLCouXGDwHo6vEFhrgCgYFl94CCIH6/baxYB46ugrf6JxrBmasmq/HD3SAM6rx2IMY3LpvQDhdripCnS8IWzoKWwTEHzcUPo34TkiH2a2+xprxSZOECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=S3ycakIt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="S3ycakIt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21210eaa803so18300265ad.2
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 08:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732896257; x=1733501057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QHz8Fpy+ReCENFpmNjc83Oh3B9l1Q+byHC4n7Od6OM=;
        b=S3ycakItCqyEYo1hTTBsDbOTdTwq+eF3rcEgzK8r37WKTqB5JqoCQtDthpQCSpWZ5g
         34kB+3Z+Xy7m+VDmBMYUjJDHLkfA/Lqg+dFkVIAy/dFoa5sfjHjr8U4MPMtK5BFD24O6
         UL9vk+GW0yWpLJ5/i+EmWyXoOGkULTOGM+vG/58z2Oi7wPgCr57OblfF80QV+V2tEB1e
         hAgzJahh7s3iiv2fkQJbxuV0h28FJ40iwpZPZ/y1nlmFSwsjRdEdoWrSoxhMIYD0nTEp
         Ii+9qJ21Mss30j3uww04N3It9jEWS6mLjfwgPEa3IkqyqdtWhrARxyubbTlgSLrPSyuo
         54uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732896257; x=1733501057;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QHz8Fpy+ReCENFpmNjc83Oh3B9l1Q+byHC4n7Od6OM=;
        b=HAMfPbgxTBN6iCZ6conS7l2iwNnmL1+CoXaYRKjUmU5DZs2E6Cm5yQLjI88SftCqyx
         u5lMghAbe/ugmMSxn7nmgqgRfWKt0mlPAAVtdrIXqKe2aAQhkybqueCWwlLZ5npdNXrU
         dyHMXEQKBI4l62WCmiVi2+Fclerz1B0CHRIQdTDDKxhxZWNw7plIIcsRu1UE7lE0N3HL
         uVbRR0rICX3JTPaY0tStJPJlPIbnipQXNFClUQN2TS8MRCYdFIHNiv4uKkCMypHqPTd2
         CZXDl2CNVu2rW7lc7RaAtFQtDa6AVSiHLlFbxtZUvGzgr+WUqkWbOQ3KBPLnFquehzN/
         caOg==
X-Gm-Message-State: AOJu0Yx9F7gI+28LMWGCz5MwoCaTai4BMMi2Y7UUwhu7DTTuqaK6UPt9
	vsVZ/xJBrVivDeP+dinX+YRpVNjGkelZZAr0b0klU9NvX6RqsLONbxEq8W2oYVI=
X-Gm-Gg: ASbGncu8wXi797HJPhMU+iLMHf+znL6gRLramC9rvgz9ftQiVRcMYgzSXWFk8Xcx7MV
	Ipsod9YwzwqJ989eq6a1KTbwvvob14xcJa6Vm83PvL7pWhCKzgTkEgrvxPiXatbY5wzS+jRaNw3
	6g5z92teSV0+djgJNw1wlBT1QkhcewSGfZm06qjuQFtayhAPnSf4XRamTvSJtEtGTtvnt8heMY+
	8XwIjhDIw1Zer0s+Tgv4CJfnhdO8qW53fI0m5oa9w==
X-Google-Smtp-Source: AGHT+IHKuAaYzrVmcoRpFP8FnuUpm9DLYH5CyRXMeCHIOOe1YczAdbA6w9GRsdAyK3azcFqi32Ss9A==
X-Received: by 2002:a17:903:41ca:b0:20b:6d82:acb with SMTP id d9443c01a7336-21501286dfbmr144768965ad.23.1732896257289;
        Fri, 29 Nov 2024 08:04:17 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f46a1sm32302925ad.39.2024.11.29.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:04:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20241126000956.95983-1-dlemoal@kernel.org>
References: <20241126000956.95983-1-dlemoal@kernel.org>
Subject: Re: [PATCH] null_blk: Add rotational feature support
Message-Id: <173289625614.195012.13799955548832996774.b4-ty@kernel.dk>
Date: Fri, 29 Nov 2024 09:04:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 26 Nov 2024 09:09:56 +0900, Damien Le Moal wrote:
> To facilitate testing of kernel functions related to the rotational
> feature (BLK_FEAT_ROTATIONAL) of a block device (e.g. NVMe rotational
> bit support), add the rotational boolean configfs attribute and module
> parameter to the null_blk driver. If set, a null block device will
> report being a rotational device through it queue limits features with
> the BLK_FEAT_ROTATIONAL flag.
> 
> [...]

Applied, thanks!

[1/1] null_blk: Add rotational feature support
      commit: 1c42dabc051ee9b55db21bf66959c7884f3a243e

Best regards,
-- 
Jens Axboe



