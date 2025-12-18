Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC883BB44
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766025702; cv=none; b=kM+tFFp0u5HfRSfjI2J1m/jyMM3zyoiMFzy+i2j45TpBU5/g+GnLch0qSGF96NvI9J5RS0fPzk0LV8xl6q5Spp8zGt6MSvYYEp60PTy640mY+tbfU8iTFKhueX+o4kerCTQ4J3SWVxudtT1Rd4wSciCJJx+Lj8FrLhjDLxL1AKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766025702; c=relaxed/simple;
	bh=fszlObuC7cNaUoTEfJmEqx+EjS6k+AwVEzrkth4Bzwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fbF8yxUF46+xGWbOpQrShr4qAVnrzGub4KMijQ2jUiVSun6eh7tTI9TZkmaq4kRfXfINWii3KiDZFiAaN7qYTdRHHSok3yejhyerSi887528JIIIVb07Nx7PpE60ZTGU6hkyNEGKJ6v0I8Jmp8LCjImYyxn9/twnqPQX5xXLNhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XE+yq0MQ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XE+yq0MQ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c6da42fbd4so53365a34.1
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 18:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766025700; x=1766630500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9uwrXzDESv1rYaGqjObtlUzrS3biP31gVjvDPSv0Ag=;
        b=XE+yq0MQjU8c1JD2qGOJDRe/08kyDv1tuRis6oIWvIxk6hcDhwX3L3bf4VbP5wzSyN
         Fb8Lbwk1JS2IH0QFUzXx4LG89T4KUJedKAfTMqSq0AJvu8F2sQo2/ChZUpgX1W1JIi5o
         MJVR4IxAOeG6JdJGsZTCJ86+ZocMT/UNWiRgJf1aPXskBkSzBnsdlmhqCFN6lL6jHCXG
         FtYPy9f4Q2N94A6k1N6jwsuLW2d5onoU77FX6UtG5XdAjXnQiHO4J8a8PBFL4bgrAOe0
         kgVylHQKAeOr2qvXfsT/wrbNSDEI8Ts4LfiZByFZWO/Z4ragkzBUzhPPDkGRQ5oeQWxP
         g1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766025700; x=1766630500;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9uwrXzDESv1rYaGqjObtlUzrS3biP31gVjvDPSv0Ag=;
        b=v+83n/aGsArec474910MtMF04ij/X/igq0+MPyehNJPQMT5lr0JOEMMjQdjdxj3jKb
         kwY2jHur10elruQk2C8DQyGtUJVZ8JPIth1pJd5cjzLBSj8QUryx3o5MplNZuts4mXWf
         fAXFxnMo2q0XvaY2opxbnNYg0q6F0OV42dHfnOh1LL7DA73Mr+Pjh8egfPFLTXNc6/VD
         ClVR/FysyYtO9YUxO0D6agpE7/ElEhPLRoyCW/Bdip6iOSbYXe6jx34zIegAfym+VLbp
         GEYcapHeH5OlYdPDzW0MnyCMoPk8HYeayImoab2PgH3barjulw7+x6VSNVnKMx3zv+cu
         68ng==
X-Gm-Message-State: AOJu0YxodfSCwyBnV9RquBh9tR/nvBFV3B9gSXPeOBb6uJi4HmU+aWvc
	/cLI7qGQ89fyngx9Q1Te40u1AnhBHlWtry4/SiqXbfzjR46p5T8CkWGLkTDbiOVqWk4MR2AmmE+
	QkPAoH1E=
X-Gm-Gg: AY/fxX4adFL2ZGvJnHg6nYrELr52zNrstUPTkwc+/WDGindIDu1SEzSAKgxmFxUfXIC
	tIWs9yHLXemg0prEb0VmFY4LhetnUVbvewGfuEh8aH0sIkyF9XK65vBPE3cqB0CfvL0CIVk4OTE
	Q3yHttr7hPg18L9lNIegzcwZvA0r2+Mvii9dOVpImgx0Llj4NRs1Wow3kO+5gpe5R0tDuV2u65G
	j6N0TlOc/bfJ5sQGr8uVydn1rS7QO3SvS+DY+43baMlFEZ0Tiu+JajumITuaOU5vixu+NS7XH85
	tOleGL+252JYGRup6Vs2REzJNDdmF55IBi2HFpwe6V6NoYQgPAOLsQzZmfO9748MKufDxi07sfD
	O9Hh/hQuPzBdhzt30hLsDq70mA9tmCtRcINtl58BqlbICzF6xW3L0vIEtvMMKMe0NvW+QS1PoOz
	1C068QJ74S8RQ1uw==
X-Google-Smtp-Source: AGHT+IF5gU/cj22U4KKR/EBhqNWnoMQfTT25sftjT3yGCYWOEAfpazmknhSlvPXdqtKRqnn5KNA/9g==
X-Received: by 2002:a05:6830:488a:b0:7cb:1309:5b64 with SMTP id 46e09a7af769-7cb13095d4dmr3292793a34.36.1766025699839;
        Wed, 17 Dec 2025 18:41:39 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc59a7d560sm794948a34.11.2025.12.17.18.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 18:41:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20251212143415.485359-1-ming.lei@redhat.com>
References: <20251212143415.485359-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
Message-Id: <176602569801.193494.13054789455823293484.b4-ty@kernel.dk>
Date: Wed, 17 Dec 2025 19:41:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 12 Dec 2025 22:34:15 +0800, Ming Lei wrote:
> When one process(such as udev) opens ublk block device (e.g., to read
> the partition table via bdev_open()), a deadlock[1] can occur:
> 
> 1. bdev_open() grabs disk->open_mutex
> 2. The process issues read I/O to ublk backend to read partition table
> 3. In __ublk_complete_rq(), blk_update_request() or blk_mq_end_request()
>    runs bio->bi_end_io() callbacks
> 4. If this triggers fput() on file descriptor of ublk block device, the
>    work may be deferred to current task's task work (see fput() implementation)
> 5. This eventually calls blkdev_release() from the same context
> 6. blkdev_release() tries to grab disk->open_mutex again
> 7. Deadlock: same task waiting for a mutex it already holds
> 
> [...]

Applied, thanks!

[1/1] ublk: fix deadlock when reading partition table
      commit: c258f5c4502c9667bccf5d76fa731ab9c96687c1

Best regards,
-- 
Jens Axboe



