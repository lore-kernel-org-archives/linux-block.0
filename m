Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB9C433F5
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 07:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928AA61875
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 07:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348788AbhI3HqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Sep 2021 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348701AbhI3HqS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Sep 2021 03:46:18 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39385C06161C;
        Thu, 30 Sep 2021 00:44:36 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4HKlcy40WXzQklR;
        Thu, 30 Sep 2021 09:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:from:from:date:date:received; s=
        mail20150812; t=1632987871; bh=0oOhnY/84xZj6hK/qrECeQA+ibgdAdY7+
        4wyOChyhlE=; b=PlVz50NXqlVhr74M+/SC8c0I7qwBxRINtuv6HNzxwSPu3HgOR
        I4wMMcvncB8Nw3J4pcW9yrtwTkgjCDRMn1hdFa8MQc8Qh6SL8Alk8IcrDiE9+0GH
        WOsGN6fslFsTeiIqiJ6qwy6WS1Z8l+IttseggERx0DeQITBlX8IGQw+6fuNDDRY0
        lDoYaYYZRZ7SynFp4SQLTWvG8T1coLmAJxwlSmK2ncKU473F37dmksBSMuJBLKEo
        5AIgMUptHjwOzw/2fk+rUr7IMf+RMqKSvaLLWWroAUIvzRxpsUBkN9a3Z9QpUbJs
        iLA/DAV404sZwCkEyxLTGUqfW9eGi/1JPsKdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1632987872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mcVKbCcSwBUudoYGAJZwo16RXU+ZQDQ9wrZUU4fk9g8=;
        b=KRk5bvZ72gexKynBoyFySR26LkfZEF7Mq0/K3WCAZ6O1ESgs9xpytdkHaoVC4ylmbHF2FW
        mser7shUzJi4rgN+G4RNEavdM2JM6T/2IdkxE7KN/QxTKkUqu06XRL061fBWPh410diLEJ
        SidKCiPD3Lukdc7/ft57HxMWUHg6Tn1exphKap5TATlVUHq1LYO2r4GbrEZDuXr9TSy+hC
        suLQ62vazWS48ODNK68UFaCdQ18AbcdWRk4+elbWsv5SmzX9tMk/vKxs3l/KLT2aqPftl9
        AamO6H2VLjE693f+mCcXxvSAL0BnRyUo/v0lTqvUVIKbLNtV3O/pv/9EI29MCw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Thu, 30 Sep 2021 09:44:31 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <1624640454.149631.1632987871186@office.mailbox.org>
Subject: [BUG] kernel BUG at mm/slub.c - possible BFQ issue?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 9A24C26B
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I encounter a hard freeze on both 5.14 and 5.15 when using BFQ.
Unfortunately, I do not have a full error log, because the computer
totally freezes and slightly corrupts the display, so it's
impossible to read the entire message.

However, what I could get is the following:

  kernel BUG at mm/slub.c:379
  invalid opcode: 0000 [#1]
  RIP: 0010:__slab_free
  [...]
  Call Trace:
  bfq_set_next_ioprio_data
  [...]
  bfq_put_queue
  bfq_insert_requests
  [...]

This issue appears more or less randomly and it sometimes takes a
little while to reproduce it (running fio helps).
The call trace always contains references to BFQ, but they are not
always the exact same. Once, I could see on the corrupted display
the message "general protection fault".
I could reproduce this issue on two computers.

Not quite sure but I *think* the issue first appeared somewhere around
5.14.5 or 5.14.6, during which time BFQ only got the following commit:

  (88013a0c5d99) block, bfq: honor already-setup queue merges

5.13 doesn't seem to be affected AFAICS.

Does anyone have an idea what is going on?
I will now revert the above commit and see if that helps...

Thanks,
Tor
