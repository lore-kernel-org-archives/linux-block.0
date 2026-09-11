Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C23624BF
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138025; cv=none; b=ROyGgwi+gBC13H8KqlGnWyozfN6DlxtAWtWn69IInn6lX4uDUEi8oe0nry6qNspkcN415LgPw+e4xJX0zpDE8HDTszlWpPBUfLG9ClKKShjhi18bRdYkFjMD9pPtmZ/nmFxlCDdVkLNohQ1vHBKD4rm1+VOGmaNcXS4Tax3vY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138025; c=relaxed/simple;
	bh=DSCMx1gAdSPCiTWrdPODvYb/Tkdl8QWx4O9zomiTJ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbaZCVPcKRsboIK935miWzQBZTYpklqkwX0gWw/IfsWEJNVD3ZZtT6M34SHypCyt3A1SliFCB6uJc+hzj1Zd7Ni5SzmBLGeXBtjb9j4XtHUrpbDPrFiOk3Tsy2k2EPP9c68q5yDbtRjHDL7jkR7KokGFRdBg4Ajf6GZFuOev6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XvhWFWew; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XvhWFWew"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482ea739de2so670326f8f.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789138020; x=1789742820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8M3qUem4dgvQjoYpprAxmEKjTGHs+1/VR0EZcgFwfzA=;
        b=XvhWFWewtB8xqqcNlWd47x2UsVlbT9lNrFRQzXz2xSZauGLcnLPvzw44cD7kzVBhbW
         ZWG6aft7/E1OhXcW+/qk2QdQhqeG+z5st+B2I9rGxOIjQYn4V71HinTQM2lBewtD6/+9
         fsHrEQukADG78/5VJ6rnKh8aYOxYSZRAlIItmuP4yyKWLwGPMLMnPtyCgXQBiZF8R3Mr
         4YhwfpbAL7xH7YoK/1vuHZhIGopoZLXI4qvhuPjXbB1RYNOYH6+x9rynMuMswJKS/PgE
         /XwrMFbwg6QpISaOb5kGO1xtdl1SSKWcnOj7O2wawlHvPKheoR3kBKcXLrL3+xcbUcTO
         6FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138020; x=1789742820;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8M3qUem4dgvQjoYpprAxmEKjTGHs+1/VR0EZcgFwfzA=;
        b=FOgPdoWsoLKlg8OB3ZBryuZ+zI6yDW7GIDEGwEkfCsGzFHeUC3MESNSj+AzB/Y9BHV
         8uh+nHcWa14RHlMvtIA8dhfUJuNdcigdTh17+zazIJTsU78lzC7lWq0ueYNyycE9hgBi
         xdW7/fF0YnOOJGS21xS056wqzYUpb0/nezNS/2ctzBddtXsvXwvEQbhBSwyLubAIekVh
         ppnpqg6vpuT15aKIoVGU4LQG3CrjtBjTyyeiR90S17grjFTHR/9i2cdt/sfvcit1pGK/
         ncEmDQvL8m5gxkOCXLDQZF9VBV2X2bBXbUPKS6fDwvOgkxSsagwb3cXT3x9TLkpAD1cv
         g/NA==
X-Forwarded-Encrypted: i=1; AKwUvBy47cbNDsN8n7jMeULviMYM1U05hi6FVN4TYW2YIKNUyt9CCsXbofA3EmRy+UoBXku6F8KMmi89Py+jbQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kH2V9gsfQmH/Jud9ZvyYiInwohqa6lhvA07oxRse7rqZiBqWIm
	AzwSt78ijntVcDVxj6BfQXmPs0Rfixnr6R8bQ4a6j+OVP8hn9io7naBxdtdZvt7or/o=
X-Gm-Gg: AYBFou17PUqAxeaVXDZDlAHdq1HnIVTYWUhMh4mhRIVgT/quFV9SmghhGxF8ougjGhI
	WF2AxZmw+kKTiFn1GYxF8vZ2J6+ycr790FGjpu8zlKfrlpVXmvEhOU6e2RrHotjuneHZaTHR4mO
	1S0cYOxj0c1YOa+AYv3Hejo2T7NlLcqb4nS8EtkUbrHRER+rS5QwQJRbC6wijXd+/pyv3Gr+v61
	EBnC002l+TJWdiKu2OLHVZZ2rjVMcc68LivtMdaf7HFWSeTAzELMitTESkIAQARH8e1UTXTT61C
	rofJF7MGpRZkVRTg16JbrTG1H3e/+XkBZwJ1gubbO5TlYCPFDaZfP8htHlhw4n6BqLvSblfpnKP
	mEfvIhaH87KqTI8me7W0MdDgDLxw6v2OpGhSOejEBDMd5cbI4bxq9nIYgL9niSha49iDiaLs5Yy
	zVa0aPUtwLQ4uF/TfNi+aFXz8ZjlBD8VPVNhwH4fmV9CuqxVCPY/nqoiB8Iqz4gGNwljC8UnVuM
	HnabTq2MdSphWQp
X-Received: by 2002:a05:6000:1ac6:b0:486:f405:9d9 with SMTP id ffacd0b85a97d-486f4050a4fmr1699666f8f.34.1789138020208;
        Fri, 11 Sep 2026 07:47:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:46:59 -0700 (PDT)
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
Subject: [PATCH v3 1/3] umh, treewide: Explicitly include linux/umh.h where needed
Date: Fri, 11 Sep 2026 14:46:14 +0000
Message-ID: <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017.

Add explicit includes of linux/umh.h to files that use usermode helpers and
remove linux/kmod.h where it is no longer needed.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
 drivers/block/drbd/drbd_nl.c         | 1 +
 drivers/greybus/svc_watchdog.c       | 1 +
 drivers/macintosh/windfarm_core.c    | 1 +
 drivers/pnp/pnpbios/core.c           | 2 +-
 drivers/video/fbdev/uvesafb.c        | 1 +
 fs/coredump.c                        | 2 +-
 fs/nfs/cache_lib.c                   | 2 +-
 fs/nfsd/nfs4layouts.c                | 2 +-
 fs/nfsd/nfs4recover.c                | 1 +
 fs/ocfs2/stackglue.c                 | 1 +
 kernel/cgroup/cgroup-v1.c            | 2 +-
 kernel/module/kmod.c                 | 1 +
 kernel/power/process.c               | 2 +-
 kernel/reboot.c                      | 2 +-
 kernel/umh.c                         | 2 +-
 lib/kobject_uevent.c                 | 2 +-
 net/bridge/br_stp_if.c               | 2 +-
 security/keys/request_key.c          | 2 +-
 security/tomoyo/common.h             | 2 +-
 20 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 053555206d81..af4e76babe7a 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -11,7 +11,7 @@
 
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/poll.h>
 
 #include "internal.h"
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index b77f901fc3ef..6f5d059394b3 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/umh.h>
 #include <linux/drbd.h>
 #include <linux/in.h>
 #include <linux/fs.h>
diff --git a/drivers/greybus/svc_watchdog.c b/drivers/greybus/svc_watchdog.c
index 16e6de5e9eff..b318eb34bcca 100644
--- a/drivers/greybus/svc_watchdog.c
+++ b/drivers/greybus/svc_watchdog.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/suspend.h>
+#include <linux/umh.h>
 #include <linux/workqueue.h>
 #include <linux/greybus.h>
 
diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 5307b1e34261..e66de11c69a3 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/freezer.h>
+#include <linux/umh.h>
 
 #include "windfarm.h"
 
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index f7e86ae9f72f..46af1f549337 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -47,7 +47,7 @@
 #include <linux/delay.h>
 #include <linux/acpi.h>
 #include <linux/freezer.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/kthread.h>
 
 #include <asm/page.h>
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index ccc9dbc25813..a13dff332aef 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/umh.h>
 #include <video/edid.h>
 #include <video/uvesafb.h>
 #ifdef CONFIG_X86
diff --git a/fs/coredump.c b/fs/coredump.c
index 6114839f5178..bdef7ec27b0e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -32,7 +32,7 @@
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/fsnotify.h>
 #include <linux/fs_struct.h>
 #include <linux/pipe_fs_i.h>
diff --git a/fs/nfs/cache_lib.c b/fs/nfs/cache_lib.c
index 9738a1ae92ca..ca4e81d4e315 100644
--- a/fs/nfs/cache_lib.c
+++ b/fs/nfs/cache_lib.c
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2009 Trond Myklebust <Trond.Myklebust@netapp.com>
  */
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mount.h>
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 22bcb6d09f70..5739d4d2ed3c 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2014 Christoph Hellwig.
  */
 #include <linux/exportfs_block.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/file.h>
 #include <linux/jhash.h>
 #include <linux/sched.h>
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index d513971fb119..5bef3f0034d3 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -41,6 +41,7 @@
 #include <linux/fs.h>
 #include <linux/hex.h>
 #include <linux/module.h>
+#include <linux/umh.h>
 #include <net/net_namespace.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/sunrpc/clnt.h>
diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index 741d6191d871..0ccaab29426d 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -18,6 +18,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/sysctl.h>
+#include <linux/umh.h>
 
 #include "ocfs2_fs.h"
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a4337c9b5287..cbcde5c28b18 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -2,7 +2,7 @@
 #include "cgroup-internal.h"
 
 #include <linux/ctype.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/sort.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index a25dccdf7aa7..dcaad5d65275 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -28,6 +28,7 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
+#include <linux/umh.h>
 
 #include <trace/events/module.h>
 #include "internal.h"
diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..295904ec9a82 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -16,7 +16,7 @@
 #include <linux/freezer.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <trace/events/power.h>
 #include <linux/cpuset.h>
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f070c5c1103a..37818be501c0 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -11,13 +11,13 @@
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
-#include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
+#include <linux/umh.h>
 
 /*
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
diff --git a/kernel/umh.c b/kernel/umh.c
index 6e2c7bb315c6..512dc018a50b 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -8,7 +8,7 @@
 #include <linux/binfmts.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/cred.h>
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index ddbc4d7482d2..a67129e452a3 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -17,7 +17,7 @@
 #include <linux/string.h>
 #include <linux/kobject.h>
 #include <linux/export.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/slab.h>
 #include <linux/socket.h>
 #include <linux/skbuff.h>
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index a7e5422eb5d1..89bc161a4b47 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index fa2bb9f2f538..e6ba2d054399 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -9,7 +9,7 @@
 
 #include <linux/export.h>
 #include <linux/sched.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/err.h>
 #include <linux/keyctl.h>
 #include <linux/slab.h>
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index d098cf8aae61..d26034000913 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -16,7 +16,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/file.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/namei.h>

-- 
2.55.0
