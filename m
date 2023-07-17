Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125C1EB64DC
	for <linux-block@archiver.kernel.org>; Mon, 17 Jul 2023 19:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGQTRS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jul 2023 15:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGQTRR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2023 15:17:17 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC5198
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 12:17:14 -0700 (PDT)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 52CD93F078
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 19:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689621432;
        bh=pp7/NVI0R+7BbcS+Dyztj4+YNV0Le0lGgy9ItQiWesg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=i62tCs5kM4ijN9Psm6JiSOw2z0kg7syOu213ogzlZlQyZB6Ytzef2ut8ekRLLmIfx
         eRkcXAXYyxK21Q+OmzNW4A2WskVyZz71TOLAz/+A7luYhE2f6v8UmweioL1pgHyz/q
         X+TDHMdquNF7Db/uwqXrVjN7S83L2ECWKFNn+2y+xhrrJBH49lk+DF9R2k3FOm1SJM
         MUvuE0+alwwAaH4tHEmM9ODJIMute7EiY4mrrJorvaGInCEzTk1DnDIUNj5mafXvMt
         uaoxmrEIoew823q6HKcs4dckwJPbJVt6R6Ck/1nE3mIz5qYc7dpV+EB9oxPyaDLHAZ
         msjxT32zBzwsA==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b3f17e0f52so7987352fac.2
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 12:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621431; x=1692213431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pp7/NVI0R+7BbcS+Dyztj4+YNV0Le0lGgy9ItQiWesg=;
        b=XGa9kr5c1J30qAZuljFw5Ab1AuFHr22lYJbKfI63R+GtkhDfOAijGFJ7ieCE8u17Sq
         r8UkXUiFBRc88WlXqHuojEI6wuWjJtiYmJVXuBi/JkIo5gtTjKhf0SOjuiaKfW5QrAbA
         z1tTz3hbBf5tEFWBrCGyRQbizvxDVnb7a7XRfKxMw6HS4WxZz6CxU2peYqs7Mi5M1/Vt
         2nh0G+kEBFqfhP8VZE3XWh5bzD4WCmrNwtscX0NFNlu3DIIKXGDJYH/7kneMkFBPx2z7
         hzhiuQLoBOsxSIYxahh28S97HhXQZWb6ul018Vd9Q3a/AnX0NFpAqaFJOPClG81o9rPe
         jGjg==
X-Gm-Message-State: ABy/qLa1F1sdC29qxhA5+NW4Jv6R3O5c007g14VBco+F/UIK/oVU4FOC
        z0+Ysd9Hcr1u/0GD6+eXBIPpzFel2FFehqOYhlUORmZ0NY2o1Oj7ZiwJ8KlEl66aFcMIEH2C+2f
        t5PnJtfQPmIumOVVLw64tcVMRvBgJqvQ5uAPZEVki
X-Received: by 2002:a05:6870:f609:b0:1b0:5483:7b5e with SMTP id ek9-20020a056870f60900b001b054837b5emr13806937oab.44.1689621431288;
        Mon, 17 Jul 2023 12:17:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCWgzp3YDOG8prAXJ5oatLQCn86czWrnR5Kk9SW7hYZF+k8lB6B+AXVAtgMNiip3oP06WFFA==
X-Received: by 2002:a05:6870:f609:b0:1b0:5483:7b5e with SMTP id ek9-20020a056870f60900b001b054837b5emr13806927oab.44.1689621431081;
        Mon, 17 Jul 2023 12:17:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:8296:70bd:5663:a6f8:b245])
        by smtp.gmail.com with ESMTPSA id y8-20020a056830108800b006b71deb7809sm223087oto.14.2023.07.17.12.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:17:10 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: [PATCH RESEND 0/2] loop: fix regression from max_loop default value change
Date:   Mon, 17 Jul 2023 16:16:26 -0300
Message-Id: <20230717191628.582363-1-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Apparently, there's an unintended consequence of the improvement for max_loop=0
in commit 85c50197716c ("loop: Fix the max_loop commandline argument treatment
when it is set to 0") which might break programs that handle /dev/loop devices.

The (deprecated) autoloading path fails (ENXIO) if the requested minor number
is greater than or equal to the (new) default (CONFIG_BLK_DEV_LOOP_MIN_COUNT),
when [loop.]max_loop is not specified.  This behavior used to work previously.

Patch 1/2 just notes the loop driver's autoloading path is deprecated/legacy.
Patch 2/2 detects whether or not max_loop is set to restore default behavior
as before the regression (and keeps the improvement done by the commit above).

Tested on v6.5-rc2.

Thanks,
Mauricio

Mauricio Faria de Oliveira (2):
  loop: deprecate autoloading callback loop_probe()
  loop: do not enforce max_loop hard limit by (new) default

 drivers/block/loop.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

-- 
2.39.2

