Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29AAC433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 12:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiDFMXs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiDFMWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 08:22:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA655552F9
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 01:06:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l26so2633108ejx.1
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=es6GCrlF2nUa0y5ZqhJAmYS3RmLKzWhj9CrxAydvPkQ=;
        b=WLs5Y7dQQ1ojQDKonVW6tlspo1zGSLIdb34V1BJRbZ8++lv5g3uyv8sDyc+aeAiwi+
         XcJw2lAErX6inKAEwv1iR9I9O4OHIlWTk4rMQW0yx3MsopAyhZ+ohuE5rT8oR6NKGIB+
         B2UW7eg7uhPisss+fZ3XIu7aaVgQsioBwNWykuYRMTFdLMdsIMM/v5zn4xkT501erVBv
         J7YSTnIlpqIo7WbU2m0Z8/S4YAWjF9A00yWknK4Ewp2Ikw7KQokUMgEuVTxUbPjFa8G9
         dD9dRWZUtfbPL2WQwXktQsQJnsdIl/46vrlj+vrE8MT339Exya2p8uFxtb2fqBjMKM/C
         5J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=es6GCrlF2nUa0y5ZqhJAmYS3RmLKzWhj9CrxAydvPkQ=;
        b=2Jo9dGKaTnt5lyXPstmUcG2tZ6F0lsbhzDRDIC9IK2k+vm74fEtEVJxc1c9rq2N9id
         xO6Z/Lcu+H94NmY1T7x15ZdX3ovepdBxZtT/l5UmctukO4vLjIQtANbXhg4X0Pw8Daoe
         mgQFjolXhQaBK+1LuJQqdtAspO8qis+5JHBr63WNxsoBJoQtvgKVQ1Z6W2vbl8VAO6lL
         7Q6V3cgJuYku9vAI3oc1SoXyXa/YRIpWRTE6PwwQSy1F8Zpxp7xb0Xl+f5Aw6fF+TGoi
         BUI0Vi5Lf8gHbOEv+VpFKa069ZTPa34lw0Vdsrfer41XSaiK0hJrSsQTZKNT75eeFnfE
         Tq1w==
X-Gm-Message-State: AOAM533IkPyMe/avFsZIzKaG3ri8a/mVaznXlzKvfO/0NUU5plba+Wyu
        qE8FTWMokOR9BGF2o9p/z3cBPX7O/j9sMO1R
X-Google-Smtp-Source: ABdhPJy0++LnaoradYkv1E6KheIHyeqVReiZzhg85Ym/lpm0gMzniiWG8JrkI90H2/KDZlnujE8+/A==
X-Received: by 2002:a17:907:3f86:b0:6df:ad43:583 with SMTP id hr6-20020a1709073f8600b006dfad430583mr7144090ejc.535.1649232418531;
        Wed, 06 Apr 2022 01:06:58 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id gk16-20020a17090790d000b006e802f814b2sm1996037ejb.193.2022.04.06.01.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:06:57 -0700 (PDT)
Message-ID: <60bf3e8f-9cfb-00d1-5fea-71a72ba93258@linbit.com>
Date:   Wed, 6 Apr 2022 10:06:56 +0200
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
Subject: [GIT PULL] DRBD fixes for Linux 5.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this is the first batch of DRBD updates, catching up from the last few years.
These fixes are a bit more substantial, so it would be great if they could still
go into 5.18.

Please pull.


The following changes since commit ff0f3f83175274daf2eb4fd4db6430ab71c66e80:

  Merge branch 'for-5.19/io_uring-xattr' into for-next (2022-04-04 17:59:51 -0600)

are available in the Git repository at:

  https://github.com/LINBIT/linux-drbd.git tags/drbd-fixes-5.18-2022-04-06

for you to fetch changes up to 0ab5e2117763190f684fdedb6f171abd4b939f1b:

  drbd: set QUEUE_FLAG_STABLE_WRITES (2022-04-06 09:16:13 +0200)

----------------------------------------------------------------
DRBD fixes for Linux 5.18

- enable stable writes for DRBD (Christoph Böhmwalder)
- fix a potential invalid memory access (Xiaomeng Tong)
- fix a use-after-free bug (Lv Yunlong)

----------------------------------------------------------------
Christoph Böhmwalder (1):
      drbd: set QUEUE_FLAG_STABLE_WRITES

Lv Yunlong (1):
      drbd: Fix five use after free bugs in get_initial_state

Xiaomeng Tong (1):
      drbd: fix an invalid memory access caused by incorrect use of list iterator

 drivers/block/drbd/drbd_int.h          |  8 ++++----
 drivers/block/drbd/drbd_main.c         |  7 +++----
 drivers/block/drbd/drbd_nl.c           | 41 +++++++++++++++++++++++++----------------
 drivers/block/drbd/drbd_state.c        | 18 +++++++++---------
 drivers/block/drbd/drbd_state_change.h |  8 ++++----
 5 files changed, 45 insertions(+), 37 deletions(-)
