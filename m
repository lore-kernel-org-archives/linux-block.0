Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF516EB64D9
	for <linux-block@archiver.kernel.org>; Sat, 17 Jun 2023 11:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjFQLic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Jun 2023 07:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjFQLib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jun 2023 07:38:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D819BE
        for <linux-block@vger.kernel.org>; Sat, 17 Jun 2023 04:38:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8d1eb535eso12452695e9.3
        for <linux-block@vger.kernel.org>; Sat, 17 Jun 2023 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1687001909; x=1689593909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaLHMANTlFxz5pDEw8B8VWAUhy20bV6DED3efN5fhM4=;
        b=1p81pXukbRCxGMSIwz9Bv3gVaRHn0hhKeaKKZW6lSvZqe/ZZefO7zRLSqnAXD7o38h
         a9eWWOFUVMGvaxx2aMLax4GyBZgYOPHhWV0kmBd7G/zQg40Vm/5LBie5HGpdXnOzEBOi
         NE/6+v/1LavJ0b0hp0q/E4T9qy17DQe2qevN+Wgx/0v3hUMJGhLh9GQ35FsC6kyiX9pf
         wCYWwfol2a5HbqUoJXLAw9gElTLQnhWxUg586F7Wxjjr76nABA76udU2MieC+J7Pgq8d
         jhTtULSwYgr+cn1/Ie1goF6yfF5AAKZsd/kjRqtN7DVAJRO63s4TAHx3GqAuSHtN9AZd
         8+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687001909; x=1689593909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaLHMANTlFxz5pDEw8B8VWAUhy20bV6DED3efN5fhM4=;
        b=RnmyBXY0D5aFuBshHhC1AAYo3dGPkP1YTGPn3SgH0Ry/WMxITaNOybQeOrI3lIvrBy
         kqX7xtXH1bbMSH4wYb9LVsNGAXFd056yDNt+2eyQGqbsJbPMnXM4KG53DZ57rfHdcSKv
         yU6t9Zf3EyCNbZUn2fr/kIzcRrQvb1K8XcwWaRWgSVt5QPiQ9b6z+3HatgVMNrfYl8UH
         ctyVMpOM/hkwwd7MWRYJjv39H4VUCY35/myaBMknfylzle40EgiKbPEzkO/CfJRKF/gE
         mKrl+RzFWsIKmFV5CwhUusEDXV4oO5c71obIo9A+ZpD7ElOef45hb2nGLyyRBsqWSJmN
         NaMw==
X-Gm-Message-State: AC+VfDx7iA+tYbGcaOKQA37KwzXFpjCFukn4y+X/p+nJ1eybJQcv5Job
        OUWbr7vW7eY1+PUeupQHpv1r+RVwCcq9qn+yOAI=
X-Google-Smtp-Source: ACHHUZ4pz8K7b6TdlI512BNgOJDfvQdgF1FWLZV9oXuj8XP2/OCisoH5zi3pVekrHA1o0ezgSJvoiw==
X-Received: by 2002:a05:600c:214d:b0:3f8:342:d67f with SMTP id v13-20020a05600c214d00b003f80342d67fmr3654474wml.0.1687001908967;
        Sat, 17 Jun 2023 04:38:28 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c26-20020a7bc85a000000b003f7febc8fb8sm4748855wml.34.2023.06.17.04.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 04:38:28 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: spectre-v1 patch for 6.5
Date:   Sat, 17 Jun 2023 12:38:27 +0100
Message-Id: <20230617113828.1230-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please apply the following patch from Jordy Zomer, which introduces a
spectre-v1 mitigation within the CDROM_MEDIA_CHANGED ioctl handler of
drivers/cdrom/cdrom.c, to your for-6.5/block branch.

Many thanks in advance.

Regards,
Phil

Jordy Zomer (1):
  cdrom: Fix spectre-v1 gadget

 drivers/cdrom/cdrom.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.40.1

