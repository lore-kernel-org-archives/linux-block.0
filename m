Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C32C77B76
	for <linux-block@archiver.kernel.org>; Fri, 14 Apr 2023 13:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDNNtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDNNtD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 09:49:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F11EB745
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 06:48:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6684fd760so2601215ad.0
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681480130; x=1684072130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGEc3b/5raGNTqnY3atFX+H91beKu21OZnUAnPJHGEU=;
        b=PRCNOs6GU/xpOMG+nxtDhsoiJxRT/WjfvNlD0bgucODQD1Rvehi6voQ3b21mjQsVBU
         yeic93WvC3b+wbTYQKlu7u60WUfdlZ68iC+d5IshLbfc91LN5SZOHTfHGd6QyZkhOw1g
         D1eFSnhplB1oDGnFbJp33PahepyXh0WOe4+X4G88P8/nJpIRJCUCENfFGxrBS6M2XxkI
         nMhz/73K9riSNCqmRfJouvY0btKtKaS4yfha88hnllcvNV4XOi5XqWOv9m4hbcYmNm4Z
         O8gUI/019i4a8KXmYRrHTFfpQTGDpe+Eix8a+P+kBhxtSfFRam9Y7Te3Iu/jV7MexRLU
         2Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480130; x=1684072130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGEc3b/5raGNTqnY3atFX+H91beKu21OZnUAnPJHGEU=;
        b=FNcfSvxxwh+YFS9REOTnj7bkimiKGTuH0su2Plhd7Tk8ISfcc0+YBGWeANnBuh8TSU
         q5H5Uk00+rc70Z1atb6l80QGAUov+9H28cefqFPUyLy8gJs+6vibYNhwJqoK40cSaVW9
         4OsLH3lQ9Z2U0+Pca3YLoFtYUiqV3ibLYRIlhR8Eg+mIjO7lneHFQimRqhEqsIM9YY0F
         g+PraFZWvnSoCGKy+MX0CDvsrcfPTJxYKOlCsZEVFnX0ZcGQkok7zlK2qsLrePI/QdeT
         8O8deVJnvTmSPXuVoJFO1AyZXmjEhfaCV1xT8sUcbH95dUkvXvAorn1+jKLmanPXmvk+
         57aQ==
X-Gm-Message-State: AAQBX9fCJ49U4x6R8Ri9POpWoc6kcf+b2XeQ64mMvg3Oks91tmut+ohb
        gBWdpLqgS3v5xm0KlOT5UcBhAdDABB5RnS5pLic=
X-Google-Smtp-Source: AKy350byNln2Xu6FOPWUbpwyRDbnlNY3ig8slo0Rq48xAy7l4Q35RhY2+/MQXntaeXg3xxZMXtxrrw==
X-Received: by 2002:a17:902:cec7:b0:1a5:2dd2:34ad with SMTP id d7-20020a170902cec700b001a52dd234admr3001043plg.1.1681480130496;
        Fri, 14 Apr 2023 06:48:50 -0700 (PDT)
Received: from localhost.localdomain (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001a19bac463fsm3098980plo.42.2023.04.14.06.48.49
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 06:48:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/2] Optimize block_device utilization
Date:   Fri, 14 Apr 2023 07:48:46 -0600
Message-Id: <20230414134848.91563-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

First is just a prep patch that moves struct device, which is quite the
pig, out of line in block_device, and then shuffles a few fields for
better layout. It also saves 16 bytes of space in there while at it.

Second patch caches the bdev->disk->fops->submit_bio state in the bdev,
so we can avoid this long dependent memory load chain in the fast
path.

-- 
Jens Axboe


