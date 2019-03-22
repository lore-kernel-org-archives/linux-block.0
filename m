Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A09C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B5921917
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfCVOgy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:36:54 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfCVOgy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:36:54 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLyvH-1hP9Fl3xpJ-00Ht2v; Fri, 22 Mar 2019 15:36:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Dillaman <dillaman@redhat.com>,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rbd: avoid clang -Wuninitialized warning
Date:   Fri, 22 Mar 2019 15:36:37 +0100
Message-Id: <20190322143643.1317312-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ArQEfk+AU79dMEw+t+/M/Vy4omm9JFXr12vfJvDOE8w0LvZdo1t
 DiayFQqJhMH6lbFTQ6qj3HUL0ViAwLKpYjSOZ1oRxcKkN2VaYuTzPwLKTyR3def4VVNAEqu
 3/nPfrm63xzhvFWN1Md44ffnDt1W5Yokm7PTdaZPdaN8mi2H7uPI3JNCbcDBpYI+btRwFax
 P9nJikkgSy/GZq6ExMi6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1+yyUeQGSk=:SJCif1SFlh0KUIRvSOKUG4
 P5gV4xbx/jE770iWRHakj2NmYBfZWM3fGpmh2nKMwVHZkTbfp8qEFQlKtw5CSLxMO+p+C0bnO
 EJohRr4ts39JWR/pfQFGKKxBT35MrsNYjIOzZT0ma29ACWD8Q8wfb9sporv8NgxCkeB6gnYV/
 tswxyhSMK8uIV4Lm5V1TIMXbY53bRmQ4/DGIyuU9MxXcdrodoMrGbLxIU6ap9l5CLkoGLJxBE
 At+T6i5aFRDx2km2ssRhqqh1V+usJ6r+ILdwqgTDqwHO6Di7iKnhOaRUwq89aTsbOGj+4JKaq
 g3YIQYtHrKuRN3HbsmRLZ+yd0x9OL/YCj9/R5iUuf3SfIAlMsmoPiofmGMCtDmqMVrHqBvZH9
 N00HJOJDrceZpbreVkpt749IaOi/LJoV30ICgSszH+7S2ychmUKRPHPGTpm6zB9NggGI1Oys6
 6T9Fdja2dQbjQ/1kYDFsl29JJLMMc6IkhLa21yZmRIve0QVLfS1ZpMVxBAUkAjN+QrPvyZxLu
 S0dDVDLXCeJk7kgbU4bTxjYoO7rold1OiNus3Nna+ofSfB7nOaiGTW9QqFM09v9BEX1/4q5Oj
 77FgVbCFssn9w9dauR3HnZUSRxHXEFm+hbeN5etuOmne3rhYC4Y5hmRgENxH9qolh4oDEps/K
 SQV3fu5nuPD14d0i21K+4tK0BpKm5C/pJmSJUn7MhJiTsAokJ1tbvOqG3UJG18QRNNVdankSU
 5/5J6m+hN0eXjYiKxjiLbOE+E2yhOXLyA/OPGw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

clang fails to see that rbd_assert(0) ends in an unreachable code
path and warns about a subsequent use of an uninitialized variable
when CONFIG_PROFILE_ANNOTATED_BRANCHES is set:

drivers/block/rbd.c:2402:4: error: variable 'ret' is used uninitialized whenever 'if' condition is false
      [-Werror,-Wsometimes-uninitialized]
                        rbd_assert(0);
                        ^~~~~~~~~~~~~
drivers/block/rbd.c:563:7: note: expanded from macro 'rbd_assert'
                if (unlikely(!(expr))) {                                \
                    ^~~~~~~~~~~~~~~~~
include/linux/compiler.h:48:23: note: expanded from macro 'unlikely'
 #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/block/rbd.c:2410:6: note: uninitialized use occurs here
        if (ret) {
            ^~~
drivers/block/rbd.c:2402:4: note: remove the 'if' if its condition is always true
                        rbd_assert(0);
                        ^
drivers/block/rbd.c:563:3: note: expanded from macro 'rbd_assert'
                if (unlikely(!(expr))) {                                \
                ^
drivers/block/rbd.c:2376:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 error generated.

This seems to be a bug in clang, but is easy to work around by using
an unconditional BUG().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4ba967d65cf9..cbcc3baf3807 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2399,7 +2399,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
 						      &obj_req->bvec_pos);
 			break;
 		default:
-			rbd_assert(0);
+			BUG();
 		}
 	} else {
 		ret = rbd_img_fill_from_bvecs(child_img_req,
-- 
2.20.0

