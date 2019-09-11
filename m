Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EAEC5ACAE
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 16:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D7820863
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrwK0M0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfIKQkb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:40:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33946 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfIKQkb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 12:40:31 -0400
Received: by mail-io1-f67.google.com with SMTP id k13so32138090ioj.1;
        Wed, 11 Sep 2019 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tl8NmQTauJTkodtSWs25AtKBiKIs4gXgEL1Drv1zzhk=;
        b=KrwK0M0dhLOpf2xNKKt7rOC/ir8cAmxu7g3OknTESI8+ndgvUAupbL8zdtSpJ9q9ya
         scfVgs+5s3OgeLS4tDRLlTlyQvcHFeY6n226EBv3elBq6Z2BMNbG9esOCL/nhHIFYSUy
         uAeu2TM04i6KT5YtI9oix9nRO5cAFmXAGNXyouGLmXgR7nugb0KC0YkTaScMZZUMEQh6
         EkZmBF3qzqz94I7bEwNr/SJgiFi8+0r0DmiZUp8chd3e4lzdbBfu42MptgfZ4l/zQkUe
         cHXsvM2IiBxyCBjIfFeb9BB2TUvi8z7qx3cT+osuZMmamwGPic6/fAVMt//zaD44jL5k
         vbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tl8NmQTauJTkodtSWs25AtKBiKIs4gXgEL1Drv1zzhk=;
        b=qxzf2hRA5XbMJ1F1vgWzxQKCIR6A8Nfi+D3E+p6kOWvlr3e+Cu3x/xhPxZMOYaR8/3
         pPqAOL8Hzg8iXnGZ5l6kKzD6tDWCv7r983DJ5f2gwNOht0FNnqMH6I6pxxxqqqEUQX48
         0xCY6jo65QAqY/WxppEUceT6qsTheZlR1g4o61YXSclFTnlUpiUln98EboApGX7j8XjK
         8Ya6DoVz9bkn702V/6X8GNEf8IJN837VmNpoISyY/Mf1Z/qzbgHi/VFRqqXWNQFQiV/h
         b6Zg4VK+LJR4w/ke8AjyGKwJgXSrWT2q109huA4GEzq/b6Z3jhj+bukxVHRlkLEq4BJY
         MIRA==
X-Gm-Message-State: APjAAAX+KnjvfmaVPAeTG9gALvS9YErIfwstvWR+oWSOoAMHuTIy2H+u
        8hbkT32B6f6EsFHEW47wavmHpNkvDPU=
X-Google-Smtp-Source: APXvYqzc+JQCdlEO9+dnSpChUka38hj/JdRKSAzWqwa3qzi+usVxxHxFWg7YZcVpoMqm0KSMXimWVg==
X-Received: by 2002:a5d:9153:: with SMTP id y19mr703021ioq.109.1568220030163;
        Wed, 11 Sep 2019 09:40:30 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c4sm16912886ioa.76.2019.09.11.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 09:40:29 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     mkubecek@suse.cz
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] nbd_genl_status: null check for nla_nest_start
Date:   Wed, 11 Sep 2019 11:40:12 -0500
Message-Id: <20190911164013.27364-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910113521.GA9895@unicorn.suse.cz>
References: <20190910113521.GA9895@unicorn.suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nla_nest_start may fail and return NULL. The check is inserted, and
errno is selected based on other call sites within the same source code.
Update: removed extra new line.
v3 Update: added release reply, thanks to Michal Kubecek for pointing
out.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e21d2ded732b..8a9712181c2a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2149,6 +2149,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.17.1

