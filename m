Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEA13A3ED;
	Fri,  4 Oct 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079320; cv=none; b=CTlQk9I5STQWf41VqyyM1W50Fm69KBCIjixvxqVnnJcYgnz/h0WBVREBIr62o/HfRDCqyDmVqqPr+h/ItoUuhHaVAIzp2SRSvPzEAGRWv7dxge0HjiukwWr9RMndVELvM/wV9mvWXExXch+/KqiGptIBf/MvfGLZ2UPFyoF4w4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079320; c=relaxed/simple;
	bh=yA8zi+D/kjXfBz7wwbF2jGW3GGImBGWDMebbbCkbJtk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tUWa3jQhQhbuTwrnkgmjVh5OH/iGgIfRsnXjRmoLviNIpCQJiSp00eRTFcXPY1tPpWuR91ndB8IpKWUGl4UclNBXc2y9lFprk5TII14josbrG182Zq+pNKeHA73ZjuA/jbzLtEE00+MVq1m9VgcoJrWsdwqlzSHm/SCTmUnCuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5hMdJav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5hMdJav"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33139C4CEC6;
	Fri,  4 Oct 2024 22:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079320;
	bh=yA8zi+D/kjXfBz7wwbF2jGW3GGImBGWDMebbbCkbJtk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d5hMdJavBg1kiftWPpZxcHf+KjR0tlkGnBaX/MNqoH/EtMay2VdboKsCVxqwQHArf
	 FgprJgyHGKY43fRa36k4Qk5/A3za09SF7jVAfGEYmAAKzD4z47E5pRvjyIeccJYEL8
	 FOuMDEta1fhQM6L8ceCOJOTZXBMCL7mpdlDH8vdDbDN3EQ0ftv+HgslAHCfe4I/Kcz
	 TG7ea/HgZXxpl5B5PFPpu4Of0Odli89fkgA5bRfUI2MhjPOaIELvCoTgoBR+TEmC6S
	 +vg/tVWQWE296xqIYSwMu2LTRlFQuGnrx8uPvyHcUV2G1qegQYVTxbxFVwGhU6T2xV
	 uVJiaQ6Ry6enw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE0CF8853;
	Fri,  4 Oct 2024 22:01:59 +0000 (UTC)
From: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>
Subject: [PATCH 0/2] rust: lockdep: Fix soundness issue affecting
 LockClassKeys
Date: Fri, 04 Oct 2024 15:01:36 -0700
Message-Id: <20241004-rust-lockdep-v1-0-e9a5c45721fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMBlAGcC/3XMQQ6CMBCF4auQWTumLZKAK+9hWJTpCBOBkhYbD
 eHuVvYu/5e8b4PIQTjCtdggcJIofs6hTwXQYOeeUVxuMMpcVKMqDK+44ujp6XhBV3KpKqOp7iz
 kyxL4Ie+Du7e5B4mrD59DT/q3/oGSRo3OUENGW1t35tZPVsYz+Qnafd+/qun5vqgAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728079319; l=2325;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=yA8zi+D/kjXfBz7wwbF2jGW3GGImBGWDMebbbCkbJtk=;
 b=yz5wfUx3V0h0nT096o9DYbVaoFL3T8pflNc7g21tFsCTJnfM/kKGtgWLYSVQnxXTNAjq8L9Uv
 njm4iXSHk3bBh7tUymQ2ZfjzzviLMkJFU/H+29VLkmZkeDi7mJ6ihe6
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20240719 with
 auth_id=188
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: levymitchell0@gmail.com

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
Mitchell Levy (2):
      rust: lockdep: Remove support for dynamically allocated LockClassKeys
      rust: lockdep: Use Pin for all LockClassKey usages

 rust/helpers/helpers.c      |  1 +
 rust/helpers/sync.c         | 13 +++++++++++++
 rust/kernel/lib.rs          |  2 +-
 rust/kernel/sync.rs         | 34 ++++++++++++++++++++++++----------
 rust/kernel/sync/condvar.rs | 11 +++++++----
 rust/kernel/sync/lock.rs    |  4 ++--
 rust/kernel/workqueue.rs    |  2 +-
 7 files changed, 49 insertions(+), 18 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240905-rust-lockdep-d3e30521c8ba

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>


