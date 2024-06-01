Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0C1514F1
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249236; cv=none; b=pV+z1o/lfZSZIYEZola5zMYfdKLrta8Eg7doRmiiZ4g9CT8xBSEJZqHF9cDZS79hB7Gv1IfbqRL0Kt8Wzq2cvWVn4JpRTZOuvYszXwRA9mhAOBj8AXQHitqJvQCqKseYuNd99U0lJHypnPMNCeyjXvgup1n9e/OVzVBmhzQbkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249236; c=relaxed/simple;
	bh=juRogTLPO2qs3UM+cO6uXQ3Ufimi9V6rXzS1gdbXpLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBfHwJxVXIPr34tcrMyjgbRYhIEu6WwStRjottljPK7OCaFNPRf+G23W+GUCuIdzWyj1llqNASNatSRlm81T9G/u6himcJRdv2zMgRLZd+l18eU67NDQ1SM+9IhSed52o+dOO+pcrQ+FWyePNxGjLjRUKd/LqNKUpkfmopOOOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=3L2gyQWx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="3L2gyQWx"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b8254338dso3140786e87.2
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717249232; x=1717854032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=3L2gyQWx9mzBmilZCnN72PvodhO6oit7sB2Q0mS0pUqAFrNyXgZeg7FEUvgwdwSinZ
         L+81TX1cfUZQ8tPntHnqRH2VOeH2SoLW+ChUmlCkh+iUb+ti7nIW3yK2+I1u7PhlZuaa
         rk7wZLbS1yJzKaEXIAG5ME/fzGep4tUd7JQIBO2RqQvJrztKm5h8AjXRz9u5p4aBksrv
         vuuExU7IdnDM0guesf0WjmlxW2KHqwu45xXlEwbJwTy+LAXn7weNe06qxMM8lAT+9sZ3
         2etzY/AWw37Zv1bhcTnnfeFhuiKhyGtuXRLk2MGFqOF16NTYpM5PyBmJvzTyJZC1yscu
         MudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717249232; x=1717854032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=kGMhKZNJ13kY7/dxiDEVAhEskQlhfS73z/yciGJ09dgCBIpOdMggjMbxYnrM6EhIl3
         J5ozJCQV6lThay1ohMMM6zDioWp3PpyJv9/0rZU/FqXT4R+qsJic/FvAsAuhH68CJRfs
         dXnBIXY5LMuI3/NbM+rXbSfJm0lWVeI3iarpUEYTk6xnoWTCYTIr1TsKUYr3SJulif4I
         4gtIzRNKUlqxKoLO5JT8SCOo/lSTtdHWxN++BXOuQG6mQ4+43PCYJfQ93KEJ/HoMq09J
         2aUJyPUJRRZkXKHql7NPqQOsiF4rBv8gmCl4f5jGQzGrea6DigboV7jy9fReLgTCGB0D
         haXA==
X-Forwarded-Encrypted: i=1; AJvYcCW7H3yxIISJIKUUOff3C5SQv4Evmu48SDfUoYaeJ0C7geZaiIBWD3GAg6yS425REwUZR2I4OEsJtmIx3UBH5YAhV/Oxd3SndV2Zr/A=
X-Gm-Message-State: AOJu0Ywj06P/opjcTGyonrU2V+9g1yhDn4L6dYbe7z0jKlvrei1SEBC5
	qHrdroL1jJLFlFHPRqYEmZdsYV6BA1VnO9F69OB2KrdUJmcYTLLKHa+byNojrfQ=
X-Google-Smtp-Source: AGHT+IGrq3PBkLFNZCEIOfb99HJhQdA8UmV7flzStmSdZ6PDy4PhuONljOCGU66Onvq9WUuNAfmmow==
X-Received: by 2002:a05:6512:b9d:b0:52b:8255:71d4 with SMTP id 2adb3069b0e04-52b8956093emr4368044e87.3.1717249232498;
        Sat, 01 Jun 2024 06:40:32 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a8ece075sm92371866b.143.2024.06.01.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:40:32 -0700 (PDT)
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
Subject: [PATCH v4 3/3] MAINTAINERS: add entry for Rust block device driver API
Date: Sat,  1 Jun 2024 15:40:05 +0200
Message-ID: <20240601134005.621714-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601134005.621714-1-nmi@metaspace.dk>
References: <20240601134005.621714-1-nmi@metaspace.dk>
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

