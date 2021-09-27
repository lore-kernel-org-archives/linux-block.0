Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108CFC43219
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19A96101A
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhI0WDn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbhI0WDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:30 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F8C061604;
        Mon, 27 Sep 2021 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BcUF+qNITddSgWWUKSwV6xy+2M578+kqxDNel0HR7xE=; b=Im6XRnki0OQLJiQZE8Z7WBGmHk
        OFWXu2CE3uEJaS0aQVj1USACkv60rPzSPlPP2++EourkmqaecwtZ1nHXrUVk7+tKXh9uOReFR2eUB
        jnn/htadfyzXE+66SfjvAY4oRKgknk5SwZkoj3qFNjAUYhRhfBybIxnZNuc525eB2wfTtkK4IKfjp
        8F+twfkCwCdiNvjuBWdijgj2FNP8xdo8aq2Q4GGIiNo1wm9VLFszlqcL9PSpLStWFM11JpdFcuUlC
        qmQAMaw4WlGsDxriBCCRvHawv2GlqbJGW+PtaC+FlPQNRb10Qia+CsVwDhpuXUAt9FEgS8LAMe+6e
        2uMeJoow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygS-004TPg-69; Mon, 27 Sep 2021 22:01:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 12/15] pcd: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:01:07 -0700
Message-Id: <20210927220110.1066271-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/paride/pcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 93ed63626232..a7fab3830d7b 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -941,9 +941,13 @@ static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
 	cd->present = 1;
 	pcd_probe_capabilities(cd);
 	register_cdrom(cd->disk, &cd->info);
-	add_disk(cd->disk);
+	ret = add_disk(cd->disk);
+	if (ret)
+		goto out_unreg_cdrom;
 	return 0;
 
+out_unreg_cdrom:
+	unregister_cdrom(&cd->info);
 out_pi_release:
 	pi_release(cd->pi);
 out_free_disk:
-- 
2.30.2

