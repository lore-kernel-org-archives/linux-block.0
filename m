Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19AC433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 12:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiDFMXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiDFMW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 08:22:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21A4AFB16
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 01:07:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ot30so2520960ejb.12
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=BK4uqR4DBxUcrOhSL0+7lH+xVrswMnPHtjVKXsOOpG4=;
        b=BsP+slwiGpMkPf/dgipgLte79LcScL1Bzneuo/X2T+L007SVcLKYhH4WnFDdQ4Hh11
         WUEoJUDeg/oK0y0FBgvqq+apORk9ZUEaRWyk9/4SI0EjyCBMgtW/pj+No3We4coZO1d9
         qHb5/czAauAt+P9dJDEiclfZ9AWovvrhH4HsCMoeQTOE3YQplNukr+bpn/hznfo+MABb
         WcTwf/H0bGyy35GYN/Oky7AuU86mtCuqrJhCF4scvj00IZBUvT//nrIQlwarhyq6aBdL
         CY68PBMn2TV5I34+ibPnOioCwy+udy6ngNkMrk2+Ss4xPpk4Y5FHoLmiuvBQvRXLXEfh
         06Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=BK4uqR4DBxUcrOhSL0+7lH+xVrswMnPHtjVKXsOOpG4=;
        b=kB46q6Q3J7wbdgkFA3kAMhkNeMx5kle4fUK2jSeX9UoWeNGC83bDLzvv+sIql1LUOe
         1OUWiuaby7aF/CA6W1mqFLhiTYL+VWGEVat0TI4Wi67jxERR6HbgZMlxnCbCkaZ3C5jA
         y0oeVSOvzCmCXXWDd4JsrOofXT/a3ddUFVVjUJ+LJl4B9sWLvQ5DiTNJ26mUnWIWNEE8
         EkUl0cuv7QYBClbOLTtlmJ2y9epK1wLy96RvUFc1pu1UL+IzfTa4Tq4f39wnLbZXMwuO
         N5Wpmue2zfeYt/twsN7R457aLgLcuxCN9llJXlhd7DoZOCgslqQGarptsap0juI++JpW
         7VXw==
X-Gm-Message-State: AOAM530ALFIBQVBoRtrS+5vgD/7n2JybzvCGtDgAIiwvFxZv8LH8X1eI
        43hYpsOUcHuzqr3JTm9eWC6t+g==
X-Google-Smtp-Source: ABdhPJwJX6r3yfeEYEn95I6lOIn41Oq/clijjnflZWOXHkxNbce8Drfed0p6O52HauE7LjeAPl0L2Q==
X-Received: by 2002:a17:906:6a11:b0:6e4:976b:e94 with SMTP id qw17-20020a1709066a1100b006e4976b0e94mr7316685ejc.142.1649232436324;
        Wed, 06 Apr 2022 01:07:16 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe4d1edc6sm6246817ejc.61.2022.04.06.01.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:07:15 -0700 (PDT)
Message-ID: <bca64395-2c73-25f9-dbca-76479ef5d280@linbit.com>
Date:   Wed, 6 Apr 2022 10:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [GIT PULL] DRBD updates for Linux 5.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

these updates are mostly cosmetic; also stuff we missed over the years.

Please pull for 5.19.


The following changes since commit ff0f3f83175274daf2eb4fd4db6430ab71c66e80:

  Merge branch 'for-5.19/io_uring-xattr' into for-next (2022-04-04 17:59:51 -0600)

are available in the Git repository at:

  https://github.com/LINBIT/linux-drbd.git tags/drbd-5.19-2022-04-06

for you to fetch changes up to 7e4d200ceb13f404ab4f9332c81abb2c260eeff9:

  drbd: Return true/false (not 1/0) from bool functions (2022-04-06 09:06:27 +0200)

----------------------------------------------------------------
Miscellaneous DRBD updates for Linux 5.19

- return true/false instead of 1/0 from bool functions (Haowen Bai)
- use kvfree_rcu instead of synchronize_rcu() followed by kvfree()
  (Haowen Bai)
- prefer "unsigned int" over "unsigned" (Cai Huoqing)
- use the PFN_UP helper macro (Cai Huoqing)
- remove a redundant assignment (Jiapeng Chong)
- fix type mismatches for netlink return codes (Arnd Bergmann)
- fix array initializers for cmdnames (Arnd Bergmann)

----------------------------------------------------------------
Arnd Bergmann (2):
      drbd: fix duplicate array initializer
      drbd: address enum mismatch warnings

Cai Huoqing (2):
      drbd: Make use of PFN_UP helper macro
      drbd: Replace "unsigned" with "unsigned int"

Haowen Bai (1):
      drbd: Return true/false (not 1/0) from bool functions

Jiapeng Chong (1):
      block: drbd: drbd_receiver: Remove redundant assignment to err

Uladzislau Rezki (Sony) (1):
      drdb: Switch to kvfree_rcu() API

 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_main.c     | 11 ++++++-----
 drivers/block/drbd/drbd_nl.c       | 33 ++++++++++++++++-----------------
 drivers/block/drbd/drbd_receiver.c | 15 ++++++---------
 drivers/block/drbd/drbd_req.c      |  2 +-
 drivers/block/drbd/drbd_state.c    |  3 +--
 drivers/block/drbd/drbd_worker.c   |  2 +-
 7 files changed, 32 insertions(+), 36 deletions(-)
