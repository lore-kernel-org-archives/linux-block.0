Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFC9C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF76F2148E
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwJPw8xA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfDHOjy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:39:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51836 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHOjx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 10:39:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so14666076wmf.1
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+vmddB8EPhLmq89u2MDX4J7x+h19OXK3BtBDxYPEZc=;
        b=WwJPw8xAEIceR/RAgSlJfvmVrzLFsNxBW7XVR0W5p+8vhWSrJKspLoG+sJf0kL8acZ
         TYS58O94CPHohA6nEgo80lm9PkQJ9PhZq+V6kn75fE1CNdTE1cmY0A8GCUOzFXYhQz3/
         txc0lXgqfF7wyqJ6yfBfOrMiyVeW0p0ze1SY1FjRMrdiNH9T2nI+PicPBLGa+ZO2u2nN
         RCWdA/qxpm468U0baLl5yMd9SkgvE3Ls54jh7Yty8zv8KWvczWaIONOB9sT74jaqJMGp
         8KUex0dG8zUGF2vmo65XmMcKr18mMQTtkQ0FgiD+Wnkzd3zS46QLndD19TybUQ6xmZd6
         6Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+vmddB8EPhLmq89u2MDX4J7x+h19OXK3BtBDxYPEZc=;
        b=lEZzKgujx16dF6VbGbN1SrAHO23gU0WdSIcovqlmOvjsF5f9fwHbGQjT4nXuYCk7xa
         x6Z90SJIFTBcMS3bk4OAKgnkfT9Qytxe+x1PCufIe7lVUU7mKppEuf4nQ5e6XMHAwxvv
         77Fpgv+loss84GX4WinoLHG94LAIBiLGxzP0v5hLbhIqE+2IedH/L1LMc6nAGTSx54Ut
         1sv3PXFcnxMlxmbnO6TC3ZBklmGfVqkV6+JllXV8kNboq/C1gHS15JUFLEbMMpAXNEbQ
         5d/MhFTU0sKse1TEOeXhz6Q35E53ZlaBmm1plYTpUPr98avdpX5eHSm36wci1CpDUBP6
         UGTQ==
X-Gm-Message-State: APjAAAX5p4yeK1XwTUS9X6HU8IuxNhyvRkqP2oQQuIzBKAkPq9crjFXk
        3JfAc9kMB0Yz4Hbx8mc/+3Z1NQ==
X-Google-Smtp-Source: APXvYqy0BPBsNTRbbaFlj7z49mzU1KFW6cJADhIzMBdFRSa5SrGRBhF7ga6zE6qAHso4ANbG2cr3Ag==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr17467575wmc.1.1554734391893;
        Mon, 08 Apr 2019 07:39:51 -0700 (PDT)
Received: from localhost.localdomain ([88.147.51.116])
        by smtp.gmail.com with ESMTPSA id r196sm15113852wmf.22.2019.04.08.07.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:39:51 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/1] bfq: remove prefixes from cgroup filenames
Date:   Mon,  8 Apr 2019 16:39:34 +0200
Message-Id: <20190408143935.9062-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When bfq was merged into mainline, there were two I/O schedulers that
implemented the proportional-share policy: bfq for blk-mq and cfq for
legacy blk. bfq's interface files in the blkio/io controller have the
same names as cfq. But the cgroups interface doesn't allow two
entities to use the same name for their files, so for bfq we had to
prepend the "bfq" prefix to each of its files. However no legacy code
uses these modified file names. This naming also causes confusion, as,
e.g., in [1].

So we tried to propose a solution to enable entities to share
interface files for identical parameters [2]. But our solution didn't
convince Tejun, and we got stuck.

Fortunately, now cfq has gone with legacy blk, so there is no need any
longer for prefixes in (the never used) bfq names. In view of this
fact, here's an alternative patch, which simply removes these
prefixes, thereby enabling legacy code to truly use the proportional
share policy in blk-mq. This postpones the problem of sharing common
interface files, to when, e.g., some new proportional-share policy
gets proposed.

Paolo

[1] https://github.com/systemd/systemd/issues/7057
[2] https://lwn.net/ml/linux-block/20181119103424.3853-1-paolo.valente@linaro.org/

Angelo Ruocco (1):
  block, bfq: delete "bfq" prefix from cgroup filenames

 block/bfq-cgroup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

--
2.20.1
