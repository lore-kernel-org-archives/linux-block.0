Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F12259CBE
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102718; cv=none; b=NBUa6cUedkc0WNtwo4KdcARls1MTgucKbQH0eF3nxosMI7cTd3sEKDzt7dw7OPVdz+19x27/FXInJNmdm2TU0sZkcgpiNq7q6H649Sqqejd4RlU8I8ksLQF+8vMbmOHfJ06ny9+100/CZrqsDHRhr7rm9ip+jjOWxcw0WYjUl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102718; c=relaxed/simple;
	bh=gPGd2SMtWSwL0Fk7C9vPkOctSj91rK9tyNIlwMh8Ou0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zhuuu0u1jdVkPjJAZ0OnlJz5Q1R1h4KBJ9K8Y/OibVGx4IDRaz2r3FsbSbLML9R3PpwvLHZC6MNeBpCXOLRGIvWGHl6Yv/2XLzx0AfZkmtmvMZn6ti6rm29GVDggY9/aWEb+O2qxO6b54/GwlAaLAhtpPGgN/iR6SQgNqKM4i5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eHPXFtbJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eHPXFtbJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43690d4605dso37784965e9.0
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102715; x=1741707515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSd8ve04q9jkY+lejohEQNGWVY2Fdf6RaTdBEC1rDCo=;
        b=eHPXFtbJf4SnTELpuH75eqCKgXaee+YKiH9TzGShhiME20ldLqlbWsU7uRso+ugJ3J
         Fz7mhKBUijOOUtznRhRipy1oxuXm8yQSSKHcSPypT5UNIuaH3PRZnSX25uC8Ikd3e8S3
         +zyN2aY7q12Nv8U5OY95gpF27M8SYiMnpcZYD4zQLodPI+IZtd7tfB3jTh0QSe4tw1kO
         X8tnlbzZ7nWN/feBYSmSJmzOLHpGiBdoqHIUYh5+fNDEvVBA0LSVtlEl8h5Yr3bgPjS3
         KC0inlVHBmgDu9pG65k2HSmKnncML0fAOp5QbiVeI9UarCEOG+ktxcUaDXW3gLsgkT85
         T5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102715; x=1741707515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSd8ve04q9jkY+lejohEQNGWVY2Fdf6RaTdBEC1rDCo=;
        b=rD3JqZnXILXaN+SPn67h6poCSEhRUR9203iMrTutrYg4fAQ+/fjPjizDTs6NMNhAY8
         RXpNFrICJJpR8Y9P7a7yqWW/fQN3Eznmq09GeJHN60tpjltfwObxy9dBVQa5uVigxI5J
         vpIFT5PJpb/YP296IdPmlxkcbUVIAU4dBmf+kBIwOSGrIPyGsX8FRHv2Qg2ZJ3gYI70b
         W8eAvROiSirTm5ggtC9Vua1v5iWET/XYOgKz2D0kOntaMcCHz8uwHyJsg1VuGvVjFlx6
         fiVc8s3wRREtjknUH1J92z91f06uhgNZZh3GY8kEVsH990NBqtvk8gNXHFydfS/i/s6f
         MA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh2+gG1J3Ayc0SEPnhY1qGurgyVhGW56znJtlh+LEL8dMDXos+JuIKp9Whc79zFQax+5xkp2QdmrsHVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqmi/AdAMYcdbFcRiLUWU62C8lEE4N+kE9XaoCWh+GVTGdKJB
	+eDT2CLYxgQflLEc7RrWleSNcqGzMtGTVmAQyLB503K3BIqKrawEAWFPtlx7wH4=
X-Gm-Gg: ASbGnctg0f8hwJAW/pGRP2M0SXi+FxjyoacXq991O7v5kYM5gQZIM6YwYrZK+lpfCSp
	spPP1aKvIoubP5q9pe8fk3Jb04tTIVacdG6HeQlH7XSN1FwVMlnK2je+TMP7qk0IzQoa7irHRh0
	IvYTh2/izWgvofZAlJdtzLhhGuZyK1kdd1q0FXRzD3ZX0uvQG1ELDksr09oza5XQQO0D6SVDP3I
	rUlzHynHJOLxh6hwrDmrQQSmmPZx6/zhjDgvpusoinG95Idr2rhcs2u1yzUF37m82jfcg8k804i
	i9pJVTDxnIekdSXJHCiiiKHCqxFc16d3JbTvZIY60N9FiY0=
X-Google-Smtp-Source: AGHT+IFCKBTaNh1ji5VjlXmlOoDP8Ygx/PbOCIjfOjueWZr/IzcTQzEGN3dOCOuAsGpaq/YEQ/vJjA==
X-Received: by 2002:a05:600c:4fd1:b0:43b:cad8:ca87 with SMTP id 5b1f17b1804b1-43bcad8cc8dmr26424015e9.1.1741102714833;
        Tue, 04 Mar 2025 07:38:34 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:34 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/9] cgroup v1 deprecation warnings
Date: Tue,  4 Mar 2025 16:37:52 +0100
Message-ID: <20250304153801.597907-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Memory controller had begun to print warning messages when using some
attributes that do no have a counterpart in its cgroup v2
implementation. This is informative to users who run (unwittingly) on v1
or to distros that run v1 (they can learn about such users or prepare
for disabling v1 configs).

I consider the deprecated files in three categories:
  - RE) replacement exists,
  - DN) dropped as non-ideal concept (e.g. non-hierarchical resources),
  - NE) not evaluated (yet).

For RE, I added the replacement into the warning message, DN have only a
plain deprecation message and I marked the commits with NE as RFC.
Also I'd be happy if you would point out some forgotten knobs that'd
deserve similar warnings.
At the end are some cleanup patches I encountered en route.

Michal Koutný (9):
  cgroup/cpuset-v1: Add deprecation warnings to sched_load_balance and
    memory_pressure_enabled
  cgroup/cpuset-v1: Add deprecation warnings to memory_spread_page and
    memory_spread_slab
  cgroup/blkio: Add deprecation warnings to reset_stats
  cgroup: Print warning when /proc/cgroups is read on v2-only system
  RFC cgroup/cpuset-v1: Add deprecation warnings to mem_exclusive and
    mem_hardwall
  RFC cgroup/cpuset-v1: Add deprecation warnings to memory_migrate
  RFC cgroup/cpuset-v1: Add deprecation warnings to
    sched_relax_domain_level
  cgroup: Update file naming comment
  blk-cgroup: Simplify policy files registration

 block/blk-cgroup.c              |  8 ++++++--
 block/blk-ioprio.c              | 23 +++++++----------------
 include/linux/cgroup-defs.h     |  5 ++---
 include/linux/cgroup.h          |  1 +
 kernel/cgroup/cgroup-internal.h |  1 +
 kernel/cgroup/cgroup-v1.c       |  7 +++++++
 kernel/cgroup/cgroup.c          |  4 ++--
 kernel/cgroup/cpuset-v1.c       |  8 ++++++++
 8 files changed, 34 insertions(+), 23 deletions(-)


base-commit: 76544811c850a1f4c055aa182b513b7a843868ea
-- 
2.48.1

