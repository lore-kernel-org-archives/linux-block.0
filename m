Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A907F46B
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300126; cv=none; b=aBG22dwIoG41YhoNoXIqo3s9tj3qLPE8c8Vdl06RqQDr63SijKYRc+BFU+QwphtePOQEcREBZh+pYqf1AWFdYmeL9yD4BlIE8At44oez5sZOSaERUqCPjmpgNbvoyEpcHHcpRDv924sxKUw/Ogl2d+1TgRctfaEgff04wGqDBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300126; c=relaxed/simple;
	bh=8Nm4bcloCkKdTAMMAl5tnTAzfKE2/nmNvNzGM5tA6ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEedcVdlGDqf6/o8Obrl9WFp2L2ivAsPr4Czgl19jo0jLfc3WLbmg1YRTY+KtHXeqUEPLpfjPBb3KnoXif+wPh1puaX895+LrGdGUJkvrqlKtxaw6780QJ3iOVtxuS+GzZnj1sSSwsIrz571omig0WK9t8C8GmkmKW4QYE7wJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=i9A/70qC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="i9A/70qC"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b81d087aso811451966b.3
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1716300123; x=1716904923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPucwLlGIDCoc/kjcAh9Snn7SwWN3nO4JXCoZKLG+xY=;
        b=i9A/70qCeaPJ9fVvG1CGVImnZPkBsih6cmpV+AYWxFsuSjB6UCUQXVnDxl7Oa7/KDz
         bNTF3Zz54dzoFH0CJNb9pW2oW7t5HmFlMZp6dqmFIQNV4OY1xNGEMFleQ80v1BUv49N5
         TbwEKmFTrtBAH7sX93BZ3m4OBCx3nKlOfVoK/9eWWTMGGncPDjWiicDRuzIBQCD/KFQ5
         HjCadcWwICs7fTYSTOQBzNesW+ZtgP+Vb6CRG81R0q8RKYl8hdhJz9rls36HEXDFV3fR
         sSqAGFyH8DZmzNwXNnBxrx3Pu3T+61qanm2aCpP7pCKa4Np+h9yhtXug9Y/a+j6q21/W
         h/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300123; x=1716904923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPucwLlGIDCoc/kjcAh9Snn7SwWN3nO4JXCoZKLG+xY=;
        b=E1j0mcIf0MW2R//MEIBMFdUGJJ2H5axlR4o6dqY05El90qocOlRnw+RccochbsQkW2
         glAWN//wiE7aGT/dIgXt3t7uxYoIHXSCmI34+Zaq+M4F2EEO5am5n9FoYBkDE6It3zUA
         M63VrPOEaApgNuGQnHzd2V9xk6pWhrfakIGyVZm2Im9C9ES90e5bN6kG74v636KzTv7c
         YVONFFZUJRwC7lkllE1T8kE7O2DQt09WF6wdJEfJrITotF/LTiafTIOs3IZTBLeYXlda
         vl31sw6v5tYslq1MdSN6+SQLDVILC5YjScXkZQibqs83Q+wCgaG4HwW4zNalgQMn4lrj
         pp4A==
X-Forwarded-Encrypted: i=1; AJvYcCWWdgguPstoQnu33F9RKtIis7KJiKnPkwpOU0x+MXI/tcxssAZVzDGENpN4jKiaKH+B+ZUPJNvCjuAMYbB7/g1TMtc9DS2qRKrAyFQ=
X-Gm-Message-State: AOJu0YwaVQJ6CNKXhO7+d0D8okjICo5+1am+agGP+hdrA4Q6Itxn074K
	1E6cJb4Aj4qvy5qKFryNhUj4SbSjLLD/A1sBJBCbgbyiX8D68DmM+STXbiTQHbk=
X-Google-Smtp-Source: AGHT+IFJ4zfLKPxtbiw4xxELdC1BmK4mShvQZFdNEbqdSzHTDVr/Il5ZklL0ZZ2+RuKmdn6Vxt1h4g==
X-Received: by 2002:a17:906:c45:b0:a5a:423:a69e with SMTP id a640c23a62f3a-a5a2d53ae73mr2762700766b.15.1716300123418;
        Tue, 21 May 2024 07:02:03 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d29fsm1604366166b.25.2024.05.21.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:02:03 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Rust block device driver API and null block driver
Date: Tue, 21 May 2024 16:03:19 +0200
Message-ID: <20240521140323.2960069-1-nmi@metaspace.dk>
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

Kernel robot found a few issues with the first iteration of this patch [1]. I
also rebased the patch on the Rust PR for 6.10 [2], because we have some changes
to allocation going in, and this patch needs updates for those changes.

This is a resend to correct those issues.

Changes from v1:

- Fix paths in doc comments so they are correct and `rustdoc` does not complain.
- Fix a typo regarding stabilization of `const_refs_to_static`.
- Properly gate `to_blk_status` behind `CONFIG_BLOCK`.
- Update doc comment, a sector is usually 4096 bytes, not 512.
- Update doc comment, use consistent unit names.
- Rebase on `rust-6.10`.

I did not change the interface to use bytes rather than sectors, even though I
like the idea. I think it is preferable to have some similarity to the C API for
now.

Best regards,
Andreas Hindborg

Link: https://lore.kernel.org/all/20240512183950.1982353-1-nmi@metaspace.dk/ [1]
Link: https://lore.kernel.org/all/20240512202215.67763-1-ojeda@kernel.org/ [2]

Andreas Hindborg (3):
  rust: block: introduce `kernel::block::mq` module
  rust: block: add rnull, Rust null_blk implementation
  MAINTAINERS: add entry for Rust block device driver API

 MAINTAINERS                        |  14 ++
 drivers/block/Kconfig              |   9 ++
 drivers/block/Makefile             |   3 +
 drivers/block/rnull.rs             |  86 ++++++++++
 rust/bindings/bindings_helper.h    |   2 +
 rust/helpers.c                     |  16 ++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            |  99 ++++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 206 ++++++++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 245 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  55 +++++++
 rust/kernel/block/mq/request.rs    | 227 ++++++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    |  93 +++++++++++
 rust/kernel/error.rs               |   6 +
 rust/kernel/lib.rs                 |   2 +
 15 files changed, 1068 insertions(+)
 create mode 100644 drivers/block/rnull.rs
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs


base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
-- 
2.44.0

