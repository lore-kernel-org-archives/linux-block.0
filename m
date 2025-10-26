Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F82FFF93
	for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510992; cv=none; b=UxJ3YUKCAr9PqtBiezoOkSpTt34NAYBn/qvF6O60HGljTG+GRW2U2nhxw47FMsB8yc77nbLMCFyCbZsZJMYdwJ7NBD0zHVKc9nUuAUKfA3h5kBi8R/8PI4X8UA4rJQoXl4cYZWLdumD3U73FDBimCrm0sPubyYPohIGyER1PwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510992; c=relaxed/simple;
	bh=FG105iAm7VhwqOQJGRZUv7dug7lik/o0qqXe1nIg2+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DnigXj4PUG26HoObYraejjiwTHtEEiniHMIxamzy4yJmimvESMwsIAD3fhZnFQg0jk8y1HCS0BGMHMe1+Bw9UtXk2eHdVFFH3HgUco0Eb4ShV7iBNI1Y7ej+UUeF+P8IpYZnKU0CgotcJZF6y+uLkcH4GojW66f4CQlG4DhmOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJT199Fu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJT199Fu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26985173d8eso101259875ad.1
        for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510988; x=1762115788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+hwvxvjiT/648L8Azhj+YaogvoFsk4ZqGTdVX9dBk8=;
        b=EJT199Fut8qsi+cH7DPrE9zAMG0OeSyGiAo3+CNbYt+3v6ZNlSB/QIHaiBqZ2Yg055
         yBn7YbqQHPSwEGThgU1JhDsFVoRcU2az8aiiANo8hll1GTURz5yadwKMVEem3BzEBhWY
         xN407OM36sPVtNWhY6y5fQ4fFcOC/aTKqpVQeY5fQO2pumKnrG9CA+5WejT49sQ3Z7sK
         s2H7wwiniZrT3VKwqYlfRj+AJF/hEhUq/Ix+3TVSVJjK1sJmz5S4kznbIBKOsLgXA53n
         lp17BBTZbFy7XjuSAXQtgFBEYsJckZy0TDP5dAnztQjdOXnJq3zhveA7VQUH3YJqLvkt
         QXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510988; x=1762115788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+hwvxvjiT/648L8Azhj+YaogvoFsk4ZqGTdVX9dBk8=;
        b=wxyIj5KwXvvbzQ+pLOWRw0eBHmeQOkmdA2He2YNhDUkKc3neKsLw/AGnkWdyy8C7l7
         dLeQA7L9qDS0LocgsG6FVEANBOA6RmoX4uq3PUFJj/DXjQTDHgPI28cZUZ+lBJBUdwJg
         sBPWr3uah2PWmjpMb/MKgyO3gaW4lDJ0QU++K3VO3FSfxOjd3MacwuBPtAY23wDP9ITX
         vID9xfi4RVCErjNeUskODoP1SIizNLMYgPcJ/4YOOBCoz7GLxdTx37zKDQOe2rpJpGIy
         f7rlpMSXeczVXxx1dbke5/A7noCBfBGcACeN79QmQlqtMCcKh4L1W0g48GYzKB3arx8N
         MVSg==
X-Forwarded-Encrypted: i=1; AJvYcCWeBguNQ1SsrAG4vjtjiEPlFUOpI0vyngmVO2aFukmkI+DhCT2DjmGZ/UgjH5k3alQh1y5Y2objm4LnPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUauCn9dwwhsjTXk3AwBCrk0FH+D36IatjcbYhxsgOym3/UDQm
	wJcV5Timc19fsG38HuHAnoYCkXZB0DpV6tD5GAx9/LVxt3c+Z7gXVnA3CRm6H5Cn34w1N6Qu/1x
	MYQOPvg==
X-Google-Smtp-Source: AGHT+IEGiuaYNqtmzAs0E42cvktCDNQUumB1H3lnOt3eYy3N7OB3Lp+O2CXv9ksq+J9ruS+aEn5/XTF4vMk=
X-Received: from pjbgt15.prod.google.com ([2002:a17:90a:f2cf:b0:33b:b662:ae3a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a4c:b0:24c:c8e7:60b5
 with SMTP id d9443c01a7336-290c9cb6243mr210845465ad.16.1761510988422; Sun, 26
 Oct 2025 13:36:28 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:09 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-7-surenb@google.com>
Subject: [PATCH v2 6/8] add cleancache documentation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Document cleancache, its APIs and sysfs interface.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 .../admin-guide/mm/cleancache_sysfs.rst       | 51 ++++++++++++++
 Documentation/admin-guide/mm/index.rst        |  1 +
 Documentation/mm/cleancache.rst               | 68 +++++++++++++++++++
 Documentation/mm/index.rst                    |  1 +
 MAINTAINERS                                   |  2 +
 5 files changed, 123 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/cleancache_sysfs.rst
 create mode 100644 Documentation/mm/cleancache.rst

diff --git a/Documentation/admin-guide/mm/cleancache_sysfs.rst b/Documentation/admin-guide/mm/cleancache_sysfs.rst
new file mode 100644
index 000000000000..503f17008046
--- /dev/null
+++ b/Documentation/admin-guide/mm/cleancache_sysfs.rst
@@ -0,0 +1,51 @@
+==========================
+Cleancache Sysfs Interface
+==========================
+
+If CONFIG_CLEANCACHE_SYSFS is enabled, monitoring of cleancache performance
+can be done via sysfs in the ``/sys/kernel/mm/cleancache`` directory.
+The effectiveness of cleancache can be measured (across all filesystems)
+with provided stats.
+Global stats are published directly under ``/sys/kernel/mm/cleancache`` and
+include:
+
+``stored``
+       number of successful cleancache folio stores.
+
+``skipped``
+       number of folios skipped during cleancache store operation.
+
+``restored``
+       number of successful cleancache folio restore operations.
+
+``missed``
+       number of failed cleancache folio restore operations.
+
+``reclaimed``
+       number of folios reclaimed from the cleancache due to insufficient
+       memory.
+
+``recalled``
+       number of times cleancache folio content was discarded as a result
+       of the cleancache backend taking the folio back.
+
+``invalidated``
+       number of times cleancache folio content was discarded as a result
+       of invalidation.
+
+``cached``
+       number of folios currently cached in the cleancache.
+
+Per-pool stats are published under ``/sys/kernel/mm/cleancache/<pool name>``
+where "pool name" is the name pool was registered under. These stats
+include:
+
+``size``
+       number of folios donated to this pool.
+
+``cached``
+       number of folios currently cached in the pool.
+
+``recalled``
+       number of times cleancache folio content was discarded as a result
+       of the cleancache backend taking the folio back from the pool.
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index ebc83ca20fdc..e22336e5c9d2 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -25,6 +25,7 @@ the Linux memory management.
    :maxdepth: 1
 
    concepts
+   cleancache_sysfs
    cma_debugfs
    damon/index
    hugetlbpage
diff --git a/Documentation/mm/cleancache.rst b/Documentation/mm/cleancache.rst
new file mode 100644
index 000000000000..bd4ee7df2125
--- /dev/null
+++ b/Documentation/mm/cleancache.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+Cleancache
+==========
+
+Motivation
+==========
+
+Cleancache is a feature to utilize unused reserved memory for extending
+page cache.
+
+Cleancache can be thought of as a folio-granularity victim cache for clean
+file-backed pages that the kernel's pageframe replacement algorithm would
+like to keep around, but can't since there isn't enough memory. When the
+memory reclaim mechanism "evicts" a folio, it stores the data contained
+in the folio into cleancache memory which is not directly accessible or
+addressable by the kernel and is of unknown and possibly time-varying
+size.
+
+Later, when a filesystem wishes to access a folio in a file on disk, it
+first checks cleancache to see if it already contains required data; if
+it does, the folio data is copied into the kernel and a disk access is
+avoided.
+
+The memory cleancache uses is donated by other system components, which
+reserve memory not directly addressable by the kernel. By donating this
+memory to cleancache, the memory owner enables its utilization while it
+is not used. Memory donation is done using cleancache backend API and any
+donated memory can be taken back at any time by its donor with no delay
+and with guaranteed success. Since cleancache uses this memory only to
+store clean file-backed data, it can be dropped at any time and therefore
+the donor's request to take back the memory can always be satisfied.
+
+Implementation Overview
+=======================
+
+Cleancache "backend" registers itself with cleancache "frontend" and gets
+a unique pool_id, which it can use in all later API calls to identify the
+pool of folios it donates.
+Once registered, backend can call cleancache_backend_put_folio() or
+cleancache_backend_put_folios() to donate memory to cleancache. Note that
+cleancache currently supports only 0-order folios and will not accept
+larger-order ones. Once the backend needs that memory back, it can get it
+by calling cleancache_backend_get_folio(). Only the original backend can
+take the folio it donated from the cleancache.
+
+Kernel uses cleancache by first calling cleancache_add_fs() to register
+each file system and then using a combination of cleancache_store_folio(),
+cleancache_restore_folio(), cleancache_invalidate_{folio|inode} to store,
+restore and invalidate folio content.
+cleancache_{start|end}_inode_walk() are used to walk over folios inside
+an inode and cleancache_restore_from_inode() is used to restore folios
+during such walks.
+
+From kernel's point of view folios which are copied into cleancache have
+an indefinite lifetime which is completely unknowable by the kernel and so
+may or may not still be in cleancache at any later time. Thus, as its name
+implies, cleancache is not suitable for dirty folios. Cleancache has
+complete discretion over what folios to preserve and what folios to discard
+and when.
+
+Cleancache Performance Metrics
+==============================
+
+Cleancache performance can be measured and monitored using metrics provided
+via sysfs interface under ``/sys/kernel/mm/cleancache`` directory. The
+interface is described in Documentation/admin-guide/mm/cleancache_sysfs.rst.
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index ba6a8872849b..7997879e0695 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -41,6 +41,7 @@ documentation, or deleted if it has served its purpose.
    allocation-profiling
    arch_pgtable_helpers
    balance
+   cleancache
    damon/index
    free_page_reporting
    hmm
diff --git a/MAINTAINERS b/MAINTAINERS
index eb35973e10c8..3aabed281b71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6058,6 +6058,8 @@ M:	Suren Baghdasaryan <surenb@google.com>
 M:	Minchan Kim <minchan@google.com>
 L:	linux-mm@kvack.org
 S:	Maintained
+F:	Documentation/admin-guide/mm/cleancache_sysfs.rst
+F:	Documentation/mm/cleancache.rst
 F:	include/linux/cleancache.h
 F:	mm/cleancache.c
 F:	mm/cleancache_sysfs.c
-- 
2.51.1.851.g4ebd6896fd-goog

