Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8B257858
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472244; cv=none; b=ImVTUK1Kh58gpipAQgW1tWjPBcO3KmBR41cvuukby3N5Dt+YiZsaPshClp374VKxYvOxrvV9MqznX135bqPiQZHjJrJJTA+gWnDP5ZjQhAkxHSUC2Uz3Om+Eu6eLd8FsD5JPOIR9eKtFFQGzUV2jp5ye3uU+ryVmaBNurpbP5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472244; c=relaxed/simple;
	bh=Rg8Js/mQ+ji0aVDnd3uUR+wPkIV7f8cZoyAXSG+WzrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDVz2OY60vfHS/Jj63AUIlNO2Xp1WnlEl+RhZUkvoPPwtcm3fNgL+6CZOsSIp2ZdIc5jkjPc3GNd2cWWlr6STVbs824OahLYC3i0I3FRzLY2XVYcn+BsI3ZK5W2BTKdkswYstwBG0nch0A0vvChYCNoNU8ONbuevcJhvD9TGpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxVgxLWf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxVgxLWf"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47173749dbso4360494a12.1
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472240; x=1758077040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isRfEajvq74JD8Gx5JZkbk62qSgMtw6IJwcPrIolSGc=;
        b=PxVgxLWf3U234tS82N4GAdV+0xhF6nj35VAIVGDRzDZc5hWaA1brC3f5xkRQJ+Jfav
         AK82sFn2ToREyweFCXPBPQMUaBMGXG3LQ4/Whs98LeaBoHAAX7ZWmYRptE373ad/K/cd
         TWxqFgarkuB+OnMbyFHO77/BKq/C4oX9INQFb0UPotVkHJTK6hUVwslBj+6vamtGdYlt
         V0YwYRsRG2HgnBkuUc+R3iZDY7XI/k1aA+wtG1i7v6EvZ1fBDJduQ9ckOlT5UI8IllfE
         9Xyj+5ZuufvtGgLF9JrCk/t81ULsHjSAJHIe/ATQmoqUmENU7ezyvqqzd6cn6sMzBHp0
         2lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472240; x=1758077040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isRfEajvq74JD8Gx5JZkbk62qSgMtw6IJwcPrIolSGc=;
        b=sF4IyTpGTpxgwfm54OVG43u4QY9jsvGBTyeLQsYA70nAo5gWRLVnEJiSb8Negwv1AM
         P/cZnL8cDkUxi7Rw6Jf9JvSEjQrRHM3t5fER3J57KrV38vhYcRohVq8usIp85idYDwCt
         CfrjKKNGJDka9c59ZX88TJTsQMI9V+1NALgTk6H4Pn4KHgLiz+LXpMJltCgQ7TJqzzgX
         NiGXG6n5CtyQ2LMSdi3EJwVMvE7Z7ZQK5c81dJtwyeXEkxuC7hBdh+6KfafwgIar/Dqe
         qqn9jexYuT55vqBIeAReYm+MwQBZaFw6n+HXm3XiqK4ckewcEFot8y0kn9kZdVr1OqkN
         Fiow==
X-Forwarded-Encrypted: i=1; AJvYcCVunGjDQ6Ek02OhYpb0AZZG2lp4YRJhUS0nTDJZJvDybseJAnDwpD+58WisN1UueBF1ZliuB89Fh48OkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTY6+uZVBXFFEjcB4O9aFQFc9xPPKNeaJO+5TYd847QhrVnnW
	Ae8ivEpGSn6G/+VZXQqv31b2ADWGLBrSdhbMklxyw7nOWKuCx1jg1bXY
X-Gm-Gg: ASbGncu0Raemn6ntToryaFqZyB+1P1Eywo7GZpUEP5F8uEOYeWq59lImCRFqocZwhDJ
	ZL3l30Ia+bo4pBjv8xa1DPP9TgojfQavuRMdvMD5aIjEedds2dKAfubIPPH11CGYXhV1ctes3u4
	+gA8dd9xrIRlJN6C2vA7ZNsK2e1MEDHXnU24ZXLN245AmOFXk84SfySDBDvKk3NiB1grBYsS9zU
	zXPKZRnTGpGQBJ76JomvxJ3RnQ1z5cDSmQkvxcIhH30g0NM9nXZ+1f1S6zksfDJVOPM1/ebnAOb
	nMx6V8fyVRv33kNsr/+axOGtFH7sp29AeHCtEr8YePLCLAYrE3JCpUUfjE5SGQ4vrQTPMNUNxtB
	eRxN7/wx1yWa37KHDmt40rYLR0Q==
X-Google-Smtp-Source: AGHT+IFrrGtrsp5QApHqrAEsH4Lf99kNe3GTHl7qChWDynb5tQqdU4zGL9zb4NWW/Nh5w4cYNQSmBA==
X-Received: by 2002:a17:902:c943:b0:24e:8118:cc2f with SMTP id d9443c01a7336-251734f2edcmr195946635ad.59.1757472240373;
        Tue, 09 Sep 2025 19:44:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2ac085d8sm10840225ad.118.2025.09.09.19.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4B76441F3D85; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DAMON <damon@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux KASAN <kasan-dev@googlegroups.com>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Linux fsverity <fsverity@lists.linux.dev>,
	Linux MTD <linux-mtd@lists.infradead.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ranganath V N <vnranganath.20@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 04/13] Documentation: amd-pstate: Use internal link to kselftest
Date: Wed, 10 Sep 2025 09:43:19 +0700
Message-ID: <20250910024328.17911-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=bagasdotme@gmail.com; h=from:subject; bh=Rg8Js/mQ+ji0aVDnd3uUR+wPkIV7f8cZoyAXSG+WzrA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnihuCjbtUDpafXJnbOHtXRdvzJjhG/D0b9KEh6svl Jx1Ocjf0VHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJSHcx/FNfPsFU6huDt7vJ kh1V1uZRLxRT1SOqp3E8VV6+6XDdK15GhiW/r34XtloUdOCT982MLd7bz2VGXmhWZatxbn38c0u qDSMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert kselftest docs link to internal cross-reference.

Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5f0..37082f2493a7c1 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -798,5 +798,4 @@ Reference
 .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
        https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
 
-.. [4] Linux Kernel Selftests,
-       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
+.. [4] Documentation/dev-tools/kselftest.rst
-- 
An old man doll... just what I always wanted! - Clara

