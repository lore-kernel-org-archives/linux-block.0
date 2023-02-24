Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B2C7EE2D
	for <linux-block@archiver.kernel.org>; Fri, 24 Feb 2023 17:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBXRIw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBXRIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2023 12:08:51 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A803717142
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2023 09:08:49 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id b16so5983354iof.11
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2023 09:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqo8qNqi+N5/4q9wV4jAbcOojx9t8qoKZECtfUPI608=;
        b=BTH/a92tSjDSm74B8PGZzxybKlGdDX+cpYLP9A0nTfF/O/my1ooflRDrO044U7JoBK
         NssORxp5O0BWpQmS1roEfCuwkbsgp7UFWv5ZoZAdlxqPccwDmi+tWODM9b+s1uxaQRyN
         4DRnuLxvok0WGBh5JrkjqZZMhScMtu5QACz0VV+V0Lt/SzrAFSm8Te/tzekx+TXFXnrC
         7EGg4ZYL1kX2jnh//CIoAohGdhQxCKTyu++ZXUBacfVaV29VFfDPLcgya8Hd+v6SQ9xb
         TU0e3hubf8i/83XXIIKgmqwNhRveAv0DX5CQ7YZuNwVxXR8ONWQuyTAQGZbDIcbzC/IY
         FM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqo8qNqi+N5/4q9wV4jAbcOojx9t8qoKZECtfUPI608=;
        b=bmQDgMKpp2wlZbU8NhfaJksWh00aVvuKS4z+FDeloM3V482H90lyuMF2VCcMmbuMb+
         XcSdEX/RuqZET9Bn724PFNf7WyDjN6Sqpn3zYehIrN2Ra4n9IqjsPmvqbkoM9JBxYlPN
         P23AXf3JMP+YiCKRYjB/6YviAkr1YIo+DVt7sIqbmKnACxOcy3Imp+oYGrVNg37NwxVa
         CCje2NFQLE6uwZcoTE4W3cvQBcB3cljKZ3ygsfQz/k46n8G7h5vYdDw9u57va76poB9M
         Qt/mYzI9mTdkEwRj7VJt4H0dmXqv1HqA0BSUL+oaenUQuICTnNQbEo9ASJPb3iBGzaaw
         Em5g==
X-Gm-Message-State: AO0yUKUjt64WY+CI2EnyjYJVPF5bw6s7CFHmvgctCn2oK1fGvRZBNisK
        LbHTGYlC4R+gldDGvfmNbsRHzTnKpR30Nvfk
X-Google-Smtp-Source: AK7set85gZuoruvbnkSRo9l4fpS6Hhf7ApBD2sNaKtlX0bai3LPUPs47fMTuxJyKVxpR1oYpbu8QTQ==
X-Received: by 2002:a05:6602:2d04:b0:740:7d21:d96f with SMTP id c4-20020a0566022d0400b007407d21d96fmr7820028iow.1.1677258528428;
        Fri, 24 Feb 2023 09:08:48 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a1-20020a92d341000000b0031535ce9cc8sm4166018ilh.83.2023.02.24.09.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:08:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     kbusch@kernel.org
Subject: [PATCH 0/2] Polling fix
Date:   Fri, 24 Feb 2023 10:08:43 -0700
Message-Id: <20230224170845.175485-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We ran into this issue in production, description in patch #2.

-- 
Jens Axboe


