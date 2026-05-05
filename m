Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B23E3C78
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967231; cv=none; b=oR1zhxr27yv0pEqgbMk6pV6B+GYzhuc7xQcZw4zZVy6JV9iAtGOP0TZTpopXpk2uzJeQg9gSHBfv6v/Crss0jao883ENPxPBGRDGBZvpiBGn2y+O1+pK02WR69r8g/xy6vQ+6kAqRWw0+BQ1gzwT+MC76HvdWO9TTAHTgPZ8NlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967231; c=relaxed/simple;
	bh=6ZXj16g3fEJcozefgZWcR9D8SA/Rm5KEiZR4mV3Uyyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbAiVFQstPv2OtjOt9/+DoB9s9Inle+wTyoiCw6KN0yJWyG5EVKhk/OTgK7Hhyq0Vf2MXe7NB48In+pyC3IS72MktsKwY9we/GV0kxQfAtTJH0M8fqhDgHpvfUqc0ZijJh28MMPz+orS+Lks4WAHJqNGaKQRu4X7vRK2y+n7bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Z2BVkdkA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Z2BVkdkA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so55344085e9.2
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967226; x=1778572026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onecfRphJlnqE/oCTJaBYZT0sys6LeQeVoSHHXdD2ss=;
        b=Z2BVkdkAAFhu+GneoEIeNZE3XOTf8H8vdCmMKA0caYcyVtsvdvT9buRXeKhdh9a9rC
         ILMS0Xfqb3MTy8UVWYj+oHQeUj1SJONt0y52c45vAKXOpsQGO5SisazSmp0JdWHfruQ3
         Z+i+Vk1ukNs7G/EELNpNlRTIumXgakactSJn9bJwhfqbPBPN9uqbZpl2HeFft4wR7NYU
         o4Zsm9Sro/RcMTjyayy8GN8UdcTJN9fKT9xKy2EHoV2b2/vZ7BQfwGQi3QoWwiEwqxYv
         /vFk3V6AY2bFeotNOUks+U52T44JfPjKrFlUNWja34e8F5UQOZptugmPRp0wngk5HmT+
         293Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967226; x=1778572026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onecfRphJlnqE/oCTJaBYZT0sys6LeQeVoSHHXdD2ss=;
        b=j/8rPw0P+Wo84SNL2BPKclt8eoztvTw3F24DT6bXCRg+LB5DRbYaPUr6Q8KvpGhDfG
         hH4MbXmglfkB3UrOnAvCei694A2wgZ8td6cAibkeX8dhPx+ec1gUafuHIFXg1ZDXCbIY
         kV7kFJhB0j3zjvnW7C+OFWc3zYh+5t5VqbDUXJB1SdOSNRdjSzokQILtVWDjBrvVnlyV
         +pwjyqhESrZ6ffpf45rJJxbGJUrwM4bxZPYeHVDTpGkSfDhDUnRCYR8+X+WFU9khqFa8
         jENLYsi40fjEA3nBrwdYZkpLA4d2lAVkjBq9iE6MnsyzktLniXXEsnbrcErjA95YBXCz
         lLeA==
X-Gm-Message-State: AOJu0YwWL3eE9XFAwCYvJSILbk+EuU+jj9OLyK16AP9NOhUBQBzgPaS/
	GbwDyo0Ua0DYRItJGV3oedO1OI2HQdqv5Z4X1q6MEevGzFnX0fvHhyH/XJmv2DCVLGJ5dSHgGGg
	KDNan4M7kjg==
X-Gm-Gg: AeBDiev6C0Q9erYTu9rmRtCxUNl20X/0nn2CODPHF6PLc/ElESqWtYxZXs6Ue8YEb0E
	yWDsTxAPET4P9zvAHOiMXasVhNu/kykEM6SuqEDc/DAPa/rhP95KTEzh/lBoKTEaiCJ6O1yPNXZ
	MdkdmVCO1oJ01deyDkdimvNmivxSE7zBYL1HnYTcy5B83rRLItC8ptidGk9H2beAAhtzuyxY3X3
	n1ke/Yq7q1yeItDjkj2sKIp6TYzRwY5SW+woQ8KIhpmbIFAs8EVT1JIXwfnshcvuAJPUHjhnv9D
	UZ7H0wS9kcyT9yU3aytt31jeDPqIlJ4YS6Ve3BT5NGwZpasFkbIZS+aPm//8QaQQLrztE68VsaK
	86DGHYgOJ+hDf7mNa8aIdWBUoRlNXfqw2hM2Usn3l08KyDPyNCrLn+8kHbzC1UkOGdYyQVWCbRZ
	8Y3OxskV6spyLtXbrxtwyJHJFB7vBP6ApW/Ko/z0WW1qP5uhwKstH+RCwcj18ZmA3Q4iPzTNBhZ
	1YGUNj3siepf4arHBLa3ia04ol2m2VoPTrDAY3txuYUK/JqRLfY4Te/
X-Received: by 2002:a05:600c:4e43:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48a98638227mr224821345e9.12.1777967225951;
        Tue, 05 May 2026 00:47:05 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:05 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	jgg@ziepe.ca,
	leon@kernel.org,
	jinpu.wang@ionos.com,
	Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [LSF/MM/BPF RFC PATCH 00/13] 
Date: Tue,  5 May 2026 09:46:12 +0200
Message-ID: <20260505074644.195453-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following a conversation with Bart yesterday, I am sending the RMR+BRMR
code through patch for easier review.

The patches apply over the for-next branch of the block tree over commit
07dfa981ca3

For context,
RMR (Reliable Multicast over RTRS) is a kernel module that provides
active-active block-level replication over RDMA. It guarantees delivery
of IO to a group of storage nodes and handles resynchronization of data
directly between storage nodes without involving the compute client.

BRMR (Block device over RMR) sits on top of RMR and exposes a standard
Linux block device (/dev/brmrX) backed by an RMR pool. Together, RMR and
BRMR provide a single-hop replication and resynchronization solution for
RDMA-connected storage clusters.

My session is on Wednesday, at 12 in the storage room (Istanbul).

The modules are still in-development. Many of the parts are only
functionally complete. Some features (backend store replace) are
disabled for now.

Documentation: https://ionos-cloud.github.io/rmr.io/index.html
GitHub link: https://github.com/ionos-cloud/RMR (for kernel v6.12)

Md Haris Iqbal (13):
  RDMA/rmr: add public and private headers
  RDMA/rmr: add shared library code (pool, map, request)
  RDMA/rmr: client: main functionality
  RDMA/rmr: client: sysfs interface functions
  RDMA/rmr: server: main functionality
  RDMA/rmr: server: sysfs interface functions
  RDMA/rmr: include client and server modules into kernel compilation
  block/brmr: add private headers with brmr protocol structs and helpers
  block/brmr: client: main functionality
  block/brmr: client: sysfs interface functions
  block/brmr: server: main functionality
  block/brmr: server: sysfs interface functions
  block/brmr: include client and server modules into kernel compilation

 drivers/block/Kconfig                      |    2 +
 drivers/block/Makefile                     |    1 +
 drivers/block/brmr/Kconfig                 |   28 +
 drivers/block/brmr/Makefile                |   16 +
 drivers/block/brmr/brmr-clt-reque.c        |  228 ++
 drivers/block/brmr/brmr-clt-stats.c        |  332 ++
 drivers/block/brmr/brmr-clt-sysfs.c        |  463 +++
 drivers/block/brmr/brmr-clt.c              | 1222 +++++++
 drivers/block/brmr/brmr-clt.h              |  299 ++
 drivers/block/brmr/brmr-proto.h            |  121 +
 drivers/block/brmr/brmr-srv-sysfs.c        |  707 ++++
 drivers/block/brmr/brmr-srv.c              | 1402 +++++++
 drivers/block/brmr/brmr-srv.h              |  133 +
 drivers/infiniband/Kconfig                 |    1 +
 drivers/infiniband/ulp/Makefile            |    1 +
 drivers/infiniband/ulp/rmr/Kconfig         |   35 +
 drivers/infiniband/ulp/rmr/Makefile        |   23 +
 drivers/infiniband/ulp/rmr/rmr-clt-stats.c |   29 +
 drivers/infiniband/ulp/rmr/rmr-clt-sysfs.c | 1496 ++++++++
 drivers/infiniband/ulp/rmr/rmr-clt-trace.c |   11 +
 drivers/infiniband/ulp/rmr/rmr-clt-trace.h |  110 +
 drivers/infiniband/ulp/rmr/rmr-clt.c       | 3866 ++++++++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-clt.h       |  291 ++
 drivers/infiniband/ulp/rmr/rmr-map-mgmt.c  |  933 +++++
 drivers/infiniband/ulp/rmr/rmr-map.c       |  904 +++++
 drivers/infiniband/ulp/rmr/rmr-map.h       |  246 ++
 drivers/infiniband/ulp/rmr/rmr-pool.c      |  401 ++
 drivers/infiniband/ulp/rmr/rmr-pool.h      |  400 ++
 drivers/infiniband/ulp/rmr/rmr-proto.h     |  273 ++
 drivers/infiniband/ulp/rmr/rmr-req.c       |  796 ++++
 drivers/infiniband/ulp/rmr/rmr-req.h       |   65 +
 drivers/infiniband/ulp/rmr/rmr-srv-md.c    |  764 ++++
 drivers/infiniband/ulp/rmr/rmr-srv-sysfs.c | 1047 ++++++
 drivers/infiniband/ulp/rmr/rmr-srv.c       | 3306 +++++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-srv.h       |  219 ++
 drivers/infiniband/ulp/rmr/rmr.h           |  229 ++
 36 files changed, 20400 insertions(+)
 create mode 100644 drivers/block/brmr/Kconfig
 create mode 100644 drivers/block/brmr/Makefile
 create mode 100644 drivers/block/brmr/brmr-clt-reque.c
 create mode 100644 drivers/block/brmr/brmr-clt-stats.c
 create mode 100644 drivers/block/brmr/brmr-clt-sysfs.c
 create mode 100644 drivers/block/brmr/brmr-clt.c
 create mode 100644 drivers/block/brmr/brmr-clt.h
 create mode 100644 drivers/block/brmr/brmr-proto.h
 create mode 100644 drivers/block/brmr/brmr-srv-sysfs.c
 create mode 100644 drivers/block/brmr/brmr-srv.c
 create mode 100644 drivers/block/brmr/brmr-srv.h
 create mode 100644 drivers/infiniband/ulp/rmr/Kconfig
 create mode 100644 drivers/infiniband/ulp/rmr/Makefile
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt-stats.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt-sysfs.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt-trace.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt-trace.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-map-mgmt.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-map.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-map.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-pool.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-pool.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-proto.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-req.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-req.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv-md.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv-sysfs.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr.h

-- 
2.43.0

