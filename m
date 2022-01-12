Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F997C433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 11:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbiALLjd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 06:39:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42134 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbiALLjc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 06:39:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B51361F3C2;
        Wed, 12 Jan 2022 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641987571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3lkonZ6Aw4Cz/VYixaXJgcvTIAUSEHJUQg2I3GG1RXI=;
        b=vNKoWGaWc9cPgvb1/kHWFxiH88WrPfeRQuwyUnVU2zruqQcCXQvLRqqBJm7fidqi9LqEAT
        7hIw0pJ6CPpeaLTC04W2CQ/TiBXDUk+eyQ8QR/HSETzIQ6HAn7VMX0DtlYrxdi9144uQF/
        jZI3H3AZ/MJC2GzghBi+S1NJk0sXulY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641987571;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3lkonZ6Aw4Cz/VYixaXJgcvTIAUSEHJUQg2I3GG1RXI=;
        b=os0W3HaGY8A7Huu1G9J1awfgsHyrPR1bfEx3OtliuvRzt+wRRew7Vmvg3X4+00Xn5rXKjk
        jFtfVsblyt2xTuBw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A1AB4A3B89;
        Wed, 12 Jan 2022 11:39:31 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B0593A059C; Wed, 12 Jan 2022 12:39:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4 v3] bfq: Avoid use-after-free when moving processes between cgroups
Date:   Wed, 12 Jan 2022 12:39:18 +0100
Message-Id: <20220112113529.6355-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; h=from:subject:message-id; bh=ZzDgina3UcfnZyi2haiDhvQli4PLOY4F/7PzSKebTc0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBh3r3fUpcmTOdCQKKr4HWvYZ6KEI3QquIjgheYJOIQ w/sQtTCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYd693wAKCRCcnaoHP2RA2UKWB/ 9peb9tKVPirI7HNpNE9rnObG7sHdEnN5jl9OvtJ0B7+58RZFyKd+tGYrUVyfLac+iBapOvAZz1yAUY 8RlexIq02YDmpeWJm8k8HqUAN1+god6RGe1T1PHCCWiG5FxReeRL4GbCwz878ixH/iyNnsinlb9tNm +P8MRVk5YqBaE733aoU5n9vHf8BGOEGH8TsMe0J9dwGJazDOWBvstoagTZJv6cvQ48hvEo17T/a1pW b/qfYtnq3G2uaJovWysqsczonnO/l1ji8YM4kjbmzbECU6u23AldTchKZoRdDyuQrqdoAvsb2xz3cb 1OaT+7PbYuoaHkrUUsTP9eoC3Tw4hq
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

here is the third version of my patches to fix use-after-free issues in BFQ
when processes with merged queues get moved to different cgroups. The patches
have survived some beating in my test VM but so far I fail to reproduce the
original KASAN reports so testing from people who can reproduce them is most
welcome. Kuai, can you please give these patches a run in your setup? Thanks
a lot for your help with fixing this!

Changed since v2:
* Improved handling of bfq queue splitting on move between cgroups
* Removed broken change to bfq_put_cooperator()

Changes since v1:
* Added fix for bfq_put_cooperator()
* Added fix to handle move between cgroups in bfq_merge_bio()

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # v2
