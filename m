Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B102C28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 11:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCBD2067C
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 11:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Ct+rZJOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfFILOl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:14:41 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:49184 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbfFILOl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Jun 2019 07:14:41 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 451B02E146A;
        Sun,  9 Jun 2019 14:14:38 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id FIM6OTx6EE-EbdGO4lJ;
        Sun, 09 Jun 2019 14:14:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560078878; bh=fs8nBfb3ds7H31icSADDLPErvh+7dua0F9p+22pSX7g=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=Ct+rZJOX4WGI8YQKjpH3ii9RvoN6KJhvouJJcnmN5Mc2iwej8axIJoD1TZJGtp3Vb
         S/YLSYJ1q2EjICM7T78VTIjEinHx3v6Tv239k/JhQqVXp4bRzD1QykE7daeGSxxKX3
         +dwKLLlKXPP6BKx7wJuCja8D2+NjPVrIKPnVGXZ4=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id rLRpdRuFBw-EbYSeoAF;
        Sun, 09 Jun 2019 14:14:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] block: document iostat changes for disk busy time accounting
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org
Date:   Sun, 09 Jun 2019 14:14:36 +0300
Message-ID: <156007887680.2438.10285329550436435242.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 5b18b5a73760 ("block: delete part_round_stats and switch to
less precise counting") io_ticks is approximated by adding one at each
start and end of requests if jiffies has changed.

This works perfectly for requests shorter than a jiffy. If requests runs
more than 2 jiffies some I/O time will not be accounted unless there are
other reuqests.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Links: https://lore.kernel.org/lkml/155413438824.3201.15254568091182734151.stgit@buzz/
---
 Documentation/iostats.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/iostats.txt b/Documentation/iostats.txt
index 49df45f90e8a..5d63b18bd6d1 100644
--- a/Documentation/iostats.txt
+++ b/Documentation/iostats.txt
@@ -97,6 +97,10 @@ Field  9 -- # of I/Os currently in progress
 Field 10 -- # of milliseconds spent doing I/Os
     This field increases so long as field 9 is nonzero.
 
+    Since 5.0 this field counts jiffies when at least one request was
+    started or completed. If request runs more than 2 jiffies then some
+    I/O time will not be accounted unless there are other requests.
+
 Field 11 -- weighted # of milliseconds spent doing I/Os
     This field is incremented at each I/O start, I/O completion, I/O
     merge, or read of these stats by the number of I/Os in progress

