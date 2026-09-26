Received: from mail-wr2-f27.google.com (mail-wr2-f27.google.com [74.125.225.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9633ADAE
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440558; cv=none; b=FRhhros/IAye68O3Kze3ej2VXgaxwP1m165H7bn3oy3h8jffUwHQR1OXCDsCcjgLY7TXnRH4rqM/tU7FHy7Gvh6RM5i46gM/ccOIZ1LM2hC5orLVxZrPJJVNG98Xx8MlTOUGczmxWoYlL9YKZiuGVEaMGcv3O7U3bThPXWobrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440558; c=relaxed/simple;
	bh=z8vSwDiyBuH4tzUOiupCYNY/tZi7PjC0kRQc4aVjvic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0pXinIMhWqHoHhq6jlYun/b4G9Pri8LG8owz01fIoB1V49OYzrJBIB+fX9VpNAahUIilk4D/RYawLU88YexObGfY74njVuVXUgpvdKJtduCJ21r29DAL1LEws0OJ9Weo/ySs7PsusVEOpTLTIS1u0EMHq6z9ZOIW/K4doCVG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUqbIWy3; arc=none smtp.client-ip=74.125.225.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUqbIWy3"
Received: by mail-wr2-f27.google.com with SMTP id ffacd0b85a97d-4843796e373so1032382f8f.1
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440555; x=1791045355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5pryPTOD4LdiLlKyD0wq6thMQRx5prfhqZidoKen+48=;
        b=QUqbIWy3KG+J+BTI5VvbU+iLioymBJ/bwf3G8mPllDPCUQfuqAosok/upZILgjvCCh
         9pRlTX0XjfNM2hWtl0d+Y5+1VI5WaoEsEZPrbC8MN9TfB0gfvA2NEUt/MpwOvKFu60wG
         ilDH+Kl71zLQmYN5jbOJw6wiqzg75k/+PAtZ4bInFrnP1NrNe68hL5InYA/MwgZFQ6S9
         J0aWEYXne82AwYVk9s+6GWyrD8Pbf20syT9W3rmWpcIfE3jnB3WoRbbfXLU3FenDBHWX
         5j2/ObEQeRBjRIJ2EO1ZSvY2urifxNqaghykzJ6X0jTVXaEoDicQKm+jCx79Up+fYdDY
         7B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440555; x=1791045355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pryPTOD4LdiLlKyD0wq6thMQRx5prfhqZidoKen+48=;
        b=Fl3XhMCE5cPm1M/PVLbPDReCx64wJuiEqJPpdkF53EBuGdYvkU68K/9dmHfFr8kDUv
         x0orOLAFq53NpXHrlB6zkq1wy+HBz/I1hc2lT9jbt4r3lHo7mnf8LnSCgDGFOWNEOUNN
         QypZKv1LGUCfs/Zcwxv4844VHM7libJE3dUzrfFU13DCACAHCZ3MzQJwehWU8WaXHsUl
         GpvbC/U3Kv6dxzFOPQwLkUe+9IX/9HPH8X0re86LaSeIt7ANmR6Lz+GUuxc00/VyhnsA
         6XKr2AJx4yWLDAhmkTSaswwSR9JIQlYhLyaLd7HrWMGJVcoghcDAv7qz1oePmJhcoypI
         c1Gw==
X-Forwarded-Encrypted: i=1; AKwUvBwJVY5Yq0huqzDOhb1L5vspmPjeQMcN3I0k75RoDvfzQw7sMrAHbA/D9GGEK1xuZ2k5IKUW7cQKcBI76w==@vger.kernel.org
X-Gm-Message-State: AFq9FYI08P7gJRlsp7T67zvyyfxo/NZqAEeMDByp3d+CsuIZgzmZGkQS
	KZjJr+0DLRM1lX8LZ6UmcYZTUv5TcpNf6LfvZt27rYArYsY/hcIb0I1b
X-Gm-Gg: AYBFou28Fhd4wgeVi3ZEItPoJ4A6/g3ShDObslYVwpjbih6D8RWj9vsP91HI7g1v/Bx
	+nPy6RyUd0d5K3mj0OVzacrNarVKAOn3fBE9+EP49+wjB+re0Txj8k+vD819pS+T52RH1wVy3kn
	kXthKZEQZEKtiFMYR4cYoYP8MHbJiu/0E0KI34F8S2d4xAFCkBuQNatxCz+JjNntm0B0Iu9EA0Z
	2ZdLUaKADIF5i+01rLn1/F1bZrWSQILYKokyyYfdESj5k2CQXTXNK1cLw24RQWgUkvKtcUFPIWL
	GCNZtH3SX5GIdjXs4OJzG82pOCR56kRwZBMl6jgd0oDxbMNGYb+2EvfowSjPOsqdC4BWJ1I5Pcr
	AgJX8rIaMzFhH2mN44bzpFvSi2Tt9Ax0yqm/EzezPRNkwULweBAD5Q16BRIUvkrSzpjHa4eRxPD
	zJIm+N04vrv1Kh7qaxgvXrETNOHOUMgBTapmge6vELKs2fgPlOScM65Am8sqTFKFEdfStHUp/xx
	sbm9dSWh9ICLWGU9q/ddvGPQU8LWiiyrnpNJZBPFzyFFtD5GSoryIX8mTwsh1VtTGQ=
X-Received: by 2002:a05:6000:4023:b0:488:5852:6ee3 with SMTP id ffacd0b85a97d-488716f4185mr17421912f8f.34.1790440554835;
        Sat, 26 Sep 2026 09:35:54 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:35:54 -0700 (PDT)
From: Mohamed Osama <mohamed.osama189110@gmail.com>
To: ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	longman@redhat.com,
	lyude@redhat.com,
	linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] rust: add DropGuard
Date: Sat, 26 Sep 2026 19:35:46 +0300
Message-ID: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Rust kernel DropGuard API and migrate the existing ScopeGuard
users in the block, serdev, and locking code.

DropGuard runs a FnOnce callback when dropped and provides dismiss() to
take ownership of the wrapped value without running the cleanup callback.

Changes since v1:
- Split the changes into separate patches for each affected module.
- Added a separate KUnit configuration patch.

The series was tested with:
- make LLVM=1 rustfmtcheck
- make LLVM=1 rustdoc
- make LLVM=1 -j$(nproc)
- git diff --check
- scripts/checkpatch.pl

Mohamed Osama (5):
  rust: add DropGuard KUnit test configuration
  rust: mem: add DropGuard
  rust: block: gen_disk: use DropGuard
  rust: serdev: use DropGuard
  rust: sync: lock: use DropGuard

 rust/kernel/Kconfig.test         |  10 +++
 rust/kernel/block/mq/gen_disk.rs |  11 +--
 rust/kernel/mem.rs               | 123 +++++++++++++++++++++++++++++++
 rust/kernel/serdev.rs            |  10 +--
 rust/kernel/sync/lock.rs         |   5 +-
 5 files changed, 146 insertions(+), 13 deletions(-)

-- 
2.43.0

