Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099D8C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiGVQTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiGVQTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 12:19:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D87FD4
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 09:19:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h14so2522702ilq.12
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=EJIEvCamJr3iUlfkMyefeyGCZsnSBMLNyj/g7/CrM7s=;
        b=oD7NNwUo6FmG2hdEVo6C5SDIFTJWzyfok7yA3pfKEuA91+EXtdCzu+CJeVWBd0XRLD
         /HgWC1HMfPMwRXmz0piEefly2vyqoIkwJPaNRblzOzRxkPWYSvNwBzSM1sNGDV3n5aY+
         yMsE5KYMLX7huDuRxRMtozEW4cWQRQpVyFT1xlAcjk2spYjxxv+wB2ynI3QirjLvf3an
         QogqTBRKQx6DR8sbziD9PXOr4cAhd9MrhXtwhOca0YFexyRl/peUBYynAqkix45go5vv
         LP/Sz8spslI+Lk9J5jDu4tcvkObOl3KwZmAx+iMOyh6vUAaDtohh/3OHANbPcmsWFP1+
         /u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=EJIEvCamJr3iUlfkMyefeyGCZsnSBMLNyj/g7/CrM7s=;
        b=QINTSvfgaPM4tT3ZGrC0Ro/f98M0bAUjDVjI5+uE0pF4hQaZPr9ZWjwFzwaSb7T0B3
         LC/m25lpzlZn00aBNFx3cIzNP2e/Rw+slti6m7+Neai1YHpm1JQob2CRaMK8NaeISkq3
         0+2UKucfGTaWvsJ+k/ety5/f3dC9bSJ4R7NlV8p2fC3j4uPxrTakBKi0Px43dwlMU6pC
         m+ogn/ZF8wR22+4ZsQDsYoZCghTfU3Ip4HGNNXC/gGxGqv7EiD5xIZypvAHoVGaaitTk
         eIDrIVehBDOxax1JdkdT1i13tiVI24plLK1251vTwOfrJPbsxXCvl3kR9wxYzi9uDszO
         44kA==
X-Gm-Message-State: AJIora/00E46jtD3WypeU2SbnZ5AMjvGDhK1oyg+bvHjtBB2dghiA4Sn
        ix2pKZPbnV2vDcaO63cC8jleoqlmCPUZQg==
X-Google-Smtp-Source: AGRyM1vEHALhP2kyZLaNB0SbU+2N6JLlgkvGr034DplCCh0aVdLCvSwtSVSR1OVSbaBFptLa+vE60Q==
X-Received: by 2002:a05:6e02:2145:b0:2dc:8548:ad90 with SMTP id d5-20020a056e02214500b002dc8548ad90mr316343ilv.147.1658506788216;
        Fri, 22 Jul 2022 09:19:48 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s20-20020a02b154000000b003316f4b9b26sm2184311jah.131.2022.07.22.09.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 09:19:47 -0700 (PDT)
Message-ID: <ebd024bf-f931-1396-bdd8-a9efc444b144@kernel.dk>
Date:   Fri, 22 Jul 2022 10:19:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.19-rc8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for missing error propagation for an allocation
failure in raid5. Please pull!


The following changes since commit 957a2b345cbcf41b4b25d471229f0e35262f066c:

  block: fix missing blkcg_bio_issue_init (2022-07-14 10:54:49 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-21

for you to fetch changes up to 82e094f7bd988c02df27f8c8d81af8f750660b2a:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.19 (2022-07-19 12:42:33 -0600)

----------------------------------------------------------------
block-5.19-2022-07-21

----------------------------------------------------------------
Dan Carpenter (1):
      md/raid5: missing error code in setup_conf()

Jens Axboe (1):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.19

 drivers/md/raid5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
Jens Axboe

