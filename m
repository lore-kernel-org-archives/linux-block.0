Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84D8C35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7EC20661
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J55zZsRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgBCKlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35276 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgBCKlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 05:41:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so16328661wmb.0
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 02:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7kUAuYHK3HU7kgrmlP52Bgbfr7nuCCYrdhqJu7dVQ8=;
        b=J55zZsRJHqR8+iP6YWjkIN+xlOxkGVRI4uehq2z6qvNNbhJQl7aUnIeIL9ptoxLXqF
         9qtzDOApck2LDpnlePnZvfUkD4oBOVZSjQLEKq0/Q448jvTUrZmekKlBC6SaYVqRf1NQ
         Dl06qyULTlr/6dJ8rCRcGCg7fzFk/B30tfUZZHqynDOMfkKohzX+F94DnibrYrkGVzML
         qySpDmAkLOcFYh07DJIv7f2pxY6Y8qXk+PfuLmCD+bhzh33S2FhcCSZZbDmCBeK2YNyL
         5Qe6TSUDERIUBAIISKv07hAdNEiNW/jJ4Y1wBB5rLqISOJg4PINcK7wUp349JgjjqqUa
         XnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7kUAuYHK3HU7kgrmlP52Bgbfr7nuCCYrdhqJu7dVQ8=;
        b=EWy7lc+cLVgnZBAmGkUgRJaqDbOjr3mwN/mv1dHr2hZAntIGs9Us3bJ9SVtcz0G+sO
         ujV4zEP3P02zUe1Okq+qt43bjw6c1oelB8E/eQpdATigrFGDXMa4D2swUDE0tKZRJ/zn
         VfZQiLRRgy0lPF99a+HPABSecElytNzZm/LVhx1MFido3IQz8Vr5ogXrTbRbHflyBdLR
         t7Pz7lya6wSGWRUvl9UPAnBcBwf406ZweD+VpD82zEkMtt1pChIz/+A2G9fLC7XdUxjs
         EZI47MkmA9rSU+ZhmpGUk/yWSVjPojucKEuSHQF3v1Ls3YwnlNGMo0PjTn/2DTl8bsp9
         K18w==
X-Gm-Message-State: APjAAAXbR93eUi6XS4BfaMxLTnrrl//lzs42yGakD2AKOX2FWgQZQTON
        zWkOuYmXxoqTiO6Q1LX0Rd05Qw==
X-Google-Smtp-Source: APXvYqxlzkNiELVOe6HFuEvkKPhG/U8qjsN+TV7x9MnYHIj6QHkawmzKn3HRfbvnMAZXZ5vUug/GNQ==
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr28672434wme.56.1580726474686;
        Mon, 03 Feb 2020 02:41:14 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:13 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 0/7] block, bfq: series of fixes, and not only, for some recently reported issues
Date:   Mon,  3 Feb 2020 11:40:53 +0100
Message-Id: <20200203104100.16965-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
this the V2 of the series. The only change is the removal of ifdefs
from around gets and puts of bfq groups. As I wrote in my previous
cover letter, these patches are mostly fixes for the issues reported
in [1, 2]. All patches have been publicly tested in the dev version of
BFQ.

Thanks,
Paolo

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
[2] https://bugzilla.kernel.org/show_bug.cgi?id=205447

Paolo Valente (7):
  block, bfq: do not plug I/O for bfq_queues with no proc refs
  block, bfq: do not insert oom queue into position tree
  block, bfq: get extra ref to prevent a queue from being freed during a
    group move
  block, bfq: extend incomplete name of field on_st
  block, bfq: remove ifdefs from around gets/puts of bfq groups
  block, bfq: get a ref to a group when adding it to a service tree
  block, bfq: clarify the goal of bfq_split_bfqq()

 block/bfq-cgroup.c  | 16 ++++++++++++++--
 block/bfq-iosched.c | 26 ++++++++++++++++++++------
 block/bfq-iosched.h |  4 +++-
 block/bfq-wf2q.c    | 23 +++++++++++++++++------
 4 files changed, 54 insertions(+), 15 deletions(-)

--
2.20.1
