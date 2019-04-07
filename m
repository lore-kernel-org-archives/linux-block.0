Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6346BC10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 08:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AF0213F2
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 08:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvG9td0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfDGITy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 04:19:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35886 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDGITy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 04:19:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so5516234pgc.3
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2019 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CyIs65fI7ie50Guxpn5FRBWMQhTfYw2JeejDUpG9jL0=;
        b=bvG9td0qYcRGwTcscHPUvGnsjhgt0XFDoygtgIe8oexGO16LJAXZd1TW11ywWFUAZO
         eczR+b4c2nEKzOe2iG+oBrGIu/0y090Dza2r7JW0mFvLoBS8gdF9kMf54iiGM+hXU5Wi
         jSsjJYABTZ01TFQS9PZStXdyR0Xjq31lpcg+x1CAibXzGd1N40RBsIwEFEA9PcM+T7Hn
         h7U+z+sTyYY5V13J7GNQNgpi+V/LtWwn1/OtaIpFeRlpWer7L+ihnfor2HRi8wleN194
         PX5juacbF7rqTkOUFFhQawVJuzgnt2FdCNZQfNKLabfmZOS2myXbQSFSQ361dREwB3CG
         NdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CyIs65fI7ie50Guxpn5FRBWMQhTfYw2JeejDUpG9jL0=;
        b=DbTJ/0LxGJIpzfT936wXDve8L7PcuMo2YpVIZF9d+WvFHv24dr1cAXJMFxc0uHMBaX
         I19ZYp0zV5VOHltExXV2NsUN38nFMIkRT0U+4ilxTViiyALy2yBn2eCHfKqfQZCbYEIL
         z6nzHFwwLa2pRnu6AxsjaHgVRgLKGBDrnPYq6MvpHTQBJbp9vWR56Cygr9Oq6BofB+Yq
         PqNyi7HKDoHkNd7bHRjH5Yt/fGBsib2f0VYhsiLNzHiK1C5bqHqAb+lMzE9Dbz7Ua4C+
         aY7ke8lMvwY2wvEg+DEuDEpx/4hqamnXN4kaqOsBWBadMhal/sfS6/XzH3jKA/7vTmFo
         vL7g==
X-Gm-Message-State: APjAAAVVlIJkDhDQloQXdOrxPc9iztWlereb88dsjl+f/ndjJ9lyjhgR
        FLrwIVwErlT5aC2l02GlQtq0iFeuSQE=
X-Google-Smtp-Source: APXvYqyLFnxYgbEp6mlDsqYFUVyoYMf6JcDyMWvaRDvqLPfHht+CXXTFWh4gWowuzd0qcf/qE/FrpQ==
X-Received: by 2002:a62:62c3:: with SMTP id w186mr22727624pfb.73.1554625193124;
        Sun, 07 Apr 2019 01:19:53 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id m69sm39923029pfi.151.2019.04.07.01.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 01:19:52 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] block: null: Add documentation for "zone_nr_conv" param
Date:   Sun,  7 Apr 2019 17:19:38 +0900
Message-Id: <20190407081938.20318-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

zone_nr_conv module parameter was introduced by a commit
ea2c18e1("null_blk: Add conventional zone configuration for zoned
support").

This patch describes "zone_nr_conv" module parameter to the document.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 Documentation/block/null_blk.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index 4cad1024fff7..41f0a3d33bbd 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -93,3 +93,7 @@ zoned=[0/1]: Default: 0
 
 zone_size=[MB]: Default: 256
   Per zone size when exposed as a zoned block device. Must be a power of two.
+
+zone_nr_conv=[nr_conv]: Default: 0
+  The number of conventional zones to create when block device is zoned.  If
+  zone_nr_conv >= nr_zones, it will be reduced to nr_zones - 1.
-- 
2.17.1

