Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9A21FF51
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750444464; cv=none; b=dbDNRfUbbEJ7QLBMzKq0BkQ9Ah86tRKh11etGODl7WeTgBEHIKmK69uP3epkOmG+VkIXPyOpoKLwosN1XIs+o4IvMcAUtMB7cLakpqyAQ/bnV4pSP1eIl1HpfJBVlO1sdI+IvnehPTm/EdPaviuoUXg4owPy8lwnlASgkMRDH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750444464; c=relaxed/simple;
	bh=8XsYzikH0OK5Hpl7wAKc0SWisccif2lNEEKDrwVeCXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbod+J1AdnISI0s7Us65jWpAq+TTJxy3gAJLmZWPbV6RLQE+BncyrL830dixk/kqDQ1mFz1eTRAhDX+b3mBaseoAh3e9/kwwGgrF5ERvpLzzgHCiE4pP0ChHVJo3WYAYzSdp1o+L3NQ7n4JGAfx4kCJjiXZobPuxARTnw1XnXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PHCUpLBc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PHCUpLBc"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso1584149b3a.1
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750444462; x=1751049262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDt9Tud6S9Roh6W5bYJpXYlaicNuFd+r8htTFd4j9Iw=;
        b=PHCUpLBczp8WlIRTMVhRMjZrKHIgetey+N1/WJRlVxWx3jOGwIlz+AodkFiyEA36/e
         tiL2l/uumpMvlZncDBt+mDTPY/7wHGiQT4aoTqQl6HQtI+SCbZ6/Jqa+or3IHoMsL72i
         HUwq3Bdsicu/qrRTCG1iW8mymHaaGsdYO1tZMcytv4QvvEu4kjejp4xg7EMzoOtqCShZ
         c6Sf09ktxaFtXyfqsgWDs46RHcdRwpy26IN7JgOq0HFCLSGdxAxhC2YBfB0aovuP+FMJ
         hbi1IzaFXHw3q8/KJHHzfXhIZZ7IqM/lje93m+2Gvb7MnoA6OjQCjfJ4eEgmVg8UYmhZ
         UF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750444462; x=1751049262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDt9Tud6S9Roh6W5bYJpXYlaicNuFd+r8htTFd4j9Iw=;
        b=YDTafUq+jxpHnsKUQsP/2TqgY/aa7HXs1x2MZnb2LNz7Y43/pNLjqmY2zhQyXaoTxw
         e0tgLtra0paoM6/rZth9Z50veL3B3jAJgmlwvtE7ah3HrVQW9dKEje4mvYgkeY6Nng2h
         VYXnwCXhJCisji65a688hpUkCqrhTL4LQxhxYzbi9kTISjG9De9o7CR6r80hYhUj8kyn
         BNBWZ4dln2P0MYEobkJzx1eZhy69zXn8ir8aQb/Xww7v5rmjUE3F79WlcWWkkMLewJxh
         fqDURMPyBvkHM0UAMPn5CbOHU9J2+tzMiQ/Or33V7RKn2acBcHAucdc0kK+qLSc8lZiI
         rEkg==
X-Forwarded-Encrypted: i=1; AJvYcCWSbW0c96b3egGbXV/fj+mFdu1rpGThcfjEf8DpFjKu506C5UW0TyrxMr2HQSfJ0INwzHUAKF69nlSAOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4DZZjoNI5YeyrptHyjpWB/uvUNLUUH/8LVkFz+2GonDBLWsR
	BeVBq1ZZYru6Mz+N0rqCyxc/LWYiCxYLql+rWj/Mxcn8Zcw6OkGjdWsc5qlOmzMVBBk=
X-Gm-Gg: ASbGncsXTxGx3cgkKL/MLiQAW8Yr7RKJPGoGogOfhoXu73rfHCeHPvPkStL2kBhe5I/
	/oXoktNS9hrSFMVwttN6VrljvDoH66X++42gMGrx/KTX0MzOsV8YWLarkNTF9tML16DEBkykp/T
	tcQ5KJrFUmPLd1QU+sph7k0T+btOm5lJxsl+rC9uQJ/F2q+6Lq07OmQxjatnJ3Woz7vY+e/YELw
	0jAesWaTxjt/1h2H9SqLl1zp3QPZwmiPHQvapRhLs+2l2W58rx+jN0BPXGnLf8nNFSFc/2TMKHf
	3oMOsmUvXvU385kT15zz55JcYyUzEW185i+vMXOTxtmN5bT/kTWAdwjiHeAKej9qjSkpGshmFgC
	YloH6crk/EhDWDgKYBw==
X-Google-Smtp-Source: AGHT+IGUb3KaVzKScxOQe9ijMlNd3nszvLLdCk8NMLmcsF4xnEod7cES0/O1shuIaHHP3sZwlCs2Cw==
X-Received: by 2002:a05:6a20:1593:b0:21f:54e0:b0a3 with SMTP id adf61e73a8af0-22029176202mr5488182637.2.1750444461926;
        Fri, 20 Jun 2025 11:34:21 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a6bd5c7sm2588559b3a.165.2025.06.20.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:34:21 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:34:19 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] block: Fix blk_sync_queue() to properly stop timeout
 timer
Message-ID: <20250620183419.GC4836-mkhalfella@purestorage.com>
References: <20250529214928.2112990-1-mkhalfella@purestorage.com>
 <aDjcA_H7Ec9VICps@kbusch-mbp>
 <20250529223345.GA2013185-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529223345.GA2013185-mkhalfella@purestorage.com>

On 2025-05-29 15:33:47 -0700, Mohamed Khalfella wrote:
> On 2025-05-29 16:13:23 -0600, Keith Busch wrote:
> > On Thu, May 29, 2025 at 03:49:28PM -0600, Mohamed Khalfella wrote:
> > > nvme-fc initiator hit hung_task with stacktrace above while handling
> > > request timeout call. The work thread is waiting for itself to finish
> > > which is never going to happen. From the stacktrace the nvme controller
> > > was in NVME_CTRL_CONNECTING state when nvme_fc_timeout() was called.
> > > We do not expect to get IO timeout call in NVME_CTRL_CONNECTING state
> > > because blk_sync_queue() must have been called on this queue before
> > > switching from NVME_CTRL_RESETTING to NVME_CTRL_CONNECTING.
> > > 
> > > It turned out that blk_sync_queue() did not stop q->timeout_work from
> > > running as expected. nvme_fc_timeout() returned BLK_EH_RESET_TIMER
> > > causing q->timeout to be rearmed after it was canceled earlier.
> > > q->timeout queued q->timeout_work after the controller switched to
> > > NVME_CTRL_CONNECTING state causing deadlock above.
> > > 
> > > Add QUEUE_FLAG_NOTIMEOUT queue flag to tell q->timeout not to queue
> > > q->timeout_work while queue is being synced. Update blk_sync_queue() to
> > > cancel q->timeout_work first and then cancel q->timeout.
> > 
> > I feel like this is a nvme-fc problem that doesn't need the block layer
> > to handle. Just don't sync the queues within the timeout workqueue
> > context.
> 
> Agreed on nvme-fc should not sync queues within timeout work, and I am
> testing a patch to fix nvme-fc. At the same time blk_sync_queue() should
> provide a guarantee that q->timeout_work will not run after the function
> returns, no?

Following up on this patch. I think the issue with blk_sync_queue()
needs to be addressed. If adding a queue flag is not the preferred way
to do it, please let me know what do you suggest and I will make the
code changes.
