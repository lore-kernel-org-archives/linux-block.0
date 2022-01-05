Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397FCC43217
	for <linux-block@archiver.kernel.org>; Thu,  6 Jan 2022 15:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiAFPpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 10:45:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47272 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbiAFPpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jan 2022 10:45:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AAC7A1F3A6;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BcI+QJjDD3OtJ2tHbj6Ilu+Pnw3IRelph+zKAwqmm20=;
        b=TyMvYcDOlo64pzrB+hKB85k/oVbYGav6+Va73fHC2REC6deU71gWWLve6KcJLAIxCcLU1F
        OGhI+PW2LnpuY+faIqrh/HQhA8USplJUxJYHwFD6bnheNXHuIvwGtjYyocL1PsJpHFhD/p
        lJXXmNTk4KIs9Qs9Z/gMYXxwJFWxpJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BcI+QJjDD3OtJ2tHbj6Ilu+Pnw3IRelph+zKAwqmm20=;
        b=QSrX4uWWsDW80twmzhfZGqzJJ6+aI9thkqsnGtOgWN/HujZMPiIw81Nl6Bg5GmwOs95duH
        IvMEVqgYGrvkLzBA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99835A3B88;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id C4138A0831; Wed,  5 Jan 2022 15:36:39 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v2] bfq: Avoid use-after-free when moving processes between cgroups
Date:   Wed,  5 Jan 2022 15:36:31 +0100
Message-Id: <20220105143037.20542-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=571; h=from:subject:message-id; bh=1ffaZ5kaSH6uzdWcXxo+xCN7SF5AQE5j9RbWnkZn5lY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBh1azZ6CL93eY6CK3rTMWNpyLO8OqiPXRqzdBAS9c9 7FGQ/D6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYdWs2QAKCRCcnaoHP2RA2WTXCA C06L6Fk93X+zblcROCmz5ziRTK263B5prgaX5F28CnFSMrFWrGkpgIr6SuWHWjwEEzXoxvLPZsGUAP WoliJzph3UyyOdOOcOEVWCuis1cMxaDssO3WCjksjYw04xLQF08h4mSx+AmRy3p9H/icTOY1y5/Zgf Ehvfa8mQ/Z8OvKg82Ah94lXZ8BDiAaAL0jIVpPIn/khR19lls0auPbD/nEh39CISwRLVsTE0DGoR6a tUIRKSm+jKl8qmoO8xZHt6ugMjHCfLAobNWJ1RLvSiE89uJrMljjK6Xly8qrEvDGuKTqRO4TWm+Doh yYqKjLQI5Yd6q2eBwoxSb+7pq+8Oz8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

here is the second version of my patches to fix use-after-free issues in BFQ
when processes with merged queues get moved to different cgroups. The patches
have survived some beating in my test VM but so far I fail to reproduce the
original KASAN reports so testing from people who can reproduce them is most
welcome. Thanks!

Changes since v1:
* Added fix for bfq_put_cooperator()
* Added fix to handle move between cgroups in bfq_merge_bio()

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
