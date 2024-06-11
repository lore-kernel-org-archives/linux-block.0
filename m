Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AB178CF1
	for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106371; cv=none; b=LBg7XCCauG6gty0DRlqXPR/kYak5rc0273Nqf9+2ASnOLT7C7UwsIYwq7Ig5RUXLBOD112H/buloCfI4cskMIGdbTjyd7xJVYk4gfJSbynKZAZV+bcFB5mQmhtnWrMazAV3BW7R7+RiihvyQuKh8MKJ3hTxfGSoPwnGOulWk2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106371; c=relaxed/simple;
	bh=bK4/439j4TfBOi8g7RF5Fmz+iveJlR+zA59oU+ZXsYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk66GnEfvA5e+7M8HrdeS+TxerOK2i0kjeGC7Y1nxqlxdggKY/lhpvjEm0tBlHfeBlbMfngPyOBLG786fts7he6ZBZb0RxyCXBfS8WqqDlm6jrn/B6ncEVRcvG6NrqdaubHTUhxJsZDHItM+pO+mouzhLvyO0fMTEts+PJ5cZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=0FADte0z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="0FADte0z"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so1175904a12.0
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1718106368; x=1718711168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsoSiVsjlrkn7Ag7xXOC8suV2zdKwvov8w1ygIJS+qw=;
        b=0FADte0z0wij14miBD5yNb02YfJZ/nZSMdC/E/BtglXlyeOv7HcPe2jRjrT+PSv+pS
         AVQRTOgBtRYd+Hi7wk+w5E2y03FJo3ShdHRbQI9TyffO9hcQgcb9QoeoOx55KO0c6cLC
         QkXpiwjYjedFUpPMBo8UzXsugoLyEgvYLRJCwhwNFUqrVRdlzi1jOHWaszzIP7OsoS+P
         klSDpyvtlvgyUM34n0Y1hXFsjakEBYs5PJIQk9uqX9OZShLhZjraJDYshijokbtVffPT
         5o5vv1WmkJO659Hya8TJjbm82JMPLvZWMNrdtCbr6PvAw6Swj9pj+y6zhzkFkyOYaPSi
         LUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106368; x=1718711168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsoSiVsjlrkn7Ag7xXOC8suV2zdKwvov8w1ygIJS+qw=;
        b=jCw5o66G1gReGQI9lCd6itVMf+CNGCK5GW33FHnHFJ4x5A6uX55Vri20tKJ8204FjA
         UJDJKI1iEgyhc07QznkB/FTA1T3h018yUC7rqio2UBL+bPN0R4Ri0PYhkt8RUxpVZvnb
         y4chHzff8OLcqRGpT0QsH+XtifoRdZ8jh4EliGxX+XoEaLR/PxTos4pa10AADQscXlS1
         s5nKxhyaS4JqHVpnzGnV27NSyKmuRAQZuOeIQ818IY6rBt12HEwV1+ozMm4Wi4tnI7IU
         epxqNLSh8Y9ZgzwlXJ57P6dctAVribvP4Z/c76T627qr0S2pheUGTCtjL8pyCsy7At/d
         MAGA==
X-Forwarded-Encrypted: i=1; AJvYcCXWZaTMMBDiR/IsFhSy7RolwTLqzA3BYV+3GZ0omff1k1IGS2LGDjVFnIS+wFis9iutHiHwXkiCtiXbG4neaVOqo0n5exYm3R0gacE=
X-Gm-Message-State: AOJu0YyFDO1Hliirm0jPiCJFsQIPX+ay3GsQ3jBU30cmCmfrj+sv1aWX
	ztBb0JnsuIdpfjHQNFzzTLlxZKswIgea6NfpV51rZmFmdkQE4aZEzAkm21Ivhv8=
X-Google-Smtp-Source: AGHT+IGyrv2Ggcpbj8JV4m4OsVp9QMOP1y/FVMZcbZ64kv3+ofD9N/VGItUMPm75/09H8qH8acGlmA==
X-Received: by 2002:a50:a45e:0:b0:57c:6f66:44d8 with SMTP id 4fb4d7f45d1cf-57c6f664f1bmr4279928a12.26.1718106367384;
        Tue, 11 Jun 2024 04:46:07 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae202335sm9246261a12.60.2024.06.11.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:46:07 -0700 (PDT)
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
Subject: [PATCH v6 3/3] MAINTAINERS: add entry for Rust block device driver API
Date: Tue, 11 Jun 2024 13:45:51 +0200
Message-ID: <20240611114551.228679-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611114551.228679-1-nmi@metaspace.dk>
References: <20240611114551.228679-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=a.hindborg@samsung.com;
 h=from:subject; bh=15arBzSuu6MUa8O4AgYYzv8/t5wEgyg6VebMq+lzm/E=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR1pvTnJ5ZlorSHlOeSthMTRaSGplQmtCczVwCklpc1RTTmFvTExiWE9CRnh0
 alpvcm9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbWFEYTh
 BQW9KRU9HNEdqNTVLR04zT3RFUC8zRG1yZHpEbCtmZDc1QysxMWFVM0NRQ01INWdWSlFReXVvOQ
 o0MlhKOVNsbC9XWDdSQUFIR0FpSFBNMyt4WFp4TlJTQk12YjlsYXdQQm1rclMrOUlNWTFNL1ZYS
 UkwQjhDd0ZNCklqNVRJK1BqWll2YzJrWUQ4MFB4RWdFY3VBaUlmaURaakRKaTIzcWUxUy93Vk5p
 ZWlGQW9IWjcwT21DUWY2aCsKZjhBdmlUeGJuWFhjVG84eDJOenpGMjhLVTR0V01DRGV4aXFZVW1
 VbC8zRDRzN3hUZEwyTmNWMGV0cXJXMnpuYQpaRXlQNHFkcWdKdTB6VkpoOXNBQU0zL0xKbmpQY0
 NKRXYvalhDYk1tZkxhNVF5SzRUMW11aGpTSGFKcFNLbnN1CktCTUFXRXczL0Mxdkc0dld1Q0krQ
 k05STliRXZlaVhYcmd6cWczV2FFdnZJMlJxcjYyYVN1bEJVcUkzalBRc2gKdUd6QktnUWNXTEcz
 WHNkN3RPQUVQbXI1MWZJUzBsM3hlNDZDQVVKQVV2UXJMdnlycDlLNHE5ejNDRFFmU2dYTgpOZHU
 3akhYdjdBR0FoYzFhY0FBWHhaYjNremVYU21iL1pJVTB0NEZtYW1PWkpKd3pyRDhEZHlhMGFFZG
 FIT0dQCjlSYUNXNDRWbUdzSkFjRVNURXRkRElOQzhPS0Y0bkdxdzdZeHZxdkRIQ1oxMnFsc2F1V
 1IzQkdUdlpET3ZDejIKMjVDSDE4RUEwYURjTmVlVjdESFJPenF2WktDRGhYMG80OTJXM1NFVnRG
 SWUzQmRxdlQ4RGVrWkNuNERnQStDTwpnano5bDIvTmpnUS9BSWUyYU1DbUNGRTM5SFlTd0ovWkl
 xblNxVXVEQVlvYWRubE96SktlTFI0dWlyR3J0Y2hSCk81TGxNV2IvYWhJaXpRPT0KPVJkK2IKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@samsung.com; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add an entry for the Rust block device driver abstractions.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..aa1321fdc300 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3781,6 +3781,20 @@ F:	include/linux/blk*
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
2.45.2

