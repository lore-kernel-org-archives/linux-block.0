Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02681C433EF
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 20:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiEOU6j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiEOU6i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 16:58:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05B92C107
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d5so18107449wrb.6
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfKME/JDkH531Lu6fG6fKwqq/hbTWQKEzNeth+JlmBw=;
        b=1UrWzWjtY/i77ZX54V7TxDuwcuU3xCLPGbbZVukGF+56SSCoDRhqpgyaoGKnEsEPxA
         zOP7CGmirl3P7jvEssv9f/dWrGh2gF7qAd0bpP4B0mhMNd3T6YOyQ/QcYsBAfobnaVBe
         YDmpuqbO/kjlEvvigldjlPepSFzD09VZK/2puHFZ7qFpNh3Qq+ml98kCM7fWotPsGfr0
         XVFuqzZNr3UIWa+cNY8Tk+KsfWKqHq1CiOyG3nZEVXQniMr+CllNYXwoUGdSGxpXaL0s
         DygBjbfSqOAAZSZW+26NIO6/L7grSvURQfqUGdq6S43KKAas45leKKQwj9XXuoTERpp3
         BD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfKME/JDkH531Lu6fG6fKwqq/hbTWQKEzNeth+JlmBw=;
        b=gnkcUInlV78mIzHai1UflUZzJLort40J4gT8c3aVlxNTdmIjlzq1wlwZqVKexPE2F0
         OFGUl99yGKNqAdIJpXyvBKgO8fuDonxSM5e7tTaEU+DnNludafcTl2+/PCzksXXvxkq8
         2WGnuqBGFfLdXpItnVHpdGzyrObU+2GrBy+Q3qVRQ1XPO6TMRDUBisXeJ7s2YKpwcNuX
         jtB2WCYGu9JpFT8EhHfH/KfMtUsLeVF3NhwXVyW933mBmDbdU1Aix6aQzs2MnK57UQsg
         6V1JGQNIKqvxXCzNF/+RFYu/LcjkaNf60ICMdQvE9oHZ5yoCGwW0wX8I5r6dMMIhRp5x
         FA9w==
X-Gm-Message-State: AOAM532/HvBvwDFzi3YvBc5vKCnLQvYopQybP+/Io8fC1qdyuH1JLfLI
        Md+XRxsYQD9OeNaHcJEjN9x2w5K4OWTKcg==
X-Google-Smtp-Source: ABdhPJyBFuN4WHy9iGVZHh3OoAaSzcz01v4DyfwN+mjllhGdQLD34JV1kVuJGroqk8rySpvSFN0HhQ==
X-Received: by 2002:a5d:4703:0:b0:20a:ce3c:7528 with SMTP id y3-20020a5d4703000000b0020ace3c7528mr11703423wrq.688.1652648315294;
        Sun, 15 May 2022 13:58:35 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r17-20020adfbb11000000b0020c5253d920sm8922074wrg.108.2022.05.15.13.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:58:34 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 0/5] cdrom: patches for 5.19 merge window
Date:   Sun, 15 May 2022 21:58:28 +0100
Message-Id: <20220515205833.944139-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please apply the patches from this series, including my own patch to
remove the 'To Do' entry from drivers/cdrom/cdrom.c.

As previously discussed, Paul's block patch is included in this series
too, and I've fixed it up to remove any parts that repeat changes
already made by others, so it merges cleanly with upstream now.

Many thanks in advance.

Regards,
Phil

Enze Li (1):
  cdrom: make EXPORT_SYMBOL follow exported function

Paul Gortmaker (3):
  cdrom: remove the unused driver specific disc change ioctl
  cdrom: mark CDROMGETSPINDOWN/CDROMSETSPINDOWN obsolete
  block: remove last remaining traces of IDE documentation

Phillip Potter (1):
  cdrom: remove obsolete TODO list

 Documentation/cdrom/cdrom-standard.rst      | 10 ---
 Documentation/filesystems/proc.rst          | 92 ++-------------------
 Documentation/userspace-api/ioctl/cdrom.rst |  6 ++
 drivers/block/pktcdvd.c                     |  2 +-
 drivers/cdrom/cdrom.c                       | 38 +++------
 include/linux/cdrom.h                       |  1 -
 include/uapi/linux/cdrom.h                  |  2 +-
 7 files changed, 25 insertions(+), 126 deletions(-)

-- 
2.35.3

