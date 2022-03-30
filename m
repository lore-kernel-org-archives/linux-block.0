Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C22C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 12:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbiC3MrC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345481AbiC3Mqk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 08:46:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B507DE13
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 05:43:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 33DA41F869;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648644181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z+uS0pug8qlE1UIZJxUAjv/Gss7+HiOe8n3DHdJt5Ss=;
        b=aIY46G9dPLLPFhTK/0Wkeom6zXr9VmcPx+rU/AmlRZauY4mu7118mbfOerx0ca7Z0oCBjO
        MylmEt8uQdSm9LSNVb9a43gmFhGir+cpYbKZ+IMU0WUY6oVtgXWcupZ15LQVE5IwLZ5GuK
        lMu7wEMrXUTcYTZrqLqma4ZoZuD/ld4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648644181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z+uS0pug8qlE1UIZJxUAjv/Gss7+HiOe8n3DHdJt5Ss=;
        b=PO00s8Etsx/3ZAuYYnIZfG8U1F2KhAd6pTtZ/SY4HI2prZ/hZy2BUKkvOnPaMTJIrVtZBz
        DIFfsn+B9SVKWTBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 22468A3B97;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 278B6A0610; Wed, 30 Mar 2022 14:42:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/9 v6] bfq: Avoid use-after-free when moving processes between cgroups
Date:   Wed, 30 Mar 2022 14:42:43 +0200
Message-Id: <20220330123438.32719-1-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; h=from:subject:message-id; bh=V89uFR//wiCzBy7grZ6ClpXNmKr/VfcrYFFBU5Rndic=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiRFA+J0ukLPqN28pzrtYZ9CmQzxsBu+F3YSj48bFX T4apRJGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYkRQPgAKCRCcnaoHP2RA2SjbCA CRG3kWM68snncdgAPV8PquC2BRlBfFuQh421mUE910paLsDGiWMFAWPQjz4jqfHC9JrPcoLP2bJ0jm PiezDCHEetOLyqr6jOebi6Wv8ju7uf55r7r4VHeZ1V3slGf1OWliNLmPeiUwSzXfImacvFtSCt5L+c Pwg0IwaphWg3Y+gYbQWvK+nuUKIGrlLfwKBimhHzfDnxN35yKVA9LWCU/DenNounFvwuxx9vxmFdNZ Kjm53fd5Pm6NtC83+5mZ0X+ynYsxwG4BWzG8+TASqJnFvCUgKcyHMDeXFSNjmN/3GtNFaLv48+57jW vyKJSXMhkzpO48680TO0RCgFAil1r2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

with a big delay (I'm sorry for that) here is the sixth version of my patches
to fix use-after-free issues in BFQ when processes with merged queues get moved
to different cgroups. The patches have survived some beating in my test VM, but
so far I fail to reproduce the original KASAN reports so testing from people
who can reproduce them is most welcome. Kuai, can you please give these patches
a run in your setup? Thanks a lot for your help with fixing this!

Changes since v5:
* Added handling of situation when bio is submitted for a cgroup that has
  already went through bfq_pd_offline()
* Convert bfq to avoid using deprecated __bio_blkcg() and thus fix possible
  races when returned cgroup can change while bfq is working with a request

Changes since v4:
* Even more aggressive splitting of merged bfq queues to avoid problems with
  long merge chains.

Changes since v3:
* Changed handling of bfq group move to handle the case when target of the
  merge has moved.

Changes since v2:
* Improved handling of bfq queue splitting on move between cgroups
* Removed broken change to bfq_put_cooperator()

Changes since v1:
* Added fix for bfq_put_cooperator()
* Added fix to handle move between cgroups in bfq_merge_bio()

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # v2
Link: http://lore.kernel.org/r/20220112113529.6355-1-jack@suse.cz # v3
Link: http://lore.kernel.org/r/20220114164215.28972-1-jack@suse.cz # v4
Link: http://lore.kernel.org/r/20220121105503.14069-1-jack@suse.cz # v5
