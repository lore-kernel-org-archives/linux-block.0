Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB5CC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 10:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AE821924
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 10:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfBHKWc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:22:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:47833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfBHKWb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 05:22:31 -0500
Received: from localhost.localdomain ([116.30.194.117]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LZhsq-1hWuxF0n7s-00lR1N; Fri, 08 Feb 2019 11:22:29 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: break loop when getting target major number in blkdev_show()
Date:   Fri,  8 Feb 2019 18:22:20 +0800
Message-Id: <20190208102220.21067-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:nSD3VSGATLhItH/RwZHI4PHGfwQxtlQvZE8pGh0RylQf2jgIGWa
 qzaz0YCLUppPOSAgws0Za2FhvEYiLhsWTAySEby28oOxSwTkHoB2oXQ0qhAGajOhHURa+cR
 i+ds6g8tXZz55r20FFf38CfWtJBcfIVO0rXE0zM1NnUMz7fn9dh/t5IUhNssyDAKasl59oF
 zmRw3GUcyP66CN9oWf7xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O++nXhrFqyM=:BR3OzmpS9ar1pa/UNNNyYy
 z+VMxJ5bPq+YHKsnbOK2BIWVXMgJ7NpSLaWv7STvPGkYaxc67SPKSqCKgnzw7O/yXADnX6PJK
 Vqh1PHTSYUE1wHCHKhcO4gGgjesduS6V2KGu7/2ISLBoenEGH81sHBIdJSCcqY9wAgY7eV6k5
 Is9GC8D2HDazBXsshlew3e5xB/Oujgw+631VisDebjbzxMa2hfuj9edR0VbGdJC5p+zUOqMHV
 2mwfvPCVW50GhFkr8MvAqc5OQ6RE6ftgDXAevsBVaYFXxuLY5XCIIoWQyai9RNgOp2TurEh7Q
 5/DvEsE3IP8lDA65SQvCe47DA3/vA4pxPLFGtg3aTufNR7ods9PtJERD8cVqvkYzmGD34a72W
 szodyFvgZzInN0F8DS20SWzfSLOHyVdsJfeKIIqhtt3fILigAi0czsX1WtAI3Jf29BbutfTR/
 BdtKdTPh7JjnUR2K+Oqn2gAFu7RxaFIFbJygIAvRhhRDtviJku8jK9APPW2VBsayo/Ce4iBbs
 7DZfeXNTNYBxx63+azmIeAXhfFDYBdPu7qYqDiE+Ivw+8Hl31OShXC7j3ElSvdlSjotaLBEJ6
 oJS1D7ltEmQP7RtPoPixYB2lXps0yKMzS4kys6dDrvENdYOFHVwNglYuZ+QCt2y2+eG8219PO
 c+3qgnNXiDadseuk/VrNL+t0M07Gbw8u8xNNS2rTxQdaYat52u5yoSRd/HhOPY47YQCRFvxhM
 aeKfxEL0pl6XPYblrlT1Pq70ObVrxigNRGbYygEQIWQstK2ljAeTBXN02TR+HF1JgZFtaSAf+
 BXIoeK0BK1mT2xnu0+Z5oj+scP1T3I5I5ItAajLY9yb0Z7E/pmYypcMMSGYJicVZN9QCzDENP
 JCgIfTRF/UfX7SDwQDq1Pn6StaLhFnvlSsxLTV5N/M2VDgS9EqMjJdb4dNlWrB
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The entry in major_names table has unique major number,
so there is no need to continue to search after getting
target major number in blkdev_show().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1dd8fd6613b8..908e3b4399a3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -324,8 +324,10 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 
 	mutex_lock(&block_class_lock);
 	for (dp = major_names[major_to_index(offset)]; dp; dp = dp->next)
-		if (dp->major == offset)
+		if (dp->major == offset) {
 			seq_printf(seqf, "%3d %s\n", dp->major, dp->name);
+			break;
+		}
 	mutex_unlock(&block_class_lock);
 }
 #endif /* CONFIG_PROC_FS */
-- 
2.17.2

