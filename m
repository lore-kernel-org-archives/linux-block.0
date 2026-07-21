Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B83655C1
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639574; cv=none; b=FfqiNL3OTN66gMH8sICKEABol4ikYnmWAoa7N74HgZCONncd6od/5iQZXuYyMQXo+9fPBobSJVT5Q/Z2qM3W/tQluUtrg41yOPUdFnTmWhsdgiVf9MwnZhrcihwYK9LkSBKnrwimWWcZ29xLcgun3gZmRJ4+fajdM6eNdY1+7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639574; c=relaxed/simple;
	bh=roviBJb1B7iQhUITwXosnTCAe4xvx3i/dIY5PCDwenw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi7aCzLfyDTGxB7PQLKsEdj7ejnuoA1wpWN1mSZJkn29nuwQ/0pgq6Y+tvVlCwjJANUWs6M4lIBwCd0QMOF3hSEjfXZLxem8VODUsrt56KkV8hmDOhw190TeyD8KMZZ9Lztsy8U3umbQ+cwtU7s5eq8WX2WUG0cW40tv8BJNDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LoGxvBpD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LoGxvBpD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f752b3423so1874764f8f.3
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639565; x=1785244365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=LoGxvBpDEU586mANHKg0AlOVLSwjxUwcerLWqBCuDTqB3BKr12xDPuAeaITf0OJ5u7
         pW5MXZkNE0Spz9kUiB9YFRowyZ0wzFTcuAQcWOmZNSNocM1lGunteIJ6qMNsP+7LQHCn
         K9g4hWqiodIzksvb86yTlUcAOgIE59cm3keL138dQdp2+Aqm72Oe/K9ovJombOHk9b77
         q7K21gZoQ5BwAZI8RwxdUwRFZcTCvQniV3IZouqx83co77jWHl0m4ZIhqH83wfbTdKJo
         gJdyjf/44/40tPfp4ckSZbjo5gpkBplWyQ2sI3AVC3OjkfeUBdeeMBulLolpi/ubh9oF
         H8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639565; x=1785244365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=DbuWj4jb/IIOs9x0AMJx05MQLgSANfOs7RXFdxZYOiciPGpQn77wXBeR+sGBSP4/A0
         wp3xA0GTFWyhvnV582AxVjpJQyel6ezMW92T8jbPW0JWSti4NGeBjrtdEZ/rVhItoNhP
         5Hs810yhfR5hODt54qx3ZYknwYEHfcYNmTtj4uUG6BZupDt+7dZ4JQnweVv63fqskA+v
         Nm1Q07q5D17rmS48Fq8d5lh+DHFb3taPQxW7o031P4cPiGUR5pEbLVweQ2u61g7ki3mU
         qJP7cys2kWC6AI9XlHPIZ0tTB/FNsIM+GM/HDGUhlStoPJyVhCrRXVpK03l02qjeTnEI
         RilQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUwM7g5BrEg5XauFLT92bLo+RcVIWnhVf5UtWXYjWolNnXCBZxv0F5PMblVYR7be2iJH0nrUu7jURKtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyeuUTImdWjbOYfcqGJqmR/5Zow/odIinwQdplFFYt3yc3TFt
	lOMVnL06f6pJm6LA8MY4og48IcNjDoRpeUa6m1vLZjBVYacq/VPz0H26v47W1JcajK0=
X-Gm-Gg: AR+sD11fUk0bYdHhrPZYeAmKnTJy6RPWeEmo7CqaqI+0ynaGO1a+xjoG/Y+C29xfVGD
	pnmAPm799YaBXq6Cl2chVYIj7XxbPUaaUjLIwbGqthOMa2LB1B9+veZg+7NoPwCx5rTGd2sJ53k
	e4j/lVzuPJOurR75tRmQkKSEn1dL+oI8tljApTvGB/AvzZZqdRTJBDoE8OReBuJ5ALzLc43+PRm
	uDqsT2EFkVtVvEXhe0HJQkU9UJtDsxb+XIFhtBj1y4SF5zGLgY8HSI3Okec2W62TI6jLBTCVzv2
	A8xrWsUJCsa6UqgyMFJL1hqHAX6cXxN1UokeGNYHkRijtPw+i/cWIUwI7SDWkSohlSObUEIrkf9
	F5e5xHz2uv9oSMwHkkn7sVRxIBhPybMN+FIobVH8+bmSN30pnmSqDkzdoKSuJzpFkOM4ZsqCOCg
	==
X-Received: by 2002:a5d:64e8:0:b0:47f:6fbd:8a17 with SMTP id ffacd0b85a97d-47f6fbd8e65mr15616435f8f.59.1784639564680;
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
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
Subject: [PATCH v2 3/3] module: Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:27 +0200
Message-ID: <20260721131207.803760-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721131207.803760-1-petr.pavlu@suse.com>
References: <20260721131207.803760-1-petr.pavlu@suse.com>
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
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
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

