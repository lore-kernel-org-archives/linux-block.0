Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E317C215
	for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106372; cv=none; b=mHmwjUH54jjFLeWN+YcqxjzmP4FSEFJnVdu8BAN3lZc7TpZM1fKky1nvCkXmoqm3M1q21F+B5NUdIzFyHQHuT3d4kF2WPh6nLjaA4ryrmbTz4sJwBBqyGqy99msiKDgXMsTJ78H0WtLdRoypJ99FUDyEyjaH12OUE0zLy8rObNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106372; c=relaxed/simple;
	bh=b3NGj7oL6Jv0SejkdL5Ni5oUGz6hL0S7RKz9eET4iBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVqx3plD4GQALEEtMyBnkd5xYq/tC7k+h54dSJb4pTx+29dLoWevxBv9DAPJhTPhGWoLS9c/tczsq5kqPX1lldfxksoApmQgy6swDutgQ+1w+ZAlXgL7iQcrQtZqISyzqTcI42tUezNFkBg8H8xWyxkITCEv4257ZP5D39r9+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=dtej5ZfY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="dtej5ZfY"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f176c5c10so100925466b.2
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1718106369; x=1718711169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAkMV8dOReDwzeJM6A6yM+HS2q42IbWrPAmzhy7HUmU=;
        b=dtej5ZfYwzoeE/0R7zbBd+A8yqpyEZzJcl4cjjbvxiKs5Q7wI7l7pROdLZPxlYYEoQ
         xFAXoIT917FDdbG7bS5b6NYn1G49ySs9YJTG6X1CTllvRjxFyrME9x6nq+HIVjQPt/U4
         rOkTaMJbiNVK0uKT8xfk5wMBmmQM0e0W7Vg+GWuISmzeRMZLF7fzI0grFCxS4fTsPxO8
         2IPXxIrW0jPUqbHqrVX4YFkS1mzlXSrGo8sWKgljLBpcSAm763SwZW+6zRm417uXkRpd
         2gIOaTZ0p5GUh9q7K03rsfLmqaaexFIQb2Fx9emNPrKQmGqTCOoPzmxokaNiJVVocqri
         6NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106369; x=1718711169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAkMV8dOReDwzeJM6A6yM+HS2q42IbWrPAmzhy7HUmU=;
        b=RiQQqrG401f7KjvXPyCfd/2/ZPdZNy3XK6CdXs6HEBYrx5CESl58Vk0Vz9jSbCA0C+
         Wg4EaVfnOr5nt0X3c1nZj5j4BAygsEtkHrOiQN0ks7a6BZrSNlRtIh5JnSDP5/aG4QCh
         q/eLixIgs1XKXnDgGo7Xn9/8iAMl3QWdlMWOv6kENqAJytBZ7+GZ6tlTTrrRDnu281cs
         LpDt8X/VPHgGMY36HhF+0rer/MLqfExohDzhLjZD6Sp0Dll65zT1T+yMzzDSuP+Hs1Di
         Zd/WRENw/18ScbiCvhT+YO97giaugSJqX+3ZRMrOKGiRnbENmhSVM0Q2G1KkWt1TbBwT
         tW/g==
X-Forwarded-Encrypted: i=1; AJvYcCUlReOOdGwvFFnGbmoLYfZ0Tk4G45O2czKmFWZ6GMXuJ5VRQ7IOgM6O/255UPP2Fq43R2d5DuMNCMXliTddMRiZJrSNArovg7n2MCQ=
X-Gm-Message-State: AOJu0Ywp7U5qfgJvY1KldTn4Q5kgQB/XSGj/fxshXICSOsQFzCTB6qGK
	wwHiQlFVPg3x2hXU2pguVVFidXwjJigS1cyOPLXiIzKf2iWKj6tk1ZxrBdZm5Rk=
X-Google-Smtp-Source: AGHT+IFl2q2onMUUXk9QqKpsWKHTXHyxa4wuk2b6Y4wX75ZliOJXw4eHqe7iyC+vhCnnecOBQTDihg==
X-Received: by 2002:a17:906:2a99:b0:a6f:e36:abae with SMTP id a640c23a62f3a-a6f0e36ace7mr553579266b.42.1718106368615;
        Tue, 11 Jun 2024 04:46:08 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f2e7eb1f9sm144962466b.221.2024.06.11.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:46:08 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [PATCH v6 0/3] Rust block device driver API and null block driver
Date: Tue, 11 Jun 2024 13:45:48 +0200
Message-ID: <20240611114551.228679-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2824; i=a.hindborg@samsung.com;
 h=from:subject; bh=Pn9pPWG4joCwFmB/Fietx6Dc7vYUqajhD+Kxe5sk6M8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR1pvTnE5MUZmeWMxdTFkUmxBWGVrV0ZFQjlhCmRUb2RqNHhtdnh4Uml0c2xs
 M3pxRDRrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbWFEYXZ
 BQW9KRU9HNEdqNTVLR04zdEZBUC9pbWxPMWNmZEVDM0NZRkZ5RFdFV0hGeWpIQkZHTlpYc1k3Vw
 pFKzZiaWt1NGdIOU05b21tbi9BLzVPd1FVb2E2TkZMTUR6MDUvMWgzNHBlYTJYRkJGelM2Y0d5d
 CtKSnMrY0ZVCmw3T0FndTdsQ21jT2VqSHFZOWJmNDJwN3ZPazRDWEZtbkIyc1hCcUNsS0lXek8v
 a0pBZWJycXJhWWhJZlp6T2gKa0JNVWx6WEsrRW5YMzRVVkpNUi80MUdDNDhwODRRWHRpQ3Y3ekN
 4aEZ4ZW5DZkdyaUJtd3FOTjRqQjZNd1FEMwpncEFmOTlSRGp2YjZ0M3Z3dUlLbjRaTXBwcjhGNH
 k4RXJ0TW9QcmUzWEVtUFhNckRIR0VUR0pmeFRxamlmcFIxCnAxdWdmNnlXbVVTc1BrUUZ0U0RzM
 2hwZkowamlGVzFPbk51TnVZM295YzNxZjVRNkZ2RWxXYnN1TmxZMlBzUjUKMDFENlJnVk0xWVF4
 Mk5zV1N1MEFXWTFqNERjTG44Z0lod3R1TzZLc1hqalQxQ05abFZSN0lGWndzM1lVVU1ZVgpOZmt
 wSVZJOWZLS1ZDajV3N3NldUdsRnNKeG4vZVZFaUFpYlNOaCs5VEptUU1PS1BqZXRXbnlHeUVUUW
 p4MVhrCndxMFZRVUd2dVNHTS9nemNxaUR0WFhyUGEwNmZnVjBxWGZGWkpTN21ERlBraHNHVnZyQ
 zZtR21TWVl3VlJZVEYKQ3h2Uk9VcUkwdnJyck8yeHVXZFIwK1IvcVYzdHV1cWpqcVlLYWdBcXFj
 OFNnQ21CbForV21UbmVMUDlFRFZLOQowUUQzOThOWlJTWUkzTU1SL3ZrRko3dFhIcVlXaXpvWnM
 2Um51V0RjZ2dxVVBibG1vMjZFdmpvdDFqS3hZNjFtCmZGb3RJSVpNNXBzaEJRPT0KPW5zRW4KLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@samsung.com; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi,

This series provides an initial Rust block layer device driver API, and a very
minimal null block driver to exercise the API. The driver has only one mode of
operation and cannot be configured.

These patches are an updated and trimmed down version of the v2 RFC [1]. One of
the requests for the v2 RFC was to split the abstractions into smaller pieces
that are easier to review. This is the first part of the split patches.

A notable change in this patch set is that they no longer use the `ref` field of
the C `struct request` to manage lifetime of the request structure.

The removed features will be sent later, as their dependencies land upstream.

Changes from v5 [2]:
 - update `SAFETY` comments of `Operations::queue_rq_callback`
 - update `SAFETY` comments of `Operations::init_request_callback`
 - update `SAFETY` comments of `Operations::exit_request_callback`
 - update `SAFETY` comments of `Request::wrapper_ptr`
 - change `Operations::init_request_callback` implementation to use `Request::wrapper_ptr`
 - rebased on v6.10-rc3

Thanks to everyone for comments on previous version!

Best regards,
Andreas Hindborg


Link: https://lore.kernel.org/all/20240313110515.70088-1-nmi@metaspace.dk/ [1]
Link: https://lore.kernel.org/all/20240603191455.968301-1-nmi@metaspace.dk/ [2]


Andreas Hindborg (3):
  rust: block: introduce `kernel::block::mq` module
  rust: block: add rnull, Rust null_blk implementation
  MAINTAINERS: add entry for Rust block device driver API

 MAINTAINERS                        |  14 ++
 drivers/block/Kconfig              |   9 +
 drivers/block/Makefile             |   3 +
 drivers/block/rnull.rs             |  73 +++++++++
 rust/bindings/bindings_helper.h    |   3 +
 rust/helpers.c                     |  16 ++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            |  98 +++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 215 ++++++++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 245 ++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  55 +++++++
 rust/kernel/block/mq/request.rs    | 253 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    |  86 ++++++++++
 rust/kernel/error.rs               |   6 +
 rust/kernel/lib.rs                 |   2 +
 15 files changed, 1083 insertions(+)
 create mode 100644 drivers/block/rnull.rs
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.45.2

