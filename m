Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6ECEB64DC
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 14:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjGNOnN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjGNOnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 10:43:12 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEBD211E
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 07:43:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-78706966220so17382639f.1
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689345790; x=1691937790;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWKyfVnTo9keEWdnOsZubv8UiGUI0/zLvzj+cMsPJSA=;
        b=I15G51edg21R5PB8z+dF/pf35y06tFaPzcRTHbk34F+YpVnwRSa0dEIuHIBGzViVp2
         NLMQ0tmTUOwBTRzNHGcYbxEf79IKW5kdOsobw8NqbqPi56Lbg8XzcvdRF3dxfxb2j44H
         19tD4/5i4MR7F93hRvjJRTqPnYGmK+Bohp9mPKdftmNpDI6yCJFwI5wDqkwzUJB7NGv0
         ujZ5pPIgeFVVVpW+fWKckG+JowGvRaaSD6+YJVn47m6PS/vd2GZA2gGYVd3xLoc9LbOC
         /YTC8HTWxYKUrXLwz06Dlxh+D8K6UCguPDf1GH4Hs8+bz3vxi6BcKFo80grV4MdjgEYO
         6Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689345790; x=1691937790;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWKyfVnTo9keEWdnOsZubv8UiGUI0/zLvzj+cMsPJSA=;
        b=ADgxPXBG0+CbglQXhoZ1IzEfPH9gJm9Yb01mZq8d8atBczDbN3cXIZJx7Vs7OBSu5X
         4ukLWbz/nktJfiY/Y2qm6motf1/dUfF6J+zzCemJJF3ThdyAFpBfiOctw/eotYcCNGfm
         wCD6/oL/kRY3bLV12GNKLX8BETqbhnlnF9T3W3Hd+0ZqdVhJqhG4HcDShas2qbP052Hh
         hg8QVKOdNqhOlLtsTKalrxh4BokBYI83a52gcJ5zmRHTB6mh2FV5mqdxco5YHw2qucYv
         z943tRebLVuhCX0XOAZLQ7RPjvwk9R32kicm938pMn8rQs+dWSC2yU7kQDSMa6wLaulE
         Dexg==
X-Gm-Message-State: ABy/qLbAqPXJA70rXHgLHll/+trMpmbdfDFpZFkIndfC0PFA48CO06uS
        n7Dd6XdgV7GG24NRC6Uyt7DB9gUwbwRbdQIKBps=
X-Google-Smtp-Source: APBJJlHVJKmj+E2KnEERyaoGkjpkC5DoSgy3ONsSfwgHe5Br3yUEdIQNt7et4miX5bihSTlcnLdEaw==
X-Received: by 2002:a05:6e02:d0c:b0:345:ad39:ff3 with SMTP id g12-20020a056e020d0c00b00345ad390ff3mr3547275ilj.3.1689345790281;
        Fri, 14 Jul 2023 07:43:10 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id eq23-20020a0566384e3700b0042b0f3f9367sm2674511jab.129.2023.07.14.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:43:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20230714143014.11879-1-hch@lst.de>
References: <20230714143014.11879-1-hch@lst.de>
Subject: Re: [PATCH] block: queue data commands from the flush state
 machine at the head
Message-Id: <168934578924.629147.8177263853403805751.b4-ty@kernel.dk>
Date:   Fri, 14 Jul 2023 08:43:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 14 Jul 2023 16:30:14 +0200, Christoph Hellwig wrote:
> We used to insert the data commands following a pre-flush to the head
> of the queue until commit 1e82fadfc6b ("blk-mq: do not do head insertions
> post-pre-flush commands").  Not doing this seems to cause hangs of
> such commands on NFS workloads when exported from file systems with
> SATA SSDs.  I have no idea why this would starve these workloads,
> but doing a semantic revert of this patch (which looks quite different
> due to various other changes) fixes the hangs.
> 
> [...]

Applied, thanks!

[1/1] block: queue data commands from the flush state machine at the head
      commit: 9f87fc4d72f52b26ac3e19df5e4584227fe6740c

Best regards,
-- 
Jens Axboe



