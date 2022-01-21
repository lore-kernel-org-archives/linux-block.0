Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB371C433EF
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 10:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380047AbiAUK6U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 05:58:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52616 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380041AbiAUK6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 05:58:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AD03421979;
        Fri, 21 Jan 2022 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642762696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CVki/tORxYWB0yfTOzHKLuqZiYWc52U+vcguy8bPxlU=;
        b=AntGbxYcg9VYnGv4At4L+CSFIIoStZBX1rAeT1KbkAXmNZmbAu+gN91znVDY9DFNkMIOeY
        dp/Jg0IOhzJRvvLc1u0ERVmPZCtKKtHCeFpkQkKvZlmge5620VydiwcKMRCX0z6Gqmn2n8
        920WHLdbNxlcgN/dvP7vfE2vMbmh0iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642762696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CVki/tORxYWB0yfTOzHKLuqZiYWc52U+vcguy8bPxlU=;
        b=nLWngni37UbW8RZyYsYDMh/qMKoAdYYLpyJpe7mCZEuUogGapOCbAIVT1JhfjH505AZA3H
        8zEgwFbN24KzreAw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D9F6A3B88;
        Fri, 21 Jan 2022 10:58:16 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2A51FA05E4; Fri, 21 Jan 2022 11:58:16 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4 v5] bfq: Avoid use-after-free when moving processes between cgroups
Date:   Fri, 21 Jan 2022 11:56:41 +0100
Message-Id: <20220121105503.14069-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; h=from:subject:message-id; bh=pMj4pA56npl/w9TuywwO/aFKmHkl2WDMxLbDQubiaZA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBh6pFiPJQ0WSeYE8JqHr97kTS2P3Bv8mhJHy69zM08 xZ+TgsqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYeqRYgAKCRCcnaoHP2RA2WE5CA DoQ+gmiOlH97Z0ouWOmWGrdIUrUuPUpH1S2B1WL8O/zVQ4XSikglUuenLKSwigH4bfl8KYxqnmu0hJ OATRRGytFbOp5iWhMBTE+IwjiGCSiu/MJwmlj5hSJy95lpi1GmR64nNuO+NiStTS/Ch8cZpuRLR6i/ J/pYmnpReFH/FcbQ32beopP4wi85qt+aP1rR95D2EN9QqccqNSQMQyi4EKalolkDxCXNwuzxDI5KaL 9/Qibw8x/9g+ruZTOiyaz5QZvvP35Uj9AxgFgh6vtKHmmRbktvb8VugpKfC7xF/V4YflJjGuuEzrbb V4KiBm1sJwUvIJ81GQkb+lpRtR4Omr
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

here is the fifth version of my patches to fix use-after-free issues in BFQ
when processes with merged queues get moved to different cgroups. The patches
have survived some beating in my test VM, but so far I fail to reproduce the
original KASAN reports so testing from people who can reproduce them is most
welcome. Kuai, can you please give these patches a run in your setup? Thanks
a lot for your help with fixing this!

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
