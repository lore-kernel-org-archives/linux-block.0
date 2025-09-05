Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D71FDE14
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062333; cv=none; b=U7Df1rMRsHmLnoWOZHLup3eAj6ub0JFapZLy281fJukVjARuP23tt0PfDLn/4RaLinodywpqmfhixeGxNvelChvDbjvWq9Oo0ka3ysDHQpPh6z5y3UbNuzGYYt3P5yo6Hsf9y3voNt5QSJg+5OFpN/hbxfhRX5idnXg3S7RE4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062333; c=relaxed/simple;
	bh=uzmBSMwoXngYjlIholE5r2rVuQmZGx6pYXHocyWiQmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OB4Vrsne0BhPNZ8yj6XzvE2Vwne56fD+OnuoIdRL2N/QtX5NXcAQI9qWFP/zQdM6tjpvGjBBlGTHoRyXIOGtxZAaNPlj5IBmQvogsUU9LoKmIIYsbJMUijHesxMZ8LFNd7VJcW/wJX7SymFOW9FqR9ZzIp9DZjERBIKAQMfPpvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Em3cUYph; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Em3cUYph"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so13485955e9.3
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062329; x=1757667129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBWmDURFeu5TBKEHyo69+X2TtXzrJvvyBPGevz2jbwg=;
        b=Em3cUYph3Oyxjd3WySd0PecR0O+iE8q4A/d3UMOswYgb3a/J/JOcnY68Rj8zd54Yjb
         NTXeOIF0IHNJDosnu0hul5zg8mXQzlv0WD5pRWmwwTXe1joYIMHkJtb7Ea9g/dU0ssdp
         ZcxSKxABdzkdlByfonqPlzFVTksSMRIoMfDLDLs1U6uUT2E1ujrizkHrKLbkjfKw7w6/
         Z1NQVW6MR5YbxHMOJ034Filu8BAaOIpIP672o/2sSuA31In7nMefy+mtlj35lQuphsv4
         omI0+cZ7xZrq71MQAO+PPrYnR5OX3NF04tHnJ/IVudKLXaIqVxulOj685PNRX/HZsWd6
         eu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062329; x=1757667129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBWmDURFeu5TBKEHyo69+X2TtXzrJvvyBPGevz2jbwg=;
        b=Kh6QVxKNc0IWSCPQ56iKnGxvLAMkWy7oSzE8MBwfdvOKVw+ixYepZZQbd7SGlKPI/x
         CaF18e+mQEtULnkisO17BsN0LcG1O2hukX3NxoHmq8hwIhpubRO2HYq2sPrMKTY5acTD
         XlXFvEfK2FZAVGrTL/HIa7FOVraK/4oqSnDUKmgrXXnkXKmewtK/k3QCsI2/G3SwbhXZ
         Bg/wGUwZclSt9KhFFsma1hNpIuygNvVZrGDtKO6vrZqXhuIqQtsb9U5J9BLJtNAdPv0W
         P8C4/uoXVBax81Y/m4y1R3lK9zRBgA7E9VJHArhr0cIxMjIBPv0XIZOKm+a7du6r2ho7
         MUww==
X-Forwarded-Encrypted: i=1; AJvYcCXCIb5TzRK95Mvj57fIKw0RTqQ9+dlSNDEcpfgN+Jd9ts6jvaodjR8fU7iyo46rUF7B3+9LupvPi1OFjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZShhV4afk9SBLBXcfO8BgY3TQFcraMlWZz42tGx9fqJPhamKs
	woUg9dmZG+IbMtJ98mvIPq/K4tdHaoICd1WO0+hdZyGeIrGNyc905tB0Xm/kxcjrEv0=
X-Gm-Gg: ASbGnctPXRdgdfyYC04CMVo93AMkC4VIC8I0qIGSOi4kS+9F3o0T/LjRgxIBfE/e3mT
	dysbQDZ90+mOPNZqmJ4tOTPHkWpqiy86FKMGGH08XhIRpzwJY3xAEXSwkbeA+zdenrgsrWRvjTi
	Q1NubomYTd2+fYWlisfG71hDBpx3+rl1WONHnmTE6++O9wRZG2YzWmIG9RHGjziNYnpBezfjTXx
	a4U6gL8LpP/KiNuq6atKXSdnHa0mWMBnxdDawOM7a/KWSwtHtHpLQNylrUGUaWP3M4e8I/5r2jF
	15ZWihDTvMK8oC3McPtmI/u+7ZyitK4F14ZXw1C/y69Eak4GdYDjGKqsj56l2Lo0ZpvB5O71TsH
	dzTEizgmHeseSx315XHkehCmf/do7QVosHkd7AQrXV2vSqpQ=
X-Google-Smtp-Source: AGHT+IF+/qwt/hDvrjvFcrV36f5UMAxxiiy+FQMCKBe/CySjhZZjN3LkyXnEFc/zkLX0zFf/cCDl5w==
X-Received: by 2002:a05:600c:1584:b0:45d:d609:117f with SMTP id 5b1f17b1804b1-45dd60912c7mr14760715e9.8.1757062329347;
        Fri, 05 Sep 2025 01:52:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm166359115e9.2.2025.09.05.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:52:09 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/3] block: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 10:51:38 +0200
Message-ID: <20250905085141.93357-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.

2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (3):
  drivers/block: replace use of system_wq with system_percpu_wq
  drivers/block: replace use of system_unbound_wq with system_dfl_wq
  drivers/block: WQ_PERCPU added to alloc_workqueue users

 drivers/block/aoe/aoemain.c   | 2 +-
 drivers/block/nbd.c           | 2 +-
 drivers/block/rbd.c           | 2 +-
 drivers/block/rnbd/rnbd-clt.c | 2 +-
 drivers/block/sunvdc.c        | 4 ++--
 drivers/block/virtio_blk.c    | 2 +-
 drivers/block/zram/zram_drv.c | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.51.0

