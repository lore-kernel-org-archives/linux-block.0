Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CEFC77B7F
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 13:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjEMNjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjEMNjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 09:39:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310E1736
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 06:39:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-645cfeead3cso1494633b3a.1
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683985142; x=1686577142;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWxs4Dd3MgDKSErZGVe9jdi74y0iCFpfmQB+mTw5exU=;
        b=KblBr8b8khEkcYY5gL9K/oEZrULHyAffyQsyRpkhEEUbq1G8pHX+iYxifcZMa6NSxm
         5OLerVdTivjhTiSV88yYU52GtjCF7JkovHQ3RHd302vXPjGqCYZym6sf9nApyhjDXOvl
         OqEq6Vs/5YtlQ2e6v3G9Z1zsmOxSTJo9A+7cV4uNYgckRozXqzI3y+qnMMm749gUWkts
         h4uuLyvsrF3f4xXepks/q2itqDhLffpRqMbPYBrkZlq2E7jNDvgAvwtxavnbtzHWcd5P
         XmYQmryWzT2n5a60jPO6hEe3Tgag1I2DHIBzMAoUd10Eu99b6rumQQiS+PDBo0sqoLNc
         j+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683985142; x=1686577142;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWxs4Dd3MgDKSErZGVe9jdi74y0iCFpfmQB+mTw5exU=;
        b=AkJl2R00WeIznjDP0nLk5HBACiGs63BilYlxOHWBNAgGwceirrTrdZ2nhxiQAavmor
         LWgEZGEDhUVUvWj11exc4t/fDdam8wmainO/dnTNUkSazFGiAEf8iV6lKYGudDHVvOw2
         r7gwpYicKHY/bBoRpbDH1YGVkzpGFsuyEMFufpOAy7mN2RzgRijrT0/MYMmeMQwCyi7I
         VudGGSY4tU6TYbNHo7dd+yRJ9HDOt7VtebOcJCPSbMCV8MDeUzl8iNOblAMF0LYHNd1F
         aXCZuaFBu5sQ4FHzqz1Nz9EadQPjacaVnfDXLAkyNefiR1IVX0WSoHXfDoyOyto2Pzgg
         K/Gw==
X-Gm-Message-State: AC+VfDxOpKme/eYyxV/CpQGg/y5ifMXOU4kU1LDTEr77m2I7cjZwsUkZ
        JsH+/RV+SnjGEAFz1s8PQin/svU5ZZeAC7PEvsc=
X-Google-Smtp-Source: ACHHUZ6JBoL+VCqS4hnZeFs4ZKH1H90g0HpbGoc0+TgXXOiJrWJwHITsmVhFG+ZXev74thyTZ4akLg==
X-Received: by 2002:a05:6a00:13a3:b0:638:abf4:d49c with SMTP id t35-20020a056a0013a300b00638abf4d49cmr38475980pfg.3.1683985142505;
        Sat, 13 May 2023 06:39:02 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78058000000b00640d80c8a2bsm8684467pfm.50.2023.05.13.06.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 06:39:01 -0700 (PDT)
Message-ID: <c27ed42c-50d1-ac5c-bace-ca98c8d598be@kernel.dk>
Date:   Sat, 13 May 2023 07:39:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.4-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a few minor fixes for drivers, and a deletion of a file that is
woefully out-of-date these days. Please pull!


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.4-2023-05-13

for you to fetch changes up to 56cdea92ed915f8eb37575331fb4a269991e8026:

  Documentation/block: drop the request.rst file (2023-05-12 11:04:58 -0600)

----------------------------------------------------------------
block-6.4-2023-05-13

----------------------------------------------------------------
Guoqing Jiang (1):
      block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE

Ivan Orlov (1):
      nbd: Fix debugfs_create_dir error checking

Ming Lei (1):
      ublk: fix command op code check

Randy Dunlap (1):
      Documentation/block: drop the request.rst file

 Documentation/block/index.rst   |  1 -
 Documentation/block/request.rst | 99 -----------------------------------------
 drivers/block/nbd.c             |  4 +-
 drivers/block/rnbd/rnbd-proto.h |  2 +-
 drivers/block/ublk_drv.c        |  2 +-
 5 files changed, 4 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/block/request.rst

-- 
Jens Axboe

