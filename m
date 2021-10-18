Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B99C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4E361206
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJRUjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhJRUjx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 16:39:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0DC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:37:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g10so3988994edj.1
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ScjnYJrnYsJGi8bKW5FD5mk/S52sUj+puormkyVC5M=;
        b=H47eQItovV8yiuOoBwCYEmz2pf37NZQlvouRBxRMfYUs8XEEq0yzZYPewGA4yyfsz1
         UVUScQqM2SkHB/ngdogwtgMelp1cxhOuLF+avvkwevbrN7YskNxJtluoBWzfxwvMLl3D
         Qr9OFO4imxLXMKb2Mcv/UEic4v7yDp3JTIOBIWWWjtZd0Edm+cwHxiz1CkcpZbXEH5s6
         X+3N4zcTp+G0ZLvpR8dN2i8m4ApGGeXefEYevplPypwZiJsXymYHZc2fltYNWK6dfnlH
         GZ0u1OGUdUusfSlSDVVPGa1rk0IbHdDCA9kQgZq0na+HxjQ8bGGyAGEPybWv0aN138wy
         I++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ScjnYJrnYsJGi8bKW5FD5mk/S52sUj+puormkyVC5M=;
        b=UW82fCqEY6+fOxNXA66ulc10kT8pSDUUX3xEM8XmJ1XUPHoGr//KqX2QsNOHq+VPN/
         qL3IpOdi+1lotniAXnkDvr+HtC7IvXddS2Ua9yW20uo957Dsa+L5OCmUr325un2+J5Mi
         tMiIXtJ2/8RubEYbO/ElGlcOckXOTtawlbLEdXhGxE74JjFLLnDmccOhySwWS8vLJbkr
         A9YF7QMxaxSFk3hREERlZKVYvaT7z5AckiC48QVbJxiEMvVRV3UtLKzzXwwyEn25eKyt
         jNrpY5JJ6+dEkUE9jN6Xgh8TNVuL8eOUWfjB7Svz5+aoLtrok6QCgQZFjsh7wISosYVv
         J3Yw==
X-Gm-Message-State: AOAM530Tj/tVh+tALT3JoiEvNRpMRwP+VA0X5+uqtKB8xj+cmv3B7CNz
        qtjh0Y4SBNw7FJffyexXAYzEuQpMhzWdiQ==
X-Google-Smtp-Source: ABdhPJyqtwHv8bDyX2COmp8e7gkEXb1EdlZMk5wn/1DAJbfLD/sgUV6XkZbH+lDcnuwhaLEb00YffA==
X-Received: by 2002:a17:906:5689:: with SMTP id am9mr32828716ejc.416.1634589459547;
        Mon, 18 Oct 2021 13:37:39 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.213])
        by smtp.gmail.com with ESMTPSA id y19sm11124889edd.39.2021.10.18.13.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 13:37:39 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 0/3] blk_mq_rq_ctx_init() optimisations
Date:   Mon, 18 Oct 2021 21:37:26 +0100
Message-Id: <cover.1634589262.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Restore the original version of the patches. Mostly the same as was
sent out by Jens, but those were squashed and a couple of details
is missing.

Pavel Begunkov (3):
  block: skip elevator fields init for non-elv queue
  block: blk_mq_rq_ctx_init cache ctx/q/hctx
  block: cache rq_flags inside blk_mq_rq_ctx_init()

 block/blk-mq.c | 54 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

-- 
2.33.1

