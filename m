Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C12342146;
	Sun,  5 Apr 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433264; cv=none; b=E4H8VscT85eYw/+QpsmocxPF83EdwJPV+nuNXkMSg3svx0O9IzuCmmcKM/zA0nUriLp+wKUJjNOJglit5RIL2Jh+eLEymjkz2BauZsjBIy2EZURxxoz6KPlsQLc+LI2nvO3xFt6saZtFROoTAFIa8dXTDnei4RxsP/F0HFHPtpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433264; c=relaxed/simple;
	bh=7EaNnrhT/szhZgmliWeltWKXsYIB8rKqoUcWnLxYEoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ0kKiJAxxEIVzDXLEQw5x7492XwfvdfXCe8UunsuOAFdMHjJGoRqEsPyur15TPRfkAaaNklHfrgjwHoTBhUl4wXSRdKO6EQ8sazi8H/QgrIeGmMJ0LcynXGIBnWbQloAvv/gxxX6ZZaOAggccheFXoo4RYQGPvtlSx9nRBIzqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7CQsLxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7CQsLxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D6C19425;
	Sun,  5 Apr 2026 23:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433264;
	bh=7EaNnrhT/szhZgmliWeltWKXsYIB8rKqoUcWnLxYEoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7CQsLxqJs0ndvOCgx98FOGSkr0v/I+RAStdNRVkAkCCb+Een8p8LiCDfdFYL4BTb
	 Xm1OMGlYEspj+sl85BmUzh0tacu6p2coTtSiUMi6/AmCV4O8+R1Gw7n15Y8mZZUB/F
	 kUmixCM7jp6xAqaAb81FleCMQ6ygNusPafP4e2vCwiJrSgnruLNyyPeQs9N9yFBVLR
	 llvS4s7+D5lfYxXlJYjgiBlRngKZpF0BWA7mmE7okMql1msLbIp4I8ansTCPmXaC+U
	 SBt1pVwtNiWDdlmlhfeAbW7k4fAn2IGbHF7IqYZAWm4L+212N9igqjZw95yaYaduro
	 Arc18nSaT0UOQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers),
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH v2 05/33] rust: bump Rust minimum supported version to 1.85.0 (Debian Trixie)
Date: Mon,  6 Apr 2026 01:52:41 +0200
Message-ID: <20260405235309.418950-6-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As proposed in the past in e.g. LPC 2025 and the Maintainers Summit [1],
we are going to follow Debian Stable's Rust versions as our minimum
supported version.

Debian Trixie was released with a Rust 1.85.0 toolchain [2], which it
still uses to this day [3] (i.e. no update to Rust 1.85.1).

Debian Trixie's release happened on 2025-08-09 [4], which means that a
fair amount of time has passed since its release for kernel developers
to upgrade.

Thus bump the minimum to the new version.

Then, in later commits, clean up most of the workarounds and other bits
that this upgrade of the minimum allows us.

pin-init was left as-is since the patches come from upstream. And the
vendored crates are unmodified, since we do not want to change those.

Note that the minimum LLVM major version for Rust 1.85.0 is LLVM 18 (the
Rust upstream binaries use LLVM 19.1.7), thus e.g. `RUSTC_LLVM_VERSION`
tests can also be updated, but there are no suitable ones to simplify.

Ubuntu 25.10 also has a recent enough Rust toolchain [5], and they also
provide versioned packages with a Rust 1.85.1 toolchain even back to
Ubuntu 22.04 LTS [6].

Link: https://lwn.net/Articles/1050174/ [1]
Link: https://www.debian.org/releases/trixie/release-notes/whats-new.en.html#desktops-and-well-known-packages [2]
Link: https://packages.debian.org/trixie/rustc [3]
Link: https://www.debian.org/releases/trixie/ [4]
Link: https://packages.ubuntu.com/search?suite=all&searchon=names&keywords=rustc [5]
Link: https://launchpad.net/ubuntu/+source/rustc-1.85 [6]
Acked-by: Tamir Duberstein <tamird@kernel.org>
Acked-by: Benno Lossin <lossin@kernel.org>
Acked-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/process/changes.rst | 2 +-
 scripts/min-tool-version.sh       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 6b373e193548..474594bd4831 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  8.1              gcc --version
 Clang/LLVM (optional)  15.0.0           clang --version
-Rust (optional)        1.78.0           rustc --version
+Rust (optional)        1.85.0           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
 GNU make               4.0              make --version
 bash                   4.2              bash --version
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 99b5575c1ef7..a270ec761f64 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.78.0
+	echo 1.85.0
 	;;
 bindgen)
 	echo 0.65.1
-- 
2.53.0

