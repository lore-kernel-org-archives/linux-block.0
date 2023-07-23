Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083BDC001DC
	for <linux-block@archiver.kernel.org>; Sun, 23 Jul 2023 21:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGWVF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Jul 2023 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGWVF6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Jul 2023 17:05:58 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CC2121
        for <linux-block@vger.kernel.org>; Sun, 23 Jul 2023 14:05:57 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-583b3939521so19668337b3.0
        for <linux-block@vger.kernel.org>; Sun, 23 Jul 2023 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690146356; x=1690751156;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t847DV14PaTqet7pzsAsrJmRRW43LmacdLCGV0nteSM=;
        b=6H+bkOgVklAa9LvV6mmhZixU4WdBGtni4LwrSdgn1l/L1/Vxdppo+hTh1t/gHkzWts
         rxQzAotPecacNOASpk1o5a4KVTzU4TUDIWmdZTbdDCkrz2VObwFWw+OwdU139wWPNEQ3
         f269kK+66Mt7HngzJIFC8Q03M7FL+7fEW6LPnV/hxcRw8pm57zgcTwqDHukJalAOFldM
         saBaeQPasr9VRF4NjKr5KyCg0xS4hu+rQ2LHEOIMsghC+EVq6Lqi+lVs8ufWOIllOYyf
         bjjc88HJfoG6br50QvKXk/yAbXe1DjTasWCxM9ww17GKwln9lkV7Ff+Fq5qJw7BHhj/2
         Dr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690146356; x=1690751156;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t847DV14PaTqet7pzsAsrJmRRW43LmacdLCGV0nteSM=;
        b=NMmyrDMH4MBErCZxJ4n94kqHgTiYE7cxtMrT/Tsto5k1p7RUBGk6h9YyunTqB19uqW
         NJ3GgGAWQO3iDnSMI+Xx4IqYjH8Q/SQahBRrH0Kb8WxD7gwlCe/Bf0gFJputMeqDba9J
         GmRjii7OZf/248hhpWnmNXrgWgnmSsx7gOdQIP1ImjSbBH4ZEWGVwKvEgSxNac3MFHjr
         /aFgHGVtQiZ+L2NZz5dBQlA8ATe1OPaU2htBFugybrPmG+0OD26M2Ob+Xq+Nra6XTf/0
         TzwGMpTX6qbXOv7yiD1+9nRmyEj2hugwFxVH276wpIlUNF4T0xF98MfhvyDhnp6tdg8G
         EO5A==
X-Gm-Message-State: ABy/qLZOzYh8DuW7BMBJNe7jrC7qXDXE3UiTpuLGn+e04GRduk8EcLh2
        aX1gCHkdqGkB6g6WKa554GfrJA==
X-Google-Smtp-Source: APBJJlFHMVJ/YU/xbiqdDSgLB6BLkRaNWEWGU4gVRJJ45764mDX+eV4vd08NjS967NEIlk5wvbrsRQ==
X-Received: by 2002:a81:710a:0:b0:583:a354:f259 with SMTP id m10-20020a81710a000000b00583a354f259mr5288275ywc.3.1690146356658;
        Sun, 23 Jul 2023 14:05:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w201-20020a8149d2000000b0056974f4019esm86551ywa.6.2023.07.23.14.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 14:05:56 -0700 (PDT)
Date:   Sun, 23 Jul 2023 14:05:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mm-hotfixes] shmem: minor fixes to splice-read
 implementation
Message-ID: <32c72c9c-72a8-115f-407d-f0148f368@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

HWPoison: my reading of folio_test_hwpoison() is that it only tests the
head page of a large folio, whereas splice_folio_into_pipe() will splice
as much of the folio as it can: so for safety we should also check the
has_hwpoisoned flag, set if any of the folio's pages are hwpoisoned.
(Perhaps that ugliness can be improved at the mm end later.)

The call to splice_zeropage_into_pipe() risked overrunning past EOF:
ask it for "part" not "len".

Fixes: bd194b187115 ("shmem: Implement splice-read")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
This went into Jens's tree for a while, but got lost when another version
of the splice series arrived.  The reviewed version did contain two more
mods: but its !len check is now done at the upper level, and its *ppos
check is unnecessary, given the *ppos check at the start of the loop.

 mm/shmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..f5af4b943e42 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2796,7 +2796,8 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		if (*ppos >= i_size_read(inode))
 			break;
 
-		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio, SGP_READ);
+		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
+					SGP_READ);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
@@ -2805,7 +2806,9 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		if (folio) {
 			folio_unlock(folio);
 
-			if (folio_test_hwpoison(folio)) {
+			if (folio_test_hwpoison(folio) ||
+			    (folio_test_large(folio) &&
+			     folio_test_has_hwpoisoned(folio))) {
 				error = -EIO;
 				break;
 			}
@@ -2841,7 +2844,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			folio_put(folio);
 			folio = NULL;
 		} else {
-			n = splice_zeropage_into_pipe(pipe, *ppos, len);
+			n = splice_zeropage_into_pipe(pipe, *ppos, part);
 		}
 
 		if (!n)
-- 
2.35.3

