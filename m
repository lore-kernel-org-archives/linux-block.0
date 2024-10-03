Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021654C70
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962614; cv=none; b=UhOk8Kl4iKNDeevrZuUSVYHQPE4hkIywgtc+y3SC7vA5QzESkMkWXlT1kEQ4h4Ek2WEsg1L1mkzijplcdxcg15Oa9l+2ZPa9ELtrUyDLgyQfwwGTe9pjcX0LWg+or+95Roe+gv6UCoy6svZj7GWeFPX/qik+gNFU17yAqR42YUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962614; c=relaxed/simple;
	bh=ru/bxhwvAGcG0XP7ZzYw5ZgekRj3EDqqTHs+X11gJ2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WRr7qMNgrFRmYf5Cv0hmeHlCwKAsEsneR+imFc1iOTf51HD8dzJSqqFphvK0ZYIDBvrbv3G/lNTTNEJpfLeIaLT0sU8uU+pOMyMQRTXRnMhtOqYSotquwT4XX6JI647FcyRBwGVUx8sU82MncFvTyLvjeF8/CeaJ/IYEhqKu/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mmwHCVBC; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mmwHCVBC"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8323b555ae2so47868839f.2
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727962610; x=1728567410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Wzh6cW+7j8OaIj8AlICOtC8A9vA18FAgSrEe9GSck=;
        b=mmwHCVBCmjotKR3w7+2CdkqUG35KvxzbFzDSO5iubPFqW06LynpFM2bNCGdO+Iy3uK
         WPRw3+R8kSinK6nUQAr2CHQtl/et0mL4sUsH/GdirPocEKyd8zdiQyCe7fINNIqb6VJp
         FkbQA4IEcOV1C45Pup63GN9X5EfB0zW+rSF2Qv2ye5K856P3dn233D41LNmb7FmoRkH4
         oYPw7nSpmTsGZLvwN+T0lC+JmGPFcvQJhvTiZMpxJkO4nY01RGDKx39BRD7TFAdFMxj7
         VcWHcrwSJP6eAZERGeyV9BNbxdbGvMChzWofq1VbN6ZbnxjaM119wKUwlmpl9RzI+xpl
         OtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962610; x=1728567410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Wzh6cW+7j8OaIj8AlICOtC8A9vA18FAgSrEe9GSck=;
        b=QpkdqgD5D8j8nUSeyfjhL2izvgK8QqQutKWsLUu15+PQf0YuB7Be7bnH3XLkgcjTZv
         NGzf/aflMgNpnxtZ1ztb3FJ7VzT7MmVLr6Y6rQcizt2dyQPXK6HpEI1/jQ1LnP8P4LDV
         wZ1odtKm2oREM9QOd12pf30rmcu6TW4gQ797UcDlUK/1QcunjwEJK+U+Nk2Jr0/pjL5t
         q6dS6Rywhh8kbtOdDv9iQKLh5E0bLSg7YJTdA+GWlq37karmr++zfisBVByHj94sr7SA
         U832Q9YG/7h//bsob/LKNApqQpTl7vNayLNY7f4iB0Ob3WJMwgtZHjmfniFtQYNzRDEs
         oRcg==
X-Gm-Message-State: AOJu0YwFdPJOqeg3apyeBHtIMX9KPe8+6D8/WfwYqKLyoZGntY3x4bRS
	BlQLJuRA7/4bpYYNASuhoUzDB3bbJ6cxvwrP1SQFqBQ3pCD9TpfwGb6aIp1oP17zdnWnG0o7Nqd
	clrDVfg==
X-Google-Smtp-Source: AGHT+IF0fJNbwxE1R97Dr68/9GbFEadmdhC1ADX+CX5Llb4xpxkEsjdT+k2RM2kI7UUw3srATOL97Q==
X-Received: by 2002:a05:6602:6342:b0:834:f2ff:ad66 with SMTP id ca18e2360f4ac-834f2ffaddfmr83302439f.5.1727962610115;
        Thu, 03 Oct 2024 06:36:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55a63fd5sm274128173.100.2024.10.03.06.36.49
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:36:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET 0/2] Further block iostat cleanups
Date: Thu,  3 Oct 2024 07:35:31 -0600
Message-ID: <20241003133646.167231-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

1) Drop unnecessary ->part check, RQF_IO_STAT should always be the only
   gating factor for if the request is accounted or not.

2) Kill blk_do_io_stat() helper, as now the only thing being checked is
   RQF_IO_STAT and hence it serves no purpose.

 block/blk-merge.c | 13 ++++++-------
 block/blk-mq.c    |  7 +++----
 block/blk.h       | 11 -----------
 3 files changed, 9 insertions(+), 22 deletions(-)

-- 
Jens Axboe

