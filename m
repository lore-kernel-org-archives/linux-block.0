Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295111FCD1F
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765185; cv=none; b=ItRjsH4aewgc7IZwzPEDKyS5zCFslQFLTZ8m2hrMAQ2nOdpqCJ2h6pV0QxzM1KEjEAA53SqdR1tQUwZ6AbsGrVzDrdAjD+Ll7zPZp8UUVCSbE0+wXGZlJ8iON1q+COJi2+YisaFflKBhJQrQ0x0ZsiQ39FxxBVA77YEWWI/3O2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765185; c=relaxed/simple;
	bh=yCysyJq8LkAwV59hWlEdr5nm3LuUtyB1MER7+k6KPBM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vCTiciokIWeg+PWMdmQvNtAdoMirKB8/WQ8sMlwqxsAGrCv8FyBoHIVfjo1Oxk/Brf3NWKfYQAKG2BEl2td2HpyAZHhJV/P5HORfIoFfsk8kR5DACKn3Dc3wZi68fXdptFf94gARSpDhOYV+ozr7TJt2b48ORXR8kWtqZTrwRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Gr4XCgz7; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Gr4XCgz7"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85df99da233so568695339f.3
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 17:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744765181; x=1745369981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/C6WM1p4MsFZpOQ+vUj/pJa3LPGBmPGfVUv4yVJVX8=;
        b=Gr4XCgz7FhqHqidE+z5arTuaxbP5BSU5poRqRFsgdvnifjuf3uhCmMsHZIayp/1e+9
         b4YQiXiu8ivPZO6G8GV9gQBpsjA4Juvq6cMgd+58wKomgnWLjz5mFseaTD8+8zuFIwBQ
         X07RHf98I78Lt3faLgf6Tl7veJrW5ExrsBPc3HUcdsNWZ6sQylTsnECKR1FFI99wod5i
         WcsghRI47q6pIDHbNZyuWS1CqOXSRBDgwCHzGB81jra/1fqAd1lkOR/Z3vsZXxXKEhB/
         yUb1w6/LaFbDAs3IdVynfNcyLL1jp14ENCmx6Gy5HuDOPEw9G4EzdJnD7uEpS/vRNt5m
         LvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765181; x=1745369981;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/C6WM1p4MsFZpOQ+vUj/pJa3LPGBmPGfVUv4yVJVX8=;
        b=Nu1oMQWZ06wX7JVKpBjPMKV/tfvXGhIrPLPoOeARCKpK145QqPpg1tY/F3AtDG3p5E
         KfZ/nIbARBxn9capO5DB8T6uMHoWDH+XZ56dBOFAR0SpdZAFIDvkSqMMmPmgX6Y0W6vu
         yWUgfRI6JpHSuztjO44bhbEu0fKnl53EidF4MOa0LAW6i+5bBVWQ8WdQ0ruzrTEFFNxU
         MoJJ44QnI4DeJVWaEUoIh/WluJbqfJbp8js/DcDfiPCNFvGwup/ZOk4mNEPZrVUhgr5z
         wo+tH3YR+3QOp9f3y7eFJckR3RdtezLzr70vz5/zbBlRsSryKKzFUKJE5Dqzbb2vasQ5
         vfHg==
X-Forwarded-Encrypted: i=1; AJvYcCW8wNnqVL3IlQhC5Z9WwYt92uyJNrn/jEPT/GwKu32LUXuiLbTB9T0gZv2BhQdSwqmDLbi/fo8AeTiqeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbPOpMybkWZ79jcdGezjwWmUa+5Unfaj2RkjLHZNFTMzlRkjhb
	ipJDW7n+RZfGAxpYGWjlBmswdLRQ4b33qJNhCY26qODDmz9XY/xDGr3/2oBQS7WdvATtZjaGoZP
	j
X-Gm-Gg: ASbGncul327AOPDbXHJzkuV19ZwNyS4zKYM7xd2Ci+9cBuaHrRvQ/LlrthGDFlpiB0H
	jGZku5AaB/r+RmREs34tF9zxptxU41lNEmGQHJUJBRP8wkNskX8mFitJD8dymc760gYuNZfI8cd
	NRy0aICfu8zeYaJWIfF565sUtPsKU05vbnWdsa4TldZezZ/l8I97szWO6AxnZtbznocKw+lbQxW
	QbEFqtkKA/4kh9Ajcs2b/Xh1Ole+1jW1GOfLGOkG8mWtFpWy3ZH8Pc0u70c/QHCKL9+9il5A/pr
	qypd8vbU+ofpZAWjFiDHETqXUQ/5V/AU
X-Google-Smtp-Source: AGHT+IFMU/Y9GoBLUW+BUKmntYFtkxG6e8ZakeLL0UU+aV4r6KGUyGrf615wsayYrIxH2tPsJvDp4g==
X-Received: by 2002:a05:6602:358a:b0:85d:9ea6:59a6 with SMTP id ca18e2360f4ac-861bfbfc385mr179209339f.5.1744765180867;
        Tue, 15 Apr 2025 17:59:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8616522c958sm275458039f.6.2025.04.15.17.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:59:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: djwong@kernel.org, linux-block@vger.kernel.org, ming.lei@redhat.com
In-Reply-To: <20250409130940.3685677-1-hch@lst.de>
References: <20250409130940.3685677-1-hch@lst.de>
Subject: Re: [PATCH] loop: stop using vfs_iter_{read,write} for buffered
 I/O
Message-Id: <174476518001.250948.9754706283754943028.b4-ty@kernel.dk>
Date: Tue, 15 Apr 2025 18:59:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 09 Apr 2025 15:09:40 +0200, Christoph Hellwig wrote:
> vfs_iter_{read,write} always perform direct I/O when the file has the
> O_DIRECT flag set, which breaks disabling direct I/O using the
> LOOP_SET_STATUS / LOOP_SET_STATUS64 ioctls.
> 
> This was recenly reported as a regression, but as far as I can tell
> was only uncovered by better checking for block sizes and has been
> around since the direct I/O support was added.
> 
> [...]

Applied, thanks!

[1/1] loop: stop using vfs_iter_{read,write} for buffered I/O
      commit: f2fed441c69b9237760840a45a004730ff324faf

Best regards,
-- 
Jens Axboe



