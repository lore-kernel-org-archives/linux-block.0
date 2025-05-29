Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB013633F
	for <linux-block@vger.kernel.org>; Thu, 29 May 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748558029; cv=none; b=OeBIxXfqEPtjc2HTYdgNJlUGKANSbo4C+TJzkr5QH7C+f6b8egeMmkadZse75b8LLTNOHvv0El3YsHCW8EwfcYkH0HRkcPq9XnZ+CrLOMPyKr5h2GyxNBOtvD+M5hAwywoQLR82ggJG7QjAiANnpYudpoI3+Rp0hUvI75JBfNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748558029; c=relaxed/simple;
	bh=8/ndSRdCQFKs7rSX8PqwJiJYpFKZB81926SOkhqa1CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlbtjgnvqtJhOKYcjmTHoRzV/gBXBUX/UcuMNZ8Ip/Wsi8FuF1Ily+axv00xS2y8NaXKWnAlN0PnNZh2vJ/6licsK9QpswwKSEyQpJRXYN9OYQzGel2kPEgM3DdU/9+fGTBVfPLgawKafo0S6UxEeegbMhYEHwvOSBcQDRsgKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A4hE2L7J; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A4hE2L7J"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c9907967so1460793b3a.1
        for <linux-block@vger.kernel.org>; Thu, 29 May 2025 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748558027; x=1749162827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YSacIhSUe8j0kgUdoeFBNzPh1NsgF2V23hohzX3NnI=;
        b=A4hE2L7JSwOEjAAM0A38oYEShPGx/2PDM1gFiC5k0h8aVCt6Zq5VmY6Sfmb4fQqd3x
         fN40VW2UzwM3RFtY7ciNT2b4YOs3LkITe4FCwUZ/s3RtdPZtYmJpHvumJqNdba1BEJ9z
         wYV0k2r1lIZ3y96AGJg6ccLavLYRZMLk3P/i078w/LdP88TeAMl5SV1m4PO42P22jLg9
         m/vGcodDvhyDvi/ntJlKY8GIYlcRgdCC2Wyx+3TOOfFyzRg1vhJc0vxNHsiLgZz3rnOz
         hw/EpZUeEPdVaheOXtPr20uaknOjj5dh4Mf4VnMD9c/5XiOrFhdxauiyJm+ArwwEBrgU
         +xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748558027; x=1749162827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YSacIhSUe8j0kgUdoeFBNzPh1NsgF2V23hohzX3NnI=;
        b=shMahNbcDcKMaeleqJswR8gvRG9AO344qlYoWxTblgMigVEqVfjuDtg/kPQjfd/DVZ
         TavqGtXGqTNjajUoxFdDn188Kp8JbtS23yD5M+q0Cu17ggJIdSWqoCfTAAo8QNVv3Icz
         DwkBazMaMkqRK+Frsh0W7YF9sE867SqxJfke3gCKlh7YCF+TfO1xmMoElhyqznhRclsl
         eTi39IjzamHMbvM8a39WfoP2aNGlwv3wC3Z72XffmrpQeyfp8nrhGBbq5PcPFvyjA/uV
         JiXJ9tmbI8/tTxnrb8j6alnLOb8nFdwQ7yhIXDF2bp6gehmXvJYfNWQawTEexFkG+dcN
         yIYg==
X-Forwarded-Encrypted: i=1; AJvYcCUJkTs0zi8Y2TyWuTUuQxxf8Fy+UQrCJRBj5a7Timlt9+jKqeKw2m7ZXWxDjPKhUi1hnM4bT/9xaOpNCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAE+wChV+tugirYPUmrMZO7p6GPK2pWqyC9Plddyfc+9FVB3Nz
	rgbfSHq+YZnWcfd1SO7mb1Rwx513eJFzKxjaPSFN5MnIlkqPNSNK+DiFieeerclhAW0=
X-Gm-Gg: ASbGncvSYJroX1mn0RKnFcYUmbm+B/26louFr5NEmulo0CSP3FHHRYx+ndcFJs6Mz7K
	+jJjSARzBDOQR5deUz2RIia13+D7aXIUPZJzlGlrKwdU9Bj7B0hEOoMw4ZuSj0CHxugwwI+T/ZD
	ONu6G5K31TxvdHT5hedRQwop56QUVaNuwKsVD81X/2vZxyO9e/Hm5yJ7de7VmXhKuWbiS7ykl9w
	QTdu5XCU1TVpZCjZadbn4ygzI5O7HHjSbET8CXM7VJ51ucAdhLXPHJmp+ZjzIwuiyp7zGagJ+8O
	9/3oXHFeJGf3r4EYEQS/HZdtoxzlY9SC6bPnWxAXbKvIB+pNnAioG6oEA0nxpJlj1nxPy0c/x/A
	0WoY1Ing=
X-Google-Smtp-Source: AGHT+IHZj/1Shba20OZmM3OFPzAX7htJw4MOn1JwrvwJXkeYQGktsBWAgY05GzRUNgBCepuiRXfRSg==
X-Received: by 2002:a05:6a00:2d1d:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-747bd94c561mr1395176b3a.5.1748558027606;
        Thu, 29 May 2025 15:33:47 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-747afeab33dsm1810293b3a.41.2025.05.29.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 15:33:47 -0700 (PDT)
Date: Thu, 29 May 2025 15:33:45 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] block: Fix blk_sync_queue() to properly stop timeout
 timer
Message-ID: <20250529223345.GA2013185-mkhalfella@purestorage.com>
References: <20250529214928.2112990-1-mkhalfella@purestorage.com>
 <aDjcA_H7Ec9VICps@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDjcA_H7Ec9VICps@kbusch-mbp>

On 2025-05-29 16:13:23 -0600, Keith Busch wrote:
> On Thu, May 29, 2025 at 03:49:28PM -0600, Mohamed Khalfella wrote:
> > nvme-fc initiator hit hung_task with stacktrace above while handling
> > request timeout call. The work thread is waiting for itself to finish
> > which is never going to happen. From the stacktrace the nvme controller
> > was in NVME_CTRL_CONNECTING state when nvme_fc_timeout() was called.
> > We do not expect to get IO timeout call in NVME_CTRL_CONNECTING state
> > because blk_sync_queue() must have been called on this queue before
> > switching from NVME_CTRL_RESETTING to NVME_CTRL_CONNECTING.
> > 
> > It turned out that blk_sync_queue() did not stop q->timeout_work from
> > running as expected. nvme_fc_timeout() returned BLK_EH_RESET_TIMER
> > causing q->timeout to be rearmed after it was canceled earlier.
> > q->timeout queued q->timeout_work after the controller switched to
> > NVME_CTRL_CONNECTING state causing deadlock above.
> > 
> > Add QUEUE_FLAG_NOTIMEOUT queue flag to tell q->timeout not to queue
> > q->timeout_work while queue is being synced. Update blk_sync_queue() to
> > cancel q->timeout_work first and then cancel q->timeout.
> 
> I feel like this is a nvme-fc problem that doesn't need the block layer
> to handle. Just don't sync the queues within the timeout workqueue
> context.

Agreed on nvme-fc should not sync queues within timeout work, and I am
testing a patch to fix nvme-fc. At the same time blk_sync_queue() should
provide a guarantee that q->timeout_work will not run after the function
returns, no?
