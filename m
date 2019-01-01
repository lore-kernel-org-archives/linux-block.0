Return-Path: <SRS0=7TId=PJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7B5C43387
	for <linux-block@archiver.kernel.org>; Tue,  1 Jan 2019 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503E3218B0
	for <linux-block@archiver.kernel.org>; Tue,  1 Jan 2019 13:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfAANfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jan 2019 08:35:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:58993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbfAANfh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Jan 2019 08:35:37 -0500
Received: from localhost.localdomain ([113.116.158.159]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LhNwC-1h9F6U1yNs-00mZLC; Tue, 01 Jan 2019 14:35:35 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: add sanity check for uid in syscall of ioprio_get()
Date:   Tue,  1 Jan 2019 21:35:27 +0800
Message-Id: <20190101133527.18227-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:ugRLGInYY+7KQAnqsloCX1qd2WD3vvHGlGhmU9AxrHAbL05zThG
 elJwkYARj5C0Upe0NIVW0JOIl/1qfw7/rU5PEZTuGSzD4Kd3nalMGWGvQYqHoRaU90cTUCI
 DYRX5YWer6kOOsEgM4d04EeeAb2H2VKF8BjNTGlakkCXgdmuQY4lfolxwnEIPUf78exwOQr
 JH4NWfQ4VMMAhtG7kL9eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pKeCEHy/L4M=:tPy9kcX2O0C8SZxf6eCNTu
 AxAYfb/TADCNrFRhBtm2LgpzJ/GzvO+kcPKXq1WJwgbb2PKrIg/I1TxkV0tPgVVWZJD9fbRnP
 ByaE4W5aCNYBp+PxuvG0BV54wHGR7IYzfvCRx6ECm/x/J7RtSlwJ+D9y6ZlO6EAjkvn7R1v+/
 34z94noRbBHq8J2DFiolp3ICDVLyUgaIOWhNxuXsIrh35Bv5CUIxv2RY/v874wo38hAqPlxgG
 aFHs3yoS2lLV2sMaeNLM+7vmQQUltZRqnss1o6Oq3PCIEeLw48BistQDV3XqQ6RJl/++ROlCs
 wrDsYlLVMs9JMs3TnQx1kfy+y781KEaQ+LsMf1VO36AhytUa1jOrOiBRoZJ3UU3GRHje/5zsx
 jt4p/2a3ijQRSg9Z5IRdgVuGk00UeSYvlDqi4SmzP8QnDcpAy8FEyjqgxLN7pDGbtQwQPprab
 5nkWQ+fA2U+dy6jrkGpul+fAXEj1m0cgkF2eEb9ecrAPtlJKD3IJTeS+X9ftObrOMUJ2+X9Nj
 z6WzkoKCS8zFWvagl13d6NSvezeV68IcgrCozo91XoRHOcAhfm9PPkNfwPthR+bry5Bz898pD
 CyqLl37A4u37jJJrdAIDvl6fGZtevnWG9L0FbCQ8UpWt6RZIuGgPvLbTjhoAsgqnAobwZkgzk
 Smrb/RqHmP8SS8XvWRr/D1jxxX6VS5MhvY0iPsFRksM4SLGPKB4GGjcXqcD5fqfT19pax6Y+8
 kRCLXsMN87xZn5xTwcHw8yZtcV4yE5L306gHgn8TuKhpwNAPnSWiJG/6B6gI7zdmunCEN5Ahp
 jC/Y9tUBoJBcgl6AMIfO6UvucelMOMzuze4AB7eks6GReZyq9wTRXV7ydJ7z6KSurGgYN1gB4
 WgT0LXBYu8A8G5Uvzs0b4pFDgtT+NT9VSA5lrLJ9g=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It better to validate uid info which is from userspace.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/ioprio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/ioprio.c b/block/ioprio.c
index f9821080c92c..b59397662da6 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -218,6 +218,8 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 			break;
 		case IOPRIO_WHO_USER:
 			uid = make_kuid(current_user_ns(), who);
+			if (!uid_valid(uid))
+				break;
 			if (!who)
 				user = current_user();
 			else
-- 
2.17.2

