Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC645C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 20:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiCJU4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiCJU4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 15:56:45 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86F8190B41
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 12:55:43 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id x4so7910852iom.12
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 12:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:content-transfer-encoding;
        bh=OZ5w5qcBb5By4pEzzTFtlfbNxuZ0xF0TsMUdVKKSC2s=;
        b=V/H/icaOX+rjpjog/4MbOUNey/ef5oTcJNVpD6JjyktIQRxOzTkVHFwkmDOxmJJ/ss
         vGuFY8dXnfb3Zwm5PtRUA6QXqBH/oCfq24mTZWP0feirus4qNVqYtUofJQ2/ImYr577U
         yiOdjP+a/vZlkGaGJJhcqtqjwJLcmT8hIvTgxzPG2t7XTx54sQvv/sHxM0jppS9pmCox
         BwVb0tJVQ7qub9jhuiNOp0m3DCVordBUfLuyGl9u1buTq5Y+4k3XfJmDNYjGX9mlkdLX
         7idcarTSmaI/Jy+bzYb4tiMcEJdr3M8U0nPiYFoOGjxm8B+Ap7hKZXFQDPnHKhz+keN+
         WLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=OZ5w5qcBb5By4pEzzTFtlfbNxuZ0xF0TsMUdVKKSC2s=;
        b=YfS6tKaOXrL5W1oeIswTc8CnxI5GtBq8z4NjMka4LskE8DyyoBt4JyqOBb/GmI1QJr
         JJ8hyARe7/oztqcz+FC6Aj2UxGq/TCJrAOLRD2gUCPF0trffjcROymPNJToP6ydYJ+3U
         AGBXmFzWcO9PiuGyTZs/HoRojHE1/ypOmj/wq0Hbj1UhszoJNaoJ75vVGQIxgkXNsmut
         aVY07V7G0QjUpyEhvUrPen9+35xfOSvzgff3eXND/S4MfWM3qZnZ9OeAB+qYIsejREyB
         6nzA2gKuyM7fNwdUibMusOF6r6ytOhKvAzqYH9z5jr0p88rAoJLoIUhIzPJyzhzpBpip
         943Q==
X-Gm-Message-State: AOAM5338H9Pr7nKMlQ/L3x6Er0CeeI/5x0AqjOb71PLtwFsvs7gKSOLs
        kvts70E70EGUc+Rpnvda4+zYkkgZTm72y1m1
X-Google-Smtp-Source: ABdhPJztNmqyUKBMGNwt6tvbGzSXkYvP4nkbKslrE7DSjtUddxDDr/MfgIFWxsjJ8VcL2qkkvcflFA==
X-Received: by 2002:a6b:4f03:0:b0:646:c48:ef13 with SMTP id d3-20020a6b4f03000000b006460c48ef13mr5387855iob.24.1646945742991;
        Thu, 10 Mar 2022 12:55:42 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s13-20020a6bdc0d000000b006408888551dsm3069827ioc.8.2022.03.10.12.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 12:55:42 -0800 (PST)
Message-ID: <70ff8ffa-f118-61d7-d8ab-8c1106d7574e@kernel.dk>
Date:   Thu, 10 Mar 2022 13:55:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.17-final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for a regression that occured in this merge window.

Please pull!


The following changes since commit 30939293262eb433c960c4532a0d59c4073b2b84:

  blktrace: fix use after free for struct blk_trace (2022-02-28 06:36:33 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-10

for you to fetch changes up to 0a5aa8d161d19a1b12fd25b434b32f7c885c73bb:

  block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection (2022-03-08 17:48:39 -0700)

----------------------------------------------------------------
block-5.17-2022-03-10

----------------------------------------------------------------
Shin'ichiro Kawasaki (1):
      block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection

 block/blk-mq.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

-- 
Jens Axboe

