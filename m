Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6A0C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 15:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934C020673
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 15:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Naa6Gv+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFTPDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:03:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33246 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfFTPDn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 11:03:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so5227243edq.0;
        Thu, 20 Jun 2019 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c+VIZiG1eBhlF3rxdIGklWohp2FF58HwtgWB8kP2krE=;
        b=Naa6Gv+fzky/gjo7CpiXlMXWStve+HDn/z269u6D22mS2YIpyIrbsm2maPJM8MFOMC
         sLJ4Mx+S9e28+0xXqFixfbAiLz4asoZQJV/yZMrpNQRJXEhR7exHvmKwm2uoeBGgDjqS
         c1DQDyrnfPkhxK0dgpJD5D81nU/tmjK19pQoYEHFAUOnVA6RARX08SaVNL7mX2aGlJZF
         NGZDeLwOfaNCQR+pPHBqIH9MYeVykh7c63njdxCkmSCnAy4Jp8szjlXEfPskU8/L8AuO
         3iQPfGK/MbJEV+/jC6xk9MxyKAHBaYngivQKkVklF+zxGKp70UprypqQSnKS8BYra6Wz
         aWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c+VIZiG1eBhlF3rxdIGklWohp2FF58HwtgWB8kP2krE=;
        b=Hq50IGEzxBradTglNucwFCjxHPCTV3gB6tSeetMWSd3eMbLvCvR+KtqZosW5a88fK3
         CYQz79JcHOFwJLyEDcn7u2gBRrJ6DXJpa7ak5ED6bCiGee0TVKSqSxnThexYIF1a9HQ/
         GSrElsLgs9yRgUQGDX3zy06vasCH82q1HrpnvE+kkcb3NDaXOpp9qlxa7yPcMZYQa8Wr
         RYB+WgvROdHigNIaoVAHJcQPWo+jBYf0UmsQWgq07HamnRLCDL7JQhNC8AbHcSoZ8DOT
         Bz5KqQHVNYup9yssko68iRrcEmUlvgOv69CH+Bz6oF6ofBfzMwohLfO9iVVnO3eaVn/Q
         /Bsw==
X-Gm-Message-State: APjAAAV3FqgXcvl0Nlb2vN/BHTnwD+TxASTbrSzKI5KAopM1yC3i08ni
        zIV3xpHIR1HPJYaSU3bOiCQnDKxSzUg=
X-Google-Smtp-Source: APXvYqySLvmNh9wxZPmypuFfuYTZApGsVZAKsp5UHnSm6q0WQvtYv0puHaE5hU3QulgOF732v/JHvg==
X-Received: by 2002:a50:9167:: with SMTP id f36mr31218322eda.297.1561043021582;
        Thu, 20 Jun 2019 08:03:41 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:41 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/25] sysfs: export sysfs_remove_file_self()
Date:   Thu, 20 Jun 2019 17:03:13 +0200
Message-Id: <20190620150337.7847-2-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

Function is going to be used in transport over RDMA module
in subsequent patches.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 130fc6fbcc03..1ff4672d7746 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -492,6 +492,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 	kernfs_put(kn);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_file_self);
 
 void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *ptr)
 {
-- 
2.17.1

