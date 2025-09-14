Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6342741DF
	for <linux-block@vger.kernel.org>; Sun, 14 Sep 2025 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757823573; cv=none; b=eMt4VBvZR6B4cDnZWH/VeU3rOH3Hp0+EDwFJCfmk17WvzZb+vmTsBSeC7FSq6zWwq6ntp2fUC/N5PP+fW/xCWL8amn0ma44Hv3bUkTFBv6G8N0MuFEt+NzhuSLu9lX3Gf+Tyw3m+7RfO39DbeR5vmhBGQv+za5f2T8XTF75a7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757823573; c=relaxed/simple;
	bh=nKH8BykbZ/NG2ohjRy0QYNVXxhFKK6pBLbFy0ufJ1Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVU/qzcmQTVe1hVRHlmMShjxhYtTrXDMyU8jizAqrFZp+D5wB30pKjsi6Y7/vPq7qEONsfc+OOKZ5FQgqrHWMEWEcPry3NaMMrN2nN1TMvBJymD7njxVmYkmT2BaUQW9/iml9KD9y21fgYTm6v7JBeNS81jAP+URIQeCxGfvSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJqW6gFT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJqW6gFT"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso101166666b.1
        for <linux-block@vger.kernel.org>; Sat, 13 Sep 2025 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757823569; x=1758428369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=;
        b=OJqW6gFTmxCLo302hPNut8BO+ryXGy8PIMl/uEHO+E+z8i2EI7bfQdJIzRtBRfvXw+
         kcWbRtogH1JQpYSKNv6/zC4/cphZqfgFpRGzi+biQSqIyclF5+D85pOtnPCF+2OqkZz3
         CDy5gGsVM4vK7s4rQQw8rm4UeVohzh6niXAU3IEb2SuGNO2EeuKPfgMpVtnZIsHoZjbx
         vpDwdZIfOKoR5NhKuV5Cx0QkZBDdn8VSiqtXNhrSCK1lfZzEVpu8tq07tpGEuWiSX78h
         yx8FmO3uN2ENwCxH/6hjHHYqFM9jtWMEntVkZB7EYZ3E0XE1sdusU+KrGJTN7b5oFKbe
         8fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757823569; x=1758428369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=;
        b=YLLJ3DRwgV4A2NDsepfCO8Fe7b4pnI1djzm4oBzI1flP9jh2DsopvfFiZ+miD4apWA
         6n45ZrfQk4jnUkar+tIgkyYKQ47f6MVJd541xodRZcnc8jPYq9FEj2hVh/QqU07M4I0U
         7VFOQEO0/JimRZEE1/QenFtPCQ1r4nkg6diijaGmmpWNFWM27C0SeWXP13XvNo0NaC1O
         kqxxRwaCQSVufddR2/QBGojGCmclT3wZk/XV1F5M1qWFHcQ7uAlAXJ+d3SS0do7RUILY
         F6p/R9a4MTNEILeax/PgMgLm7ZusRGfEnEHZlCmSfYlCh4LsENPLnZ9yes6e4xsSYt66
         XKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/XHlT2EKX9VCwiOlh0gAaVIr5K16RPMP72bleFdEYp9GpQTZiXBS8BUAyOTqCN8V7U1XPRG58tzhWMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhWy5J8JrtD5OqwPxFKief3s8n9rEt/aToFAqN7QH+F89MUVW
	aU3hBT5nBHlnU/Y0wWNTGIv3GpwvXMl5vd5Ury2LEBJJ97AHhfAvSm/L
X-Gm-Gg: ASbGncuaz/cIftNibHsk13GavAkbqW76lxhW/95Tr5RTewPC6YrabFxk3uG0NlO1XUD
	5OmsdB/LQG6pQwxu4jy1XeSP9RDr/mctS8ZJx7C1cmaZNZhihOA5T4osx9278dlUNjehQy7MulM
	5r5qbZkrial+LVIRwm2WcxHTjy+Q012+f5g3KlQ2s/ltoAVkljpmpyFPrOyOxuk5LLzSWaNkhg4
	IEp8ufbgm6BsCCdJaUB+ApieF0llgUQmVPm3LrcczbxF94jPTlF6Ckfex1dbCJWyOLD3rZFZFuY
	OhYBkUw4iSa8wg6IeXy0IHi7u8HXCOnXVkbxMUki4hFHBqQDgdxiEsayBEK/dXaPxNeaUOJJlqK
	ZdxRILHVEKGwH0IhDUkQhKADbZ/UDpQ==
X-Google-Smtp-Source: AGHT+IF6mujdx9qWAhF6oXDc9ZfcQYBKEdRbKR8jum+cm7upWvg9UYWarRjAWufJtq6SFHzRS8+jpA==
X-Received: by 2002:a17:907:9809:b0:b04:25e6:2ddc with SMTP id a640c23a62f3a-b07c353a723mr763099266b.8.1757823568595;
        Sat, 13 Sep 2025 21:19:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07c28f190fsm504796666b.39.2025.09.13.21.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:19:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Sun, 14 Sep 2025 07:19:23 +0300
Message-ID: <20250914041923.4119219-1-safinaskar@gmail.com>
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

Gmail banned me after first bunch of letters.
Just now I sent remaining letters.
So now the patchset is ready for review

-- 
Askar Safin
