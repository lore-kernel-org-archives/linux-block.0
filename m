Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73624A070;
	Mon, 24 Feb 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390913; cv=none; b=D7vtUUDqSyRSw2Q2lTSncOJK02QyNBDoBAYuAaVLaMAbL9bi904VyQGcEOKQkuCGoZuO8mU86OG5hXJP6g0FWhUuDrRuHvSvXscMLopEcPzfhRSHOOhSDbenY+vq18v9IUwGByQoFt6cLZZeM3LmqW3prf4wn4NlEr2GVtW1jgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390913; c=relaxed/simple;
	bh=byIhktOyiyjAT4tz5qNe5uSyIyc4GSH4aaX66A2Opd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GglxrGZ2cV005dA/aFvVritQqdqSeVfJXlEDwTihbTwBFxC2wuPH8VLaAmxMD00FR6OBMFjE4mz1ojf5JLnJd4nJ2UpFnDkKCECr47SCGZYBfGd4FwtGGGX1yVV2miEtHz2JJY9lJEd10ew1Fe9/S0MYr4c6ZKVp1wYKGEmgbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5Q0fC/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5Q0fC/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D3CC4CEE6;
	Mon, 24 Feb 2025 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740390912;
	bh=byIhktOyiyjAT4tz5qNe5uSyIyc4GSH4aaX66A2Opd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5Q0fC/gA7kzvRu6w33dKn2qtGQ4PIrfEeniWR6yVVJrhZno+oR71sMIy1kLJ5zqf
	 /nJ4QoO73WIjis/PRRRwbyPqhJ0gLn6dN512THTJipWnmMYhs8xGJU0OAnVW9CaRau
	 wU0t2rAMbOURzOgMojHHQiBPqROIUvGnZZLcXeUW4jmEfS3T4Is19ZfQ++sJprqIyk
	 lH1l+aYD62ROqxOF6H0bw3DzeOFKMgsRi/6PMdQi6OnGYcO922UA63Ap2nah09nbvn
	 Wzeisb1uP2IDGXpkJpCdk5c7TWmISfI6oV8b6QQZbiw0D2hVCrOHBQB6iytZOo6nBa
	 FdPKh46w0A/pA==
Date: Mon, 24 Feb 2025 20:25:08 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/8][next] block: blk_types.h: Use struct_group_tagged() in
 flex struct bio
Message-ID: <ccf673b997e771430b7570fb8a6dfc11d07a2bde.1739957534.git.gustavoars@kernel.org>
References: <cover.1739957534.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739957534.git.gustavoars@kernel.org>

Use the `struct_group_tagged()` helper to create a new tagged
`struct bio_hdr`. This structure groups together all the members of
the flexible `struct bio` except the flexible array `bi_inline_vecs`.
As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.

This new tagged struct will be used to fix problematic declarations
of middle-flex-arrays in composite structs, like these[1][2][3], for
instance.

[1] https://git.kernel.org/linus/a7e8997ae18c42d3
[2] https://git.kernel.org/linus/c1ddb29709e675ea
[3] https://git.kernel.org/linus/57be3d3562ca4aa6

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/blk_types.h | 84 ++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7..9182750457a8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -212,62 +212,65 @@ typedef unsigned int blk_qc_t;
  * stacking drivers)
  */
 struct bio {
-	struct bio		*bi_next;	/* request queue link */
-	struct block_device	*bi_bdev;
-	blk_opf_t		bi_opf;		/* bottom bits REQ_OP, top bits
-						 * req_flags.
-						 */
-	unsigned short		bi_flags;	/* BIO_* below */
-	unsigned short		bi_ioprio;
-	enum rw_hint		bi_write_hint;
-	blk_status_t		bi_status;
-	atomic_t		__bi_remaining;
-
-	struct bvec_iter	bi_iter;
-
-	union {
-		/* for polled bios: */
-		blk_qc_t		bi_cookie;
-		/* for plugged zoned writes only: */
-		unsigned int		__bi_nr_segments;
-	};
-	bio_end_io_t		*bi_end_io;
-	void			*bi_private;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(bio_hdr, __hdr,
+		struct bio		*bi_next;	/* request queue link */
+		struct block_device	*bi_bdev;
+		blk_opf_t		bi_opf;		/* bottom bits REQ_OP, top bits
+							 * req_flags.
+							 */
+		unsigned short		bi_flags;	/* BIO_* below */
+		unsigned short		bi_ioprio;
+		enum rw_hint		bi_write_hint;
+		blk_status_t		bi_status;
+		atomic_t		__bi_remaining;
+
+		struct bvec_iter	bi_iter;
+
+		union {
+			/* for polled bios: */
+			blk_qc_t		bi_cookie;
+			/* for plugged zoned writes only: */
+			unsigned int		__bi_nr_segments;
+		};
+		bio_end_io_t		*bi_end_io;
+		void			*bi_private;
 #ifdef CONFIG_BLK_CGROUP
-	/*
-	 * Represents the association of the css and request_queue for the bio.
-	 * If a bio goes direct to device, it will not have a blkg as it will
-	 * not have a request_queue associated with it.  The reference is put
-	 * on release of the bio.
-	 */
-	struct blkcg_gq		*bi_blkg;
-	struct bio_issue	bi_issue;
+		/*
+		 * Represents the association of the css and request_queue for the bio.
+		 * If a bio goes direct to device, it will not have a blkg as it will
+		 * not have a request_queue associated with it.  The reference is put
+		 * on release of the bio.
+		 */
+		struct blkcg_gq		*bi_blkg;
+		struct bio_issue	bi_issue;
 #ifdef CONFIG_BLK_CGROUP_IOCOST
-	u64			bi_iocost_cost;
+		u64			bi_iocost_cost;
 #endif
 #endif
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
-	struct bio_crypt_ctx	*bi_crypt_context;
+		struct bio_crypt_ctx	*bi_crypt_context;
 #endif
 
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-	struct bio_integrity_payload *bi_integrity; /* data integrity */
+		struct bio_integrity_payload *bi_integrity; /* data integrity */
 #endif
 
-	unsigned short		bi_vcnt;	/* how many bio_vec's */
+		unsigned short		bi_vcnt;	/* how many bio_vec's */
 
-	/*
-	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
-	 */
+		/*
+		 * Everything starting with bi_max_vecs will be preserved by bio_reset()
+		 */
 
-	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
+		unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
 
-	atomic_t		__bi_cnt;	/* pin count */
+		atomic_t		__bi_cnt;	/* pin count */
 
-	struct bio_vec		*bi_io_vec;	/* the actual vec list */
+		struct bio_vec		*bi_io_vec;	/* the actual vec list */
 
-	struct bio_set		*bi_pool;
+		struct bio_set		*bi_pool;
+	);
 
 	/*
 	 * We can inline a number of vecs at the end of the bio, to avoid
@@ -276,6 +279,8 @@ struct bio {
 	 */
 	struct bio_vec		bi_inline_vecs[];
 };
+static_assert(offsetof(struct bio, bi_inline_vecs) == sizeof(struct bio_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
 #define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
-- 
2.43.0

