Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AC3C43217
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 13:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1C561350
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 13:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhJROAl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:00:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38716 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhJRN6h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 09:58:37 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634565384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TNy5fx37MKIeMOmCqNas0TQAO/g1wIjjEHw3s3354RM=;
        b=tbHm/3mZsoyFzzgrDd6ThmBzgj3iwkXMY+JcrlNNSqJoE5jU1Xr9kc2jA+Lr73U+ZmDrZw
        qsyDl8CCJzkXoOOZJA8SO8jsvgWyipkoY0GyV4t7nEcT7HY0cQsnLfpeTdVS8QEw965+Ge
        Db8UJ/oYE9tiGm9nbr6oYoYxTmyNa+fuMif0Ff8Y54kgL447cQ8wYWkdc0QH6uoZRTavvL
        etZlVX/oLJmzR07VI2LMRNp4ReWDlCcyMwXMR8trGs05BQkQEofpDPBI6+5fNvrK/BEpQP
        R5x9zzd3K2VboF0lOCzQLr2vBoYeSv0kLbbouXvoyTjrigeib2d2opgALRckXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634565384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TNy5fx37MKIeMOmCqNas0TQAO/g1wIjjEHw3s3354RM=;
        b=jeY8lzsUIPx3h6DIxAYPeBZJMkr0rVjt+7UjB+skHHFpDt2h1EVdobD4tcTPEzYGnis2Iy
        6YL2l2Bm/CbO8fAA==
To:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/2] blk-mq: Allow to complete requests directly
Date:   Mon, 18 Oct 2021 15:55:57 +0200
Message-Id: <20211018135559.244400-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v1=E2=80=A6v2:
 - Drop the SCSI patch for now.
 - Make blk_mq_complete_request_direct() call the completion handler
   directly instead going through struct chain (Jens and hch might had
   the same in mind).

This series converts a part from the MMC layer which completes the
requests from kworker/ preemptible context. Its intention is to avoid
going through the softirq stack in preemptible context which would
involve the ksoftirqd in this case.

Sebastian


