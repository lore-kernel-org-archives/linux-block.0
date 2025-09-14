Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E2E26C383
	for <linux-block@vger.kernel.org>; Sun, 14 Sep 2025 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822268; cv=none; b=NZTTHa6WPf2XxUzRxjjGMrSKKP7d5wOZ7/Cp4sbdrkPkxqcg3Z+Hxh8hLqsiO0+3b+mhkPWU5ifWmv08E5utavJECwZWCcbaP1JybXCEQYDKAS9Y86iLN6qTu+s4K4JLgPTT0XHJdeM+S6SArKJL1B8+KTOZddIl9tDcASrDkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822268; c=relaxed/simple;
	bh=oKU/He6fgnkGxFwiXzfMSQvpywViA2YaDdh3D2HgJ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeBh0kZb7xHhInvs6SnAxlopQxe54QOxJg74+IULy5pbGs9hMkv66JaASUIxNIXyX/9ZKpdtUcW9wLy+LQSai+GtgxWj7MeQ+rI+nRwa7DyO1YUlY5nYHgl/JGO8J5Yp8SxsKx0Q++S3D6+kOMmCjw5jXK6bp9i51WIbHJ3edQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0pjvupp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0pjvupp"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so5095530a12.3
        for <linux-block@vger.kernel.org>; Sat, 13 Sep 2025 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822264; x=1758427064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLgSWRUhBJ+Eb73oE0EhwiwscJ+skfUSjN5GwJ3O/gU=;
        b=Z0pjvupp9oiKINjNbyeuSobzmzNc3O235l4XZaJq6+xnV8xiQNvmcPRhTjA0wy8g9j
         1e/VnNr8qqUxIu704AIAXUk3hdIHvQA2i+7JMtdyUSLBNWCch2mJfUrX3kek54B00jIX
         cpkdx+SF3alQFdxuMwBpZmAMcBz1Fkvbhqc+rqW0oPJBw3vuPYmCSOvsKe8xp+b9RN/V
         gAdtsX4NIFWKTmhvWP3oEqv1ZMtJ8kBfRF67kPO2/akOjOYC2dMCZGY8BqZAd+ytSz+V
         h3rnckiFQSpaBVNrFt5iWUY1JpIoQK/ePVg8RRD6OraLlYp4RCO48NNQFUqRkIYcPgQk
         HyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822264; x=1758427064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLgSWRUhBJ+Eb73oE0EhwiwscJ+skfUSjN5GwJ3O/gU=;
        b=dhi8KtSoMJpJ8LxZ5HzpY8YrfzGYSXahpt254uLgGZVvOHIO/SvRF5cfDsKHGFnAin
         CFjblxwzIhZfmyGTIJRaamKy3mBlbagfRsAdiUPz9pasxjzWafMsqUGXeHDX1Yaox0Te
         WD3M+qt1b8g8IefIECEOu5ahzwB/vRQvQDYkT5HbxeePhOZg6eK1XbtTJNicY9l4hFg5
         TBDF9VC2xwqbA4D87EZWPjPpU2BOSHCv6/qV/YmvHkzN3nDxAB9fAI0tMILxl6/KvAnM
         A/dWd027Oqs9+RHLpGSXlnwcQW1wVU4wAWorftKTeJbZlqiAYOVo3dlUsFgZCxpaoILW
         vBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTi1siTm80AULinBRgsAf405NoxUNXgsY+BlShQkuCmq3PEIFgSXpStNtZDwI48wqizx9lKgBf3nQWhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAEHUoMCSFvRbP3dGJefP1kocKckUqf48xBjjttHG2xUONmnv
	pdt44lQKaAN8WEeADkZl8mVuS5QCbAjh8etgXd8MdhHL7x3q170HDgGP
X-Gm-Gg: ASbGncvbi5xbIWSvrIfC4EMzZ0cNBB3OeLmt0Yl10JP2s4PGVGY2XK3rtFMRNF+ZUn7
	y1rVZfebUGXv3kaEFD3d2PE7bUU8ul+y07pGcBkJBfYeYQ4FA5ZZDqaYkikx+HGpoVRXX58Xmm/
	wqW4DaCKAj9lgwdYjw5jDqmOMupx1pfQ91QyvU+gG8c4+xU1nzXcQfKM34Mv8IfgD9Ca4bwc1G4
	ylv7J9zRo9Khk4rRMUZpiaKV1u0XaH+QNPn4WE6JT8HLRJ47CnrKObetJ8lF1OsISlEJRDqnotN
	Ocw1AjQ0oo9rntXNtIkCG5NTxD1evq2D53Ao/JZH3xKAOEMhMpcluBaMnCVZaOFr/h8qs0BmeO/
	LcvUj9/V4+SaZB8VpYPv/zokU/PHvjQ==
X-Google-Smtp-Source: AGHT+IGOdPvfXOVddm8G6LJhfH2nNJDoTTLKR/3NE7kowNRoQPIuzhxmV+feQvXrrMYzfjsz5Ubcxg==
X-Received: by 2002:a17:906:a84d:b0:b07:cf04:8a43 with SMTP id a640c23a62f3a-b07cf049441mr520202566b.41.1757822263792;
        Sat, 13 Sep 2025 20:57:43 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b31287cesm676665366b.30.2025.09.13.20.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:57:43 -0700 (PDT)
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
	patches@lists.linux.dev
Subject: [PATCH RESEND 50/62] init: rename ramdisk_command_access to initramfs_command_access
Date: Sun, 14 Sep 2025 06:57:38 +0300
Message-ID: <20250914035738.3741007-1-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index cbebd64f523c..a42f1f0fce84 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1587,11 +1587,11 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	int ramdisk_command_access;
-	ramdisk_command_access = init_eaccess(initramfs_execute_command);
-	if (ramdisk_command_access != 0) {
+	int initramfs_command_access;
+	initramfs_command_access = init_eaccess(initramfs_execute_command);
+	if (initramfs_command_access != 0) {
 		pr_warn("check access for rdinit=%s failed: %i, ignoring\n",
-			initramfs_execute_command, ramdisk_command_access);
+			initramfs_execute_command, initramfs_command_access);
 		initramfs_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.47.2

