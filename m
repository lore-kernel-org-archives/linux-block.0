Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48E418ABE;
	Tue,  9 Jun 2026 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032601; cv=none; b=LaY5GrGGgq6sUmRVbVythqUuGaTM7rHf7yZ3SiYIBRrwLdOqZDab7NFruav72FIggxrVoIAWmI/H+Mm58b/fDE8KIVHNXvC6J1DR+4kyX2h8IuFA3WQvM0G2oAhymoG9jNc9g+dlYqPqybeDYQC//gN2wcQPI1AG5xbL+FTPbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032601; c=relaxed/simple;
	bh=aBDol8JJ1NQKOh4ZvZj8LERoM7BdVagGFC62N+EJb38=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V23nKxuJy/UvLsJcvh1vK2zRkOb07L2p+DYlF+Lf3dJPBvuhD0A2cykuqrBlGNt5fAjFnqkrWrCQznSoeZhufSLKSscIvj8ComMNdAeM9HWTUd9DDKxrrQhAw1sqgXxxz9e919YjEYbqa3GyCwKsQiWJdkHKat8EkS1wdQi3VhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEjEchev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEjEchev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAF01F00893;
	Tue,  9 Jun 2026 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032599;
	bh=OJKIespo7UAV8WqLkVK16is/xpXLxxDxJyvTJTwcShM=;
	h=From:Subject:Date:To:Cc;
	b=GEjEchevrUVLxHQ0z133kJFCp9HNzi3Ya+B298kCOItehrkqqpH/oCCYqUlGbR7xX
	 dm4gdLIET8szGwJNGF/kMAfETEydRCZ7cz7AV+3O0+IxgQAWt2I5fa6/isTkhXh5CG
	 VYgwO+2+t15CqAJrRLvQM5Jdmk0Yih6kZ46vF6fviuCTFueR5sLKURze6uqWI6e5nB
	 AYELKDe/3xsBiqP7pb6Ogda32pgXwlu4nsViril33pt2T2x7Hj/scjeOXnO4WZmREv
	 d4N5h2cWDzFqfauwzzLRoSN2UpDhBDT2pZ8LIMb8mhrHxiA/NP4xt9mkbJXz22FT6e
	 Gn3p9nB2HaSgg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v2 00/83] block: rnull: complete the rust null block driver
Date: Tue, 09 Jun 2026 21:07:39 +0200
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH1kKGoC/32US27bMBCGrxJo3TH4lmgURe5RZEGRQ5utTKmkp
 CQNcveO7aQN0FhLjvTNP++XpmJJWJv93UtTcE01jZke4std448uHxBSoHcjmDBMcA0lL8MAqwF
 uoXgNFXMA23kp0RsrgmkInQrG9HRx+/3h+i74ayHv89XY9K4i+PF0SvP+bm13nJyJ5qMqBcGEZ
 pJpWHL6tSCQUxA2+mBaHS3a/crbTxAumIQnV4p7Bsxzeb7GyJiQLLJWKTT7Vf0PUn7MvIPD6H8
 GnIDSAM4i9950qEO7X8VnJJcMJkeWdRzcnAb6NALTMWqrNWuDvKHIRQeHOEEe6f/YB8WRS8267
 oaO4ALSaRogDu5QIeWMBbzhtlW9aHt+m1MwpQx1SJ7MOc2AHUZromdtb29S+pqVCyHNNBkVei8
 NUwZtjGGD8tMCRxwmLBUYCfVCt0J17QaCT9NYZggjtftcfTy3zBnnrWxlUBvkh4L8C5RJxWL0v
 dOb6ZWUD/0SI5VRCaW1Ncq5KLZSG3NMh1jBQ8DolmGGQxmXiWoTeuaUMlI6s+HgbZpd8eAqTHM
 BKbAXzIaAvN+KdakzXBVT/oF+pm4YETnraGS2Qj6WOZ0oQ+fntCJE3knFeURtbslpYeE0hmXAC
 qsb3pYPrXat662K4R08Ya3ujfx6QckzbYPQaic1vwy4gEfMv49uHJIb78vidxiWnc/fPlM2rAM
 qDykGNzuoz9lDx3pjXC+5cJ6W/ha2TIQgHB9pnQIF7soBrGLo0TPZMbeB/m3qed/HGCvOYEiQt
 1x3lvENNC8ndxEkM3Q6YMu6oLALZ+Z8/I6pzmN5vpxYMp2v31tnzOfXdOXAaLYs1TqqXhl7/xN
 LxmE3lkPz8Pr6+gebPNHgtgUAAA==
X-Change-ID: 20260215-rnull-v6-19-rc5-send-98c33ec692d6
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org, Yuan Tan <ytan089@ucr.edu>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16183;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=aBDol8JJ1NQKOh4ZvZj8LERoM7BdVagGFC62N+EJb38=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGSx8IL1s3Sh+Q7zDy5TaoR1XHvbDgaoeTEhp
 HzxKbi365eJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihksQAKCRD6UCkIqsW9
 0KTNEACV7EpyJ0XTutHyJsGvkrPVAR6ryg4xGFzugCpXHdorq7aUV2e/yg21RglRd2BS3WLCt2N
 ZJXuQSYnIXBjbj2wi7tIrRZ3DPDk9J1qg+8hBxcLbiV48a7Ty4hlhU1fzK63yNvl2hP9uTAjOHU
 mKWa2fMuwVPtOqW1B0tusDiRUxnlo6oJs6oJ8+teOZALUqxsg140B1a7lj643TOjneorJzNmhxu
 R1uhy98RV9Ww4aEeE++SIyscW3PUxRkZef5BLKbYRzkPlD8VRPalpNqCXbyjKtjb/t/IPIRO16n
 GXP7kOi+dd/N9GtMyeMZ4gFpe/wdQqtAYXSqxc1ZhW/QjNDJofxbpWLz6ddCJo8zA7PJ27paXZ9
 Y3Q+20+tiSaN+kDgGvzQAy+ZAvmxU9ClPBtjZ2Y2vQK6SEscyg0u8Y/gmFWOh0PPULvxzhC+1qr
 rgRnCpwEO1UdrCxDLLonZSHJAWZdCmMCPyXcaYcCSv3keDjDxzYXHE01UyDwLWw1sEdl4qvB/iD
 nzUJ65j2ngif68PfB8/krxmNa84sOZ/sBBIMT0RPNZxdubRzdWczL/TYkiE9cOYDs+ywnBIkVef
 Z66ysjnGX4PPN1WNfnG4681bHuq16vh/PwL6qR0qN5ujW2YQzGWa+ymcPUiaQfI4fa9CvyYm3lv
 3UVnkf70xKRdDhw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series aims to bring the feature set of the Rust null block driver on
par with that of the C null_blk driver.

There are quite a few changes from v1 in this version. I tried to capture
everything in the change log, but I might have missed something along
the way.

I have prepared a tree with all dependencies applied at [1].

Best regards,
Andreas Hindborg

[1] git https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git rnull-v7.1-rc2

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v2:
- Fix shift direction in transfer length calculation.
- Retry page preload after reacquiring locks.
- Fix a bug where badblocks did not correctly limit IO size.
- Close TOCTOU window in configfs power-check stores (Alice).
- Use `bool` for semantically-boolean module parameters (Alice).
- Take `NumaNode` instead of a raw `i32` as the home node argument to `TagSet` (Alice).
- Use `c_void`, `c_uint`, and `c_int` from the prelude in `hctx` private data support (Alice).
- Use `size_of` from the prelude in `Request` private data support (Alice).
- Return `Ok(())` from `new_request_data` instead of `pin_init::zeroed` (Alice).
- Add `// CAST:` annotations to casts (Alice).
- Expand the comment on the `BLK_STS_.*` bindgen blocklist entry.
- Depend on "rust: module_param: return copy from value() for Copy types"
- block: rust: introduce `kernel::block::bio` module (Alice):
  - Use `kernel::fmt::Display` for `Bio` and cache `raw_iter()`.
  - Mark the `bio_advance_iter_single` helper `__rust_helper`.
  - Use a `srctree/` link for the C header.
  - Remove the stale reference-counting invariants from `Bio`.
  - Take `Pin<&mut Self>` in `Bio::segment_iter` and `Request::bio_mut`.
  - Document that the `bvec_iter` cursor can be copied and moved freely.
  - Use `&raw mut` instead of `core::ptr::from_mut`.
- Narrow the `unsafe` block in `Request::command()` using `BitAnd` (Alice, Gary).
- Use `c_void` from the prelude and drop a spurious blank line in the `TagSet` flags module (Alice).
- Drop the `Tree` type alias in favor of `XArray<TreeNode>` in rnull (Alice).
- Use a `NoIo` memory allocation scope in `queue_rq` rather than passing `GFP_NOIO`.
- Add the missing comma between `memory_backed` and `submit_queues` in the configfs feature listing (Alice).
- Fix the `use_per_node_hctx` store to set `submit_queues` to the online node count instead of multiplying by it (Alice).
- Use `static_assert!` instead of a `build_assert!` constant for the page/sector width check (Alice).
- Fix a typo in the `TagSet::new` doc comment (Ken).
- block: rust: add `BadBlocks` for bad block tracking (Alice):
  - Remove newline after `use` statements.
  - Add C header link.
  - Convert boolean to int with `into`.
  - Remove duplicated docs from `enabled`.
  - Use if/else rather than `then_some` in `set_bad`.
- Add a patch to rename `SECTOR_MASK` to `PAGE_SECTOR_MASK`.
- Use `pr_warn_once!` where applicable.
- Require `TagSet` private data to be `Send` for `TagSet` to be `Send`.
- Require `Operations::TagSetData: Sync`.
- Require `Operations::HwData: Send + Sync` and add a note on the bounds.
- Require `Operations::RequestData: Send` and add note on the bound.
- Add `TagSet::flags` to obtain flags and fix a bug in zoned emulation caused by taking a mutex under rcu read lock.
- Link to v1: https://msgid.link/20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org

Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: rust-for-linux@vger.kernel.org
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: "Liam R. Howlett" <liam@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
To: Benno Lossin <lossin@kernel.org>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
To: Boqun Feng <boqun@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Jens Axboe <axboe@kernel.dk>
To: John Stultz <jstultz@google.com>
To: Lorenzo Stoakes <ljs@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lyude Paul <lyude@redhat.com>
To: Miguel Ojeda <ojeda@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Trevor Gross <tmgross@umich.edu>

---
Andreas Hindborg (83):
      block: rust: fix `Send` bound for `GenDisk`
      rust: block: rename `SECTOR_MASK` to `PAGE_SECTOR_MASK`
      block: rnull: adopt new formatting guidelines
      block: rnull: add module parameters
      block: rnull: add macros to define configfs attributes
      block: rust: fix generation of bindings to `BLK_STS_.*`
      block: rust: change `queue_rq` request type to `Owned`
      block: rust: add `Request` private data support
      block: rust: document the lifetime of `Request`
      block: rust: allow `hrtimer::Timer` in `RequestData`
      block: rnull: add timer completion mode
      block: rust: introduce `kernel::block::bio` module
      block: rust: add `command` getter to `Request`
      block: rust: mq: use GFP_KERNEL from prelude
      block: rust: add `TagSet` flags
      block: rnull: add memory backing
      block: rnull: add submit queue count config option
      block: rnull: add `use_per_node_hctx` config option
      block: rust: allow specifying home node when constructing `TagSet`
      block: rnull: allow specifying the home numa node
      block: rust: add Request::sectors() method
      block: rust: mq: add max_hw_discard_sectors support to GenDiskBuilder
      block: rnull: add discard support
      block: rust: add `NoDefaultScheduler` flag for `TagSet`
      block: rnull: add no_sched module parameter and configfs attribute
      block: rust: change sector type from usize to u64
      block: rust: add `BadBlocks` for bad block tracking
      block: rust: mq: add Request::end() method for custom status codes
      block: rnull: add badblocks support
      block: rnull: add badblocks_once support
      block: rust: add `Segment::truncate`
      block: rnull: add partial I/O support for bad blocks
      block: rust: add `TagSet` private data support
      block: rust: add `hctx` private data support
      block: rnull: add volatile cache emulation
      block: rust: implement `Sync` for `GenDisk`.
      block: rust: add a back reference feature to `GenDisk`
      block: rust: introduce an idle type state for `Request`
      block: rust: add a request queue abstraction
      block: rust: add a method to get the request queue for a request
      block: rust: introduce `kernel::block::error`
      block: rust: require `queue_rq` to return a `BlkResult`
      block: rust: add `GenDisk::queue_data`
      block: rnull: add bandwidth limiting
      block: rnull: add blocking queue mode
      block: rnull: add shared tags
      block: rnull: add queue depth config option
      block: rust: add an abstraction for `bindings::req_op`
      block: rust: add a method to set the target sector of a request
      block: rust: move gendisk vtable construction to separate function
      block: rust: add zoned block device support
      block: rust: add `TagSet::flags`
      block: rnull: add zoned storage support
      block: rust: add `map_queues` support
      block: rust: add an abstraction for `struct blk_mq_queue_map`
      block: rust: add polled completion support
      block: rust: add accessors to `TagSet`
      block: rnull: add polled completion support
      block: rnull: add REQ_OP_FLUSH support
      block: rust: add request flags abstraction
      block: rust: add abstraction for block queue feature flags
      block: rust: allow setting write cache and FUA flags for `GenDisk`
      block: rust: add `Segment::copy_to_page_limit`
      block: rnull: add fua support
      block: rust: add `GenDisk::tag_set`
      block: rust: add `TagSet::update_hw_queue_count`
      block: rnull: add an option to change the number of hardware queues
      block: rust: add an abstraction for `struct rq_list`
      block: rust: add `queue_rqs` vtable hook
      block: rnull: support queue_rqs
      block: rust: remove the `is_poll` parameter from `queue_rq`
      block: rust: add a debug assert for refcounts
      block: rust: add `TagSet::tag_to_rq`
      block: rust: add `Request::queue_index`
      block: rust: add `Request::requeue`
      block: rust: add `request_timeout` hook
      block: rnull: add fault injection support
      block: rust: add max_sectors option to `GenDiskBuilder`
      block: rnull: allow configuration of the maximum IO size
      block: rust: add `virt_boundary_mask` option to `GenDiskBuilder`
      block: rnull: add `virt_boundary` option
      block: rnull: add `shared_tag_bitmap` config option
      block: rnull: add zone offline and readonly configfs files

 drivers/block/rnull/Kconfig              |   11 +
 drivers/block/rnull/configfs.rs          |  605 +++++++++++++--
 drivers/block/rnull/configfs/macros.rs   |  143 ++++
 drivers/block/rnull/disk_storage.rs      |  326 ++++++++
 drivers/block/rnull/disk_storage/page.rs |   78 ++
 drivers/block/rnull/rnull.rs             | 1198 ++++++++++++++++++++++++++++--
 drivers/block/rnull/util.rs              |   65 ++
 drivers/block/rnull/zoned.rs             |  696 +++++++++++++++++
 rust/bindgen_parameters                  |    6 +
 rust/bindings/bindings_helper.h          |   55 ++
 rust/helpers/blk.c                       |   47 ++
 rust/kernel/block.rs                     |  101 ++-
 rust/kernel/block/badblocks.rs           |  716 ++++++++++++++++++
 rust/kernel/block/bio.rs                 |  147 ++++
 rust/kernel/block/bio/vec.rs             |  448 +++++++++++
 rust/kernel/block/mq.rs                  |   78 +-
 rust/kernel/block/mq/feature.rs          |   76 ++
 rust/kernel/block/mq/gen_disk.rs         |  336 +++++++--
 rust/kernel/block/mq/operations.rs       |  489 +++++++++++-
 rust/kernel/block/mq/request.rs          |  677 ++++++++++++++---
 rust/kernel/block/mq/request/command.rs  |   65 ++
 rust/kernel/block/mq/request/flag.rs     |   65 ++
 rust/kernel/block/mq/request_list.rs     |  119 +++
 rust/kernel/block/mq/request_queue.rs    |   60 ++
 rust/kernel/block/mq/tag_set.rs          |  299 +++++++-
 rust/kernel/block/mq/tag_set/flags.rs    |   29 +
 rust/kernel/error.rs                     |    3 +-
 rust/kernel/page.rs                      |    2 +-
 rust/kernel/time/hrtimer.rs              |    5 +-
 29 files changed, 6603 insertions(+), 342 deletions(-)
---
base-commit: 9e0898f1c0f134c6bad146ca8578f73c3e40ac0a
change-id: 20260215-rnull-v6-19-rc5-send-98c33ec692d6
prerequisite-change-id: 20250305-unique-ref-29fcd675f9e9:v17
prerequisite-patch-id: 6c6a7fdd56627293ec3bba61c495f16a0858700c
prerequisite-patch-id: c1958590235ee32d6ddb31ea168105bd9cf248f2
prerequisite-patch-id: c5a4b231dc8adf37e93ebdce308dacbe6a244bf3
prerequisite-patch-id: 541dba7938ba874f8d17fee05a36b1cd9fa2c4d7
prerequisite-patch-id: 3668fd640e4c411bae0c8ea9d986c3fa5d3c9e82
prerequisite-patch-id: da1274864841e267697be9529a50531126c64872
prerequisite-patch-id: c1463b6578e94b56d2bad41f6e614b5286fb1db3
prerequisite-patch-id: a31185fe1abbf553377d6d695c5d206eebc84358
prerequisite-patch-id: 4f392b5736e55a354ec3022644389f89b52fda42
prerequisite-patch-id: b6388ff0ebdd54610010d72a5398842a3c668bbf
prerequisite-change-id: 20251203-xarray-entry-send-00230f0744e6:v4
prerequisite-patch-id: 5d797523ed1bb94597570b6faa4cacea8d94b4f7
prerequisite-patch-id: f82bffce83d85ad4dd0bc9dab876e31c4500d467
prerequisite-patch-id: bc00e3c0a3694d8d490c782bc24b2a5786350da7
prerequisite-patch-id: 39c26c865ad383b133a742e5998e2b1f54999908
prerequisite-patch-id: 4082a1ae45104c2f3170197e186d83db552f9302
prerequisite-patch-id: de0c55224727e169d151d68a5316f0ae4549e4b8
prerequisite-patch-id: 57c6d2464a380542b5283817666540d2c97b0b61
prerequisite-patch-id: c788013f9319aa91f51f74f92f43cf7f2c04496f
prerequisite-patch-id: 959c962400d8595cc55b4f1b3a5501c2290a7d0e
prerequisite-patch-id: 66ed5c6a31fe2d775b5bc70774e3148fa3d860e5
prerequisite-patch-id: 869aa913843e11b467890ed35a1455458dbf3de4
prerequisite-change-id: 20260206-xarray-lockdep-fix-10f1cc68e5d7:v2
prerequisite-patch-id: e871db17a721fede1b7419b8236229190449885b
prerequisite-change-id: 20260130-page-volatile-io-05ff595507d3:v4
prerequisite-patch-id: 09224764d69c35c18e6fec846d4b7ba33c0e9cac
prerequisite-patch-id: cfd909257db3f5811c94d52ac2fc31cf220560c3
prerequisite-change-id: 20260128-gfp-noio-fbd41e135088:v2
prerequisite-patch-id: 420a09fdd0f2758f4d46228f99f29ff82f2d05f3
prerequisite-change-id: 20260212-impl-flags-inner-c61974b27b18:v2
prerequisite-patch-id: 379fb78c07b554278fae3c42d84d62bcfcfa0d45
prerequisite-change-id: 20260214-pin-slice-init-e8ef96fc07b9:v2
prerequisite-patch-id: cdf4e4b2b8c43bcb54b3ddf13a02e28c0e11e9ce
prerequisite-change-id: 20260215-page-additions-bc36046e9ffd:v2
prerequisite-patch-id: 6c6a7fdd56627293ec3bba61c495f16a0858700c
prerequisite-patch-id: c1958590235ee32d6ddb31ea168105bd9cf248f2
prerequisite-patch-id: c5a4b231dc8adf37e93ebdce308dacbe6a244bf3
prerequisite-patch-id: 541dba7938ba874f8d17fee05a36b1cd9fa2c4d7
prerequisite-patch-id: 3668fd640e4c411bae0c8ea9d986c3fa5d3c9e82
prerequisite-patch-id: da1274864841e267697be9529a50531126c64872
prerequisite-patch-id: c1463b6578e94b56d2bad41f6e614b5286fb1db3
prerequisite-patch-id: a31185fe1abbf553377d6d695c5d206eebc84358
prerequisite-patch-id: 4f392b5736e55a354ec3022644389f89b52fda42
prerequisite-patch-id: b6388ff0ebdd54610010d72a5398842a3c668bbf
prerequisite-patch-id: 1f57b529c53f4a650cbeeb7c1ff81653cb95e7f3
prerequisite-patch-id: 4d71a95c2d1a6a36339a9feda6296c33ec86f258
prerequisite-change-id: 20260215-cpu-helpers-08efb2572487:v2
prerequisite-patch-id: fd7f24bed247075d1946f9f526390772afb45236
prerequisite-patch-id: 7d243f4cd29a08a1eb2ca0e0e976fa82f0760f11
prerequisite-change-id: 20260215-export-do-unlocked-00a6ac9373d4:v2
prerequisite-patch-id: c65f4a3078f1acc1b77ea28b531e54664187dbce
prerequisite-change-id: 20260215-impl-flags-additions-0340ffcba5b9:v2
prerequisite-patch-id: 379fb78c07b554278fae3c42d84d62bcfcfa0d45
prerequisite-patch-id: 04c7db66a06be7a2566a23328d2c485ce24f1bb8
prerequisite-patch-id: 4d78d6d7aae15c51e6a1df2cb393392fb7ea90de
prerequisite-change-id: 20260215-ringbuffer-42455964aaf2:v2
prerequisite-patch-id: 44924a030c52ae111983078f1225510e9dc0c009
prerequisite-change-id: 20260215-configfs-c-default-groups-bdb0a44633a6:v2
prerequisite-patch-id: 03b8e71b79be89a73946f3c1f7248671c28ccd42
prerequisite-change-id: 20260215-unique-arc-as-ptr-32eb209dde1b:v2
prerequisite-patch-id: 20f44fe6cfe6b0e52b614bd64469fbf1df5c1e94
prerequisite-change-id: 20260215-rust-fault-inject-bc62f1083502:v2
prerequisite-patch-id: 03b8e71b79be89a73946f3c1f7248671c28ccd42
prerequisite-patch-id: 8b287be6364945d10e661e0828ad17b023f487e1
prerequisite-change-id: 20260215-hrtimer-active-f183411fe56b:v2
prerequisite-patch-id: e029dd2cb097192e597417e40d7d23bedaa79370
prerequisite-change-id: 20260529-modules-value-ref-e95a7ab94fdb:v2
prerequisite-patch-id: 618f9f3cfea3f8a03db5e73229d77b48f6549ab4
prerequisite-message-id: <20260411130254.3510128-2-wenzhaoliao@ruc.edu.cn>
prerequisite-patch-id: f714b166f93e453dddd01ed17c976b53e6da4957
prerequisite-change-id: 20260608-queue-data-sync-80b66ab312ac:v1
prerequisite-patch-id: ec86c4ec1531441a2c19085bf24ecc06819d7420
prerequisite-change-id: 20260608-update-hw-nodes-arg-940ecec0380a:v1
prerequisite-patch-id: a1e95b0ec36bf18976553fb8a2e17fd1527a6a1a
prerequisite-change-id: 20260608-configfs-fix-offset-6b3117158901:v1
prerequisite-patch-id: e8355bdd4444f8bda2663aa0bdcf3336de126255
prerequisite-change-id: 20260608-numa-node-id-85de708d4e8d:v1
prerequisite-patch-id: 8b82a179a91cd3e0ca8396eff81dae7bf66e5349

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


