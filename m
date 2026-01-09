Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB535B137
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967078; cv=none; b=Se/z3nx5wS6FhyfdPv1mokaqi5S3s6sOkmYSFELDfVInDqsG2GmwBgwwVd3DgHZ6H1E0/Xj6+2WqY4rPaE+uFEejHcnQFa+144mGkfJpgFgaIRugtTw2q5T4BJa6SAgLGS9ELLx7MqlhN+F67V9xVL9rQCML4vykGNZguGN7kRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967078; c=relaxed/simple;
	bh=IG7VeOnL0e3SPFIp2OKwM4uDe3Zq7jJjgtFhchcpy20=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A23fS1GO8hIIYF+DZPRDfqfuK482QkgH0zwO+bVcoz2MTgjKu/GWU6Db7jawcheDRugVNg7e+hESJGhqix6R91DMbTzxTYs/qyKe6YQ4E9GeVDZ8youvYpn8aO+CSM2g7sqzgYJook9/HuNY8/n6OlJVGgWJqv5GNMqjoTKzKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Rtohrww7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Rtohrww7"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-459a258561cso1993913b6e.0
        for <linux-block@vger.kernel.org>; Fri, 09 Jan 2026 05:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767967075; x=1768571875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA21iePt7O3/RnbF9+vmt7Uj0PNTlKRj74JnZQkTREA=;
        b=Rtohrww7kEx6IhEbCRd7oBFV8fbC6LzuKZtRFgdokLo0AjN2o5uGo9QEIFYvI1kZ/P
         QvEeUht6nTAY6LfBvpz9eI+JXJaBIrjk/9ZeNOXhINWqELM1EXtKcVe7JPpsM5OGCAjB
         CxPMcBbQz8tReOI3xDsWmtzK1HI1PJPwuMQyKjSkdNu+nFlIlMXrD5Mab8RN689hpoFG
         GVjAaA57F9fpYn1+tkXoO4yzbtXc9NTutsBuaiix/g1YklzLo/8d/jSwleNzWdsopk/O
         m3sH75mCe6tbRzR4f9o4NA3E/6+ymr+/ewVCtEYq/+TXuzH4bQ9lgk8K2udasaYuRD6U
         TYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767967075; x=1768571875;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JA21iePt7O3/RnbF9+vmt7Uj0PNTlKRj74JnZQkTREA=;
        b=NCcIhzxDMmrgpp4fBlRoaUNxxFrMM8NBMN15o+STb0vcquukrXU/wrZJOOA061B15l
         J5SQqJpl6NzVvcZLTYjHKTKvnmYY+YfmqKqlO98BlQvzZFDN3By35cSkg+N/VzCHzsvn
         Ck+2SNyckQXbdGgwbb58qTpPOqumuvNZypoPK7JtCRK2g3XbUfKc0LPAToLt+JTJRWJT
         zQgKfELTLVHgB1cVu22um6F68sASl3BITyNLMEqju5hZrfRe0L8kd50TJVa7XRfmSuYK
         WjQ8vVaOflCW060hhQlKs2IS4Uge220yqm2RxmsfuxZyIXWSWwgRlmpXuU8ZGfNAGe5P
         dFMg==
X-Gm-Message-State: AOJu0YxNYAUTsaLzyP/hnYPWi7zcCmqoUJkCt3W4dZlbNEhb6bD6mzyD
	JQlyL3jehXz4Mup7guLsrp05Y4sLYrAry9lZr+C/do7c2u97WE9mSBaUaiK4ZPcO+i8=
X-Gm-Gg: AY/fxX6RxnAIMMZCmbGv4tp6NQYRxp/+IPRMTsAMuopboL6jE+DUhTBOAXDfNCmDMF0
	bl8WSjqZzYcvODtAAYHywinvcF/0MrHfVsolFvEVF6tibiVza7kqX+xMSJJhjirSXP8ezHxKMfD
	Z7XiiX2pladl5FMTzcdcURvMHOqMqxbzgKeaXiZObqn1eeDsXYSp4NE+hLPqHk8PWLLDbexCK2V
	/sr8aFAjMuGLMRv/BWDUfqhGQcUxCGtV12nPtHLyLFpPbmnVmRWLwgN2kxcW3Xiz2Wu7Hafaf40
	nVyM/ij6m9SGqp4Q27j/KM/U3n+9NZSB6wFsnHbhdAR4XyP6Ax/JjyW27YXYH5th+opcl9TLEXU
	vYw89jyqHMB2CjIDoQGuFGsCyX9mIQYxmB3IDJB+Upu/FjllCvrPl9zVi3YwoRcdkoiU9Wf1svD
	kG/ag=
X-Google-Smtp-Source: AGHT+IERAJyFaR9Jqzl0/mBW0aP4nQcsrOScLnDgCjnYQlJ/kjzcCk5ZJaPs8xDR5/cJ+ZRvDqWb1Q==
X-Received: by 2002:a05:6808:1c0a:b0:450:b92c:aaa2 with SMTP id 5614622812f47-45a5ca711damr8453344b6e.18.1767967074682;
        Fri, 09 Jan 2026 05:57:54 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2894e0sm4793950b6e.13.2026.01.09.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:57:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, Ruikai Peng <ruikai@pwno.io>
In-Reply-To: <20260109121454.278336-1-ming.lei@redhat.com>
References: <20260109121454.278336-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix use-after-free in ublk_partition_scan_work
Message-Id: <176796707339.352942.10082949749228844372.b4-ty@kernel.dk>
Date: Fri, 09 Jan 2026 06:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 09 Jan 2026 20:14:54 +0800, Ming Lei wrote:
> A race condition exists between the async partition scan work and device
> teardown that can lead to a use-after-free of ub->ub_disk:
> 
> 1. ublk_ctrl_start_dev() schedules partition_scan_work after add_disk()
> 2. ublk_stop_dev() calls ublk_stop_dev_unlocked() which does:
>    - del_gendisk(ub->ub_disk)
>    - ublk_detach_disk() sets ub->ub_disk = NULL
>    - put_disk() which may free the disk
> 3. The worker ublk_partition_scan_work() then dereferences ub->ub_disk
>    leading to UAF
> 
> [...]

Applied, thanks!

[1/1] ublk: fix use-after-free in ublk_partition_scan_work
      commit: f0d385f6689f37a2828c686fb279121df006b4cb

Best regards,
-- 
Jens Axboe



