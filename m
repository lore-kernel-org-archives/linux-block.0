Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C72BF011
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089399; cv=none; b=qes99f08jr0Fy3qiZBkIe6NLZmh3SVG5UstJBz79BfCZjMlNsk8H6XhZ84dW7VXToCjga99FMFwYxx1um0e64L/x1/zH9RKTzQwAkbak/dp7rEmV50RI91KGWgs9hCUV/6CIyejnwm9dWDmpUKMaJ2pf+aQRY/FRuvBONtz6xTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089399; c=relaxed/simple;
	bh=tfJwv3nqlpDtjcN28xzwLtu0Ad/Qk3DuNUw19bGFdw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+Oektmq9FmFvImxzDK2pNW/j9m+ih9tlE3bredpjjklydvbXkY7SH7BCpUQYox8V37p/2k18xo9y/OTq4IEPiILk4LIe+TVQLtDii4yTv2YzHWvDhQZMOOj100KT7dNDG4dNPLxtbN1g0Gyqftq/J7WeQ17P9V7uRDH/Sj5U3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2MNdXQh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2MNdXQh"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so17450465e9.3
        for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760089394; x=1760694194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmHzldTWpRVGaYiRV7mqVTmbw8wTd7DjVDHFKbOWCEM=;
        b=H2MNdXQhBP6UZRIf427UJPOaBPKLw53ezfUFHqraxZPLItmNzxyiaxGWwwZw5KnSVm
         +coy6QRPj4Ko0vYtaep45sJwuLKzSNfQ8Y7YCUJrEKs40bAzoMrJyBPxlngY0CUhZ2nz
         MJzzl6pASGIC1HeeEoVEuSZIv11I9yr4Xh6mLzABxM9BoAd7pHlvuaBSm4nxtXKd65x2
         6Jlmoylazu/vg7ORaRSBTN2JFXA4Gaq+37SnXVMXDrh+yhe/5G/CkVovRVDxmPHYaNOc
         c2eGNEvTd6/zFDTK1NRsZDPCv590fYmLNC4Jm0tz+g2ZBLExX6OzvFoBW2NiPYvZCllE
         RaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089394; x=1760694194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmHzldTWpRVGaYiRV7mqVTmbw8wTd7DjVDHFKbOWCEM=;
        b=pTH/wG6qszJwaTg2kb/PfO+Eqof9bG57cilC3hWIbLET7GgsZdrOu1iH3JiALN5v2I
         vT/wQtyDUK+euu9McmFgRoLdarfY2hx/5s3ogdjrkg8Q5e74dCc+W1BNCN6oQCOyjq6T
         Nk/GnUEy4BFg40WZeVkI6ViMxKj5ZYuo6KjkeD3fqxCrgldjLAIsCHUi1lGzBR8H3RgN
         sMaWcaz+Y+wfwcwU4lux9naKiks1Re8YQEQ+A3oIW0jQMbjjbs7bfuHeA42bHiN0tT01
         GHJF4PoU5S/aGJADy1zY+VRGRpUaERnKfydWjXD1E1xv2R5eEhfTWU4sClpVZ6O10N2Z
         GRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0qqKjrqP3A6AYPhegpNLKXXk2EWkjhcvSIuW5ZLhrtXDKDG1EaywCY9HM3V68bYFIZLnyidHiE9ScYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7K2WwygmprdMLUKQEi+5bAjze1xv3uSo1EbLbRt07wwLs3MP
	1FZ3bMwlOLdy+8/+JED8T/dD0zEYfjTlkItJPOXwX96tKTC/dwzCBqYg
X-Gm-Gg: ASbGncu81mvK591BvMZCPZRZSDTYJEZYLAHJIsot03XSR+I8w+vrLh15Qux3xl+mh5K
	uM0gUm6uZosKagISHzO15kUqQ7hBfFV1sFUGdhE6RS0pd2UIjwrcCNJWQox1mhcQFK0kEXU8LpQ
	3DJ3JqV0p+PGShcwbT5NN/GwKeuqu0uKm45y+wVZ8vtpBmw3VR9FB+E6kJ8M+finaF/4dLeJGrc
	yjXkAA25s9UMN04KXT5Dvt4uKOc2GMg3eWbJv4kmplEZ15XNfyIODJwA8lYd7zeEiMchaYdtBvN
	SgdYQo+9qIqZhSjzhQZpmDAQynMLY7gN9290YxUAT13eXzxwCIF+vXn12yWWiGXmDr4xDt6m/f4
	ZcKMBaXBUk5yK6LSNxqlwaUIUoeyxZcY2NgyfwFK31TkCJ8dx
X-Google-Smtp-Source: AGHT+IF9s+/76+HLGw2mLZk76tGq6/V4j0p5f2hCMj0ootyyX2pqmy4ieClzRxxY9elYI46O7lbdMg==
X-Received: by 2002:a05:6000:2dc8:b0:425:6866:6a9e with SMTP id ffacd0b85a97d-4265ef6e5c2mr4984366f8f.0.1760089393527;
        Fri, 10 Oct 2025 02:43:13 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5e8309sm3283123f8f.50.2025.10.10.02.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:43:13 -0700 (PDT)
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
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v2 3/3] init: remove /proc/sys/kernel/real-root-dev
Date: Fri, 10 Oct 2025 09:40:47 +0000
Message-ID: <20251010094047.3111495-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010094047.3111495-1-safinaskar@gmail.com>
References: <20251010094047.3111495-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not used anymore

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ------
 include/uapi/linux/sysctl.h                 |  1 -
 init/do_mounts_initrd.c                     | 20 --------------------
 3 files changed, 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab937d0..cc958c228bc2 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1215,12 +1215,6 @@ that support this feature.
 ==  ===========================================================================
 
 
-real-root-dev
-=============
-
-See Documentation/admin-guide/initrd.rst.
-
-
 reboot-cmd (SPARC only)
 =======================
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 63d1464cb71c..1c7fe0f4dca4 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -92,7 +92,6 @@ enum
 	KERN_DOMAINNAME=8,	/* string: domainname */
 
 	KERN_PANIC=15,		/* int: panic timeout */
-	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d4f5f4c60a22..fb0c9d3b722f 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -8,31 +8,11 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
-#ifdef CONFIG_SYSCTL
-static const struct ctl_table kern_do_mounts_initrd_table[] = {
-	{
-		.procname       = "real-root-dev",
-		.data           = &real_root_dev,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-};
-
-static __init int kernel_do_mounts_initrd_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
-	return 0;
-}
-late_initcall(kernel_do_mounts_initrd_sysctls_init);
-#endif /* CONFIG_SYSCTL */
-
 static int __init no_initrd(char *str)
 {
 	pr_warn("noinitrd option is deprecated and will be removed soon\n");
-- 
2.47.3

