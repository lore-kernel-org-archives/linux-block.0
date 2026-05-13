Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B302BD58A
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680569; cv=none; b=ArKA040lEkL9R6JODSkUtjtqlQnAOC1Tw+YEbWfaEMC6FrubdQL+v03fAQiRlMerrZDzA+zE+PZcfwB2KeOeSfm6LLvyEEDvZ3dV65tXiKauKtfObj6TBzMcs+uN/UF/z4Xt/v6UED+AVhz4ijL3x2jC7wnnUp6mlU187e0+WNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680569; c=relaxed/simple;
	bh=XhltUBaAJNijJMB60BcpKe5hSXdb7Bm8XFFXjh3PJl8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jzrE04C8VVddnZTBpxxS0OtSpW66TOmzIPv5GuT4d+1MRK+8XxBNIW8lYdvCpI+TUHTwgcsGrJ5W25VHCg344IpocZ3/bKzLp/Zg8dI/51WxyoKctj/IXI7lGqCo25566LO1iJzswLli+ZemxqEBzP7LxzZ/1xRH8O2vO/pUHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=AS6v8Wzv; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="AS6v8Wzv"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-439a7e828b1so1322918fac.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778680567; x=1779285367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUsiQzFbsCDbLVSzZ+u0+8y253XZk7g1w4U0y/oBNa0=;
        b=AS6v8Wzv125bsFiyFayDR8uIRlSwZgYCtOT444tYlj3bDMCLDdURNB+jQiH4p3BBHD
         x7MnUTRm/3xvi2BkierMJrjcxkkF15yk/BMfy3pd4af1oxlCknt3bbQOCpHkg+rZnLGS
         mu7l67jSf9ly6ODA+L9DE3y8/6xVUiB/7DmiZ9X+maL4lP8mOzaaHB7ZVGARAIkyImBC
         04RqbiLd7DBOTh+eXgkE0wfwjr8QLjT176v7SKSj/YTLwxnbiU+kj7NH32sN0bSD2obs
         tKwTuFd/hkb9LNqNJ1QaAoXTqNIX3YLbANht1j58joBNAKHtWQzhfEwykf3g25WDSns7
         vRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680567; x=1779285367;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUsiQzFbsCDbLVSzZ+u0+8y253XZk7g1w4U0y/oBNa0=;
        b=ZfWJWD/qD4druWPWHM33qb5/z4QJEORTW4gUIWmSfTCK6p60YwUZHufHMdsqENMF5L
         S8u3GvxOHmOxQIuF/VQAafrij+9ebBSzwhXH+UWnAu1m/hwWGRIbJqMNfBujYc5alxSP
         8sO8FI9jThGW0OvJbYlglLFAoOB6HDEZwx5qTHYgpeOc7Fl4DudOP38fzreAu8OMIN9+
         U4XDvRC8nssYOc3nnybd8n5RqnOg3emV6zJ5XXyOpPIY9gzV25crBjMrvOJQ1UQWYbbh
         P7wZZhQZte2VQOGGD07zF1ylKtjiKDjJcJ1VUJrDbaAgDbkFJLfSCYcDJKddia9V1G1T
         rzfg==
X-Gm-Message-State: AOJu0YxJzl/7G8hkIMXgYUUfcbPSUYCzg42QMbxWo3Qpu49ISaJmHetv
	4B7bfgpvaf53EbNHSfG9UYGzsD8l06M41pRosLsn6lbaM93zZrblANQGydqbqrZdEV7otMZS99K
	mGw/c
X-Gm-Gg: Acq92OHFSopxIgOk6KRcLObDQ9DL8FR1guYthC3muDHQsn947+k1T88FRWBR4wbDdaw
	k2PQLqp0h9JL1+jUK8nCVuxssVpGVfsFYeyvUNLeEY2OWfQ6QyXZZUNAzcS6h113GTHzYd5oKxr
	uNfNKlTmocAzcoUVu9cozzQFA5QLWTJsSJYbFWhb8dizmTI8kziHXUFLL5mKw6FYRLCN6JwpmJN
	6i828Fa2kME8aE13gzEINucv2jbACjb5wfy4jFhO/XJL4rs0hGSxvofF7fvncvnq7TsXUQExiCP
	DsK4yhk5jMi0E4N4w3oymCzDJvwVxXSFvH2Qk/DJxrj5nuopWBlVdGVVc+dIBTEHoXbMjVtgXq/
	2zU7lFt6sSPmtfNZc1M1JwE3w0r9KUmqVfX7fm86FdG2hvMNXTHKGmDpzCHrWUlHv3JOIR4cWIr
	tjilzH1EAGU/8Xba0K5jT99ogp555rDNtZemlEJV/SsaB0Q+6iFy9yev/k1fP+1CSD02EvsLr+C
	pTE
X-Received: by 2002:a05:6870:d609:b0:3e8:9b72:5cda with SMTP id 586e51a60fabf-4399b5dbfb6mr4411331fac.11.1778680567021;
        Wed, 13 May 2026 06:56:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439c0954a81sm2962187fac.18.2026.05.13.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:56:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260513101941.1373998-1-tom.leiming@gmail.com>
References: <20260513101941.1373998-1-tom.leiming@gmail.com>
Subject: Re: [PATCH V2] selftests: ublk: cap nthreads to kernel's actual
 nr_hw_queues
Message-Id: <177868056593.400295.12640470219021357080.b4-ty@b4>
Date: Wed, 13 May 2026 07:56:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 18:19:40 +0800, Ming Lei wrote:
> dev->nthreads is derived from the user-requested queue count before the
> ADD command, but the kernel may reduce nr_hw_queues (capped to
> nr_cpu_ids). When the VM has fewer CPUs than requested queues, the
> daemon creates more handler threads than there are kernel queues.
> 
> In non-batch mode, the extra threads access uninitialized queues
> (q_depth=0), submit zero io_uring SQEs, and block forever in
> io_cqring_wait. In batch mode, the extra threads cause similar hangs
> during device removal.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: cap nthreads to kernel's actual nr_hw_queues
      commit: 87d0740b7c4cc847be1b6f307ab6d8547cb1a726

Best regards,
-- 
Jens Axboe



