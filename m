Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbiANRC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 12:02:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiANRC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 12:02:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B5F81F388;
        Fri, 14 Jan 2022 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642179747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8GJYI5WCWxC8HWvDHEpkhu2dfFmREem4K0obUwKbBBg=;
        b=sfsEk+BXEyVp8b6kjoTO3yCItyNcUKaNBC51qXPyiqGmPRIf4dczLzydloDxjNzBLIKUxt
        E3Y/9SZ6aow92N3WIKCsOf73m/+T7zIlFDXr90ndGtER2hyaHyTykhxuDbIrH5QAMwnth7
        JykezgVMvwA+uKCNj4mUaAakkjK2AI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642179747;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8GJYI5WCWxC8HWvDHEpkhu2dfFmREem4K0obUwKbBBg=;
        b=DvjIzMGTNBkPyvzX1Okk0DnEWnQh5dqPtx9Qv13UTbCcr0r+yP/s1MpNalYPIhyfNDT0ls
        Plm9usKC+fhlQQDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC120A3B87;
        Fri, 14 Jan 2022 17:02:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 52E49A05DB; Fri, 14 Jan 2022 18:02:09 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4 v4] bfq: Avoid use-after-free when moving processes between cgroups
Date:   Fri, 14 Jan 2022 18:01:52 +0100
Message-Id: <20220114164215.28972-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; h=from:subject:message-id; bh=97F3bVWj+aD0Nvmi66BPKA+zZ6B8Rgb7b9bjJYi814s=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBh4axpo5cH5M/TAdH/qcnZs/jostAdLt4XjbpClIHQ u53XC2iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYeGsaQAKCRCcnaoHP2RA2TlqB/ 9Pjvgq2IDniwY6109iKKvbPVofDYY3/u/TYvT/XEZp0YPw/Ulqf7nNBekKi7PaDHOcCCAMEcF6C/sx bJe63BeRHjLlswNIYvGMSES3eKgDmeyVAADRleVknGM0ZFFslicF6dndHymvsjiY/UkarKi7EYqKzj ltsPOukf2bqKS4bMlkX/dfF4gdBRoDKp1MHhT3eZyM3VQEPPcCI+Ep1qJG5nwGiB1vR1EXnGozvcVx p5V2mq3vJeavE77xNhPfCC3F3IbqWZBeMrbKA+1Xmu/MTYTI/p7UDNRJW9ArUVibJ4OUfc02nwX6ig 9USV4vyqShbUJlAhJkUMNLE9F58YO4
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

here is the third version of my patches to fix use-after-free issues in BFQ
when processes with merged queues get moved to different cgroups. The patches
have survived some beating in my test VM, but so far I fail to reproduce the
original KASAN reports so testing from people who can reproduce them is most
welcome. Kuai, can you please give these patches a run in your setup? Thanks
a lot for your help with fixing this!

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
