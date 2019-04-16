Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19126C10F12
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2502086A
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlnVkBFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfDPD20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:28:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40102 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDPD2Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 23:28:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id x12so21751113qts.7;
        Mon, 15 Apr 2019 20:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hQC5aSEtbFdhbXWX1DeduxbyazYDPsD+6g5fd10gWwI=;
        b=DlnVkBFqvpn9QjAmP4wXC87GuVWp/Eg+Rb+Twi2frnhqV56+b3R3w/QnK2HZV7FmTq
         xwqWTJ3LUPkaWlbRWlj++fqLeJkhIMgOUagJbZ6jBV6lDB6ykiTAK24yfFfXdtiGdub5
         KSzozx617bTCgg3xqislRTD5SKPXg5r4GHdkGafoyUXInOid0+NbWnC+fZS8Sw4P1dwd
         1Tf47vLMqHlfCuEwHAgYbKE+AabicWqZDpShtc0svP7Eeesjco8yd73cwIeuFht6u/9W
         AyWgcpOlpzOAMXiJ2rTztyjkOamENVPfVL44D/AzPS3U4ygDdE8mOuqujSaNs9ZimZPz
         B+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hQC5aSEtbFdhbXWX1DeduxbyazYDPsD+6g5fd10gWwI=;
        b=gOM0j7iAd/Kob12qbL0UQEUviSnfB+HZ3pVqAHgFfsuaheKx1/FZxZSyudtpN6RrSg
         WP95/FKVQQ2L+763ebd8zgx8AI0tsrMw6d5Tl1Y2TqnRJ/gnlCRdw6U3JYckfJnrkadK
         nwUah7NA/LdYYRhYgoERgdfjVShNL/Jw/yoUc/Tm5oXxPa/cxB7LM12ODc7isvDO+668
         uX4B+m2WFkSCVJnvEJp8aoHgpAH0osoZki2rYhpP845qwv6OG87kVFzFDUdJRKXbuLAN
         R8VYFQV9g7Sr5fmMkI1e/qtepS33G/VP9W2YhhnvLvh+zs08I/8EZYnI9AMtJQc2HqHY
         NnfA==
X-Gm-Message-State: APjAAAXJNvNk0VkUN/WaejLa6xkds9zxaxwl7uJ0kGXep27WrdTvONVD
        Kb42rsolSbXtrVbO1UMIrvxyfqr3QEk=
X-Google-Smtp-Source: APXvYqyIirsI5x0kqsT7rLXFkdKYEPr7Y5MQS5xI9qTAuf1y50UdLJjx+4JrQSqKNLWPAHikdxMMJQ==
X-Received: by 2002:a0c:87b3:: with SMTP id 48mr63192996qvj.199.1555385302937;
        Mon, 15 Apr 2019 20:28:22 -0700 (PDT)
Received: from localhost.localdomain (189.26.177.132.dynamic.adsl.gvt.net.br. [189.26.177.132])
        by smtp.gmail.com with ESMTPSA id z16sm21501299qti.53.2019.04.15.20.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:28:22 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, marcos.souza.org@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com
Subject: [PATCH v2 3/3] Documentation: kernel-api.rst: Add block/blk-mq.c
Date:   Tue, 16 Apr 2019 00:28:01 -0300
Message-Id: <20190416032801.200694-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190416032801.200694-1-marcos.souza.org@gmail.com>
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now documented functions of blk-mq.c will appear in the official kernel
documentation.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---

 No changes from v1.

 Documentation/core-api/kernel-api.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 71f5d2fe39b7..cc323480ce0e 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -276,6 +276,12 @@ Block Devices
 .. kernel-doc:: block/blk-map.c
    :export:
 
+.. kernel-doc:: block/blk-mq.c
+   :export:
+
+.. kernel-doc:: block/blk-mq.c
+   :internal:
+
 .. kernel-doc:: block/blk-sysfs.c
    :internal:
 
-- 
2.16.4

