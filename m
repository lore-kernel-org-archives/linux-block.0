Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0520FEB64D9
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGDXiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 19:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGDXiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 19:38:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81001BD;
        Tue,  4 Jul 2023 16:38:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b852785a65so1003685ad.0;
        Tue, 04 Jul 2023 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688513902; x=1691105902;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogkOTN/QP2XMJx0kscIbgjlcvmFOVWNpmWQQA/4vWw0=;
        b=qabU8//NAV+c94p875TZcxTP2R7WLEaMsj+LvvCs9/N4vLWrNDWmS+LhlFqz2NXh6K
         iOwP7DIy0zSniww7RTUpzGTkGRz9Q1ZipQixQZuxmGsQL8eEiKOpZgfIraf8Q2bzRqfs
         R8W677ma2L5n5Jk627XMqGD4UZOocQ88emAyztiwVt0Mh/fkPFsVrw9luLG5HR8daJw3
         Gp6rTddTxfZJyYZESZ33GZxsDhujbI9ey+QXJ0iRfeLKGiDN4f9f4tqANJ3czmUi96b9
         Q5XoUN+tya3ZCom4NHdLzWw4UnyXX6RUBqrahfXzIzZiZyygaqdMb2ggEJOFfjeXtfbN
         +rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688513902; x=1691105902;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogkOTN/QP2XMJx0kscIbgjlcvmFOVWNpmWQQA/4vWw0=;
        b=N83BwCxE3ryuqL8hZ7jQX2GJunQx1uyiGxmIRGxQji/pkIKxYB/ZaE0I4Ba11RZTZo
         GZuLmJDPRkIl0eJvFfXUh/skXa6hJ/YyDavn6gNrKuYCV9OC00plpVhCcTX+7F7DKsHj
         l5rlDmANKDMFpoicr8OHgy6u/xpl7qRml8mToPtDIDrl5G46k631FEec/oHJtWhtYehj
         O+AU10MxX+mM05iMqTDhAAjb8tBmkgo2G2NDb8sFwKOUXETF7hDydegBCdKEangAhMRZ
         uWEPS77Wy/ePJw0w65Ak63UxIeJmTs6HSZlQHeBwq0rcKosNramX6UyzaKlUhE8qKLdf
         VCeA==
X-Gm-Message-State: ABy/qLZzp7CEKY9/ugtxDvZ6NGueh1O3LCYm/YWH8nlL0/I7d0/ir8Bo
        8sGSlCRKRmxt7nFMvRXgLsA=
X-Google-Smtp-Source: APBJJlE4tcf5QBcndHgRQMPBJFBrzh9QEQI+vGv7HoNhOnH0a3hGIhni0QQR3uHb7iIPVU/kGoZdyw==
X-Received: by 2002:a17:902:db05:b0:1b8:8682:62fb with SMTP id m5-20020a170902db0500b001b8868262fbmr926641plx.4.1688513901851;
        Tue, 04 Jul 2023 16:38:21 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001b8a1a25e6asm2813419plb.128.2023.07.04.16.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:38:21 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 6F34D36031A; Wed,  5 Jul 2023 11:38:17 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v4 0/1] Bugfix for Amiga partition fixes
Date:   Wed,  5 Jul 2023 11:38:07 +1200
Message-Id: <20230704233808.25166-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230620201725.7020-1-schmitzmic@gmail.com>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

my (again, hopefully) final version of the bugfix for the
bug reported by Christian Zigotzky against the Amiga RDB
partition code currently in linux-block as well as upstream.

This bug affects any users of RDB disks where the value of
(signed 32 bit) -1 signals the end of the linked list of
partitions. One of the popular AmigaOS tools used to
partition disks (Media Toolbox) uses this value. As a result,
the last partition is considered invalid and cannot be used.

The bug and this fix have been discussed on linux-block and
linux-m68k at length.


Testing by Christian also exposed another aspect of the old
bug fixed in commits fc3d092c6b ("block: fix signed int
overflow in Amiga partition support") and b6f3f28f60
("block: add overflow checks for Amiga partition support")
that I document here for future reference:

Partitions that did overflow the disk size (due to 32 bit int
overflow) were not skipped but truncated to the end of the
disk. Users who missed the warning message during boot would
go on to create a filesystem with a size exceeding the
actual partition size. Now that the 32 bit overflow has been
corrected, such filesystems may refuse to mount with a
'filesystem exceeds partition size' error. Users should
either correct the partition size, or resize the filesystem
before attempting to boot a kernel with the ealier RDB fixes
in place.

Note that this is not a new bug in the current code - just
one particular result of the old overflow bug that has only
now been noticed.

Cheers,

 Michael

Michael Schmitz (1):
  block: bugfix for Amiga partition overflow check patch

 block/partitions/amiga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1

