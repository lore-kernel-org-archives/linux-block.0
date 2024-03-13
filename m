Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6941232
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327971; cv=none; b=cq2zwNbrTTyaZIdu3RbNCHoErE/8tcPIwjuXH8SV2GyRLjVwHVWWu7siKg1FbWyyOzuhERYn6ZTRawE40YjP+lY5B6wdGpCB1FimNJj4h0XNhs67AIMkakCPbR+e9l76URd/OZ1YahxM2xbB515YMfOrE0eugyU14g4aw3/JeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327971; c=relaxed/simple;
	bh=poKb8VxBrFQtoK1H4oQ1UgXa3OWgewJdw+oLXHq0Dns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjFe2n4StlEAVqw8Eby4HSdT8yskZmB5lrwc+i5njJ8P4yMOX7/QiALl89ZWhTnSAXTiENxQm3g2dtqOlh0KBRyRWDM3zlhy7qFVBhbSpgRtPK2J7MV8UZK66Z+oaQAbpG62WB0A4zkmmlNJA6AlSV3G5moqCpz7RGd0zJfwsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=TPwjM3jM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="TPwjM3jM"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4661ed51c8so42776966b.3
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710327968; x=1710932768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJhpLaBye+vDxABkGVxNk0R4/Je1BHTggYd+F9CS0JE=;
        b=TPwjM3jMqw80NkaKsRfTJcf8kAhvMWN4NrwL/mKZKZBzeEAgNwWUAEH2UFzY1ZyFXZ
         95PP6VA5FBk8NGCFWrMiLp16CF2UmGsZD1jK+R+JLTbxOfIR2Vwfe5F1dH3Dqo+HhMHn
         DD1fvIA98FBH17Zqga8Axn7fuwA1xpTqo8pc2cBRDFDPbqTgw0Zyzl6PLQw/oma9M/pK
         oR1guAO0pF+al7Z7EObuYOMOYhWuFljZuwULxSJEOKgCC+dLdD//C6Vt0PZnoFoOg4W9
         1IcWM42+GtYqxJVpl+imHtn7MK/0ORqFThIS00vHmONRFldclB2xPughk+iFTdAxBwvF
         xgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327968; x=1710932768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJhpLaBye+vDxABkGVxNk0R4/Je1BHTggYd+F9CS0JE=;
        b=UyfJ4bWT5hfD9ZjPSuJWT3I3NRYlZUJfm+Wyrc8pmNyZzepkMgqQWdJIjGLkGMkdcu
         +6TmoFsRHWiQB10+FyeIb17qspqjcRWvCud9aXw72GO5GOx55610FFrtpfIa8glOPY0N
         fK0MAwCvHUJ89dC4xFauchGnJWAWjN2qrhEmSvYlfDbQEm3Bqlubu1k78TZSEB8lQwP/
         fAHrZLsA7cePd2fRI0dJEHZvvW4ECR/AcQ11uno9VnUTKYf8vaDyeyw+1izAKoyEL1FW
         iOmmNpiFueM4c11e+dmttpKbWeXwvs6WjYie/6/lww/t8Jfvygh60VLKOxofsA3XT3qI
         +oVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7HvuNqnD0ZcuoljWbHEHamD9MyYip8+NkizaPY2CJ5O2iFQB1/BgSMWNSS629BITU28nuNXzExVsmG/vMLCeKZ35kza96QjPM9OA=
X-Gm-Message-State: AOJu0YwllrZfmz7vYXfh6LrRin5ZX3y+I1BiB65dCIrAAR9ttGEgcP6M
	S7jbdcePC4OeLonyT3WPdaNCa6ogcDS7aee/o6R12zSJlf+rWelq5Fqs8fDW20M=
X-Google-Smtp-Source: AGHT+IH2kW+8cJvn0ZC8fmOzX8cVltqW6h1KgZezqvXcb0+MfBFkrVtJmrcgIoAGxQxFO9AZ2LURKQ==
X-Received: by 2002:a17:907:8a85:b0:a46:5dc4:dab9 with SMTP id sf5-20020a1709078a8500b00a465dc4dab9mr951325ejc.38.1710327968092;
        Wed, 13 Mar 2024 04:06:08 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id bf2-20020a170907098200b00a461e206c00sm3397412ejc.20.2024.03.13.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:06:06 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
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
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [RFC PATCH 5/5] MAINTAINERS: add entry for Rust block device driver API
Date: Wed, 13 Mar 2024 12:05:12 +0100
Message-ID: <20240313110515.70088-6-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110515.70088-1-nmi@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aabf1c15bb3..031198967782 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3623,6 +3623,20 @@ F:	include/linux/blk*
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
2.44.0

