Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B8C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0928221473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UGxQ7DdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDHKer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:34:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:48447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfDHKer (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 06:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554719684;
        bh=QrVEKgk9agKV+rysXlEHUyB4hEY7EP5iU7pNfzj0+is=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UGxQ7DdAvXTHg3lbdUlnm9yuPdVucSGzQ6Vr6SSDYFzohChkrEZBjl0oSpE8AUi26
         /XOY6yIX4S9Lr+nFZyxLJhgLUI9OP12P7WrH/GWDFeWn55rbLuPqhmiQEQBVFjHtsK
         YSNRNwyOBcsJMzerDlsLQJxVFe8n66bnzU3qQmp8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LomJ1-1gfmUS1LHn-00grRK; Mon, 08 Apr 2019 12:34:43 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] fs/block_dev.c: remove unused header file badblocks.h
Date:   Mon,  8 Apr 2019 18:33:54 +0800
Message-Id: <20190408103354.18638-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IdWEG35kcXSQY/BOwPV9zEGdfcLTpTe+j1IjN3waepCTgWOdjya
 C97uDoluuZvrfaKAlPvJfIYITbFNZlGJyqGTs68F6pwYKnxBGliLEdRqjzzZTPIyf0VOjKY
 zEnk5JhSTsG9nvZfJt2caz0VMXfWf4sCnKXl0wlKBH9ziU24AdwLbcU/xQYwbChtBsOaseb
 2SCAPCKBLDVznvZzdvpHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3k5JMIsJnqg=:POSrs9GLKPVh0EGk+S4lHm
 CZ93IKDhdUOROLYC/b23UxQvOWzmRZokxiX/EasU7I+7e12LdNouPLim5mc2G7fxiDAILUa9Y
 P7aZsybJq286lrEsj27sPpGWtmU6LtDmt0QIPFPGzMNYkFnRZJyZGIVb5FxzV4yKJvmCjzn9a
 FoluFAc1kz6iy1CmTt9jie/ENzd28zjbbgIs0sFX8/Jv2It8ELy2HUXqM7vpbJaKRuy7HkazM
 lnN7mrmeXOHI1umfN2ZnXXqi/qwalBvm/vWOKbnH+sReSqZjixdr++vnSCoyscGmku0cTcBRE
 xeCuHZp5gUOiZHBrtbZKYqFEd745zenKCu1dFDFY2Jg6WuvlKBRy7AbiskhlNLFgfyH6PRFNR
 S+D/ip/3tVtftsVXa0NM8/eMl+CyGxx51kZeABOdI3PyX4FOoC0nuPmDJfyvc0klPRDnT50qG
 YGhUYT+qKCY0H9X1tU8T1p8JEc+ZCzGZpV+7TeEaWUWrC0a8fMBMy8x175CMGX3u77U1oZHfP
 IkpFrrk+S3nQTTxEddyBBiTjDgpNxupfI8YwJtRvgwczCH+CBwIPIdjeE9KtqRGFKWTuGKwlH
 L+h+RAT6XAUhRIy+4hE4flCezOiQUWPqRFWq01hrQfw27UjBEF4de8iv/+miIrW+ylKfVX9p3
 XE1wWjXt+klAaA1FfVpKW+urW/BsR+u+E1QFs8/nXNuc1f5w7BdVYnoZ94Rcp4u67KgtUM7Sc
 Je26J7qvv7GyS1Mb4+MzoCotm6uM/zOJZK6mKDXJY0KT/OxH8MdhitnfCjHXw0Vi/UU5KWFTs
 x4WX3IQQJPJT73Ko5SuZB9b1xsB9All8OTpH+OCC9QMfa4M4vR27BCxpAJX+EGjUT2gIUGzP8
 nhcNXGiTFoWDLjhJlUi8unXBtRLTXUSBJq1warZPujRpeZKRE1zKGzO7vIAgGW
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch just removes unused header file badblocks.h
from fs/block_dev.c

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 78d3257435c0..6b584817d461 100644
=2D-- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -30,7 +30,6 @@
 #include <linux/log2.h>
 #include <linux/cleancache.h>
 #include <linux/dax.h>
-#include <linux/badblocks.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
 #include <linux/uaccess.h>
=2D-
2.20.1

