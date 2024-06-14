Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A941C75
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718409277; cv=none; b=PUFe1hyGJziyKY/JrdBQ/GAqTchK4mN6o+dbJL2L83xF5wA/8GbKSqko9j2z5baOO3NDrU2NFPRB4YihKXa3yYazqBXpGw5eoDDFGp+ANkFQOPtVWgzfx6KOScV1eHnv/Ydz4FpFXh7JwwXdacfLL3rknyVAlSU86sUROAKvF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718409277; c=relaxed/simple;
	bh=eq2bnC+Kto6G+yAEZZDc+NgUyz39TjriuInfX1pG6wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=can8Tk5+0gqyPtwkoX0wOVLUJebYuYgv3WMKzdJ/d0d6KFnaZ/XqcU6Sysy/FD+xA9Y0pi3RENLtMNDYAOBWa79jmQ0bwfjfrG8e1liPwuEQjHWh7nvl8muD2a74lySWJ8Aa+B+7qrsOWEXyIymQxrpubsgTVhHMkJXwgP4hueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=TTf0akaj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="TTf0akaj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cad4475e0so5210613a12.1
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1718409271; x=1719014071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZu/IIRvhXvFotOTSriopPgpYSumlLx6Rgvx2BrjDjs=;
        b=TTf0akaj+ggH17msuZDC/lPXdfO5ff+6LgD3ftwYbDQJSD8rATACdeTCVMpA/BMhSH
         zovPgXxbyPCeL3ObLr5EdWzosfxjNvBTRDC6lBLTae9tOvLg4Ye7SF76xDJV0js4z73T
         m1rDl7E3cSrCM8kC+iWWJXsUilUO8qKIEhEZoDKWejIyh225VaVH24stz04MQXPYxKOE
         GEUqrCXVaFc3ErBxtS1wkEkPDQKttoWQpvtPV0fm/+mv8EqcxpDJDJvb/uWlDLaYKKJo
         fiVs1tefVqBpCcu0GKWKtr9QaxAxcgdxbAnMxlwpcLS7WDP/zh+wZERANcTmmeowXUM1
         YhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718409271; x=1719014071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZu/IIRvhXvFotOTSriopPgpYSumlLx6Rgvx2BrjDjs=;
        b=jbwuH6KJOGe/pWvjSfcdN1N6HfJTxFUKRD2/EogWnAEuZa4mtcvE0pV7DqGAkFhW/5
         yjx6V3qcxn3cpbubuxGD7g7TKurCsvXuRuYMyRPCcUwiC1lpcib9/6fIAN+lENaTcOTP
         x8LXlGKVoZ9QdzhGMMWWeYwJ3dL0dYwsDVTq9WmzvcmSpgW0TSvlxGd/OZocz5/fS924
         mCmIbvcwpsXRKc/c5Ibs4EcXgtMDCHIbEorHnV3z3kFwOn3is02XsOf3V/dXF9eQgcZC
         e4tKyYxpOSUjsn83cY98q1nPAZlzqB2l/ebsELoeHKXvmVPzETZcyBP0EETU6PTCQwQA
         F5hw==
X-Forwarded-Encrypted: i=1; AJvYcCV6NCZNYiTDhm9O+3dzlqRevnvjRYec2Hir/Lbm3smsDeIH81vDR4k1/UlnyLH7sHSPSCZuEgWxy3OcnKXanQ3Gpmsez03ReWY0g+8=
X-Gm-Message-State: AOJu0YyEqHaLc2j82anLCxKYMzp0owxNdz68dnLHGVUJh2Rmyl9EQWwh
	cnM9MM5Sx0l5DLAQBd3TEKHNTY+QtSHZZzYhYmL7wn4A++aDdZm5j3zdTExYd2Q=
X-Google-Smtp-Source: AGHT+IEt2RsfFZLBXTpCse+hxHi+1xaGk3nQdfa3QlVg6gP0B4pud43hAedq+iwJK+I55tLUr9jwMQ==
X-Received: by 2002:a17:906:6a14:b0:a6e:7720:7e39 with SMTP id a640c23a62f3a-a6f523ec10bmr547713166b.8.1718409271209;
        Fri, 14 Jun 2024 16:54:31 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed0d89sm237215666b.134.2024.06.14.16.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 16:54:30 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	"linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org,
	Andreas Hindborg <nmi@metaspace.dk>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] rust: block: do not use removed queue limit API
Date: Sat, 15 Jun 2024 01:53:50 +0200
Message-ID: <20240614235350.621121-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473; i=a.hindborg@samsung.com;
 h=from:subject; bh=odo+QThTIhIcr8sNk1XDIIxIe423Cu3o1cIcLJ2Bws8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR1pzMTNURVl2NEdDZDhBKzh6dE5GOW9tVjJtCmF0cy9mTEg5bHNUbUJ5Y1V3
 aUt4bFlrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbWJOZDB
 BQW9KRU9HNEdqNTVLR04zYXowUUFMMFNLVjY0akVCZjBnVjRYaUVqV21uTjB4akRGelhyRGxNNw
 pQNHl1dnJkeUdvMENoR1l4blFhTWs4STR6RFM5b1pZM3NtS3ROK2hMenNTOW5McWd6SW5JRU9Xd
 1NWK1paditFClhJaTdtSlIvb294YXgwTWxTQlQydDlRcitVMzV0L3hTTWNwbllDeDJJTzd3UVVI
 TUU3aFRmc1RBbkUxbmZySlUKakJ2ajNTVVZndTJPN2hQK3dVUXFzTXNxWFNxYk9TWXpEekY3VUc
 1eU00NE5wcTR2TVV4SlRqY1ppU0xEQ1h0TgptT2pEK3N1TnB6WGdQMWR2YTBHR3BBOHlHVUY0ZD
 d0U29rMWQrQXIrSFpvVFFDTFh1UUtwQXBMTVB0YkRoME5RCkh2cDFGb0UreWhYRWMraG5jTWtJR
 nE4dXFON3dwWXh0cHVDc1pCQVIwaWorb2s4WlJDdU42RU42V3pSUTBBNUkKSENWSFZTbWw3YnRL
 NW9tK21jZC9yTE5mcGJxeW50YmZQWUJCM05lWmx2cTFRd29hWlRCblgxT3ZJNWRuUklnYwptWEF
 1aEorZHdKRXJuMSs4QllIUTRzNURYKzBCeUhBWVExN2FGZUR1TXAvWjhRWjQvQmw4SFF0SG1qNG
 83MDMyClRiRDU0dXd6MzVNQVRUY0RNUkhpcVdwcDZsS0FxT1dFckRYWEhaeCtxRVd5S3FQVHZYe
 ktPbFB4WWtRdzdxTlUKUExxZHNWQVhlemdRMGRKb1NZU2o0czF4THpSWVJxKzZHUWhKbHA4d0cr
 c3ZxaTlyNXNwUFF2VGhyeWlmWXhkNApncU5OaUhjcDN5QzVGY3JhY0JnNDZyVDc2VFNqcDF5MGR
 iemRLWDJIUUUzeGo4YmwvZnFIajd2MDdPOFlmT0NNCnpaNXdYSFVCSnlnamx3PT0KPW0za08KLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@samsung.com; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

The Rust block layer API was using the old queue limit API, which was just
removed. Use the new API instead.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/block/mq/gen_disk.rs | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 3b9edb96c8ff..e06044b549e0 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -95,11 +95,17 @@ pub fn build<T: Operations>(
     ) -> Result<GenDisk<T>> {
         let lock_class_key = crate::sync::LockClassKey::new();
 
+        // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
+        let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
+
+        lim.logical_block_size = self.logical_block_size;
+        lim.physical_block_size = self.physical_block_size;
+
         // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
         let gendisk = from_err_ptr(unsafe {
             bindings::__blk_mq_alloc_disk(
                 tagset.raw_tag_set(),
-                core::ptr::null_mut(), // TODO: We can pass queue limits right here
+                &mut lim,
                 core::ptr::null_mut(),
                 lock_class_key.as_ptr(),
             )
@@ -141,18 +147,6 @@ pub fn build<T: Operations>(
         raw_writer.write_fmt(name)?;
         raw_writer.write_char('\0')?;
 
-        // SAFETY: `gendisk` points to a valid and initialized instance of
-        // `struct gendisk`. We have exclusive access, so we cannot race.
-        unsafe {
-            bindings::blk_queue_logical_block_size((*gendisk).queue, self.logical_block_size)
-        };
-
-        // SAFETY: `gendisk` points to a valid and initialized instance of
-        // `struct gendisk`. We have exclusive access, so we cannot race.
-        unsafe {
-            bindings::blk_queue_physical_block_size((*gendisk).queue, self.physical_block_size)
-        };
-
         // SAFETY: `gendisk` points to a valid and initialized instance of
         // `struct gendisk`. `set_capacity` takes a lock to synchronize this
         // operation, so we will not race.

base-commit: 813025d515f5a4c232504487f5b8b2091ab43dcc
-- 
2.45.2

