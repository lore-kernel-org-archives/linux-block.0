Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0313CAA4
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442114; cv=none; b=ln79lmJ/cvqQ+SJeJlk34jQ2V3KGDnSNT7brCCWXFhMyUXNObgE5hf9X666q9oWX82p+fU/Xxd4u9J4xnAeTZgOIX00RgbsINM9++BX1R3DYK/3pvIPoo1/JTHd0hEtKxyGMJJKbZ95Q9RCL0i/ZyW2yOjMQtSDFYDUGEGsUvcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442114; c=relaxed/simple;
	bh=juRogTLPO2qs3UM+cO6uXQ3Ufimi9V6rXzS1gdbXpLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXjTdspxf21n+HZbCcA8z6t+pfP3nXjYaDLg438EAR5QECy9P33WPhxTPGVmdZd//Vlh0ndz4DhJhD3HQ+cvkiKixTJjCLdyqJQu6y9OmRbI5LBjOjKMUDVJeh+Py81AZ07e5FQWGnRnNjyqWEyXX39vwMoUMaUip4XZyC4qP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=u9IrdIrV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="u9IrdIrV"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so2711738a12.0
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2024 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717442111; x=1718046911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=u9IrdIrV7smepPLqH8l303XnRV9EvSo3sNSt+9cNOVkSAnLD8IJxfz05mf1Juui6ju
         PAF2fNkuz4CXndWza9BpIwUINbMfANbsqRWidBgD6XTYbyJuAE4745WKgeVKa+QYiEOB
         4IxcAS2Tpq/7tAT/omX9uo4O2zh9CZaYRodXPJEVF+CeMH2jL1O8XZO0RGWdkPXkZIqt
         T6YaA098KHEgzR22bxw4o8jd7ibP8DByAPajhjyKN9XrZ8pHP9N5v+I9cNxg/Md5rqbN
         WieuaInmqpdRU9U16lGEImeAatGc5Ao0+sAmoswLbKzld61My3BN/rLYdC2GMhzusihV
         pAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442111; x=1718046911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=q8WL/RClGYkDdsu5/hzN2x0tmYCK8skLs2wlFVk/Vz+ptAgGoeZNRJbTNsJH1NHDEz
         c9e0Pq57G07FopPQS6jOmxkLpX+QmErCEt2sEth43lQnxQ8oQybPAXt2i+Fq29BoIo7p
         Y3FTdyl1VbkDSqBNjQ+5tkHWux/c484wU3ry3wweBO52+uxu2C3hqduPJ2GZMuXhkhlf
         jO517cDIgaw4UIpW1Xe/4mUYXNnoKO5xPjlkfZo1PPjmIFIHSHCTgJ2YXhmlvQgNCkuO
         QQGJC5iFdt8hNfyCNDEphEHjyrtUaIxhnvx+cYhSxq2YK7eHjXsBjSF3FwSs1OvdnXHh
         Qg3A==
X-Forwarded-Encrypted: i=1; AJvYcCXkpM/yz0vgqOch6aD1psmDMNVsSBxjqkUSNBCPy+tWZW7GW/ZXFjPDV9c1STcJG/UVRuABqU2LcA0zmLDDgbO+83EK8vOtRJXfQ20=
X-Gm-Message-State: AOJu0Yza1+/toT+48r9qIJ4NdvOCRS4tyZ1FUagMhBgMv/XjWbyV7mV8
	f+TBSJfKVPjqy+wh8UB7qxCmAUqh+4lHsOo3tGXS9m7xUyB2GxRMUX4EMrSfEEM=
X-Google-Smtp-Source: AGHT+IEIe0DVsYmJPScMiomtpDfWdZZhVOCyF8cqTfzaZhruhdjXi0NCVul3W26F1naNI0AuycktXw==
X-Received: by 2002:a50:d7dc:0:b0:57a:2158:bbef with SMTP id 4fb4d7f45d1cf-57a3635558cmr6349251a12.8.1717442111367;
        Mon, 03 Jun 2024 12:15:11 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b9943asm5809571a12.14.2024.06.03.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:15:11 -0700 (PDT)
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
Subject: [PATCH v5 3/3] MAINTAINERS: add entry for Rust block device driver API
Date: Mon,  3 Jun 2024 21:14:55 +0200
Message-ID: <20240603191455.968301-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603191455.968301-1-nmi@metaspace.dk>
References: <20240603191455.968301-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add an entry for the Rust block device driver abstractions.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..698515b0b0b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3782,6 +3782,20 @@ F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
+BLOCK LAYER DEVICE DRIVER API [RUST]
+M:	Andreas Hindborg <a.hindborg@samsung.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
+L:	linux-block@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+C:	https://rust-for-linux.zulipchat.com/#narrow/stream/Block
+T:	git https://github.com/Rust-for-Linux/linux.git rust-block-next
+F:	drivers/block/rnull.rs
+F:	rust/kernel/block.rs
+F:	rust/kernel/block/
+
 BLOCK2MTD DRIVER
 M:	Joern Engel <joern@lazybastard.org>
 L:	linux-mtd@lists.infradead.org
-- 
2.45.1

