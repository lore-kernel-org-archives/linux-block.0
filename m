Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E30409288
	for <linux-block@vger.kernel.org>; Wed,  8 Jul 2026 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525571; cv=none; b=NLmC56hZOVNg5H9SlSOWE72NJxESusP2kOgC2hxIZFKvaqdPhT7v3khC4X1BSHGamur2nRAo3/nHHdKWh93rjBJNnZ760NM/1o3H4GGBrEM0l0jXAIWBewki6W8Pbu6XSad5uuByrFaxoOZpIWWXRkfVThEArRhRePi4scSubOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525571; c=relaxed/simple;
	bh=6o/Os/YHoHLpbGBJ/Oz87lOS4kylKBP062qGBWElKsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4Bkm2KB/fyHNj4MQL4nNGj+x2EFNPOuV7B3K1+lqzbDkGu2XKXhs/s9vM44W4OCK80ClR0gZdLmIjUH27ytm/OLJGpqdS1ePlf4WxYTdHe3F93Y46S6RCp0IIH9CgrzZpyO2uufCVzkFUWl0fgjNhYXtrXcYnm8yh0v136PikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F/xDcraq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F/xDcraq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4720d22c94aso808528f8f.1
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2026 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525566; x=1784130366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
        b=F/xDcraqE7zjRny9dGpElvcrYP+TvLHulDUmHNdZhg0hx4k/ecCY84wCOji4oou5cz
         VXJpUOkuokde7MMu0flycEjUugRu4z0NFWPcqjYItrQ3J4nRTl3+vzC1w1b3HnpGNxdf
         H64963aqUef7jrOhAPDPzwH79R8InoYlihBzie9t14dqKK4Fl1xxfHrt+T3uIIp5iYi4
         gfE2K5QZBbk3aiPJN4k0Xu9STGQab/mn2KuaphtmU3Nl1u9Dmd/gQc4sqc0+srk3Dgcr
         JHFdBIBj+w+scyPJLw/BVf9V6UaVNl407BpnFBOfTrzUF22wnSL5rqwEUY1MvfPw1fLm
         ueMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525566; x=1784130366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
        b=Hj753o4GKCWXX3efkSNi6UR8mTUinBbgZ+hPUx66vnisrcUqInxLJGogOwaVkDcHvU
         W1y4dfrWHJcpnzofBvfbfE8wgneLXHT/snOx8/ya6vVZXEVh5vjGgnjfYOmUpkF0LXad
         9LUPkPZfn2ylzMCOxSKM98/2MZjiOMJ2iIvztypRS1/Utes89Y/8ehd7K0HTSQPzFDKq
         n6ED3zxFn7zX4KaoN68n6mkzxyxFq4qfLCa8wAoq6t0aPYz8mtxk1I8wot+qXWlKxYVh
         fxe6q4oOjPWrcvZaQ1eXqD9crdXfhMTNyf1TLU6BjiXP9oO7S64Fm5p8iwgr+Nh50IQw
         Lmzg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/vAYXXquiKWFBtIQLK379s4e6X0hMrJi+Lr4UDhvCeVkfs8DgJLfdigq9BVfO5mLRo+WMUxFKYb/WRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlTmt715dGmnsLBwoBXiWneA+WO2u7zpDO9qf5gg9kiJvoXEa
	vmHuja1W/0jMoYzt07/6rYumn1vw26/sDkPr+gkzbmmDcFo3E1Y80WHCE+ME7O+7FC0=
X-Gm-Gg: AfdE7clJ6oH4FykjGC2CTBJMYZYOq45prXC03/YppZJC7ksIkBR24LxSs6Rxbeu9aWC
	QuAi7rfUi5rt2GknzNbzHZQyt+TAMEqia7R3/w2rqBRLoMW+Xlb6ybcf7D3t6fP1Zqtz4yYoNGQ
	8+6OL26zo+Pbl8t9cyyp/ldeNZ/Rx7KBh03WBUBjb3WVhZ5Ex4lmsPrG2QNMcFww47lXwm9ZMrB
	4vRkHYT02YJF2X44+LSoOrqshEJGhMnEQH8iJXGbLWsuXEgGzRf1Ej8/p+qJU9BADT1fqFUrpUZ
	IsxslSUR4yhFM8ZM2zWdTosLI6QaWu6GRJFLEEwXPQKhEcGt1bgg83IGj4RFe4wdsZJKAaxuWVF
	eRF5JiYi9x4w070Cs3Y5Yc3pGWi6YubEtDetGij+nr2N5Y2RMfYkUi9EQVjJUguc57mUMT8gMtf
	PHjocaBeOguEWf30zSt6C9C0sl6DGjNA==
X-Received: by 2002:a05:6000:26d0:b0:473:673e:3836 with SMTP id ffacd0b85a97d-47df078bb73mr3861713f8f.28.1783525565920;
        Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
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
Subject: [PATCH 2/2] module: Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:30 +0200
Message-ID: <20260708154510.6794-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708154510.6794-1-petr.pavlu@suse.com>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including linux/kmod.h alone results in 1.5 MB of preprocessed output, even
though it provides only a few functions and macros.

The header currently depends on:

* __printf() -> linux/compiler_attributes.h,
* ENOSYS -> linux/errno.h,
* bool -> linux/types.h.

Include only these files, reducing the preprocessed output to 10 kB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/kmod.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 9a07c3215389..b9474a62a568 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -2,17 +2,9 @@
 #ifndef __LINUX_KMOD_H__
 #define __LINUX_KMOD_H__
 
-/*
- *	include/linux/kmod.h
- */
-
-#include <linux/umh.h>
-#include <linux/gfp.h>
-#include <linux/stddef.h>
+#include <linux/compiler_attributes.h>
 #include <linux/errno.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/sysctl.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_MODULES
 /* modprobe exit status on success, -ve on error.  Return value
-- 
2.54.0

