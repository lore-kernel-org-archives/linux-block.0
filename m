Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019F3E47B
	for <linux-block@vger.kernel.org>; Sat, 13 Sep 2025 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724201; cv=none; b=lC117tKlKiefC0wFwikxfk0HFvKHVvB5Yyv7Bs9kaSDe71j1OnYG9G+dQASUNFj3lo9V43FgkhvkwFomJW/aeoF85S0rAJFY9Z4jGj1vY84r9Pzb0PP9ZKgFtu4JzWNWinNWM4OpmDkKa2SiyFiOmquDW2UtQ82KPb+HA+l+XDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724201; c=relaxed/simple;
	bh=YJ3HeYdgmHPacx2K6CLagA34dvdD+umyj49eLYi815Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7zi8t4OtSG9haL81+AXuCsN6ZzmbC6iFj+7tdEEpvI3tz5df/k1lZuXVB3zAd34AEcQuWPO6tV247J9QvuOaOOK7+K24/kJJgw7QTRgu0foQL2D4oJIjer2dqSfUdQ0wO4WeYPK93ID9aAVWxuAFhoKYYZNex9dZepOZc4rzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFBjZhx/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFBjZhx/"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b043a33b060so373934066b.1
        for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724198; x=1758328998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBhZ+rO7As9Va0yYpTLBkeUqDA8zrexqjuJeztCSNI4=;
        b=jFBjZhx/Mc9YVQOowWWYRFZmW/gI8a7r2Jr7SHSX+maCx9+kJC7Qxhfp6pVAm8Iowi
         KktUKT6pEE6IrXOGZlm/Yaw5a6keuuTBDhRkZONxXS05e5kMOtxdlzGkeGikDZTIWb+Z
         5SdddamSLJmM/11Vhxf9uXl3CHcGNKLi6Vlq07NCu3g8ASYDtsys25quNZ5+Pl1b3dXJ
         IzgnpUAGb0+7bnrZB28miB0YrVmo9xqN/IDgazo83AaQoSLtOeYmEcg7HDENos1Kyvnc
         Co7HdjBY408nU4q5Ktur0aUYt1jibkq9wK/WOwoSuQF+fUMGM0JxQWxSfQjaIqhNNkcN
         2big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724198; x=1758328998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBhZ+rO7As9Va0yYpTLBkeUqDA8zrexqjuJeztCSNI4=;
        b=HiNSkoQkLpCuo4tAxo38+XdRto6vJlbbzpFYbT4posI/rO12rSbPvibVr4uBJmS9tA
         VbLSXVUIVnvjpAQbK//tFzFtsYtmkFU63kvqOKSn/uf1UhiFOeJjfSo02TWvRwEaHBNU
         tLiQb85ID9Ad0ILnJ+/C9prsKdbU7CHhAwCtF6ZlUC+4l+svCCZ28edRa/UfqX3p/Ib2
         2HJyEETFL+aavSOMVsUx5F6dkCVAM5WFaK6XHw+XXX5d94TXRAxqCCyzIfOjyId0fRRM
         KPDHldo7W3uo5ntG6GyeLax1Uuo272lojs/DNlbWda1VHnrw8RDcFUCmPH1ASSPwSlLn
         jIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOCND417zWx+/wYuKWZz3PMJz0FEYzFkv1TrnNS0WUReQ8qWiWKzGcBZSiFCJ2wnTGNdMSs9lLGoNIvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9jZhmrxqnh/vbnfv63dbav38j+eMlNVStuwqpys4UHt5cjs9h
	rm6cLHLpAew/rh8+dv8I0HdbDK4naZkarCS+C3e1te1thu9D0hnuBKhJ
X-Gm-Gg: ASbGncsEmVt3yN0WuqADTvHb+ZxbrYc4IJwp1aUZsEngkBmwnAkt8wo2hDM4I0ErIm8
	esRL/zWVwuer9zzyYaGO+P6ixuyMz0KTNCHNdAAs51xqGVKf/UwFSIO9oo9g9KOUl//qRKMTgBN
	DuCDhA7MY1JvE5VHFrIU78GTk+d+7uSo0ygOUAHdZHO85mBFpslYUQSkEWveIqn1BwQPUHoDHFi
	+a1gYkkru62qa1Danv8dxQ6usuE+DVAuOOwXXEzDgzqAJI2yvfFEW6TAQn1WmW2oCcitjCv0FGn
	XDF+Mn8LgLdhQMvtRWGo3Y21r4gH78oPMP2Lq9iM+GZCw/Dm+4NkbAkTJATGjz3GW9OVBl3tcZU
	DBLteD9Z8NiKoPKb00Go=
X-Google-Smtp-Source: AGHT+IHHzjbduKroQCN+yZXT2xkuDjXRSEwS3nHiIMvASVJIn5ZPiks4NchkJZtKdw5/XwXcHwo3Pw==
X-Received: by 2002:a17:907:9405:b0:b07:c9b2:dbd with SMTP id a640c23a62f3a-b07c9b20f2cmr456569266b.4.1757724197720;
        Fri, 12 Sep 2025 17:43:17 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07cd14268fsm196477866b.3.2025.09.12.17.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:43:17 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev,
	stable+noautosel@kernel.org
Subject: [PATCH RESEND 03/62] init: sh, sparc, x86: remove unused constants RAMDISK_PROMPT_FLAG and RAMDISK_LOAD_FLAG
Date: Sat, 13 Sep 2025 00:37:42 +0000
Message-ID: <20250913003842.41944-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They were used for initrd before c8376994c86.

c8376994c86c made them unused and forgot to remove them

Fixes: c8376994c86c ("initrd: remove support for multiple floppies")
Cc: <stable+noautosel@kernel.org> # because changes uapi headers
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/sh/kernel/setup.c                | 2 --
 arch/sparc/kernel/setup_32.c          | 2 --
 arch/sparc/kernel/setup_64.c          | 2 --
 arch/x86/include/uapi/asm/bootparam.h | 2 --
 arch/x86/kernel/setup.c               | 2 --
 5 files changed, 10 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 039a51291002..d66f098e9e9f 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -71,8 +71,6 @@ EXPORT_SYMBOL(sh_mv);
 extern int root_mountflags;
 
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
 
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 704375c061e7..eb60be31127f 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -172,8 +172,6 @@ extern unsigned short root_flags;
 extern unsigned short root_dev;
 extern unsigned short ram_flags;
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 extern int root_mountflags;
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b4..f728f1b00aca 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -145,8 +145,6 @@ extern unsigned short root_flags;
 extern unsigned short root_dev;
 extern unsigned short ram_flags;
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 extern int root_mountflags;
 
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index dafbf581c515..f53dd3f319ba 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -6,8 +6,6 @@
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 /* loadflags */
 #define LOADED_HIGH	(1<<0)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..6409e766fb17 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -223,8 +223,6 @@ extern int root_mountflags;
 unsigned long saved_video_mode;
 
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
 #ifdef CONFIG_CMDLINE_BOOL
-- 
2.47.2

