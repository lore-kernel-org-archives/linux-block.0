Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36872C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 09:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E963206C0
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 09:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRQFT89w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfKNJd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:33:29 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36402 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNJd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 04:33:29 -0500
Received: by mail-wr1-f48.google.com with SMTP id r10so5630595wrx.3
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOgfq2BPgwHks2knL2d8OExj9QUX1YIgf8uJJjgKXdc=;
        b=vRQFT89wvdDqZwisq7/offwKGfwyWniNkpZIiDsHJfvxsQ1UbchI2DPpLn9lLAXRW/
         IFrc0SFhH9crtlUVQhLmvt9pwQbGARfBxuPjyMCFsyQKVmQIn+LfT7RgqRPpVyeK9rtF
         qd57I3IWoRGBlNfRNbG/9Z8X8v92PEjp24F35zd1AkaTfxUox8SfhqQXG4wNe/J1CnlW
         d/D4bM8spOpZ6gr8QnbUFjSFlozkfKlw/Wqme6hPJmZnAlcoIE81dAOrd/h4QCzH7uIA
         IdwUdTA7XprwXhyt7iuIzaAS5mwmRduXhWLuh9V9i1siyK33wm8fQ2svQ9T0Bs+5OIMJ
         rI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOgfq2BPgwHks2knL2d8OExj9QUX1YIgf8uJJjgKXdc=;
        b=A5lYIezuq55DMN18jds/hiA6n/I7isbwaRcH76ezJmJYR0NBGeTS7E4OoVQZ76A29Z
         lMSex3xUxCakgSoz0HiifM0Vzb5emJP3pBNCLPjLjk2ZOlfwjtY9aAqAx8bEcs120PPZ
         f+/0Sq0jlXSf0cBDmgZMG2enKDvtTxDEnIicV1TZ2Nm7D9oneVE5N1YQ2KFGEXbFU+Ad
         0mmUppJRyC9nA74rGNak/RM3kdarmR1HuxidKd7WI0dU0U+yQS+oVo5Tb0UmvYQ/jnTe
         bZt6DZOAzSBfPQpb3yheiCkVjpcX8fXeG/mySVIyQ3ILHTlVrql6AsVYsjDElNVIspyD
         7+CQ==
X-Gm-Message-State: APjAAAXiwTibigupLlXPr1QHlAweD50Abd6QASxlGZPWxjk92OpElgZN
        229AymezWVy3fvW8DQW3J42eFQ==
X-Google-Smtp-Source: APXvYqy3krbp6mthMNl4YSw918Ql+MakUswnHylyA3IVbydYKB9uj45ZzlRyWYZGgm2E6r3pnOfv5w==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4194906wrm.106.1573724007087;
        Thu, 14 Nov 2019 01:33:27 -0800 (PST)
Received: from localhost.localdomain (hipert-gw1.mat.unimo.it. [155.185.5.1])
        by smtp.gmail.com with ESMTPSA id j22sm7523409wrd.41.2019.11.14.01.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:33:26 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 0/1] block, bfq: deschedule empty bfq_queues not referred by any process
Date:   Thu, 14 Nov 2019 10:33:10 +0100
Message-Id: <20191114093311.47877-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
change from V1: added check to correctly work only on bfq-queues
scheduled for service, and not on in-service bfq-queues (it makes no
sense, and it creates inconsistencies, to deschedule an in-service
bfq-queue).

Differently from V1, which was still under test when I submitted it,
this version has already been tested, by those who reported V1's
failures.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: deschedule empty bfq_queues not referred by any process

 block/bfq-iosched.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

--
2.20.1
