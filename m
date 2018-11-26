Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51834C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E095E20659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t2uaO7cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E095E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeK0Dai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:38 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:43525 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Dai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:38 -0500
Received: by mail-io1-f42.google.com with SMTP id g8so14442248iop.10
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=BabmGWQzqNAwdsICxbJ+D+vbOudaTWcl1/+nmNU0djA=;
        b=t2uaO7cN+NTJF6iwQ3T8Y88ttXsbfXXThlaNSFewcqBVqHn3qGmynj1RS+u9Kd+lEZ
         Xn7vcHU3dFPPe33AUyQMu5P7P0G0grszm0PuB85s5j7NUFHYVxdWIfucM4M40vIN96j9
         L8giIKdHsyM3XRH2mjv0p805D6ri8d9qcZPWyqgbVNKjKZQ65o1f3InGL/jPD3HFfLl3
         1tE7y1LftdmGzRr9/Snb8wBWP4cb2r6wUeTn3skkHbYOZwqQmO3iF0lV5TT2KUO5jr7K
         UkE/iyHXlkduxZduihKcwMpP3u9U0FWRoFeU5eM7BT+0H33tD7dyxiABLQmCkpRQH4pX
         F0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=BabmGWQzqNAwdsICxbJ+D+vbOudaTWcl1/+nmNU0djA=;
        b=BBGo0ctZBZcM6uJsrnw4fc5RxHqNpf9njuo6SMEPMyRb+AIbScCKd3Blw5Bt0nf9+P
         3GEtZmAA1hd1HEnYPNRQc9pK6JsMR0UOr4rThCI77/xGan+lXdYXE1fk9B9ckL+usORt
         JW0VXtno5VV6B1huDpy+an8qcXw8Zy2GEdbTVCFRr3tkvQdu8NQ70b5tj0jqTDFREI+I
         11JTOIrF4iuU1OrEt2IGBy31ZHBbRCoDHJZl8vjw3+5wpC3fuTaGcgD+a1CKvywmGMR1
         FSQN3ySy1baWEpa0Hg0eyHzUhk4KG/rf+FSIBC+0ExNmJWuVhyNzcakSPg6mk7Ag48MB
         dWuA==
X-Gm-Message-State: AA+aEWYeV02Dq8F4gf6ifz6Q9ec7Xwg4uFLotd78sfz8jGAIhUyPpj1V
        am05+Bv+90whk1M11gQBLi4ZRrwHuDg=
X-Google-Smtp-Source: AFSGD/XAH2HT6I9f424HpJLFY6eU8yFCq0XAX26u6VWR3wuMLPfs8gC7yMzJ4yPpAfImsZCcR+SrKQ==
X-Received: by 2002:a6b:b556:: with SMTP id e83mr11624271iof.195.1543250160676;
        Mon, 26 Nov 2018 08:36:00 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:35:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCHSET 0/8] block plugging improvements
Date:   Mon, 26 Nov 2018 09:35:48 -0700
Message-Id: <20181126163556.5181-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Series improving plugging for fast devices, but some fixes in here too.

1-2 are improvements around plugging accounting. Changes the behavior
a bit, but works fine for me.

3-6 add a ->commit_rqs() hook and implement it in drivers that use (or
will use) bd->last to optimize IO submission. If a driver currently uses
bd->last to know if it's needed to kick the hardware into action, there
are cases where we flag bd->last == false, but then fail to submit any
further IO due to other resource constraints. We probably get saved by
the fact that this happens for the case where we have pending IO and
that will eventually guarantee forward progress, but we really should
kick IO into gear at that point.

7-8 improve plugging for blk-mq.

In terms of improvements, for virtualized nvme, I've seen a 2-x IOPS
improvement with proper handling of bd->last with this series.

-- 
Jens Axboe


