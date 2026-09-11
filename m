Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CD35C692
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138023; cv=none; b=kvTwg36rmr3JWLdAZmkX/5zNTuvdR4XpOVy0gqAn2C1gqGk80UQS9fumLuD8slWQKXjnajRp6kuqCB2ZTLhWr4uIO1rHHSKHU1Kc0OswLK9h92qZ8AlGCyLXU7uQzGz50VzaOU80VrBeethvuAS7k4yG0TwDLqc8kSduiNZQOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138023; c=relaxed/simple;
	bh=DmDN6UHtKvikcXdajHKVO+yHNn5RNaijR4wIa+sYjRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rsdo0gI9RvljEHh9LwCnN7BDi2I44xg+w2wUBbnIESKCYTowvyXVzHu4ptCEb/7B9+nwN60FPQRidr1EjdlC6ES6g6TAYenstfEPrQ8FNTV96q78fAR02xfL/uO7K+PcJtKfNmv0HOQgorxa8i5yZywo4S5VPfkZDUtQ1makkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B4uAGCpW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B4uAGCpW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495437bb891so4841455e9.1
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789138018; x=1789742818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DAY0H524IPnoUin0wM315IyLKxNaVBFm7h+DvdUw5U=;
        b=B4uAGCpWL5jpC8i1sY5F+3M4833A8BFjWN6LmY6MP4JQjZc5Ifb4szZU4q47YDSqFg
         8rB2pBsDFN9ddgmA17zUhtJZ1cf3mqkYsQLmNEBfx9DTq/fR9pctpKx3oJmWcJIKvjYa
         Qjk3RbZvRdMMoAJ1riJU9GXdTRspE4CFCh8IywRMw6mcdiUTiq8zo9HLQ14sJcYvP+U2
         jsI7GZUnhFf/4QIhvNo87/no0MO7ukavX183hQ/Kzo9m6UaUzjwlLpD+u/WtXjXLgF81
         ykuaNCSAQ20shbx+xhRJpuFrMy+jxtaqz7wF74dTLC5ehrikNnbBMK0QFxP/CeUEt6IB
         Fz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138018; x=1789742818;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6DAY0H524IPnoUin0wM315IyLKxNaVBFm7h+DvdUw5U=;
        b=g43tPq26tZbuqmBKbthyB3wAEFSF4rNxBB2SAJ11oKH2BO7x8RSCLQsKClkqWOw6bO
         IqxOTLRB1jLQh/LjKXt6fw2L4YUzaBLvHRuBzst0CLa3mgddYXOeLRcl1g/Cy3cZDucw
         SoE3ut28f/HKuMnMbcAN87rW1jIO1kGcbU9MELVn+ogGBoYA5Djq1YUv+ztUhGF0cMwW
         HHXEPzpRrLwP9WhU3pzgHDkiiL15mV/tgzS08CdaYXzxtdf9ikDAw9JQ30uYht69fGOi
         JGYPkJl/Eh6Yaozkud+TUSa1iwVd2rd7Rax7z4zGeP9OLbnDud/BizD6glHrQ3Nc0MYk
         h1KQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoKyYfs6d9ZZH4HwcXfePc1wzTSedpcWoS8hbuIQM0j3No6WHnEno1lJCDsHFOd995GPEaxTZf8mKuSw==@vger.kernel.org
X-Gm-Message-State: AFuF++mF3RQ8hkY1Dlov6tp8IpjtrbsbS+T+7/U/t9YoWaWWBq4pJIlk
	sPe/21VgHR6N6jP2hcJAynQ4jBohaQdos2EJKYL3qc5O3bbrS2Y0uoAxxIWujvkk2TA=
X-Gm-Gg: AYBFou3zMYNeaYn4f2nhagWNlobT7vsrlqSolAKWGGFgU3V0HcO6qJsMvq8SRRFmTsP
	7bHitRyQOdJ8MZ6eYnxlIqRRm7974bGOyBM2nu2opShj2iwgJum4+H4MZCJURav1q6jCksbgueC
	mZEibAi3HwCcb97U8b7ZAswIYDGYXLQv5oqwCokSQSDTf04Z0RARK9K56zSjMwo+bqaeuJtrUzT
	r6IAHRplQiAIpOati8dXrG9C2f08SkusZDovzCt/7kfuZCyQOCyDIVNL4juAm1RE6kIKHm79Mdq
	yvXRhe+OkpX79GwibeHaf3GO/6v4qB/Rnx15QEBxlanNqeymmlbquV7SeXvfZJrBdAkk0aXonrc
	rUF/WPjyPJLC1l8kTqETbNGtf/RJsNTafabpWaL9NeIbpzA6bMKEam+TWbVzxZe0pKuh8gbgbDZ
	OU/AFUsnXVciK7hJ/l5gJ/+09RcbBOVqikiPi/yqQ7MwX7h/EjlVooQbDaLmTDYIln2UBfhSNKZ
	1N3gg==
X-Received: by 2002:a05:600d:8444:20b0:49d:27ee:79c9 with SMTP id 5b1f17b1804b1-49d27ee7af0mr93376655e9.8.1789138017731;
        Fri, 11 Sep 2026 07:46:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:46:57 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/3] Bring includes in linux/kmod.h up to date
Date: Fri, 11 Sep 2026 14:46:13 +0000
Message-ID: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260816-module-include-kmod-14d1a0e19462
Content-Transfer-Encoding: 8bit

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
files that use usermode helpers and remove linux/kmod.h where it is no
longer needed.

Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.

Finally, clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. linux/module.h appears in
roughly 15k #include directives across the kernel. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions. Note that
this series doesn't immediately improve the situation, since most of the
files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Apologies for the wide distribution. Acked-bys are appreciated.

---
Changes in v3:
- Rebase on top of v7.3-rc2.
- Clean up commit descriptions.
- Link to v2: https://patch.msgid.link/20260721131207.803760-1-petr.pavlu@suse.com

Changes in v2:
- Remove the linux/kmod.h include from kernel/cgroup/cgroup-v1.c.
- Add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
- Link to v1: https://patch.msgid.link/20260708154510.6794-1-petr.pavlu@suse.com

---
Petr Pavlu (3):
      umh, treewide: Explicitly include linux/umh.h where needed
      time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
      module: Bring includes in linux/kmod.h up to date

 arch/x86/kernel/cpu/mce/dev-mcelog.c |  2 +-
 drivers/block/drbd/drbd_nl.c         |  1 +
 drivers/greybus/svc_watchdog.c       |  1 +
 drivers/macintosh/windfarm_core.c    |  1 +
 drivers/pnp/pnpbios/core.c           |  2 +-
 drivers/video/fbdev/uvesafb.c        |  1 +
 fs/coredump.c                        |  2 +-
 fs/nfs/cache_lib.c                   |  2 +-
 fs/nfsd/nfs4layouts.c                |  2 +-
 fs/nfsd/nfs4recover.c                |  1 +
 fs/ocfs2/stackglue.c                 |  1 +
 include/linux/kmod.h                 | 12 ++----------
 kernel/cgroup/cgroup-v1.c            |  2 +-
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/time/jiffies.c                |  1 +
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 22 files changed, 23 insertions(+), 23 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260816-module-include-kmod-14d1a0e19462
