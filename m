Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68636C169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 03:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C582083E
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 03:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBLDRk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:17:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:41571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfBLDRk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 22:17:40 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0M6jMS-1hGgcP2Rtc-00wZ4M; Tue, 12 Feb 2019 04:17:38 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: remove redundant unlikely annotation
Date:   Tue, 12 Feb 2019 11:16:57 +0800
Message-Id: <20190212031657.14324-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jKosQEJQT+jxK9WNDOMQI0oIh9KlD5NCBV4sK3/0ztei/VDRax2
 ECH4WThjTocJMvUYjHc8jrrlIKKBIPp8TjSAIA2P8NXTkxu4DYPhCWhHWw7pGcR1DCqB4zY
 ulaq9NeM4Tl5m0bT+6pHCEztmpHYWKuS7FYOKW2+wbfe5LmikKpFul4F4/Mcu+seIQXsD83
 jpC2quTjNQV9b1qvds1iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GyW9gXjyodw=:X13FHi+AXOvE4mX2GWDpJh
 M/P5r3wKljsnGl8jhJczGfBKSqlKq8wSYHFgC4T/axavgNeGTcDRWJwchZEUDVOuwWbbqiA5C
 6rsPJrAEpBfx23d5c/30WqKKKyg18Z+8p6thS10Ml+iK1OdzQIuasPOV5P3iUvQG+yLwE4Y9F
 OI5O3zMhYTIWb5syHdVCTOsz384T7lCFOweFmYmsySKE3elp0FBDo2BzrgtDfhQKJTUi1O8nE
 KE7JQN7bCvlpCmD81OfLtl5MwEo+LaYxJfSr4mzMh7jn3FVrHzW3CNVECCb8wI6LqdMfgXtES
 QdZuCMNWJ1T6Vmm3rSPcte43+L5o3eH1q0STe6BVnUROvSSJQbBlyXwUKVNMK2bj2DfUrBJtm
 Sc1BnoABr+ogPL6rDop2Qw4USi0Z6E118foINySp1Y/+suniRcgI/Z8GbyVfOiJxGxOL4vOLp
 tkLKU6vG7zZNW2UseFycnc1e5rMPm+dYKho3zG1CkpC71LcfIf7qoGMMI0di4pq4Ux2r/r+mr
 8QBtyficyFlDLTrxfmQHjrrez8G8Fe9Zob8rB1kbtfbk6cEH/q/rE3p4u0QQEQozcvl4ehuZG
 o/QanGOfIB8zl64z4cdoSTVsL9+cmDFR6c3KIop9zYN3+L4RFTdyT+eQJqg9I8gU6N1c5MW0j
 zPkz1iotKzfoFSnlPDqhS3ArZXuggLyVb0woU54NJHS0frLchcIE5Aa/ZN0EqQOu+tR25gXgZ
 b8qJ6NDYPhr+8ApwoA+eWYMnRZc9ae0Jd32H6grDVbtfayiYXYh7571ZCVFobWnSAxP2rWrVb
 3hns+8u6YDSsfjFS67harGU0T+AaZJnZayS0XgvpLBQXLWNKmGUG9RcX42TIlCgQupJmkPBqZ
 z5e7wtYg0OYPjhSmO4aPbKGja0e900o+tFfpVns5iSniOAipk/TeJ+sSd6XPGL
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

unlikely has already included in IS_ERR(),
so just remove it.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2bed5725aa03..699dba716c83 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -880,7 +880,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			blkg_free(new_blkg);
 		} else {
 			blkg = blkg_create(pos, q, new_blkg);
-			if (unlikely(IS_ERR(blkg))) {
+			if (IS_ERR(blkg)) {
 				ret = PTR_ERR(blkg);
 				goto fail_unlock;
 			}
-- 
2.20.1

