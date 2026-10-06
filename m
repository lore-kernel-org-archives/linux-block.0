Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFD3B3C12
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301581; cv=none; b=JuqSjhhykaeOAfRY6larcaH4lZQrmOphCGC0Y8F1lLOzwZ26GXy1aXD9suh3O+nsSp2NiWgfQ4QBabQPoJ35B6p1PIeFwKL3LdDLaRF8PjbRyAbUe877kq0vTXWpoZHFoy3uhLgi1RansEYmGfXeTugD5FWkGUQA9QR23bTKXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301581; c=relaxed/simple;
	bh=NdKVx/kAAvIcfHYBklfeMUqMKDPbPiekB2a6KQ9cR4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1mWXaPtGI82RK05OZZ72sBrTe+OVybVUXYHxBc67zxeUyiOhj0/fvAZCHBw5gKUjKkcgpODGQRPfgjuIlRROCawEqZXzLKi8nLVnFcwLQItB8uFwllXZQ2Nh1SKAnbDEY5sQaQ080N1GZV/DmKrs+XAF0J2K6boMqqe0NHKrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=TY9toAUd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="TY9toAUd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so34846565e9.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301577; x=1791906377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/gteuD3CKm9wTyoGyLA2Y7vgXDVvYBBJ9de/wZCxOo=;
        b=TY9toAUd1WymGHn/pSev/f4bR5bgpjMNBoJXNbNjgUVexf03yc+ucK1Hqi09zBiO8F
         mL662qfgDK25MQHtraRkRunTH8L9GbFtLPSxdWovsDPXXKPuCVgpMq2eDgEirbw8s6EA
         dgxYlNBJqNbkIHh42vV9fECbrCzu7jcXxwYuRF4nLrd7v0uNrGVJVb0/LYf8I8q0fqgE
         BJlPPrADDIJeFzmLx6Eci+QcfDffatlC1V3JzMQe+wN/VCoOZ4P4vSfgbuIlyiRFqJdp
         P5BxmWTE0hAHnZRM/hE8c1vo6n3wsT+txQOQvPVl3drcVzB/VdU9bX+Oa1M/CvwYIQzZ
         XC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301577; x=1791906377;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/gteuD3CKm9wTyoGyLA2Y7vgXDVvYBBJ9de/wZCxOo=;
        b=nXXciCKREtrTn9lqLAA538LCCR4yul8vJpFu8tGUoQklSQLDm70Z3maT0Y/nw81V4k
         /wWRE/EczxKRkDQryonUM1XP2bh4hVXTAA/7pemSsVltm2/kFfYxKD06sCJyV3fIIbPB
         lfcb6wzs25jUzXXuGnN/VcezTZ0ddzEtNMK5TQdB7bOGAnLT+dv6wehRlXB7dQzbuuYm
         WYc/7vfybDaTWke6dAqTOCD31fLvFLzaBXuGVyHdcVshlCM4GNELeMK7Rbmg10WxDgq4
         tK78xi80ju3U/k2kyGl8kYzu3KaVrq8Z47P8TmNnyLixD/um5nbMWX8ZO/ocSXOIQOxG
         j7mQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+lmTWcYub9goPhpeR4SGu30fZlo/mfrxCm/YFBYtjxTYPD82p4rzxRveA9UuBZvC5TUUEro+oomEVwg==@vger.kernel.org
X-Gm-Message-State: AFuF++lO4Y8W324S7IQyqExUC60WkveqnaThdaAW1Kv72nzOrFPExGqe
	OIIbH6yJehLfgGFuuTD4mJaOUvhlM2Nwyel5dcbyTHoQxTcICZWECchRZTTdpwfsuKY=
X-Gm-Gg: AYBFou24+IPI9RJgGaGTXmO6r5GHR/Z0MofW4FAREm/0cLlYSsvz8+cvSP/d+LC/Qli
	zIu22AlC331dvFVXuhqnl+GDGztsiecqrD0M2nyZhQcl3x5uJbZnXPfqAWeNj57cShxTt+22gFL
	iRgemRDHczeT2vXwwNBFQZR5B0JSGoIwHJhfN57WItPYMYSyDEuUqOl0yiN4CRMuqpP1+ZTRjJs
	qdNVI5O1ZU3UG6YxerXS7QFg5a2aP26C5BShkVHfCRittymnbFeGuWxLG70vTWVbM6cUeUZhuDn
	gkMEJt9xjdtMTuwAMqGhnbMtFAPf3slO7XXS7dRPf9u1NaaH4BL8gRGFrwp0NQrSyB1y7al/F6w
	HgivNQGrqiUaicssCmJHZ9FHNfj9elMePfka8dNrJlFbauErFKOOkoprQmYdYiqJjRXwBTvQa3F
	zOu4jmZnTsNlrRL7TrWmp9GhAYzjlob5hw0tFNPWQJlGWRVjRL6lYambfrt8V1HsqVjPLD8XG43
	KWT86oVDyiZJSqftBYdCrYx3Hqf0dea
X-Received: by 2002:a05:600c:4687:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4a1777b8a37mr65460095e9.14.1791301576850;
        Tue, 06 Oct 2026 08:46:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:46:16 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 00/20] drbd: DRBD 9 rework
Date: Tue,  6 Oct 2026 17:45:47 +0200
Message-ID: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As discussed (context: [0]), here is our DRBD 9 rework series, intended
for linux-next via for-7.x/drbd.

This replays about 10-15 years of active out-of-tree development work
[1], depending on your way of counting. The out-of-tree module has
severely diverged from the in-tree version over the years, which is
what we are aiming to fix now.

Hopefully that somewhat excuses (or at least explains) the massive
diffs -- we've tried to come up with a way to group the changes by
topic, but I realize it's still not exactly trivial to review.

We've been polishing this series for a while now, and we have taken
great care to make it as "upstream-presentable" as possible. That said,
there are still probably imperfections. It's a start -- feedback
welcome!

The netlink interface has been reworked so that userspace is not
broken: the existing "drbd" generic netlink family keeps being served
at version 1, and this series does not touch its generated
serialization or its UAPI header.
Every shipped drbd-utils release therefore keeps working against this
driver. DRBD 9's own utilities speak a new family, "drbd2", written as
a YNL specification under Documentation/netlink/specs/ and following
current genetlink conventions; its generated code is checked in as
usual. The driver registers both families and translates each onto the
same wire-neutral core, so the multi-peer administration model is only
reachable through drbd2, while version-1 clients see the single-peer
semantics they expect.

The RDMA and load-balancing TCP (lb-tcp) transports are not part of
this series; they will be submitted separately once they have had the
same treatment. The rdma_ctrl_rcvbuf_size
and rdma_ctrl_sndbuf_size net options do remain in the UAPI: they are
generic transport options that are interpreted by whichever transport is
in use, so there is no reason to remove and later re-add them.

The base for these patches is for-7.4/block, plus a set of preparation
patches that were sent earlier but have not yet been applied [2].

As discussed, the goal is to get this applied to a for-7.x/drbd branch
so it can land in linux-next via block-next. After letting it mature
in linux-next for a while, it should go in via the block tree.

Thanks,
Christoph

[0] https://lore.kernel.org/linux-next/899e0337-9642-4ca6-9050-aeab14fa22ef@kernel.dk/
[1] https://github.com/LINBIT/drbd
[2] https://lore.kernel.org/linux-block/20260923140608.1116713-1-christoph.boehmwalder@linbit.com/


Changes since v1:
- New modern YNL-based drbd2 netlink family
- Compat layer that serves the old drbd v1 netlink family for userspace
  backward compatibility
- Dropped rdma and lb-tcp transports to reduce the diff size, these will
  be sent later
- Incoroporated review feedback from the previous series
- Many checkpatch/style fixes


Christoph Böhmwalder (20):
  drbd: mark as BROKEN during DRBD 9 rework
  drbd: extend wire protocol definitions for DRBD 9
  drbd: introduce DRBD 9 on-disk metadata format
  drbd: add transport layer abstraction
  drbd: add TCP transport implementation
  drbd: add DAX/PMEM support for metadata access
  drbd: add optional compatibility layer for DRBD 8.4
  drbd: add application/resync IO synchronization documentation
  drbd: rework sender for DRBD 9 multi-peer
  drbd: replace per-device state model with multi-peer data structures
  drbd: rewrite state machine for DRBD 9 multi-peer clusters
  drbd: rework activity log and bitmap for multi-peer replication
  drbd: rework request processing for DRBD 9 multi-peer IO
  drbd: rework module core for DRBD 9 transport and multi-peer
  drbd: rework receiver for DRBD 9 transport and multi-peer protocol
  drbd: rework the netlink core for DRBD 9
  drbd: serve the "drbd" genl family at version 1 for existing userspace
  drbd: add the "drbd2" genl family
  drbd: update monitoring interfaces for multi-peer topology
  drbd: remove BROKEN for DRBD

 .../application-resync-synchronization.rst    |   208 +
 .../admin-guide/blockdev/drbd/index.rst       |     1 +
 Documentation/netlink/specs/drbd2.yaml        |  2476 +++
 drivers/block/drbd/Kconfig                    |    43 +
 drivers/block/drbd/Makefile                   |     9 +-
 drivers/block/drbd/drbd2_nl_gen.c             |   748 +
 drivers/block/drbd/drbd2_nl_gen.h             |   107 +
 drivers/block/drbd/drbd_actlog.c              |  1267 +-
 drivers/block/drbd/drbd_bitmap.c              |  1989 +-
 drivers/block/drbd/drbd_config.h              |    44 +-
 drivers/block/drbd/drbd_dax_pmem.c            |   172 +
 drivers/block/drbd/drbd_dax_pmem.h            |    43 +
 drivers/block/drbd/drbd_debugfs.c             |  1721 +-
 drivers/block/drbd/drbd_debugfs.h             |     2 +
 drivers/block/drbd/drbd_int.h                 |  3748 ++--
 drivers/block/drbd/drbd_interval.c            |    37 +-
 drivers/block/drbd/drbd_interval.h            |   125 +-
 drivers/block/drbd/drbd_legacy_84.c           |   641 +
 drivers/block/drbd/drbd_legacy_84.h           |   129 +
 drivers/block/drbd/drbd_main.c                |  6680 +++++--
 drivers/block/drbd/drbd_meta_data.h           |   154 +
 drivers/block/drbd/drbd_nl.c                  |  9477 ++++++---
 drivers/block/drbd/drbd_nl.h                  |   390 +
 drivers/block/drbd/drbd_nl_84.c               |  3622 ++++
 drivers/block/drbd/drbd_nl_defaults.c         |   167 +
 drivers/block/drbd/drbd_nl_drbd2.c            |  2533 +++
 drivers/block/drbd/drbd_nl_types.h            |   388 +
 drivers/block/drbd/drbd_polymorph_printk.h    |    37 +-
 drivers/block/drbd/drbd_proc.c                |   327 +-
 drivers/block/drbd/drbd_protocol.h            |   614 +-
 drivers/block/drbd/drbd_receiver.c            | 16314 ++++++++++++----
 drivers/block/drbd/drbd_req.c                 |  3172 ++-
 drivers/block/drbd/drbd_req.h                 |   332 +-
 drivers/block/drbd/drbd_sender.c              |  4354 +++--
 drivers/block/drbd/drbd_state.c               |  8963 +++++++--
 drivers/block/drbd/drbd_state.h               |   326 +-
 drivers/block/drbd/drbd_state_change.h        |    80 +-
 drivers/block/drbd/drbd_strings.c             |   103 +-
 drivers/block/drbd/drbd_strings.h             |     4 +-
 drivers/block/drbd/drbd_transport.c           |   545 +
 drivers/block/drbd/drbd_transport.h           |   480 +
 drivers/block/drbd/drbd_transport_tcp.c       |  1746 ++
 drivers/block/drbd/drbd_transport_template.c  |   164 +
 include/uapi/linux/drbd.h                     |   299 +-
 include/uapi/linux/drbd2.h                    |  1012 +
 include/uapi/linux/drbd_limits.h              |   135 +-
 46 files changed, 58914 insertions(+), 17014 deletions(-)
 create mode 100644 Documentation/admin-guide/blockdev/drbd/application-resync-synchronization.rst
 create mode 100644 Documentation/netlink/specs/drbd2.yaml
 create mode 100644 drivers/block/drbd/drbd2_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd2_nl_gen.h
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.h
 create mode 100644 drivers/block/drbd/drbd_legacy_84.c
 create mode 100644 drivers/block/drbd/drbd_legacy_84.h
 create mode 100644 drivers/block/drbd/drbd_meta_data.h
 create mode 100644 drivers/block/drbd/drbd_nl.h
 create mode 100644 drivers/block/drbd/drbd_nl_84.c
 create mode 100644 drivers/block/drbd/drbd_nl_defaults.c
 create mode 100644 drivers/block/drbd/drbd_nl_drbd2.c
 create mode 100644 drivers/block/drbd/drbd_nl_types.h
 create mode 100644 drivers/block/drbd/drbd_transport.c
 create mode 100644 drivers/block/drbd/drbd_transport.h
 create mode 100644 drivers/block/drbd/drbd_transport_tcp.c
 create mode 100644 drivers/block/drbd/drbd_transport_template.c
 create mode 100644 include/uapi/linux/drbd2.h


base-commit: c3bcce56763375946bc31a4dac859b4b4cc07ccd
-- 
2.55.0

