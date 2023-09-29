Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB40E7F156
	for <linux-block@archiver.kernel.org>; Fri, 29 Sep 2023 11:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjI2LCl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Sep 2023 07:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2LCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Sep 2023 07:02:40 -0400
X-Greylist: delayed 316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Sep 2023 04:02:37 PDT
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD01A8
        for <linux-block@vger.kernel.org>; Fri, 29 Sep 2023 04:02:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6E1483F445
        for <linux-block@vger.kernel.org>; Fri, 29 Sep 2023 12:57:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k4mCMy8EoTaD for <linux-block@vger.kernel.org>;
        Fri, 29 Sep 2023 12:57:18 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 794CB3F358
        for <linux-block@vger.kernel.org>; Fri, 29 Sep 2023 12:57:18 +0200 (CEST)
Received: from [192.168.0.132] (port=43288)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <forza@tnonline.net>)
        id 1qmBBN-000J1D-3D
        for linux-block@vger.kernel.org;
        Fri, 29 Sep 2023 12:57:18 +0200
Date:   Fri, 29 Sep 2023 12:57:17 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     linux-block@vger.kernel.org
Message-ID: <ab9a424.2f3f68b6.18ae095efe3@tnonline.net>
Subject: dm-cache: How to properly flush dirty writecache?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Is it possible to force a flush of the dirty cache in a dm-cache device?

I read in the kernel docs[*] that there is a cleaner policy, but it doesn't describe well how to use it.

Ideally, I'd like to be able to use `dmsetup message` to issue a flush after suspending the cache to ensure that all dirty data is written to origin and no more data is dirtied before resuming. Is this possible? 


Thanks
Forza

[*] https://www.kernel.org/doc/html/v6.5/admin-guide/device-mapper/cache.html 
