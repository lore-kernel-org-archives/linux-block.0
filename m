Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7E2E03ED;
	Tue,  8 Jul 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984133; cv=none; b=iVrDywq3004CCNh59IrBGX6kXK4msg3QpiyTebWai425QbEwBrC37/v5bbbvmxybxZgNnvwa2hnGsxJAXB3c8Yh+1ec6uNhx/CqgwzuAGHJ0vRT6hTvPaC0UQi6bJ9t8NLpZJVDcIMbyTAoksr4f0/ncFOzidD8dZUWSU5yj4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984133; c=relaxed/simple;
	bh=LjqQwO6EMtttFZ01h5W9YCZvdVVY5sFtNrc3+SiL3PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhCvUJmrJ5vk7S6jcLIsAUVB1GLCzygxd13bqKP7CaQDS9O1XOK5DAVvK/pBUVRTWOVH9I4RTYd/W1mCYxLrn2YCyoXPQKeM83AQlnqLgGn1nOBG8A/HbYNY/hwyRGqcPbM/++OJucn57jvmojf52ch8V0pu9JyhHbvjUb/vMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/uXl8TL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/uXl8TL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA5FC4CEEF;
	Tue,  8 Jul 2025 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751984132;
	bh=LjqQwO6EMtttFZ01h5W9YCZvdVVY5sFtNrc3+SiL3PE=;
	h=From:To:Cc:Subject:Date:From;
	b=n/uXl8TL3y1ZZeqXjJeC/DFx54bM8uo97Gb5kJgnhGiRwjvzZVZt02O88xA3/+FPF
	 NpNz6c1fDvZwbXzihXHrJP0Yela7u0nw8z/AJMDRalCkzIuTIovyyeI9V25mh/4PlT
	 6Ex/LEwF/inveVBRPNZZmojL0uwhQVaSmycE/pieH1hhOIue56P+zYS6/icCDB+MDq
	 asOtj5QweyI2Bdm32SmQCK4HA89Z01mh4ccYsWMdbYpE0JdOeXaJe5ScZmizhlcTZV
	 OlEyQxLwL6jvi/klcUPu1wb81X5trd1hapBzwMriOjwC26J8qL9W4mWr9HHTQuyJlt
	 9R3rcp1Gnr63Q==
From: Benno Lossin <lossin@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Fiona Behrens <me@kloenk.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Alban Kurti <kurti@invicto.ai>,
	Michael Vetter <jubalh@iodoru.org>
Cc: linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust pin-init for v6.17
Date: Tue,  8 Jul 2025 16:14:40 +0200
Message-ID: <20250708141442.1339091-1-lossin@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Miguel,

This time there are a couple of interesting changes, see below. Most
importantly, we can now use `Result` as an initializer. And implement
`Zeroable` via the `MaybeZeroable` derive macro. When the second part of
[1] is merged, this will make all types in bindings that can be zeroed
implement `Zeroable`.

There is one small mistake in the second commit e832374ccadf ("rust:
pin-init: change blanket impls for `[Pin]Init` and add one for
`Result<T, E>`") I forgot to ping Andreas about the changes in Rust
block and thus don't have his Acked-by. We discussed this privately
and he his okay with the changes. I didn't rebase due to the fact that
the commit already is pretty old and that Danilo already merged that
commit into driver-core-next, see below. Sorry about this!

All commits have been in linux-next for over three weeks.

No conflicts expected.

Note that driver-core-next is also merging the tag
`pin-init-v6.17-result-blanket` that includes the first two commits.

Please pull for v6.17 -- thanks!

[1]: https://lore.kernel.org/all/20250523145125.523275-1-lossin@kernel.org

---
Cheers,
Benno

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/pin-init-v6.17

for you to fetch changes up to fc3870dc5cadb701b4122e4a8daa85f9fa2f57b9:

  rust: pin-init: examples, tests: use `ignore` instead of conditionally compiling tests (2025-06-11 21:13:57 +0200)

----------------------------------------------------------------
pin-init changes for v6.17

Added:

- 'impl<T, E> [Pin]Init<T, E> for Result<T, E>', so results are now
  (pin-)initializers.

- 'Zeroable::init_zeroed()' delegating to 'init_zeroed()'.

- New 'zeroed()', a safe version of 'mem::zeroed()' and also provide
  it via 'Zeroable::zeroed()'.

- Implement 'Zeroable' for 'Option<&T>' and 'Option<&mut T>'.

- Implement 'Zeroable' for 'Option<[unsafe] [extern "abi"]
  fn(...args...) -> ret>' for '"Rust"' and '"C"' ABIs and up to 20
  arguments.

Changed:

- Blanket impls of 'Init' and 'PinInit' from 'impl<T, E> [Pin]Init<T, E>
  for T' to 'impl<T> [Pin]Init<T> for T'.

- Renamed 'zeroed()' to 'init_zeroed()'.

Upstream dev news:

- More CI improvements to deny warnings, use '--all-targets'. Also check
  the synchronization status of the two '-next' branches in upstream and
  the kernel.

----------------------------------------------------------------
Benno Lossin (12):
      rust: pin-init: improve safety documentation for `impl<T> [Pin]Init<T> for T`
      rust: pin-init: change blanket impls for `[Pin]Init` and add one for `Result<T, E>`
      rust: pin-init: examples, tests: add conditional compilation in order to compile under any feature combination
      rust: pin-init: examples: pthread_mutex: disable the main test for miri
      rust: pin-init: feature-gate the `stack_init_reuse` test on the `std` feature
      rust: pin-init: rename `zeroed` to `init_zeroed`
      rust: pin-init: add `Zeroable::init_zeroed`
      rust: pin-init: add `zeroed()` & `Zeroable::zeroed()` functions
      rust: pin-init: implement `ZeroableOption` for `&T` and `&mut T`
      rust: pin-init: change `impl Zeroable for Option<NonNull<T>>` to `ZeroableOption for NonNull<T>`
      rust: pin-init: implement `ZeroableOption` for function pointers with up to 20 arguments
      rust: pin-init: examples, tests: use `ignore` instead of conditionally compiling tests

Miguel Ojeda (2):
      rust: init: re-enable doctests
      rust: init: remove doctest's `Error::from_errno` workaround

 rust/kernel/block/mq/tag_set.rs               |  12 +-
 rust/kernel/configfs.rs                       |   4 +-
 rust/kernel/init.rs                           |  28 ++---
 rust/pin-init/README.md                       |   2 +-
 rust/pin-init/examples/big_struct_in_place.rs |  28 +++--
 rust/pin-init/examples/linked_list.rs         |  10 +-
 rust/pin-init/examples/mutex.rs               |  97 +++++++++-------
 rust/pin-init/examples/pthread_mutex.rs       |   4 +
 rust/pin-init/examples/static_init.rs         |  75 ++++++------
 rust/pin-init/src/__internal.rs               |   1 +
 rust/pin-init/src/lib.rs                      | 158 ++++++++++++++++++++++----
 rust/pin-init/src/macros.rs                   |  16 +--
 12 files changed, 287 insertions(+), 148 deletions(-)
