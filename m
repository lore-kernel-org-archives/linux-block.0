Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F64F205
	for <linux-block@vger.kernel.org>; Sun, 12 May 2024 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539130; cv=none; b=WtdqyQ3Rn+d4/jc2O8Aqh/toA35TrDbtN4NpFPjnv6fVsWlhk+nWLKl8yza80my7D5unAiquP9rZkm64HE4Eipp1eWnrv7PXInafaQaCOEKWPjjP9p6lDJSEFavbZvysYEiYG4MLf10elbiIght0fUs0GRKpa+rTpW9oIXH9Xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539130; c=relaxed/simple;
	bh=b5i2hqWqMMetERk5hQhn2SOVCTZcCAIel03ZVQRAcqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXagneRr7pIJ/hgn/Emy137nVUiArWffYCvzAP3GGx46HruRM49IKIgXIJahiI8BVTxyns4/oEI5qmtg6TJ0FPX6feiwadppk5OEL5cBsLGltqVZ9o0h/iIz7lpNlHYHvQ2IDy4soGWi3swPouvUI5jTDSsii+FujIxoLPAttNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=qUgda+IF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="qUgda+IF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ecddf96313so31579455ad.2
        for <linux-block@vger.kernel.org>; Sun, 12 May 2024 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1715539128; x=1716143928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pTw6lc2ugV+pxnsE+unm7DWQd2E2uzUOLG4JPutFiY0=;
        b=qUgda+IFj4T9eWO10xG76Vs70WTP0+FZHpiViE228WUida07OgblU26SXpJJkFeMXD
         VA7nhet1ecYlm08dwBdarOWORyR5ySQ4nzuc/N/X/p1GQufU+3W3OvWpM3GExYzJwM97
         Ti0BugEbZ+SrOxW9cAh/bGJtYxxlqY+/aNtro6vYogAkbKEluUDH0yLZkJrWTKQESyMW
         kQYfmtE4XIwTV/sb9x/SsYa+XNSn9fkJ+AR1rjkBRbh1kPFkcTZjJywPyrnlcH04lMp6
         Oluo7GdT8O4E1HDl1K+nP8rYJrFoZ7vKKhGm+adUsiKZHx5ro8IBrPF9SunmCLrFWTAA
         7++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715539128; x=1716143928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTw6lc2ugV+pxnsE+unm7DWQd2E2uzUOLG4JPutFiY0=;
        b=FQ6Zi4/Kw5EL8YGGUaxXd5OCtU6AighmhmiItbeYB0Vnw4u+8YuqDKO9ffrd3pHnar
         Lc0iOYGIafXMDuq5bS1AORqCUho85w6DA0EerYfMv40uLexQGYOtlmRuPHof+PqoMa8C
         E+axsmtESmvnd8B+wl/cWv03cxHAbwOg598NRsQlcKgOcqi7VhhC1s+PobnES0t2rhnS
         IZ995ZmgG8pbl6slQM9M9yJseWds4ikG1GrMG7o3NzS8MkHtdrA6KGPDuN5g/ybeONDf
         ShPoNrn5F7Ae4DCxLZbvlfZ5dG/AexmFPG57Z53iGm9zQY9VxvRABGU7BBOAdCg+hLcv
         X7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6CJi3YZbDlxaRh9+Ulht3ZpXc1evwpIWQUIDsl4f3VpGRFh9tzGwNc5mqBXNjBq43Ulg0sdgkt8uenCPXDO3RgAYzNh5YCsjcxzA=
X-Gm-Message-State: AOJu0YzPmm7o78lWzrUNDCQ08ffWK+OTbanmGCz5ThIyIqZrZZHnUZ3N
	wHTwGzVT5B+GoDbyF34wljHED2ElT70Y5xQs08IZj6HUh4FMYZZ/NfSStI+wGuQ=
X-Google-Smtp-Source: AGHT+IHYI+JDwwHMS9qaOCTM3NFMH1XQ5+NtCnwnFUuRK9C6B3gqEBh9KT8mufB19yR5/TuoFY+YCw==
X-Received: by 2002:a17:902:f647:b0:1eb:3df4:e63b with SMTP id d9443c01a7336-1ef43c0958dmr137532155ad.7.1715539127718;
        Sun, 12 May 2024 11:38:47 -0700 (PDT)
Received: from localhost ([50.204.89.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d4733sm65063365ad.54.2024.05.12.11.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 11:38:47 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
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
Subject: [PATCH 0/3] Rust block device driver API and null block driver
Date: Sun, 12 May 2024 12:39:45 -0600
Message-ID: <20240512183950.1982353-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All!

I am happy to finally send the first _non_ RFC patches for the Rust block device
API.

This series provides an initial Rust block layer device driver API, and a very
minimal null block driver to exercise the API. The driver has only one mode of
operation and cannot be configured.

These patches are an updated and trimmed down version of the v2 RFC [1]. One of
the requests for the v2 RFC was to split the abstractions into smaller pieces
that are easier to review. This is the first part of the split patches.

A notable change in this patch set is that they no longer use the `ref` field of
the C `struct request` to manage lifetime of the request structure.

The removed features will be sent later, as their dependencies land upstream.

As mentioned before, I will gladly maintain this code if required.

Canges from RFC v2:

- Change request state tracking method
- Use a slice rather than a raw pointer for `RawWriter`
- Use typestate patttern for `GenDisk` to prevent mutation of non synchronized fields
- Remove per gendisk  private data support
- Remove per tag_set private data support
- Remove per hwctx private data support
- Remove per request private data support
- Remove use of `ARef::into_raw`
- Remove use of `Opaque::try_ffi_init`
- Remove map_queues support
- Remove bio iteration support
- Remove methods to fail requests
- Remove request introspection methods
- Remove module configuration via module parameters
- Remove timer completion support for Rust null block driver
- Remove memory backing support for Rust null block driver
- Remove soft-irq completion support for Rust null block driver

Thanks for all the feedback and comments on the earlier versions!

Best regards,
Andreas Hindborg

Link: https://lore.kernel.org/all/20240313110515.70088-1-nmi@metaspace.dk/ [1]

Andreas Hindborg (3):
  rust: block: introduce `kernel::block::mq` module
  rust: block: add rnull, Rust null_blk implementation
  MAINTAINERS: add entry for Rust block device driver API

 MAINTAINERS                        |  14 ++
 drivers/block/Kconfig              |   9 ++
 drivers/block/Makefile             |   3 +
 drivers/block/rnull.rs             |  82 ++++++++++
 rust/bindings/bindings_helper.h    |   2 +
 rust/helpers.c                     |  16 ++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            | 109 +++++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 205 ++++++++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 245 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  55 +++++++
 rust/kernel/block/mq/request.rs    | 227 ++++++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    |  93 +++++++++++
 rust/kernel/error.rs               |   5 +
 rust/kernel/lib.rs                 |   2 +
 scripts/Makefile.build             |   2 +-
 16 files changed, 1073 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/rnull.rs
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.44.0

