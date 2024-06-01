Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7061B812
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717229929; cv=none; b=HDlly6EnBIm2uvtntPwZwn8bzLV0X0SI2rYjIPDgWOnk0pQyv2alBol2z0UCyvgf6D2tfvsVlmiUJQGMdDI66Qr/H04KX6QFMePb+yV2AiH5K0DNjXT2YuUU0wWNqFV/dfau2+1RPpF0igkVv8sykCnldc04azdIWoSnj10sHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717229929; c=relaxed/simple;
	bh=juRogTLPO2qs3UM+cO6uXQ3Ufimi9V6rXzS1gdbXpLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ0G65rhDHYLBMZUFX2ZGw5b1+39i3dbRKQNWzquzd42Ttr4eeyBwuCRR6acO9nvYKRBnFxSyzqx1OY6aMOsjtRuNWH/WVTU7YdFQTLksMpnli+/pGCaZvdx5ynORPgpjl1KT/hogrKHkEYNie3DaxDtuK3q2kPDpTikbJGzhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=UXAeb+nT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="UXAeb+nT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35dcd5377c4so1980312f8f.2
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717229924; x=1717834724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=UXAeb+nTAXYVlf/wWSR6UtWpUp1HdEJnm9CFFgcSUfUzYH/0sIUktygmcLEIO7VYQQ
         tnWgHESeAQJ4H+XORw+Z6OLTCtawqYU+C2otIFGAjd8b3LFBJiXfCM32OivPBTNuZTqB
         Y3XPXrqU7Ex+/cUXVu808VmwS/rc+NSVEnUewag1q8CLrK8BWR2pRh7imhL927WjTCO0
         VzHUgQmxU9jS7Y7A/C9FUL7em4eZBRRmDgSPFcnpSp8+jZMpzt6h6VDz6aee7SDSr87Q
         Z9u0slFVcXK6yk6B/mkmQDU6UJhqS3WRqRUL+H4PdnclxD4aJT8Ew5uRxaA/zLA/dhjH
         4H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717229924; x=1717834724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=uUQQ12zJDjIO0pwx7pA5ufQhLQqfgssRf/7w4QkF+6ztUcbqg+EJVBhhsLFayFfVE6
         9OjCwkoI0/pF8hxNmRzc6/xa58aaeyVgMNVWjXWMi9ffq2x11bNf6FxtsE6l0m+0Fz1Q
         JLxxhQGsreTwRGbsyf/9FLxvukuPMv2DSINF80K+cjuYR0sa8z/vH6LCXt5RyXs+02g9
         KSY+BIx6ExzColy+F4wW3ElqVS/lD8212y8GGDbnsQX8fuy6OxAWWqHhgVpOoiaDnmZH
         VL+fBBfe3Lpq/mccoO2RpUFdYgjxWKAnvVpgz2BNZbAJ4geQnQC/OEFqaI28qVKis2mG
         qp4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBo+l+09Ooq6Nyz1yYRKpGdVwWC6lLG6h/2s++uNHbSmLGqwbHD28OWobkvrei/MYhkHTXTuSna9Tta/5sSOiqI43Ta80nr1DkOcs=
X-Gm-Message-State: AOJu0YyuMpY/+nbuo1hvCgz7nhx1UzwERYfTjROWyfHEd8XNc19SVRBg
	YqN/gdAkyfItsx6Q/JIwQ61YRNGc+BGbPd+CDjt9MnbLu5cxgyzzqOT6ywPsCTg=
X-Google-Smtp-Source: AGHT+IHUHqF5zw5T0LAYRAz4EodAka68lyRIDO+dvLKGP6ottBNPhvhdtLKKamX3vjh65SPUKbcu8g==
X-Received: by 2002:adf:cc82:0:b0:354:fa0d:1424 with SMTP id ffacd0b85a97d-35e0f2580fcmr2520631f8f.14.1717229924498;
        Sat, 01 Jun 2024 01:18:44 -0700 (PDT)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm3547736f8f.23.2024.06.01.01.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:18:44 -0700 (PDT)
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
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for Rust block device driver API
Date: Sat,  1 Jun 2024 10:18:06 +0200
Message-ID: <20240601081806.531954-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601081806.531954-1-nmi@metaspace.dk>
References: <20240601081806.531954-1-nmi@metaspace.dk>
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

