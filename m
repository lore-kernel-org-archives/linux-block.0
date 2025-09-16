Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD72F3C35
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066650; cv=none; b=SUxZH4caTsWB4hrtk+BPyNaTj0sMDjq+YFMhHs19meoAFgdQd8jLg3SFErK6+9yaW3RcmeDevIRpD/1IzJwhXfGXj7kXFURJL4q4SHBgbFep/Di+zKee4stFHZpIErwEfiHYX5ew30kf/+5pmirGJfdnkdULUDgBVWTPpuZVZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066650; c=relaxed/simple;
	bh=7Q1Dt6cW/jz0KBUiqHat0uPVKLWzVn4GevYUHc782N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB/K5fck6gF/uRHcUP+8ysH3n5z3AG2kpBRannxAMAAAgPQsxv3mI52nh+HYcxavKH7OJf8QDmKtw507/VmKhkFZq0IaYMRRRdJkDqcghEs6w7tjW8nWmN1NslowVUV92ZykHjnBlQI8vylCP0cpl/I1K9O1cNRLaWXBJrovcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4nZs65K; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4nZs65K"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b54abd46747so4403042a12.0
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066648; x=1758671448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+NMp3ltxnO5CFeWsOjiSsF9PGJU04eVtZWsdkv4qsE=;
        b=H4nZs65KqSJcFohG7N353NtUcZHPHfIlSGaqN2/DuAEiBoqASPHbI7sgKrI2N0veOO
         BwMTxpOmkWzQf9DogSm6TyVT1IZsw5RAA3YrKQstaInrfY3vR/sPTJqNVZ3eGoJ0hGw6
         D8jBcBoIBWJUUGcdP7GhXIW3/TqBE3lpKSCAhhwkunh+C6dBO1wNgtJGQtfNK1VEsm2+
         s3hkj1Pca3KyjBY6geKyuj4h58jQoUvwDLc2ceGpof3MIFVoFGigYi7pUSxv5S0ndD5b
         BG7Ff2bffhg/F7qc/PRPWHgVhUii4aQTgnVtTbA8vC8O1dPww2aYh1VK9l+6skNS0o0I
         Eimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066648; x=1758671448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+NMp3ltxnO5CFeWsOjiSsF9PGJU04eVtZWsdkv4qsE=;
        b=lbAdKycywB5bkdRdsctsbA+Ky9FdXViFdrXyMy3Le7U6P5jSlhrvKCCpgfRjpfiY1Y
         7cDNQhBsv1uUaHXl2UfBlJoWmP8ibstqsyDNA9WbAkkMbDUY5+H71qpmU1txplyxnFoe
         NcAuzTo0FeaOIFpCQ4T2717BlOfH8C5nWkymEXp72Ploq8FaC1r1HRRl436NS5reEZ7a
         vyY2N+uxsSSrxA9ypE3DJ3VkoNaTaPxZ5+ZWVKDEoQWX9jzxS3gZB4WWqwj4BimoWhYV
         iESqMF8cpMBy+t7gAZn1NlmNUdmcf6O+UOlXo7q33CR90oifUpmUJX7bbS72xpVGUIme
         hj8g==
X-Forwarded-Encrypted: i=1; AJvYcCWhYe+DIx50wxKox4oktHEk3JhZag/bwTOjQmu7u7qv7aSfBo1QFmVZ1c0HgOCijQLj5GJqmL5wV3xNow==@vger.kernel.org
X-Gm-Message-State: AOJu0YziJ0RyDEGkbvAdxQU2U2Uo9sfqQ+hbIww12fTJAdqNtEp4ykFH
	6L42fwLhQMON72aYIhO9iUxJcdKSazhYFm1GWE4QblDqgL5Ff5jd0H86
X-Gm-Gg: ASbGncvW0K+oB2Mu5Xj76oEzwQ0lzMh714xv4gi/NSyeQ8bE3StiMmJn0LxTM2cxrbz
	OlWACi7VZGXTEI/peeul/etRvk+4IiTGHij3Ez4WqT7JcdFqfizaGd6MHIoYdWv7u7JdhooiMcp
	IT26dBNqffOV8uXza0yeIHZo6TeGkVC2hHEsQsHDg2iWmL4YLaQsNA7ZwWIwVHmhrW1XAf1Q8qr
	ZhHEYMoLu9mbiiogUsI3+sJ+LYhkMG/SxUJ4R6QD4i4/MqA1E53OE9izTuHalmyRY129srGlO7T
	fuDXr4JgaLvlZVUHRI2MRVrUg/lNgmyTQ/tS9i6y8Ejs2y6LqwFBqiLq4cZFHhC0aQAAbX/oasT
	MNSXpNjK133IoTZUl70fJ29A8+7+LnOnItkroENfZKkAfduWDEmQZF0sdVTiB
X-Google-Smtp-Source: AGHT+IEuhryhbicy76K19ArHUIZwQ4Ti+gIdMzC3b4BIvrAOJnQzgpt+MmmwRmfy153QJKNh9L1dvg==
X-Received: by 2002:a17:903:1c3:b0:268:b8a:5a26 with SMTP id d9443c01a7336-26813cf3934mr1111755ad.54.1758066648186;
        Tue, 16 Sep 2025 16:50:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26800f63a11sm5689715ad.84.2025.09.16.16.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:47 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 14/15] fuse: use iomap for readahead
Date: Tue, 16 Sep 2025 16:44:24 -0700
Message-ID: <20250916234425.1274735-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do readahead in fuse using iomap. This gives us granular uptodate
tracking for large folios, which optimizes how much data needs to be
read in. If some portions of the folio are already uptodate (eg through
a prior write), we only need to read in the non-uptodate portions.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 220 ++++++++++++++++++++++++++++---------------------
 1 file changed, 124 insertions(+), 96 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4f27a3b0c20a..db0b1f20fee4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -844,8 +844,65 @@ static const struct iomap_ops fuse_iomap_ops = {
 
 struct fuse_fill_read_data {
 	struct file *file;
+
+	/* Fields below are used if sending the read request asynchronously */
+	struct fuse_conn *fc;
+	struct fuse_io_args *ia;
+	unsigned int nr_bytes;
 };
 
+/* forward declarations */
+static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
+				  unsigned len, struct fuse_args_pages *ap,
+				  unsigned cur_bytes, bool write);
+static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
+				unsigned int count, bool async);
+
+static int fuse_handle_readahead(struct folio *folio,
+				 struct readahead_control *rac,
+				 struct fuse_fill_read_data *data, loff_t pos,
+				 size_t len)
+{
+	struct fuse_io_args *ia = data->ia;
+	size_t off = offset_in_folio(folio, pos);
+	struct fuse_conn *fc = data->fc;
+	struct fuse_args_pages *ap;
+	unsigned int nr_pages;
+
+	if (ia && fuse_folios_need_send(fc, pos, len, &ia->ap, data->nr_bytes,
+					false)) {
+		fuse_send_readpages(ia, data->file, data->nr_bytes,
+				    fc->async_read);
+		data->nr_bytes = 0;
+		data->ia = NULL;
+		ia = NULL;
+	}
+	if (!ia) {
+		if (fc->num_background >= fc->congestion_threshold &&
+		    rac->ra->async_size >= readahead_count(rac))
+			/*
+			 * Congested and only async pages left, so skip the
+			 * rest.
+			 */
+			return -EAGAIN;
+
+		nr_pages = min(fc->max_pages, readahead_count(rac));
+		data->ia = fuse_io_alloc(NULL, nr_pages);
+		if (!data->ia)
+			return -ENOMEM;
+		ia = data->ia;
+	}
+	folio_get(folio);
+	ap = &ia->ap;
+	ap->folios[ap->num_folios] = folio;
+	ap->descs[ap->num_folios].offset = off;
+	ap->descs[ap->num_folios].length = len;
+	data->nr_bytes += len;
+	ap->num_folios++;
+
+	return 0;
+}
+
 static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 					     struct iomap_read_folio_ctx *ctx,
 					     size_t len)
@@ -857,18 +914,40 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 	struct file *file = data->file;
 	int ret;
 
-	/*
-	 *  for non-readahead read requests, do reads synchronously since
-	 *  it's not guaranteed that the server can handle out-of-order reads
-	 */
 	iomap_start_folio_read(folio, len);
-	ret = fuse_do_readfolio(file, folio, off, len);
-	iomap_finish_folio_read(folio, off, len, ret);
+	if (ctx->rac) {
+		ret = fuse_handle_readahead(folio, ctx->rac, data, pos, len);
+		/*
+		 * If fuse_handle_readahead was successful, fuse_readpages_end
+		 * will do the iomap_finish_folio_read, else we need to call it
+		 * here
+		 */
+		if (ret)
+			iomap_finish_folio_read(folio, off, len, ret);
+	} else {
+		/*
+		 *  for non-readahead read requests, do reads synchronously
+		 *  since it's not guaranteed that the server can handle
+		 *  out-of-order reads
+		 */
+		ret = fuse_do_readfolio(file, folio, off, len);
+		iomap_finish_folio_read(folio, off, len, ret);
+	}
 	return ret;
 }
 
+static void fuse_iomap_read_submit(struct iomap_read_folio_ctx *ctx)
+{
+	struct fuse_fill_read_data *data = ctx->read_ctx;
+
+	if (data->ia)
+		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
+				    data->fc->async_read);
+}
+
 static const struct iomap_read_ops fuse_iomap_read_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range_async,
+	.submit_read = fuse_iomap_read_submit,
 };
 
 static int fuse_read_folio(struct file *file, struct folio *folio)
@@ -930,7 +1009,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	for (i = 0; i < ap->num_folios; i++) {
-		folio_end_read(ap->folios[i], !err);
+		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
+					ap->descs[i].length, err);
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
@@ -940,7 +1020,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 }
 
 static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
-				unsigned int count)
+				unsigned int count, bool async)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
@@ -962,7 +1042,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
 	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
-	if (fm->fc->async_read) {
+	if (async) {
 		ia->ff = fuse_file_get(ff);
 		ap->args.end = fuse_readpages_end;
 		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
@@ -979,81 +1059,20 @@ static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	unsigned int max_pages, nr_pages;
-	struct folio *folio = NULL;
+	struct fuse_fill_read_data data = {
+		.file = rac->file,
+		.fc = fc,
+	};
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &fuse_iomap_read_ops,
+		.rac = rac,
+		.read_ctx = &data
+	};
 
 	if (fuse_is_bad(inode))
 		return;
 
-	max_pages = min_t(unsigned int, fc->max_pages,
-			fc->max_read / PAGE_SIZE);
-
-	/*
-	 * This is only accurate the first time through, since readahead_folio()
-	 * doesn't update readahead_count() from the previous folio until the
-	 * next call.  Grab nr_pages here so we know how many pages we're going
-	 * to have to process.  This means that we will exit here with
-	 * readahead_count() == folio_nr_pages(last_folio), but we will have
-	 * consumed all of the folios, and read_pages() will call
-	 * readahead_folio() again which will clean up the rac.
-	 */
-	nr_pages = readahead_count(rac);
-
-	while (nr_pages) {
-		struct fuse_io_args *ia;
-		struct fuse_args_pages *ap;
-		unsigned cur_pages = min(max_pages, nr_pages);
-		unsigned int pages = 0;
-
-		if (fc->num_background >= fc->congestion_threshold &&
-		    rac->ra->async_size >= readahead_count(rac))
-			/*
-			 * Congested and only async pages left, so skip the
-			 * rest.
-			 */
-			break;
-
-		ia = fuse_io_alloc(NULL, cur_pages);
-		if (!ia)
-			break;
-		ap = &ia->ap;
-
-		while (pages < cur_pages) {
-			unsigned int folio_pages;
-
-			/*
-			 * This returns a folio with a ref held on it.
-			 * The ref needs to be held until the request is
-			 * completed, since the splice case (see
-			 * fuse_try_move_page()) drops the ref after it's
-			 * replaced in the page cache.
-			 */
-			if (!folio)
-				folio =  __readahead_folio(rac);
-
-			folio_pages = folio_nr_pages(folio);
-			if (folio_pages > cur_pages - pages) {
-				/*
-				 * Large folios belonging to fuse will never
-				 * have more pages than max_pages.
-				 */
-				WARN_ON(!pages);
-				break;
-			}
-
-			ap->folios[ap->num_folios] = folio;
-			ap->descs[ap->num_folios].length = folio_size(folio);
-			ap->num_folios++;
-			pages += folio_pages;
-			folio = NULL;
-		}
-		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
-		nr_pages -= pages;
-	}
-	if (folio) {
-		folio_end_read(folio, false);
-		folio_put(folio);
-	}
+	iomap_readahead(&fuse_iomap_ops, &ctx);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -2084,7 +2103,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	unsigned int max_folios;
 	/*
-	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
+	 * nr_bytes won't overflow since fuse_folios_need_send() caps
 	 * wb requests to never exceed fc->max_pages (which has an upper bound
 	 * of U16_MAX).
 	 */
@@ -2129,14 +2148,15 @@ static void fuse_writepages_send(struct inode *inode,
 	spin_unlock(&fi->lock);
 }
 
-static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
-				     unsigned len, struct fuse_args_pages *ap,
-				     struct fuse_fill_wb_data *data)
+static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
+				  unsigned len, struct fuse_args_pages *ap,
+				  unsigned cur_bytes, bool write)
 {
 	struct folio *prev_folio;
 	struct fuse_folio_desc prev_desc;
-	unsigned bytes = data->nr_bytes + len;
+	unsigned bytes = cur_bytes + len;
 	loff_t prev_pos;
+	size_t max_bytes = write ? fc->max_write : fc->max_read;
 
 	WARN_ON(!ap->num_folios);
 
@@ -2144,8 +2164,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
 		return true;
 
-	/* Reached max write bytes */
-	if (bytes > fc->max_write)
+	if (bytes > max_bytes)
 		return true;
 
 	/* Discontinuity */
@@ -2155,11 +2174,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if (prev_pos != pos)
 		return true;
 
-	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios &&
-	    !fuse_pages_realloc(data, fc->max_pages))
-		return true;
-
 	return false;
 }
 
@@ -2183,10 +2197,24 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 			return -EIO;
 	}
 
-	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
-		fuse_writepages_send(inode, data);
-		data->wpa = NULL;
-		data->nr_bytes = 0;
+	if (wpa) {
+		bool send = fuse_folios_need_send(fc, pos, len, ap,
+						  data->nr_bytes, true);
+
+		if (!send) {
+			/*
+			 * Need to grow the pages array?  If so, did the
+			 * expansion fail?
+			 */
+			send = (ap->num_folios == data->max_folios) &&
+				!fuse_pages_realloc(data, fc->max_pages);
+		}
+
+		if (send) {
+			fuse_writepages_send(inode, data);
+			data->wpa = NULL;
+			data->nr_bytes = 0;
+		}
 	}
 
 	if (data->wpa == NULL) {
-- 
2.47.3

