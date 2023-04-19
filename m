Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E05C77B73
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 16:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDSQIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjDSQIE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 12:08:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA91C358C
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a7111e0696so272825ad.1
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681920482; x=1684512482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=toVfklchumbtFrUnA8SGKenhZ6u9CN2GQvMh+PIxLnU=;
        b=25Pak+4kHlmsORoGLLv0Z/iEqWUnupCNDEZYeTJpRP0o+NlEtqRqKXoDFmYgKIHwug
         pxNHPqZNWc33Bj0jN1RBYMucAq355eJPcYFz9gJoaEbIXH3cHLCkYxcNs8GtLHsc/k2g
         CAvukhZKhF1dhsgPVlSmiQq+7N+/8BteV1Xw4g0bzr+o32zzAfPxoJiONDLapyVHEP9d
         ryNmh35ESsqO/oLjkx43qtPszwGSP9kXu+dbtZgxm+k/wAJ0wQTft/EIWzB9jsbhhaHo
         sykuKcScu1Dk71d97Ntk++nDKZtVN7S4slvRJ2y94lFh7xjAOPP0DBxwg5wGs7VfsGR3
         R/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920482; x=1684512482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toVfklchumbtFrUnA8SGKenhZ6u9CN2GQvMh+PIxLnU=;
        b=YgFORaDm6FoSEynU4EMDVpEd+NitECL9cx20cOLVZ6Dh1xuEKXr4r03PguF0dxNGp0
         DDxFQpPSOeQ8orISr5XZs7P4ubeWaJpBLxF07TTNiSmUNobtj7X2QvsLCfqhdMsQEmYz
         Z3i260SMZDkXTGY9kfWNB72NII+F4WyfZzrTGkvG4n3YT2iY/xQOpdT6hG5cvDl36i0v
         /36hE1QSKoqHs6UZtuVm5sIflDbM15JjTQ5zfXxTA6PB5TBT5UzzvbBSCmYtAp5/cjbO
         IxNikK6GgLR38wdNX+762coaAION6iVs3szXtE0JhEMULvU4N8vshXIylGOJbg4kcpw6
         NiDA==
X-Gm-Message-State: AAQBX9c1gAMD0q/B+nOVjnoCovO+2b5/zdKdcXtUbs7Y+RiTGNZOHKUu
        wF7CIAak2w8axnnXiYtU5u0/9ZU9Vc8melNe7lI=
X-Google-Smtp-Source: AKy350YXBGA7Z7uePmF6aNqhjIxSITc+JU17mnAdW6x+y7w75rtI3MiAB3/+mPiAYPP3fUfOV6pldA==
X-Received: by 2002:a17:903:11c9:b0:1a6:6bdb:b548 with SMTP id q9-20020a17090311c900b001a66bdbb548mr22124374plh.1.1681920482057;
        Wed, 19 Apr 2023 09:08:02 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ik14-20020a17090b428e00b00246f9725ffcsm1566258pjb.33.2023.04.19.09.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:08:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     luhongfei@vivo.com
Subject: [PATCHSET 0/6] Enable NO_OFFLOAD support
Date:   Wed, 19 Apr 2023 10:07:53 -0600
Message-Id: <20230419160759.568904-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This series enables support for forcing no-offload for requests that
otherwise would have been punted to io-wq. In essence, it bypasses
the normal non-blocking issue in favor of just letting the issue block.
This is only done for requests that would've otherwise hit io-wq in
the offload path, anything pollable will still be doing non-blocking
issue. See patch 3 for details.

Patches 1-2 are just prep patches, and patch 4-5 are reverts of async
cleanups, and patch 6 enables this for requests that don't support
nonblocking issue at all.

-- 
Jens Axboe


