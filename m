Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19921CDB482
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 06:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjJRG7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 02:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjJRG7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 02:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40BEA
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697612296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QceAaGz8QFib7qs3wWJh0gmuzZcVhllRWYFNw//CH5U=;
        b=elQ18Oehek2dSg4qBZZcdcvPthmicZaZMcMX/GPZm/+D2HmvNT0+HMJhaX1wOy4nV3euGL
        vOuI8pvcyAk4OnDFiKseDaaWL+TiJQWcgTlFFU3KYO7jB+TmGPex2n3SLg7ilVvRfmLnKZ
        ubNyP9fWQ+dndKXNcJ+HKP2yp8BECD8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-z9n3-P8kP3G5q0IGM8s7pA-1; Wed, 18 Oct 2023 02:58:05 -0400
X-MC-Unique: z9n3-P8kP3G5q0IGM8s7pA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1c8c1f34aadso8881711fac.3
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 23:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697612284; x=1698217084;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QceAaGz8QFib7qs3wWJh0gmuzZcVhllRWYFNw//CH5U=;
        b=f4p2+bOG6sfF3NSMrGEey6jneA1ZtysuPMoM7F8Z8zSy19MlXAgqEe8UVsCD8ptxit
         dqStswQOiGf5BgkLVoW7MT18evXWdZRrRWT+q4yvJSJf8X1w8W5z+SvFyfvrE4Jo4Fgg
         K3Al6OE0huFRStGMlPqlLhRv5byVOcG+LOk0Zpqx4cT4N+J35tg24CUbM80Ts2aUVoAz
         ZaycGSYvn+LIjOp2cACr3VRXIauGqIqcdR82fmkvQpAtIoUF9LTDUK7ejmlu3F6bdIL9
         sCv/54YnsGn8Ff/bGdJlJQOi/9NVVgTrm1y2URk2xztlMLpohtA67TuYAs/9MCvZPKqf
         PKaA==
X-Gm-Message-State: AOJu0YzVUCP1AIZqbftnKa8iVR63nJs37+oL44sUiKW9fBb1fHBrHnHC
        c0y93n9DoZDrOse7OafwqovCunwjSJ/AcjloH2uKKYKu8ebCr9RnS/91rv3DFUnBOQnEY5VZ4jx
        Dwdv/hBcu07NvLbgIJz67tA1V+2RlUWTIEKJtODSju58/NHasVLN/0xs=
X-Received: by 2002:a05:6870:1b1a:b0:1e9:c59b:a9af with SMTP id hl26-20020a0568701b1a00b001e9c59ba9afmr4499541oab.15.1697612284212;
        Tue, 17 Oct 2023 23:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZQwuZ9AVf4q6Nr0ZrOE5VZqFMDyTMT1rLOJZLSbGUmbyXFPDYSjWqhEgKsOmu0skCI4Mul01uDaCEJ3n6c24=
X-Received: by 2002:a05:6870:1b1a:b0:1e9:c59b:a9af with SMTP id
 hl26-20020a0568701b1a00b001e9c59ba9afmr4499534oab.15.1697612284009; Tue, 17
 Oct 2023 23:58:04 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 18 Oct 2023 14:57:52 +0800
Message-ID: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
Subject: [bug report] nvme authentication setup failed observed during
 blktests nvme/041 nvme/042 nvme/043
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
Just found the blktests nvme/041 nvme/042 nvme/043[2] failed on the
latest linux-block/for-next[1],
from the log I can see it was due to authentication setup failed,
please help check it, thanks.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-next
e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
'for-6.7/block' into for-next

[2]
# ./check nvme/041
nvme/041 (Create authenticated connections)                  [failed]
    runtime  3.274s  ...  3.980s
    --- tests/nvme/041.out      2023-10-17 08:02:17.046653814 -0400
    +++ /root/blktests/results/nodev/nvme/041.out.bad   2023-10-18
02:50:03.496539083 -0400
    @@ -2,5 +2,5 @@
     Test unauthenticated connection (should fail)
     NQN:blktests-subsystem-1 disconnected 0 controller(s)
     Test authenticated connection
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +NQN:blktests-subsystem-1 disconnected 0 controller(s)
     Test complete

# dmesg
[ 2701.636964] loop: module loaded
[ 2702.074262] run blktests nvme/041 at 2023-10-18 02:49:59
[ 2702.302067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2702.447496] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[ 2702.447707] nvme nvme0: qid 0: authentication setup failed
[ 2704.099618] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[ 2704.099688] nvme nvme0: qid 0: authentication setup failed


-- 
Best Regards,
  Yi Zhang

