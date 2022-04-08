Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A673DC433F5
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 03:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiDHDlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Apr 2022 23:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiDHDlE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Apr 2022 23:41:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF376461
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 20:39:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o16so3998469ljp.3
        for <linux-block@vger.kernel.org>; Thu, 07 Apr 2022 20:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=TeuhoDyucgL6ibFNhic47bN2F/d8d7zAJEJcjdT5N9M=;
        b=IzG8ZhkyhGeCbIoRcBrTUT2lK6iJEaz5gtuuuqcaLQUp5ZyGTELxiEVWejz6Fb6eE3
         GUNyi/Y05A/l5Jm1j401TrtnyIgoObyaKPck7dAbQGiX4IERK7jjn7iJPOKMrw8yBGpi
         9mVKfNubadEnDlSC3ZNJBMMjf2SEFj1TPqtHwDUrv1HQIbLs51biIYxKQ32xSvwGN002
         cLIfOeOXdUDcT2/Uj5WhgYL21x7V981HHdseUu9V+yJh44yYptgdXD4+glrSL3/ilria
         dJyEAv2ucNes49lyUnYMFOoi3U0oWUqDZpjLL+mla8tR38Xgw+UiCzlz9Zh3KLZOSnqp
         Au4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TeuhoDyucgL6ibFNhic47bN2F/d8d7zAJEJcjdT5N9M=;
        b=Dav34O08OVICet+ZgeKMXh6UmR60cGE8Sk2QGEBlcvCKQ5qQfXpbogkjts1DmIDf6i
         /L2pU4aotR/g26PA+gyOyfJoxLwYgs1FyCGfP575YGOpMF8OVIxEPASJIXPN03xjqoSq
         DB2RnCu0RZWVr3lIiWVXcUgKIKLuAHmBKu66rIusd2VFdxEpFBPy1MI8QODm30xnwRdh
         C+qdXRcupBTumEW49uMQ3tX6OtJbEV7aZssNkzf8iBjAyZKVVpD5py0sVGX/i6cPqXm5
         v3zX/jVQPgSaC0sYi/KhuTBNyvs98dpZ6kMJQhkBqZ2B/GUtsnehfHUEn6mjl/bOxG6o
         bCzw==
X-Gm-Message-State: AOAM532+4fcWXp5e3/426OODSk2lFWuhlgnLzyc/hjV9LScfDF5vNV55
        04vTY4oEEh52l3bb+gNwpVpqXqJaMZ9X/X1jHXHneEbgtwieZXPG
X-Google-Smtp-Source: ABdhPJzX+q2AqdHNKQpthogDkJq/PuKB0t54xDKxc1YjPDNrvflrFoYhSpUYoODF/WxpFC3rfxALWCTrgd5+y3b0St4=
X-Received: by 2002:a2e:b791:0:b0:24a:c272:d721 with SMTP id
 n17-20020a2eb791000000b0024ac272d721mr10692520ljo.357.1649389140377; Thu, 07
 Apr 2022 20:39:00 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 7 Apr 2022 21:38:44 -0600
Message-ID: <CAJCQCtQkDFs7bt5T=jHO0iZ0zUgvaPpYPf_n4s+URtQXqF2Mew@mail.gmail.com>
Subject: 5.18-rc1 nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I'm seeing this never before seen message in the journal, all in red
text. This is kernel-5.18.0-0.rc1.20220406git3e732ebf7316ac8.19.fc37.x86_64

Apr 07 21:26:30 fovo.local kernel: nvme nvme0: pci function 0000:03:00.0
Apr 07 21:26:30 fovo.local kernel: nvme0: Admin Cmd(0x6), I/O Error
(sct 0x0 / sc 0x2) DNR
Apr 07 21:26:30 fovo.local kernel: nvme nvme0: 8/0/0 default/read/poll queues
Apr 07 21:26:30 fovo.local kernel:  nvme0n1: p1 p2 p3 p4 p5

03:00.0 Non-Volatile memory controller [0108]: Toshiba Corporation XG6
NVMe SSD Controller [1179:011a] (prog-if 02 [NVM Express])
    Subsystem: Toshiba Corporation Device [1179:0001]

This happens with every boot of this 5.18.0-rc1 kernel, no such
message for any 5.17.x series kernel.


-- 
Chris Murphy
