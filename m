Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018B19FA92;
	Thu, 19 Dec 2024 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641967; cv=none; b=J9WGtrVrmjObePgMQMmyK6KAQnvCHKQeqm6W460/NEx4a8xER8RgDOdjaJJoBzL1hZ6qUudPVp9QxEruyprpQNtipGmc7M+kQohcQfAd60Zq5AN3hnZL6XeIdTCQnLgs1yxmnHYY5+WHJmpkXOj78ahaw/t8npkkaEoTThM0QMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641967; c=relaxed/simple;
	bh=WZvqg+TueHor/UjhA5RR+jtq6I/LXSlgCrqEo4+fv98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JVUPbLoYT8CbRxjx3FPKFW9UE2RZapBPYJDk5cjTqYh8GitR9LSGx3j+UgwdYx1Fwd0tIoJNlF9c116SyzttuYwxJg3UfPkQcRfm3Biaa/dHZ3aKmMG1UsfgkucRyf/aVqSWQ1p37XVVEDfF838hL9UeTD/nKkbIbRhJcszcxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+CwBa5j; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+CwBa5j"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7f4325168c8so572789a12.1;
        Thu, 19 Dec 2024 12:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734641965; x=1735246765; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itIeJiLDxG+gf/edhn9TtR8VMo0YdxJKNH0/VPITOuU=;
        b=O+CwBa5jT5iG1hKvcJtFukpXCsw9gSUpAHxyuHyiirkv+RE6XHroAMbs2l0vfBEjk5
         02F9Te3+BwENKvhOHKbfTasghU/zcmC9Jjodp1BCXUJxnZXtkFPxPFuBv8uR+3+o37iG
         LkvNrP79ROW0N5nN5NWX2e/3Cf4vRAkXDRd5Si4+XfnGlg2VJfD+dvS4UKWcELn/U81J
         fBY7eybbmsRetZ9QEr/9EgYzsh2DXeFyd1mcqzibpKiuKZh4Lcn6I9q9GJFGwX/y7cSB
         l9DZPWqBz9nLabhE+Bk0qy9gG30eM1NhvUAUA7j9eiPhR8EzVuMKYeZEtiETbv29+d8Z
         DBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641965; x=1735246765;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itIeJiLDxG+gf/edhn9TtR8VMo0YdxJKNH0/VPITOuU=;
        b=fYpJZE/X6nSOJFTmRa1/hd5tCSnUa4Ebl/0rkTQzr6GZNBVjFaAJ0tH643seHuuNuR
         31ziUDqpL+WYu5XdX5n+1Be32gijuVHbMPP3Ej6cSykHlzYslHRU1TMVGbJ1KjE67Cu5
         LIGG1jg7OPsRxF6lXNQrw6MAAZzPF4lmsz/9XuF8b6cB02Dw30nr4L2O0KXcb8pDdH2Q
         7cCVXHYmXxscQ5coad+tSnkYpLd7dQw8kUsKAGD0JyoqReg49jrLRM6Gn8Eq4nlVjFXx
         iqrTi5uyUHy7WD6qvZ9UjFV1dIV6+EquKQGwC2lwxR0QtaJt3o8yTCVzic8yJaU946rz
         pZzg==
X-Forwarded-Encrypted: i=1; AJvYcCULfiTFzLmresmARD+lnL6/MxPfSGCjZ/uI80NUIaPRQfAgiQWHUe+AC1zPQRzGNj7jyM0gvq1M@vger.kernel.org, AJvYcCUTXkadofNEVIdY7okax8omgVLAH5i1zVMd0Evb0n9FTxXRQn1p++sheSNlB7FT5BN/29oGGpmpEII2pSc=@vger.kernel.org, AJvYcCVA2drducftNa8dDoze0MUXXVge16klJq6tAs1CqMPZr27JkqMAEoPJ88fFLaoDoC+y8CJEGYF8fncSQJgnV9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zfiOjn7T5Tfn5DYvP1+pFfmzXBzg657qPzQ6akuZ9gEOqqQU
	Qo+Q2r7z+kcB3aPnMZsEMlQY1X4RCvgIGowuNyCm9YljphhW9BXS
X-Gm-Gg: ASbGncvAxzCjFom7yB5mf5FCAUWbvC4uzCrO7ZtCWL2Sj81vFl6YXAGTtVSt4yn6leO
	6HQrozwocLmGDw7qdEVmRE/rKBfytL4A41azXxbuXEBSkxwgaPNLTAaPN2S1pY+ttcmNqqZg3Al
	CUT5Ykm1+n0n7o/AXQK/MUZpZavE8GUxfOrYSGo/wiAn8zKmuMZjkai7OTLoGx+m/zkP7SCSsHd
	egYFZbqUTegOvmdNKdzJXstrnXD7iwMmNP4lAF4SWwtIR5PdXYrS8gmVJoGMJtKvQ==
X-Google-Smtp-Source: AGHT+IGoh8BXDGsBfbh/U5qR1CbAPSwtkKfGguzV1OfM/P/NXOzHODZBBBS2KzINPuDoVeJhxqPTog==
X-Received: by 2002:a05:6a21:6f87:b0:1e0:c8c5:9b1c with SMTP id adf61e73a8af0-1e5e0450114mr908697637.9.1734641964665;
        Thu, 19 Dec 2024 12:59:24 -0800 (PST)
Received: from mitchelllevy. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c331sm1751090b3a.196.2024.12.19.12.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:59:24 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH v2 0/2] rust: lockdep: Fix soundness issue affecting
 LockClassKeys
Date: Thu, 19 Dec 2024 12:58:54 -0800
Message-Id: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6JZGcC/3WMQQ6CMBAAv0J6tqZdaARP/sNwKNsFGoGSFhsN4
 e8WTibG40wys7JA3lJg12xlnqIN1k0J4JQx7PXUEbcmMQMBhaiE4v4ZFj44fBiauckpFwoklo1
 mKZk9tfZ17O514t6Gxfn3cY9yt39GUXLJDWCFILUuG7h1o7bDGd24f/dIClH8RIJTpRUW6gKyx
 a+o3rbtA/JEwNfdAAAA
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734641963; l=2765;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=WZvqg+TueHor/UjhA5RR+jtq6I/LXSlgCrqEo4+fv98=;
 b=A/fjUcDpI6qaKoobjgy82wbk67WA4XKsK7ZDp0iqyw5apjw2+mQK0qwSR0ydHEULrqxEhQgpF
 HNG/Fn9n3OZDZUw/2ywMx6Q+dJ0b/y6znzqq/2DqGYb3WEKvaIa1tIo
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
Changes in v2:
- Dropped formatting change that's already fixed upstream (Thanks Dirk
  Behme).
- Moved safety comment to the right point in the patch series (Thanks
  Dirk Behme and Boqun Feng).
- Added an example of dynamic LockClassKey usage (Thanks Boqun Feng).
- Link to v1: https://lore.kernel.org/r/20241004-rust-lockdep-v1-0-e9a5c45721fc@gmail.com

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
 rust/kernel/workqueue.rs        |  3 +-
 8 files changed, 78 insertions(+), 23 deletions(-)
---
base-commit: 0c5928deada15a8d075516e6e0d9ee19011bb000
change-id: 20240905-rust-lockdep-d3e30521c8ba

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>

