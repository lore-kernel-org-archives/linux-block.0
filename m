Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79752E92BA;
	Sun, 15 Feb 2026 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199051; cv=none; b=iaeXPbke9G19dOZbcb3aqymrY+DwLl2/Pau0t0sw+KZSAQhTtZ2c/1N2bfLMDycHk007A8rjbRL/HQlcYfTcyx0RIlMJaQezVbHrBeOEYDQApQu5ykB4eIMSFdhEU5dfN3jkLdWWpEcE8AJYjaLq/QUA+A6UT0WwicUQh+NRf2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199051; c=relaxed/simple;
	bh=8tUb4kuCfMG5UJ8wjZwbNrxjIDGhs1L62Et9fuNTLM4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iHofRnv7syArtDUyLgza/ZIcONoYwclJvUT+gqCQdM1qZIZrVi1MmkjkKR1h2x8wLF1f3lBDkMlrY3IhAAoTZ8zjKkVJUtQy76iUG2IB9fD2MlN3rAOlF810qQteH3+fg2xyFX3iFsa3hJR/ea3cxwIjZF2dRUp5dlp+acvJeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE5IRuG7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE5IRuG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA46C4CEF7;
	Sun, 15 Feb 2026 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199051;
	bh=8tUb4kuCfMG5UJ8wjZwbNrxjIDGhs1L62Et9fuNTLM4=;
	h=From:Subject:Date:To:Cc:From;
	b=pE5IRuG7fuyr56x9St/U6tAgXtbK273yuga3NbqjkmBkttrWiaVUSg4NL5NCZrCTm
	 7SwZRe4k2G3LcA4PIozztxbboMs5ZXEA6i3EQ1qCO4hV+3W/nzJ9toFCbMDSoeIPcS
	 XMSqV0Gcvjq9R4VxTtJyg8ueBVPA+mdbt3JJdHIEF1e8Pk0ocZQOSL6vonvE/qj+ca
	 FdK6LQLE4XgyKeRATxxwEaTyyizAvFvrOu++mmPRG3F/t5MxgXNGCtBW+w63smOeJo
	 OVqehvdqGZzuYDn1ajJeP5muoBjod3Qv6ksKLQ/rKmagEgVXbqHZajoqXHzYY6VnOW
	 bJICknme/bsuQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH 00/79] block: rnull: complete the rust null block driver
Date: Mon, 16 Feb 2026 00:34:47 +0100
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhYkmkC/4VU227cIBT8lZWfe1bcba+qKv9R5QHDwSGxwQVsJ
 Y3y72V3GzVqN67fAM+ZYWbs1yZj8pib0+G1Sbj57GOoC/rl0JgHHUYEb+u6YYQpwqiEFNZpgk0
 B7SEZCRmDhb4znKNRPbOqqdAlofPPl7Hf76/rhD/WOr1cN5tBZwQT59mX02FTx+u0M3bGnPWF9
 3T4eqGl9WFMSnFkSjHaSqAwxZx9uHvCFHA6xjR+az5KPh0qUhJOJKzB/1gRqiJgvTNWtdL12J8
 2Km5AKCMcnnVK+gUwlPRyvSAhjBNHWiFQnTb+L7CaQ9Q7cIrmyeIC1QOgxFFjVIfStpXztkoBD
 nUBbS0Mvsw6P8GsTYqgBBMDNZy2yE5bd4uXcgLL2bAtTrr4qR5FINI52UtJWss/0UtZB6NbIMT
 6vhusoEi5JF13U+U5fAZ+XiZwkx4z+BAwgVG0b8XA2oG+4/7Or1pKFSGkJ/TIGOWX+Nz66Is+l
 jjHEJO/G2ftp2Ptw7fb1AIWHyBP3tTt4Atgh65XzpB26D8VLK/GVFt9qb3OMBiuiFDYO2d3UGZ
 Z4QGnBVMGUokGJlsmunYHUvyM4FKcIegQM3TKdQMlAwrN/gezOBUN1udlquWxLWHYtl1n2Z5Gf
 F5iKmBjLfi5b3guqVba9LzlVuwgP4T4xxnCBXHODFru+pl8GIfVuRp9baaUvRJau70bZiwQQ41
 t0j9fwLTcGS60lHaP5iGdjUmgTfFb9ZV2XFDqUKphL7YYnB9dBlMtdXqdCowprkvN3Q5EC6E41
 2pnwO9fhU4GdIalJOAMB0Z6a5HuMac1F7gy+vCIptSmKeYo6eoXdXHn/u3tF0BNclNsBQAA
X-Change-ID: 20260215-rnull-v6-19-rc5-send-98c33ec692d6
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13667;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=8tUb4kuCfMG5UJ8wjZwbNrxjIDGhs1L62Et9fuNTLM4=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgcM01FLWjjGFqmeKP8M0ULEepsy9Wa8j2TD
 OzEuTce7tWJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYHAAKCRDhuBo+eShj
 d6XXD/0fwis7BeaPw8KWxiqLebdqxz8Mx2EiogPlf65i+JoRV5jc8zeZbIp++R1ZpjojvfQV7TD
 s6gsKQ4/69hufOMHeHe+1Fk2hxcl7lWlwi6TxM7wIjdOzTh7UJB1sZXd7RKFPGQpRXaGeFodsRr
 9g4TlqHk60CugjpZtgSOwGcUxWwRR13lgjXC6nIqBcmH5c8+EoeA3RUOSrzbXSx11aBSEjaYU4z
 ZK/ADRGFnOAkNbPrA/rPSlQkIWcysObTkGaKrKG8krwuYeGlEw0m5Cxmv+ffUNdXE0fEyea0+MV
 EUTgi5Np0mx+1y2PB/0AphJswlO8IEiNno5WOlMHVJ5I+NfgBcO6Zj0m7jMa+45Dijw4ua9s4TG
 K8KJ12aapJLNG7L/O9mGEecPQMttcpBo8mxNQMA0F2dNhAydyIlBme+7uiu5UpB71W/RE5iGDIy
 3TRI+nBwf/s1Qns28Smc35u2eZj6SQoXEPXceRyn4rGhKt8V8SCwkGGG5VQmmTSGkW12BgwDmdQ
 2ZmG5KUkvmydLghMUteif/YdG5bi7QsRrxlDABItLRTHCwmMY9dGXYEC/Kd3wDaUphT5sT3VeqR
 jkSwUSlykr9WD4kwT1AIZx1y15cdhm8B4WF0oeiS0vhT3r7Z6JPR9RdZd2fLtw5XX4H1jcHRgrF
 M+fdfwvX/aWm8WA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series aims to bring the feature set of the Rust null block driver on
par with that of the C null_blk driver.

I intended to send these patches little by little as they became ready, but
due to dependencies everywhere, that did not work out. This series still
has quite a few dependencies, but they are all on the list. B4 should be able
to track them. I also prepared a tree with all the dependencies and this
series applied [1].

I tried to test everything thoroughly, but there are quite a few moving
parts. Tested-by tags and bug reports are highly appreciated.

I was a bit in doubt about whether I should organize all the block layer patches
first and then the driver patches later, or if I should move the Rust block
layer patches close to their corresponding driver use. I chose the latter,
because it is easier to connect a subsystem change with the corresponding
driver use that way.

Best regards,
Andreas Hindborg

[1] git https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git rnull-v6.19-rc5

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Andreas Hindborg (79):
      block: rnull: adopt new formatting guidelines
      block: rnull: add module parameters
      block: rnull: add macros to define configfs attributes
      block: rust: fix generation of bindings to `BLK_STS_.*`
      block: rust: change `queue_rq` request type to `Owned`
      block: rust: add `Request` private data support
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
      block: fix arg type in `blk_mq_update_nr_hw_queues`
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

 block/blk-mq.c                           |   13 +-
 drivers/block/rnull/Kconfig              |   11 +
 drivers/block/rnull/configfs.rs          |  561 +++++++++++++--
 drivers/block/rnull/configfs/macros.rs   |  128 ++++
 drivers/block/rnull/disk_storage.rs      |  303 ++++++++
 drivers/block/rnull/disk_storage/page.rs |   76 ++
 drivers/block/rnull/rnull.rs             | 1137 ++++++++++++++++++++++++++++--
 drivers/block/rnull/util.rs              |   65 ++
 drivers/block/rnull/zoned.rs             |  694 ++++++++++++++++++
 include/linux/blk-mq.h                   |    2 +-
 rust/bindgen_parameters                  |    3 +
 rust/bindings/bindings_helper.h          |   55 ++
 rust/helpers/blk.c                       |   47 ++
 rust/kernel/block.rs                     |   97 +++
 rust/kernel/block/badblocks.rs           |  721 +++++++++++++++++++
 rust/kernel/block/bio.rs                 |  143 ++++
 rust/kernel/block/bio/vec.rs             |  414 +++++++++++
 rust/kernel/block/mq.rs                  |   63 +-
 rust/kernel/block/mq/feature.rs          |   73 ++
 rust/kernel/block/mq/gen_disk.rs         |  293 ++++++--
 rust/kernel/block/mq/operations.rs       |  464 +++++++++++-
 rust/kernel/block/mq/request.rs          |  634 ++++++++++++++---
 rust/kernel/block/mq/request/command.rs  |   65 ++
 rust/kernel/block/mq/request/flag.rs     |   62 ++
 rust/kernel/block/mq/request_list.rs     |  113 +++
 rust/kernel/block/mq/request_queue.rs    |   57 ++
 rust/kernel/block/mq/tag_set.rs          |  254 ++++++-
 rust/kernel/block/mq/tag_set/flags.rs    |   27 +
 rust/kernel/error.rs                     |    3 +-
 rust/kernel/lib.rs                       |    2 +
 rust/kernel/page.rs                      |    2 +-
 rust/kernel/time/hrtimer.rs              |    5 +-
 32 files changed, 6278 insertions(+), 309 deletions(-)
---
base-commit: d0e305301e82474223bf26185e86e7dc2eb85350
change-id: 20260215-rnull-v6-19-rc5-send-98c33ec692d6
prerequisite-message-id: <20260111122554.2662175-1-lossin@kernel.org>
prerequisite-patch-id: 7e37741a0938ad95a2db219937aa2ce746d3af37
prerequisite-patch-id: f11cbc5fad12be51606cd87a58a0f57025d97a62
prerequisite-patch-id: cf31a67c2cdaca2d6587a470509924b278bcb30c
prerequisite-patch-id: 4192011922ae8e3a05d53e60cd91e3681bd19698
prerequisite-patch-id: 59fad9919fed79eb8b0321ba12028952e10f706c
prerequisite-patch-id: 172bee0aa19a19aaaa3872be19817c8024d586ff
prerequisite-patch-id: d68edb5c60cdc3c857e0d5c4f758c2afb4c21369
prerequisite-patch-id: 8b686b69aa0edba261ed5dd78457042d640134ba
prerequisite-patch-id: cac7713b71455ec1f1ad98c89d5c3669103778f6
prerequisite-patch-id: 536291f57f0e29b6eeb31529d00a06cc8fddf6fb
prerequisite-patch-id: 9b53103d8d24e44c6c2057eeecbc5bf7c37ab7d9
prerequisite-patch-id: f4cd560fbf982ac76595b8a66045db4a0221305c
prerequisite-patch-id: 917d9f21fc9f3b741c5218f2d7eb428ae4824bb2
prerequisite-patch-id: a1a2cd0f690ca9e596addaf6a766ff2300c1b479
prerequisite-patch-id: 27e526c235aab930c18a300a8b0d611f06c23e9a
prerequisite-change-id: 20250305-unique-ref-29fcd675f9e9:v14
prerequisite-patch-id: cd414158ad8a77616cf5e20f01212929fe4a9b4d
prerequisite-patch-id: ff052142fd3b16d7190b0ad2fb79cc39813e49fd
prerequisite-patch-id: 4da98d17bef5f809a9caad013bab670f661c8d4e
prerequisite-patch-id: a31185fe1abbf553377d6d695c5d206eebc84358
prerequisite-patch-id: 8074279c3569e7997f7a993a8ecac7b977b4509a
prerequisite-patch-id: 541dba7938ba874f8d17fee05a36b1cd9fa2c4d7
prerequisite-patch-id: b7eb6740359975d4d781fbd4f684bc5a8ec277f1
prerequisite-patch-id: d83fb5f310b84492bdf44eeec0f9d3d3146a73f5
prerequisite-patch-id: 77308c47591e44920a3bc0279a4d9013035fcac3
prerequisite-change-id: 20251203-xarray-entry-send-00230f0744e6:v3
prerequisite-patch-id: 5d797523ed1bb94597570b6faa4cacea8d94b4f7
prerequisite-patch-id: 912165c18fcbf3e95b1cfc904d7b9f3d5998df10
prerequisite-patch-id: da53a023167d68b40a44a65477e56552427d2159
prerequisite-patch-id: 012e65c80cf0d5316ecdcc7120b085b26d9744bd
prerequisite-patch-id: 9afe8b888aeebb6c48af0ab61da629d38a6caf6c
prerequisite-patch-id: afd36f629c086991533929384a98013957ac7bb8
prerequisite-patch-id: 178fef5f81fae2f9ef42f9bada1f5e3317877562
prerequisite-patch-id: 02b994ccdb101e499b86875edf8db4b1f0120c87
prerequisite-patch-id: 10abad6caef816abc740a06dc93c761814140f1f
prerequisite-patch-id: 422475ac1209fc9803d3f404253c543e34cf7250
prerequisite-patch-id: 66ed5c6a31fe2d775b5bc70774e3148fa3d860e5
prerequisite-patch-id: e60ef90661b76f4f477e9253d3eace29d2baced3
prerequisite-change-id: 20260206-xarray-lockdep-fix-10f1cc68e5d7:v1
prerequisite-patch-id: a9c6ddbfe6ac4b1e18bb6fc17cda7ea115ef863c
prerequisite-change-id: 20250304-feat-add-bitmask-macro-6424b1c317e2:v8
prerequisite-patch-id: 05dfcf648017dee65c356604e4f99959e76ff64d
prerequisite-change-id: 20260130-page-volatile-io-05ff595507d3:v3
prerequisite-patch-id: f8ee836e5d93eb5dab2850efcfb90466b1b36092
prerequisite-change-id: 20260128-gfp-noio-fbd41e135088:v1
prerequisite-patch-id: 734ceb7200843b2dd8d96bc5c465da1d7e095dde
prerequisite-change-id: 20260212-impl-flags-inner-c61974b27b18:v1
prerequisite-patch-id: edebc37750dccd8d19db0b8fbd5f69f9877675a2
prerequisite-message-id: <20251216000901.221375-1-fujita.tomonori@gmail.com>
prerequisite-patch-id: efa4bda7cbf96b462e2fc4ee64e2e59bbfd987fc
prerequisite-patch-id: efa4bda7cbf96b462e2fc4ee64e2e59bbfd987fc
prerequisite-change-id: 20260214-pin-slice-init-e8ef96fc07b9:v1
prerequisite-patch-id: 9e379a7ad70a3d8d463598ac18888badad490fbd
prerequisite-change-id: 20260215-page-additions-bc36046e9ffd:v1
prerequisite-patch-id: cd414158ad8a77616cf5e20f01212929fe4a9b4d
prerequisite-patch-id: ff052142fd3b16d7190b0ad2fb79cc39813e49fd
prerequisite-patch-id: 4da98d17bef5f809a9caad013bab670f661c8d4e
prerequisite-patch-id: a31185fe1abbf553377d6d695c5d206eebc84358
prerequisite-patch-id: 8074279c3569e7997f7a993a8ecac7b977b4509a
prerequisite-patch-id: 541dba7938ba874f8d17fee05a36b1cd9fa2c4d7
prerequisite-patch-id: b7eb6740359975d4d781fbd4f684bc5a8ec277f1
prerequisite-patch-id: d83fb5f310b84492bdf44eeec0f9d3d3146a73f5
prerequisite-patch-id: 77308c47591e44920a3bc0279a4d9013035fcac3
prerequisite-patch-id: 394eed28da13692ef8e9a3c6df5b9d5a88da2b25
prerequisite-patch-id: 929ffa3147738613a25f319a19fa94c79228ddd3
prerequisite-change-id: 20260215-cpu-helpers-08efb2572487:v1
prerequisite-patch-id: fb5e44b1a2f6c1dafc302698c11eb58578fae354
prerequisite-patch-id: a0817c213565d3e2091c151c386efe87c99bc10d
prerequisite-change-id: 20260215-time-from-nanos-86f8b10be4a2:v1
prerequisite-patch-id: 8e5e18575f4c753f0a04a2d6b145f451b0b04f70
prerequisite-change-id: 20260215-time-delta-display-d702e7788d2d:v1
prerequisite-patch-id: d7352e25e22a1ec8147c50c2623397e9536a2a16
prerequisite-change-id: 20260215-export-do-unlocked-00a6ac9373d4:v1
prerequisite-patch-id: af7e673634a9c9b96692fb1739c7d91402289bb2
prerequisite-change-id: 20260215-impl-flags-additions-0340ffcba5b9:v1
prerequisite-patch-id: df7e080424845e49a13d0fc3842d6a5d9994168f
prerequisite-patch-id: edebc37750dccd8d19db0b8fbd5f69f9877675a2
prerequisite-patch-id: 3a872dd9f9e689ee0b199d59231d4dccb3ed4e0e
prerequisite-patch-id: 545f093139ddd2b81d6e4b0d9a34b449cd0dac5d
prerequisite-change-id: 20260215-ringbuffer-42455964aaf2:v1
prerequisite-patch-id: b83497d39605ac2eb4f58f60fe01d685b753f068
prerequisite-change-id: 20260215-set-once-lazy-c73fc34a55d9:v1
prerequisite-patch-id: 56b8aff3bed13e3dec3155da2d22bf82af7e15be
prerequisite-change-id: 20260215-hrtimer-active-f183411fe56b:v1
prerequisite-patch-id: 18a4cf0bf6b6df01b0c85626551781a1a99c18c1
prerequisite-change-id: 20260215-configfs-c-default-groups-bdb0a44633a6:v1
prerequisite-patch-id: 5c82dc0deb0768531d2cdb24ac5e92857c9e76a7
prerequisite-change-id: 20260215-unique-arc-as-ptr-32eb209dde1b:v1
prerequisite-patch-id: 556fbdb0805258a37eecc1da428abdf493346322
prerequisite-change-id: 20260215-rust-fault-inject-bc62f1083502:v1
prerequisite-patch-id: 5c82dc0deb0768531d2cdb24ac5e92857c9e76a7
prerequisite-patch-id: 76ff44f1133e2b2cca23ae41c682155e6921e0b8

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


