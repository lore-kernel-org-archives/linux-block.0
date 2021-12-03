Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B94C433FE
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 15:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381843AbhLCPmA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381868AbhLCPl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 10:41:58 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A682C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 07:38:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z26so4161231iod.10
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COvGc91kGEx45CwbolbCt50nZ4xf97Yd3rcNs9kUkpo=;
        b=xMnUaRd4HMjguy5c5Z0KLiVvHtSPulNHRYEiePn85tGLYNxqTpk18iMj+as6k7+Ync
         KxAOzXRUEljQ1YPimhQ56NIiD+yeGc7BHiXF0fXZCu7j0L+as7tej76Wi9POKQ3PfQWw
         3RTh66wkVxcwF+mIZUwwp1mxWkgGF7B5JLiFMjgnd2uy0laKGXX+GoyLgB5cLSI49WpV
         rPWprGv098zmm/rnnzzOQVzjAwCHw0cFeIS63a3oYL6aNpQtlsK+6i3g+9fei23K7B+J
         XRwgla8R/H/+1pClATktoTdyo9OH+2H6h+cjB9EPzjT1MKCghsO6FCTS1h7UMtdH/Cqh
         zC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COvGc91kGEx45CwbolbCt50nZ4xf97Yd3rcNs9kUkpo=;
        b=uJ0zt9cC7jX+ppnrE9FXPk4l9MON1E6e9VNDOE6yW1dZO/pQdJjBh6fc+7GHnbwv+J
         EyHGK0WHvYJja4iD512cok9f5YRdAlxJelVsvTzA9ROQ99Oc5mWLRhBFcQR77xraZjWG
         tkVt+QxMf/b9TtBxenrm8qjxJcVgcAQVzqhJoJpg441xKvvlGGpYfIFLCOodcoTplKjQ
         wRMBDmEBrfOY8ORaUHWr8yvc4SpRYtBvxNLP3dwSUgg6SfAjSJUHKgGX133QvEoNLeDz
         HFhRB/fCHtEUr4auWPgEslns0+cq9t9zEF3cSL/+oBeD1o5VcwTNBipRYxKonr02F73v
         TvKw==
X-Gm-Message-State: AOAM531AtBV2wDhwZddjW64w7WWVPqjrTXLP6Q0OdR1cKOaflhxItnS4
        3NcJC5VM6G/C0HZRnPLpD3fcYtQTmh0YaqVE
X-Google-Smtp-Source: ABdhPJwIibvfxS4MNqPMZp/te522t9aVgfFV6W9Xh0e9E+AaH0vY953h8IG8L1lq+nhfPUAiumKXfQ==
X-Received: by 2002:a05:6638:3486:: with SMTP id t6mr24459850jal.13.1638545913925;
        Fri, 03 Dec 2021 07:38:33 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c15sm1753042ilq.50.2021.12.03.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:38:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHSET 0/2] Avoid unnecessary indirect calls for bdev dio
Date:   Fri,  3 Dec 2021 08:38:27 -0700
Message-Id: <20211203153829.298893-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

There really is no point to going through generic_file_read_iter() only
to call back into our own bdev dio handler. Move the logic into
bdev/fops.c instead and avoid both a function call and an indirect
function call.

-- 
Jens Axboe


