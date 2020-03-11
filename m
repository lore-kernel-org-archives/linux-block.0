Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id CCFB17DE57
	for <lwn-linux-block@archive.lwn.net>; Wed, 11 Mar 2020 16:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgCKQMs (ORCPT <rfc822;lwn-linux-block@archive.lwn.net>);
        Wed, 11 Mar 2020 12:12:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39527 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgCKQMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 12:12:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id r15so3389439wrx.6
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PE0xCP/YldjBqal9u3IvK3D+Ap2jsQmYbSPkKDPiuBs=;
        b=PoV8vNpKEqmS6XlEvPSSFO0NHvvX8HU+2kzE8hagEylCUzZwOBfxRigt+JiQwLKWEA
         /Dz8F/s+mB//57G+1Kq6QHtIkp+mw98JSN6l8JDaqIylQU+d8N5D7UT2K6ePC5UFRjGV
         HLD/xFFgzx4m1Fzka6tKjtAEnJ+hDv08Z/sd0+3796LSSFKjxgPRvmHMErhkHjlRMF+V
         ji5WLy9WleF9ARTLkXFdIPbLJ2ABGjLSZRd/8ZRaOW9ModBoN3IavlxRLVQXvXFtm+L2
         cMIFW9PmFgvZMRbR8RHJLdu8TS4TLDHos2Egh+NZRwUhWUtTcQUOVN6DEcoGwFp8vxw+
         iBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PE0xCP/YldjBqal9u3IvK3D+Ap2jsQmYbSPkKDPiuBs=;
        b=etSxqI1xfxvBCv9Tdg78qLvuXzzb2Jc+1NZx3YaZ8KgRdhPxvqhca0742rUG5Wo/30
         ustcKOGiZ2wAl/isRqbMuTy0W7LwnDLbfrDugepJigzvA25nOKZoHjHczLb/s2H0/My9
         GDgQ2UCVZ/K7H05d8HlIfBiYA61i13ug5cLyP7N1wCAwrFvZkzRvnX8cgnjPM4wVhZwQ
         ssAOkHAeBOw8CXo0fiajgrT6zLAilAqmwrtXUoA4/AbkuZMJSccEndC+RWcxSCjKE9YE
         9UtitEXqLWxpCEeTJNiPUpW8piwk8E45Kyzv/s5vB3iQ+PiTsidwb4Svp8ryVanYk6HI
         0hYg==
X-Gm-Message-State: ANhLgQ1mX64pyJwKXkRcnGQzV2uyXZkR9n44hPtUQ6dZ7uO5pb41Ccy9
        IHl8lD+GS1B6rpgqwTnvyCzxudpxJwE=
X-Google-Smtp-Source: ADFU+vsMURNH0kPk2In9gmj9C2kOmVc3l0CR1aomn8nb1qXr2Sd8q5PYVuJ13KEI8q2nN4n/y4hoqg==
X-Received: by 2002:adf:f148:: with SMTP id y8mr5171816wro.322.1583943165029;
        Wed, 11 Mar 2020 09:12:45 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:12:44 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 01/26] sysfs: export sysfs_remove_file_self()
Date:   Wed, 11 Mar 2020 17:12:15 +0100
Message-Id: <20200311161240.30190-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/linux-block/20200311161240.30190-2-jinpu.wang@cloud.ionos.com/>
List-Archive: <http://archive.lwn.net:8080/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>

Function is going to be used in transport over RDMA module
in subsequent patches, so export it to GPL modules.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
[jwang: extend the commit message]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

