Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57799C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 10:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FA220830
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 10:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LbcB7SN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfDIKix (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:38:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:44435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIKix (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 06:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554806330;
        bh=5asugcsdV5dPpTXf15PWosu2E2PkgYvYsdV0rAITvU8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LbcB7SN4zMdf6fY/9X+iwM980OqdrBVUoAVzpRk4wXU4Ar3LJ8aZnTgP2blWY7UoA
         GRZVoTRVyu4YXK0qUIEstNxE99ueIIi4/JJLh8RblcW5i9Fpw2+3aD29liUJfSqPxu
         E96Atjb7pA008XKEAGhhzU8BwYdq3XjCr0dvbSyc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Mh9yT-1hZzrc1i6r-00MIX4; Tue, 09 Apr 2019 12:38:50 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2] fs/block_dev.c: remove unused include
Date:   Tue,  9 Apr 2019 18:37:52 +0800
Message-Id: <20190409103752.28532-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bfDUOsKoMVk33YJSHCtkNGjsboyNuB3HAPHyxrSpMreMZKZlsZV
 ns7uzXOqJq17KdscSgIF47E1ukdew3CTvOzM2s5xaxwHIvttSsZmrpCKOv6hmF1h33b8OdL
 yWx9YtKwHHU56bFo+K3XcfnevstBA/VmOMcKtvFtlyWI4FAyuaOO1ZC0xRkZQ+boOklFmrs
 ND5TDCPEgDqnUy+wdcH2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B22jwk2UEME=:Yg8yQ8yfDDMzvqx/DO14B4
 GNJzg+J+UvzWHwAtejPI9QWBO7rQ9Y5J6V28O2hD9yczcQ7Iha89yO8AOlBKjCSs6v4rEG47D
 nqNNifVqS2xpU57d1NyXceL31QTsG9/YuPP8X3EP9LJZp8iSZE5hIzeKVdH1DYve+QsH9woFy
 rndx6/A3+SZujcAGNThLV3unzK7hSZK1cMCQVlGzT8B0SAvRrnGV93s2F5hievg2GmNBCJEQG
 yT7ZonFFqHSNA8e+ZnbNTqz2Ch+m33W8N6/XZzMrz6xU4RVv/lEEyUIdGBK+LLPvf30M1DSGU
 aj7HSTdbdTMP+ouEReuzjHbHdEqz65fkoLmWbZ6qxxbrICT+Hj0hvMqUFZZ8RozGRN2Ff/rTn
 oki83QYbeJpyPqwfDEUuLvlJRpOfmE3dfRQeSOV84Po/gk0AdgfMfocbO2JwMZPrEIpyr16se
 /gPu/onnlsTBdGbgCi0yEy3kV+wbEhDliYmNguBQlzza7kWWprIj4WtzV6RltgU0D9Q1uOazU
 jzJJkb+7/Fp1JV0RMcy6i4EnrRbi6G4dX0AYWrBSEv7fr/jM/+o5vrF7krdzzCUGK7mYMI3Nq
 MhkoOTexfLvepbfGtCf6bgeeAMtHPqAI4EbyNMl50p4BRgfq35kvUrngVKtN3dVi3vjXUDuC5
 KEe4B1h8HlUwf3CBclFBfXrGO0YZ80n9f51IswWg6sxeaEBiXdN8/4Rsrl1xjcmNPS4gtWggy
 xBYxG0FnGA13EUTwJqHZ6fFZLk8vxYWxGYOuLcprNIqY9tCk4LEBHeFrt0QBDT3oqM+1xWtZv
 7J+0zAIlyUbfx8xuIMe1ntikAsgEQYlHZeWDSG7yh5VfvdciR8WpZ7SFu11HmFgeD0/poHjtU
 YZQATceDXvmLDRxpJz0vvjmGNWRX4Hr+N5rAChh40IP7YM7JVN0qo9TVwpjAFi
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just remove unused include <linux/badblocks.h> from
fs/block_dev.c.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
v1->v2:
- Modify patch title and commit log.

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

