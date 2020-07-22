Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D2DC433E1
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 10:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D270420729
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 10:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Rk9o/7pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgGVK1O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgGVK1N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 06:27:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052AC0619DC
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 03:27:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so1619312ejb.11
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=30u5W0gssAJucuy+Ek91LRF04P++ZfAtzcMqrVEzV5A=;
        b=Rk9o/7pmyOfpZ58MqoYuIm9o+4nh5ingdqMOPJ+m70HvzMMaphmBw96wyStOMvQakB
         riU4thZJ1ivni8Hz6LxecSJI0K2FlnpAUGlE3KrmoHbM6GO84lLTGnafAJGbwajH23Km
         P2VAXYhCWr3sPmm2Kem+jtaKrwwRwgBsTAJvJMxtjUTpTkHSUwBe0HfHxMKV+/oQYZv1
         wovAwiXB1YKOZ8x/cGnB+Zo2U+rMR2kAxsWmYC4KD3Ts0qNe4XoWiGTRYEM6KNpQ4PPb
         6z9/XJhl8HdnCFFW3s7WSVcktlwLFSGdcujY+kI7qEWiuUaPSZRfS7tM1VL/PFwWnVsC
         0rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=30u5W0gssAJucuy+Ek91LRF04P++ZfAtzcMqrVEzV5A=;
        b=jcJa61r0KRX+3teIbqqu9p0rsBthNekBLbtTSGXZn+2mgUjQqDvSGKI+lxg1PvZLzA
         fBdNv0L5YRnQjxNLdBCmmxIv3kMJZbCRf03pi64rH3gbUUyn4jrmRoWoNveznKE4vQVN
         GibOok1/vmwwFrrujvFn55qFCogF97O4R/Rm6Imak+3IHg5Ad+xRJePMhT+Qje8id2m9
         KVKp8Xt+a4kkV8mDY8Dyg/n7wEUkVAvsLxO1KUNYXZey32TIAatoVehLWjHsjuQv3rWX
         1SFt9KIYA2svA71cP/iTkcZfweozKdWrmQyKPr/XgjI7Fuif/axT1+vS/8p2byybdyJr
         bJWg==
X-Gm-Message-State: AOAM533DbKWKsrifSwPOO//fSy6R3cJ8zIyb2roYDPlV53CDlR2mdQED
        y3dOy0OF2dpFe6K39P/R7jwy3A==
X-Google-Smtp-Source: ABdhPJx6rTKpLcr2vlAHxkok4PBENkYUKuEUacg1KDRZe16vLh7GPsSHz+TRERTMUNMh5LXYySZUFQ==
X-Received: by 2002:a17:906:26c3:: with SMTP id u3mr28627669ejc.483.1595413631831;
        Wed, 22 Jul 2020 03:27:11 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:c136:467c:a322:7c9f])
        by smtp.gmail.com with ESMTPSA id w17sm18581044eju.42.2020.07.22.03.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:27:11 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/2] Two patches for rnbd
Date:   Wed, 22 Jul 2020 12:26:51 +0200
Message-Id: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Could you reivew the two patches?

Thanks,
Guoqing

Guoqing Jiang (2):
  rnbd: remove rnbd_dev_submit_io
  rnbd: no need to set bi_end_io in rnbd_bio_map_kern

 drivers/block/rnbd/rnbd-srv-dev.c | 37 +++----------------------------
 drivers/block/rnbd/rnbd-srv-dev.h | 19 +++++-----------
 drivers/block/rnbd/rnbd-srv.c     | 32 ++++++++++++++++++--------
 3 files changed, 31 insertions(+), 57 deletions(-)

-- 
2.17.1

