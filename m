Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0010CC43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 00:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C347B2133F
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 00:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="Sx95wuRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfAKAPl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:15:41 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:37091 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfAKAPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 19:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=ngWYQo1nEEoACFHrqfhg2XD1LODR5Ty7uRRyzIF0TQ4=; b=Sx95wuRhO8Bn
        RbOM1gi6jqk5mHR3jl0NeQNEC+3Ai3jiIQLr5hryBHaHuy/h5L8Gcc6/hOy+sS+zr2csJz8KaEEpw
        cfVzNcveCuxWQTa/vOPV3cAGMJpTesmmp7ixroaZbnujoVShTkL/E5epGcR3fv/gqttSLdNR+HAJ3
        gJCVnWJl36+/hmDfJrXaTbC4sgaALDzmqHPNKCGmkU38LHQ1H+VJSZHSfFPb7WmxnamXmh8nk7IwU
        7mhKDVi+oTWxKsmL03oQdZBaw2j9GY4qyXapRv6ayiTtShcDa/3c4CrgzZomEOW8N6uy4u3wxunXj
        V7YpmiyHx3/0Ec6w0xojrg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghkU5-000EFA-6a; Fri, 11 Jan 2019 01:15:37 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id ABC61C05E6;
        Fri, 11 Jan 2019 01:15:34 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] fs/direct-io: Avoid duplicating the check whether or not locking is required
Date:   Thu, 10 Jan 2019 16:14:51 -0800
Message-Id: <20190111001451.77567-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5u1NW8JjovyfofWkmWvxBbV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTaOqZpfO3PVJjdazu3l6Zm3CrxbKqqxVb1b/D8J7mjn9gmu
 FRYKs4jlPyIgb09lryVwGlrc+zmv9g8VXL7aqBBBpgBGCOe4dpigFzOkCvfcancVNcjtQDyIrrrt
 tXx1J8UmdKiUDu05sQ+NXK1SVivz4pWx7WxWFZpsjT/483ewgmA+i3ELh3mZmIGS9ZTwk6a7CSkL
 W9LSmlMSg6zTM5DjlPGX/gfakiT80rH2R1nK5O5JDLnTmHDzsd5E2ZsfNx7OC4knOJkMS8NGDKsP
 9r3K+YAsXLEiw/7cdqe91zRXkCRWioZEg8uHACOXv9T/3KwM3C4j4m6e3ojJJmfkw125HKpZsFrP
 AYwuqATgb9HSJk9cw+faPHD2CrOPeAQYmFk4dKQpVT+PQilZdUnBlc+mXY8fOcUKvVQ+NlG00bnQ
 aN9fxN2oReTDHAyOynaY0Cm+1YVZQG7kKIVLKDAfP/fiLz/dsiahQ1DFoGJGH4QvNBsJtQPKQiHZ
 yFvUHYw7eSOJUjxiJ+iyIer32bek7nPrlX1S+8oMSMSBIUAYLLu4muidX4Ts4xdG+C13IyWeZaKI
 V3UMWdIW3N4pA1N9PyHRU34/WMvOa2MADyzbmruTAFTdIOqBUyv13AysbAGiWKifmZ7ww2G4L5hn
 RBNVVsfCQ6ie30W+SekWG2g23NglFX+g57a6J/5sK4+TfGG8msAA80uNsTeFa4yYJFGS1Hp0ygEw
 wwWe3xXNBQ8NJdm4PkndMi/yowK/A0SwUdhvH2JbjOsRoljf5NgOcH54FJI8kJK3Wi8N+W/OFvjW
 oRnP9WYxGv7DZfr3KAxqGJNAwF28CnHyKT6N77/NkdXPDV6r+g8VkhKEFJ2lUlbkduNBMFsWkGe3
 rrP8epBg83OZBP3RMrw5DdwH1AXXXLvYNFIckdu6/R2FM84kxYRFSvC1IPgY9FHHe9U52OFRRlrQ
 QHTNsFlW4xzv3KSabGJbxYTP2MRBN/yBhg133u1IFee4oorsCbHHHr9rzACKpZmvWdFvZfKMnvFR
 NXBZ7Tcs3Zay
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of repeating the check whether inode locking is required, perform
that check once and store the result in a variable. Remove the obsolete
comment that refers to direct_io_worker() since that function has been
removed. This patch does not change the behavior of the direct I/O code.

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/direct-io.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 76d1295ed0a4..b8e7729c9cb1 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1185,6 +1185,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	struct buffer_head map_bh = { 0, };
 	struct blk_plug plug;
 	unsigned long align = offset | iov_iter_alignment(iter);
+	const bool lock_inode = flags & DIO_LOCKING &&
+		iov_iter_rw(iter) == READ;
 
 	/*
 	 * Avoid references to bdev if not absolutely needed to give
@@ -1215,28 +1217,22 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	memset(dio, 0, offsetof(struct dio, pages));
 
 	dio->flags = flags;
-	if (dio->flags & DIO_LOCKING) {
-		if (iov_iter_rw(iter) == READ) {
-			struct address_space *mapping =
-					iocb->ki_filp->f_mapping;
-
-			/* will be released by direct_io_worker */
-			inode_lock(inode);
-
-			retval = filemap_write_and_wait_range(mapping, offset,
-							      end - 1);
-			if (retval) {
-				inode_unlock(inode);
-				kmem_cache_free(dio_cache, dio);
-				goto out;
-			}
+	if (lock_inode) {
+		struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+		inode_lock(inode);
+		retval = filemap_write_and_wait_range(mapping, offset, end - 1);
+		if (retval) {
+			inode_unlock(inode);
+			kmem_cache_free(dio_cache, dio);
+			goto out;
 		}
 	}
 
 	/* Once we sampled i_size check for reads beyond EOF */
 	dio->i_size = i_size_read(inode);
 	if (iov_iter_rw(iter) == READ && offset >= dio->i_size) {
-		if (dio->flags & DIO_LOCKING)
+		if (lock_inode)
 			inode_unlock(inode);
 		kmem_cache_free(dio_cache, dio);
 		retval = 0;
@@ -1372,7 +1368,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * we can let i_mutex go now that its achieved its purpose
 	 * of protecting us from looking up uninitialized blocks.
 	 */
-	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
+	if (lock_inode)
 		inode_unlock(dio->inode);
 
 	/*
-- 
2.20.1.97.g81188d93c3-goog

