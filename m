Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DA1E0DE4;
	Wed,  5 Feb 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785571; cv=none; b=kSMZMl+/FvM/BUrYx32tQT90EvwU0aQD6+fyQEQJWWMNZoA0j+MwO0TTqKRjDRwTmM5pnFIjONp/QDK46uju9p6SojaOWype4tgF8ppHbQ58xNcwvcDb1mR7MHdEB6o23ljNuy+mEmhC2JKOEuf/JaccJszQeaqTMF182xNr3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785571; c=relaxed/simple;
	bh=ACKEe92ssQNFPIaS9wr4RpP7/D2sC2Fx4+a+V9MRB38=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FZ5Hs13rAh3w7kJhOFDQympDdsZiDfmiR69JOa0zxOoFN03MZjP2fqKLIBBiSjSQJO6/c4NTPy4qyBPVD01mSHHd0SStJuo/3Yn0y6PXgHmK2W8cjVc5oz9ryK3m7gSTOg6MNcQIuAiashcCMIXJcZZsGBUEmJK+Xnb4G3YOAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNwvbtXi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNwvbtXi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216728b1836so4120855ad.0;
        Wed, 05 Feb 2025 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738785569; x=1739390369; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLZ4yxwrmwIqGistr3nQwNXLyHVytAv2EOU/Cc1veH0=;
        b=cNwvbtXi2imTR5wkIzm8W6B2Ou/4ybhCyGdA8ZbNbUzT3t7QZljcqo8jyyGfiMB9l4
         551U/0x3dsz7zIXMqY8aXAePeUchn/D/V7n0FK1eLzkaTA8xn61hXjjreoKOZMyVFGL3
         QlenTG1HM2aAjnYoDAuSxBOG9+LIR5hnGQ6DyfqmUDAadPOTcInK0hY8HKee3/bDymRg
         B1sgJugY+rdTNKfMOGvCMCHIsx/LEHPTorrd5jCVSNAmfX2A3Qp/cZXUAs+QFsR+F/Qw
         2h2TnIMrbyy2HV61Z2nr2ve1pNKkE7ZsiU5la7pI21U8T7CCQ3MoEXReUMCMCb8RRjAJ
         s7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785569; x=1739390369;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLZ4yxwrmwIqGistr3nQwNXLyHVytAv2EOU/Cc1veH0=;
        b=jXoxAT7zawW/KM8uKuYSziB3hGGu6zWam2s7aOVHI0P0ga6SypBEs/FspkyVRh7HWq
         Wky/uwPmkOJBX52KiayY130Im39wqMdvMOydvDTOwvFWX8Hj9+K+yaZIKu7muoa52dXt
         AlwsMBpDw2oDBO6Tol6tYs0qPvwhBsRUsPsDxjbpNQjszU8Jml2330rpSBvlECbHZemu
         BIbpEseR14wwYVeondBBzWuN+V1JidGT50DtTCggGwWHof+v3Jlzc7yL2Tt87l65u6Xs
         m/CFpFQRZOukanWNbuxUUpZWg3Tx+m+qIfXiL/54fDZLk3scJzxi77RD7VffpJZKYju6
         IooA==
X-Forwarded-Encrypted: i=1; AJvYcCVRB47OD2ZBftXXYoAqxkE9WWESjMPSaKViNOqU05Sj0c40YAXu5zkk56FaBt01ixXmN67HA6sQgIMHQio=@vger.kernel.org, AJvYcCVkDqlJsURcTleaogAIzPO8eFcPoVnbXcTr16QArwk4+W7OdAT2AkeHpNwkxc0BflorWk/OXf5U@vger.kernel.org, AJvYcCWg4H8DAqnjJGITkWTnj9bUrONSLEc5dUYUQC2W4Vdx8l2SYM0WyBJPqFOg9lhoUiI2tl++Qfd2Ig+WiqehFLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBEFmG6GUwMh5pv7tsvFSn694QsN2CniATjUaEkXz+e+EEgho
	uncrrYEsJw9vSe3A/RiZW0cqQLM41Ra5v/PXNYNqZpZzTfccaIsy
X-Gm-Gg: ASbGnctOpgogx4pB/GdK7/bKGtOvAp97tSESkTUUjcFbv0pKftfb3/5xHNGCQtPk57K
	JDs+StySoY614Rh/o5dBlDMb9lazImJXWpudYeN7aere9Sd1qGJz27NxN7BlimzHU7Xq0kp0hN/
	KHXPYj0hwwCGGrZwN8DqWoKX4ByLmq3FsWs2+tgsDg6AvSq9DItW6xdkG7IihZj+b7gx7cX9zpl
	LL8cN7GaCgxecndLvE2Cg9kB3N6JrzzVxao50lt1uqqZMc+5fdWnOd0iXpJ1wx36GVeIxllJLuD
	VpXtKXEtQ3lwt+gNPLZ1h85a
X-Google-Smtp-Source: AGHT+IH3YxZThgSMEPi6tgul2ydkkZWAdZzh9uXNwt9wafsZTzMsZone/XEl+08Vn36Ajh/+Ooszyg==
X-Received: by 2002:a17:903:2406:b0:21f:f02:417a with SMTP id d9443c01a7336-21f17f03200mr73805685ad.38.1738785568678;
        Wed, 05 Feb 2025 11:59:28 -0800 (PST)
Received: from mitchelllevy. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1668800fsm19685765ad.158.2025.02.05.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:59:28 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH v3 0/2] rust: lockdep: Fix soundness issue affecting
 LockClassKeys
Date: Wed, 05 Feb 2025 11:59:03 -0800
Message-Id: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAfDo2cC/3XNTQ6CMBCG4auYrq3pDFTBlfcwLsq0hUb+0iLRE
 O5uYWGIxuU3yfPOxILxzgR23k3Mm9EF17VxJPsdo0q1peFOx81QYCpyIbl/hIHXHd216blOTCI
 kAmWFYpH03lj3XHPXW9yVC0PnX2t9hOX6JzQCB66RckJQKivwUjbK1QfqmqW7IBAi/UGCm1xJS
 uUJwdIGLd9H/HwEhPwLY8T2KBOR2YIkqS2e5/kNtMx8yRoBAAA=
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738785568; l=2949;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=ACKEe92ssQNFPIaS9wr4RpP7/D2sC2Fx4+a+V9MRB38=;
 b=Bjla0QQs8vNHx5HsuVFrueOFYKdYWUOF3JdRpG8iKzEuCUYUC29n3RmMAGZLla0qjiGwy/x2k
 qPbjWA8d0oXDfVb4cTrO/5dJv07zbsKv+sr9hVx0up3ZYQYXcHhWump
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

This series is aimed at fixing a soundness issue with how dynamically
allocated LockClassKeys are handled. Currently, LockClassKeys can be
used without being Pin'd, which can break lockdep since it relies on
address stability. Similarly, these keys are not automatically
(de)registered with lockdep.

At the suggestion of Alice Ryhl, this series includes a patch for
-stable kernels that disables dynamically allocated keys. This prevents
backported patches from using the unsound implementation.

Currently, this series requires that all dynamically allocated
LockClassKeys have a lifetime of 'static (i.e., they must be leaked
after allocation). This is because Lock does not currently keep a
reference to the LockClassKey, instead passing it to C via FFI. This
causes a problem because the rust compiler would allow creating a
'static Lock with a 'a LockClassKey (with 'a < 'static) while C would
expect the LockClassKey to live as long as the lock. This problem
represents an avenue for future work.

---
Changes in v3:
- Rebased on rust-next
- Fixed clippy/compiler warninings (Thanks Boqun Feng)
- Link to v2: https://lore.kernel.org/r/20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com

Changes in v2:
- Dropped formatting change that's already fixed upstream (Thanks Dirk
  Behme).
- Moved safety comment to the right point in the patch series (Thanks
  Dirk Behme and Boqun Feng).
- Added an example of dynamic LockClassKey usage (Thanks Boqun Feng).
- Link to v1: https://lore.kernel.org/r/20241004-rust-lockdep-v1-0-e9a5c45721fc@gmail.com

Changes from RFC:
- Split into two commits so that dynamically allocated LockClassKeys are
removed from stable kernels. (Thanks Alice Ryhl)
- Extract calls to C lockdep functions into helpers so things build
properly when LOCKDEP=n. (Thanks Benno Lossin)
- Remove extraneous `get_ref()` calls. (Thanks Benno Lossin)
- Provide better documentation for `new_dynamic()`. (Thanks Benno
Lossin)
- Ran rustfmt to fix formatting and some extraneous changes. (Thanks
Alice Ryhl and Benno Lossin)
- Link to RFC: https://lore.kernel.org/r/20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com

---
Mitchell Levy (2):
      rust: lockdep: Remove support for dynamically allocated LockClassKeys
      rust: lockdep: Use Pin for all LockClassKey usages

 rust/helpers/helpers.c          |  1 +
 rust/helpers/sync.c             | 13 +++++++++
 rust/kernel/sync.rs             | 63 ++++++++++++++++++++++++++++++++++-------
 rust/kernel/sync/condvar.rs     |  5 ++--
 rust/kernel/sync/lock.rs        |  9 ++----
 rust/kernel/sync/lock/global.rs |  5 ++--
 rust/kernel/sync/poll.rs        |  2 +-
 rust/kernel/workqueue.rs        |  2 +-
 8 files changed, 77 insertions(+), 23 deletions(-)
---
base-commit: ceff0757f5dafb5be5205988171809c877b1d3e3
change-id: 20240905-rust-lockdep-d3e30521c8ba

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>

