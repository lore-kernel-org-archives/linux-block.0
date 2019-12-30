Return-Path: <SRS0=HKcR=2U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEAC2D0C2
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF93206DB
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gJvcpD4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfL3SPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:15:10 -0500
Received: from mail-yw1-f51.google.com ([209.85.161.51]:37281 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfL3SPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 13:15:09 -0500
Received: by mail-yw1-f51.google.com with SMTP id z7so14377185ywd.4
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2019 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FY9NvcQo+Ay221rC3tOOdmX1FXnP6b/qFNCKzOkIwK8=;
        b=gJvcpD4LG++K/r1KuvUVlIMKwXcRKulbd/78Q3cUaHZin1EtV7tWgd1fN31wzPcaG0
         XKIid+kMfhFqLpbvNebsK8j8G9qxZrc3sWg2DI19tnyi/e8gICBPNxqdnHg/VtbWVxjz
         IeTD7bmvLmnhjV7NxZe+6tAjffMo7vOLOFT2kmjFkjvmHQb9vSz4RHPSeW2BZ3kPE3sP
         Clo8Py/B51+ZnWsiSqH/guei/X/1ebmuBx+vUs3GTBtHcLhdyILKDXDdHn6mKJELgvxU
         WBO6foPiICB90nBWsletkREOzPF9Q8fKphtKE1wWyiNpq/I4/lpvFhP7vg5iJwbB5ctq
         LeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FY9NvcQo+Ay221rC3tOOdmX1FXnP6b/qFNCKzOkIwK8=;
        b=XtY+bbqCVYV9MFbxr6ZibR7FV6UEPTdCW9uWEGJ3Ka7r0pj3j3WpHVFsV8CDTDqjtc
         SunTvcN8+oosu3LCN1AZ9FVK8qCUYBV5ujUB0t+0NPNAwsxQfvlc2KkSQvgJcCOjd1p9
         CNo3dGyEjUMRuGcLgE9D/elwpn/n0/oxj9lvrrCql3QHbNuKWqXBu7yPiNZWXO5/a18U
         mzC7ooAPQDGXWhKqXLmOkjawmokDN+BezmeOhVBp8tHb8ld3ARFnVrNQO7vG3VNQph/6
         w5BdEmBxg3qgggzdPE9bKsmSqMk1TQivLSAcqIz+a+cBS9ccdv0FvMS1gAgEIjo6DdS/
         OP5w==
X-Gm-Message-State: APjAAAW6mtPbXzQQXczG3yPYr9SwC4xnyYWzGXiCefgnBTaO8l4kVdsk
        p98fIxHOzMXfhspN8QMysPfqF5Vq7lc=
X-Google-Smtp-Source: APXvYqw+X0D4dMXL1Ya9MgIMETiQwHOUdMPfCA4pz/iymhafvco1rVcAgIY3vbNXbgTjJLm2KU/Y2g==
X-Received: by 2002:a0d:ca14:: with SMTP id m20mr49824332ywd.251.1577729707276;
        Mon, 30 Dec 2019 10:15:07 -0800 (PST)
Received: from x1.localdomain ([8.46.73.113])
        by smtp.gmail.com with ESMTPSA id u136sm17879910ywf.101.2019.12.30.10.15.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:15:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/4] blk-mq: per-ctx tag caching
Date:   Mon, 30 Dec 2019 11:14:39 -0700
Message-Id: <20191230181442.4460-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is something I've been toying with yesterday, and got it cleaned
up a bit just now. It's still very much a testing thing, and there's a
few debug checks in there and items that need improving.

Anyway, the idea here is that we can reduce the cost of getting a tag
for a new request, if we don't get them piecemeal. Add a per-ctx tag
cache, and grab batches of tags if it's empty. If it's not empty, we
can just find a free bit there.

/sys/kernel/debug/block/<dev>/<hctx>/<cpu>/tag_hit holds some stats
associated with this, so you can check how it's doing.

I've seen nice improvements with this in testing.

-- 
Jens Axboe


