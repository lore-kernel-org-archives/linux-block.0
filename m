Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE83BC33C8C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 12:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5982075A
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 12:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+KXHHqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgAGM2m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:28:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726937AbgAGM2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jan 2020 07:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578400120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4UTyKgnP0YFJHjbElbv5KiGj5R8K834Ui92u2kW+y6I=;
        b=g+KXHHqklOfuFFap1zpbbjk5w0WCw8n1IERkwSgOeyZbU+lBFGkNGO4BHNNDZQU76w+xJf
        9oo2+h+jZajoR2PeII1HcidRyVa1aJsUBxr8WJxTu5i0xftBNEOnxAf5HxRf2xNT7oriy4
        RG8Oy6Vl/LUbQIwM/uGkdeloUUhdJyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-4JkScn_7PRaZeSlTpXi0dw-1; Tue, 07 Jan 2020 07:28:37 -0500
X-MC-Unique: 4JkScn_7PRaZeSlTpXi0dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5635D18A8C81;
        Tue,  7 Jan 2020 12:28:36 +0000 (UTC)
Received: from localhost (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B752A8208E;
        Tue,  7 Jan 2020 12:28:26 +0000 (UTC)
Date:   Tue, 7 Jan 2020 12:28:25 +0000
From:   Joe Thornber <thornber@redhat.com>
To:     LVM2 development <lvm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, markus.schade@gmail.com,
        ejt@redhat.com, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joe.thornber@gmail.com
Subject: Re: [dm-devel] [lvm-devel] kernel BUG at
 drivers/md/persistent-data/dm-space-map-disk.c:178
Message-ID: <20200107122825.qr7o5d6dpwa6kv62@reti>
Mail-Followup-To: LVM2 development <lvm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, markus.schade@gmail.com,
        ejt@redhat.com, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joe.thornber@gmail.com
References: <alpine.LRH.2.11.1909251814220.15810@mx.ewheeler.net>
 <alpine.LRH.2.11.1912201829300.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912270137420.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912271946380.26683@mx.ewheeler.net>
 <20200107103546.asf4tmlfdmk6xsub@reti>
 <20200107104627.plviq37qhok2igt4@reti>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107104627.plviq37qhok2igt4@reti>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 10:46:27AM +0000, Joe Thornber wrote:
> I'll get a patch to you later today.

Eric,

Patch below.  I've run it through a bunch of tests in the dm test suite.  But
obviously I have never hit your issue.  Will do more testing today.

- Joe



Author: Joe Thornber <ejt@redhat.com>
Date:   Tue Jan 7 11:58:42 2020 +0000

    [dm-thin, dm-cache] Fix bug in space-maps.
    
    The space-maps track the reference counts for disk blocks.  There are variants
    for tracking metadata blocks, and data blocks.
    
    We implement transactionality by never touching blocks from the previous
    transaction, so we can rollback in the event of a crash.
    
    When allocating a new block we need to ensure the block is free (has reference
    count of 0) in both the current and previous transaction.  Prior to this patch we
    were doing this by searching for a free block in the previous transaction, and
    relying on a 'begin' counter to track where the last allocation in the current
    transaction was.  This 'begin' field was not being updated in all code paths (eg,
    increment of a data block reference count due to breaking sharing of a neighbour
    block in the same btree leaf).
    
    This patch keeps the 'begin' field, but now it's just a hint to speed up the search.
    Instead we search the current transaction for a free block, and then double check
    it's free in the old transaction.  Much simpler.

diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
index bd68f6fef694..b4983e4022e6 100644
--- a/drivers/md/persistent-data/dm-space-map-common.c
+++ b/drivers/md/persistent-data/dm-space-map-common.c
@@ -380,6 +380,34 @@ int sm_ll_find_free_block(struct ll_disk *ll, dm_block_t begin,
 	return -ENOSPC;
 }
 
+int sm_ll_find_common_free_block(struct ll_disk *old_ll, struct ll_disk *new_ll,
+	                         dm_block_t begin, dm_block_t end, dm_block_t *b)
+{
+	int r;
+	uint32_t count;
+
+	do {
+		r = sm_ll_find_free_block(new_ll, begin, new_ll->nr_blocks, b);
+		if (r)
+			break;
+
+		/* double check this block wasn't used in the old transaction */
+		if (*b >= old_ll->nr_blocks)
+			count = 0;
+
+		else {
+			r = sm_ll_lookup(old_ll, *b, &count);
+			if (r)
+				break;
+
+			if (count)
+				begin = *b + 1;
+		}
+	} while (count);
+
+	return r;
+}
+
 static int sm_ll_mutate(struct ll_disk *ll, dm_block_t b,
 			int (*mutator)(void *context, uint32_t old, uint32_t *new),
 			void *context, enum allocation_event *ev)
diff --git a/drivers/md/persistent-data/dm-space-map-common.h b/drivers/md/persistent-data/dm-space-map-common.h
index b3078d5eda0c..8de63ce39bdd 100644
--- a/drivers/md/persistent-data/dm-space-map-common.h
+++ b/drivers/md/persistent-data/dm-space-map-common.h
@@ -109,6 +109,8 @@ int sm_ll_lookup_bitmap(struct ll_disk *ll, dm_block_t b, uint32_t *result);
 int sm_ll_lookup(struct ll_disk *ll, dm_block_t b, uint32_t *result);
 int sm_ll_find_free_block(struct ll_disk *ll, dm_block_t begin,
 			  dm_block_t end, dm_block_t *result);
+int sm_ll_find_common_free_block(struct ll_disk *old_ll, struct ll_disk *new_ll,
+	                         dm_block_t begin, dm_block_t end, dm_block_t *result);
 int sm_ll_insert(struct ll_disk *ll, dm_block_t b, uint32_t ref_count, enum allocation_event *ev);
 int sm_ll_inc(struct ll_disk *ll, dm_block_t b, enum allocation_event *ev);
 int sm_ll_dec(struct ll_disk *ll, dm_block_t b, enum allocation_event *ev);
diff --git a/drivers/md/persistent-data/dm-space-map-disk.c b/drivers/md/persistent-data/dm-space-map-disk.c
index 32adf6b4a9c7..bf4c5e2ccb6f 100644
--- a/drivers/md/persistent-data/dm-space-map-disk.c
+++ b/drivers/md/persistent-data/dm-space-map-disk.c
@@ -167,8 +167,10 @@ static int sm_disk_new_block(struct dm_space_map *sm, dm_block_t *b)
 	enum allocation_event ev;
 	struct sm_disk *smd = container_of(sm, struct sm_disk, sm);
 
-	/* FIXME: we should loop round a couple of times */
-	r = sm_ll_find_free_block(&smd->old_ll, smd->begin, smd->old_ll.nr_blocks, b);
+	/*
+	 * Any block we allocate has to be free in both the old and current ll.
+	 */
+	r = sm_ll_find_common_free_block(&smd->old_ll, &smd->ll, smd->begin, smd->ll.nr_blocks, b);
 	if (r)
 		return r;
 
diff --git a/drivers/md/persistent-data/dm-space-map-metadata.c b/drivers/md/persistent-data/dm-space-map-metadata.c
index 25328582cc48..9e3c64ec2026 100644
--- a/drivers/md/persistent-data/dm-space-map-metadata.c
+++ b/drivers/md/persistent-data/dm-space-map-metadata.c
@@ -448,7 +448,10 @@ static int sm_metadata_new_block_(struct dm_space_map *sm, dm_block_t *b)
 	enum allocation_event ev;
 	struct sm_metadata *smm = container_of(sm, struct sm_metadata, sm);
 
-	r = sm_ll_find_free_block(&smm->old_ll, smm->begin, smm->old_ll.nr_blocks, b);
+	/*
+	 * Any block we allocate has to be free in both the old and current ll.
+	 */
+	r = sm_ll_find_common_free_block(&smm->old_ll, &smm->ll, smm->begin, smm->ll.nr_blocks, b);
 	if (r)
 		return r;
 

