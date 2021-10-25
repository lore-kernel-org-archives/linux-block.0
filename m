Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9736AC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9B260720
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhJYHJY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:09:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhJYHJY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:09:24 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635145621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+xRj/RFeDSYLUfrOMWwjE0Md0VzxsD/tjTPIXybBD7Y=;
        b=d7VIuOigwNIs1/+xPxXrjZMAtd4Zwzf/gEZJTsuvrLQoFv0FDEA53A4HHjfjul8L+23CQi
        RWM181APdtNjIQ34txIArYJiOb6QFv4U69ePQ35OwATVgLvjql6KsVZ0IsGgLLmrdv3UPI
        YCgr42f/eJAnsndsP+/bT5Rg+6NbZ2I6fS+RPTJTHu0hXLCO4np3qScrTKHGgw47FCrUZe
        /pB0ouGEU8fQ5kjpN35vC+kYZ9n/W2vkCqKXl4eFnG776pNpAbnUrRQP5V2/dLdJpkmUMy
        qMzwW1n6IC7HWklJU/98cAmqGtF/tFlTSXWJRyvSHiM9vB7DIbo0r9qF8X+PJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635145621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+xRj/RFeDSYLUfrOMWwjE0Md0VzxsD/tjTPIXybBD7Y=;
        b=AOZBVQpoDD7SOQTC+avwBOJGEMr8KPZDJC/YWFllcYliwvx33YZBtLX2DXktaq9PDlL4co
        y12s7oVLoMVleQBw==
To:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 0/2] blk-mq: Allow to complete requests directly
Date:   Mon, 25 Oct 2021 09:06:56 +0200
Message-Id: <20211025070658.1565848-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v2=E2=80=A6v3:
 - Align arguments with the begin of the function name
   (blk_mq_complete_request_direct).

v1=E2=80=A6v2:
 - Drop the SCSI patch for now.
 - Make blk_mq_complete_request_direct() call the completion handler
   directly instead going through struct chain (Jens and hch might had
   the same in mind).

This series converts a part from the MMC layer which completes the
requests from kworker/ preemptible context. Its intention is to avoid
going through the softirq stack in preemptible context which would
involve the ksoftirqd in this case.


