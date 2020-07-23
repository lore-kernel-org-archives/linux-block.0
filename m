Return-Path: <SRS0=kKib=BC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC3FC433DF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 05:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049A8207E8
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 05:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpupmgBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgGWFRN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgGWFRN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jul 2020 01:17:13 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06348C0619DC;
        Wed, 22 Jul 2020 22:17:13 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id t6so887572ooh.4;
        Wed, 22 Jul 2020 22:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Zbq5s3NWQ6aMlyNzWrT29aHUmN+zLUvS/LCeuCEFaZc=;
        b=EpupmgBATf213WBksb0Z7TxdIzKg66JWtdAc/rkgj3nfF4MCFEBqgCYi0v1FGxYMhx
         VFxyWg0bwbW/kwG57ipBjs0aaqXJZlVdki8MatmIaTHXcMvyfvCHVbmldLPgdNrlFA2P
         PSsPao1HdBVRNVWW0nb0tCyZPwKbV3OEm6Nj6yc1PhdMdu7ewEVa+qDwUo2cRGgnFXAM
         UdnrBT/jM6PfKBZ2fce8e/c3Y4b1mA6rPRsU5WNlGVfbWwSAfCXeX1G5wsOzWx+3swGH
         AbxYHBWPELOkhkE9eCy1IWO4NK1F9q6v8DW2JVYty8z8jakcALWeca8iFuoQg9vV84DL
         zw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Zbq5s3NWQ6aMlyNzWrT29aHUmN+zLUvS/LCeuCEFaZc=;
        b=CbgqCHflPhK7qxW5KY/FwbTTFgmGYN0Pw4dD/oMeC7DGwy36ZpdOufD3abON5qeDf0
         R1OwWxg5f01lAAnmKvGeaCWD9vf2cDHxWqaikjYFXw78pHiZgqYJ1dEuqg9nS/437+oV
         SU9EaERZjP5YND9fETqcUAbet/T+5rbFhMU8zaNpQM5vI27ODKHdNsBEXnx7AiRC+f5R
         2bNLnWBSU0i6Qq+ZxoGZZEajvMzW3+y3Agy6VA2iH8yeEAx4zZIahWgNxGsBTJ2vKgJ0
         6a+6tsDEH+WnuV1HNL2koEvVNvO2FK5mDga8gNF35dY8E1qfqAWepl7E8R4ZvQfEVhlJ
         27TQ==
X-Gm-Message-State: AOAM533J5cepKpRQbL/Ktbv+zek2g+h4lCRoZUVES9epC9fgHmzE0KO+
        jCG6GNGdxLJyLv10NNiLaoxGOduIAcgbTiIPsZSuCm3x
X-Google-Smtp-Source: ABdhPJyzFbPx6TANJJKvaLSb73XxjCPGu5I1eX38jYmjFzSlaRFzQ6HmMdl2zbj4Jzh5Hxwf8I6TYWl9Tf8LbeIm5c0=
X-Received: by 2002:a4a:b503:: with SMTP id r3mr2978556ooo.92.1595481432207;
 Wed, 22 Jul 2020 22:17:12 -0700 (PDT)
MIME-Version: 1.0
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Thu, 23 Jul 2020 13:17:01 +0800
Message-ID: <CAJNi4rOaCLfZhiMOB1+5qOpmBV2h+W3CGUZHy-qF=rSszWqMiA@mail.gmail.com>
Subject: [PATCH] Update the obsolete comments of 'register_blkdev' func
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        xuesong chen <xuesong.cxs@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From the code of 'register_blkdev(...)', the major number range

should be in [1..BLKDEV_MAJOR_HASH_SIZE-1] while not [1..BLKDEV_MAJOR_MAX]

in case of calling 'register_blkdev(...) with @major = 0, so correct

the wrong info of the function's comments


Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>

Cc: Jens Axboe <axboe@kernel.dk>

Cc: xuesong chen <xuesong.cxs@alibaba-inc.com>

---

 block/genhd.c | 2 +-

 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/block/genhd.c b/block/genhd.c

index 8b1e9f48957c..db73aa852434 100644

--- a/block/genhd.c

+++ b/block/genhd.c

@@ -429,7 +429,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)

  *    then the function returns zero on success, or a negative error code

  *  - if any unused major number was requested with @major = 0 parameter

  *    then the return value is the allocated major number in range

- *    [1..BLKDEV_MAJOR_MAX-1] or a negative error code otherwise

+ *    [1..BLKDEV_MAJOR_HASH_SIZE-1] or a negative error code otherwise

  *

  * See Documentation/admin-guide/devices.txt for the list of allocated

  * major numbers.

--

2.17.1
