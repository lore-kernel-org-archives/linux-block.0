Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACEAC433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 10:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245593AbiDAK3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245574AbiDAK3p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 06:29:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E98326E558
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 03:27:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CCFA521A99;
        Fri,  1 Apr 2022 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648808873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Qy+aItlDnKh+kf9kMWucumFijaWwv/sCrv5oXIjwE9g=;
        b=EsU7WJWJeLTs0QB+7//u4cT9HN9Cr7pVvlXYjwbm2ztNRhoMiKz031S0B+MfvrB8FF+w8k
        HIlwCX4aiZwfX6z5taXUhWJk1vR/j6nZOyK/mfrdv70i91ry7Ef32FoKRa7ulFByp0AfTb
        zKQ9Y5NGj5cRBDh8yy935utkduyBP2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648808873;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Qy+aItlDnKh+kf9kMWucumFijaWwv/sCrv5oXIjwE9g=;
        b=A6Drk6x03lvY20Zo+e7yMym1jqwo+mVO5jGDA3S2nN74qRlhN1hT5+Qn5XzzRcouvos1RU
        tV6m1gL/sRXCMBDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AD955A3B93;
        Fri,  1 Apr 2022 10:27:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6F5ABA0610; Fri,  1 Apr 2022 12:27:52 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/9 v7] bfq: Avoid use-after-free when moving processes between cgroups
Date:   Fri,  1 Apr 2022 12:27:41 +0200
Message-Id: <20220401102325.17617-1-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; h=from:subject:message-id; bh=Woq18d3GqSq325hnHrVbkiYazH+zBVj4PzXclk8lnX8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiRtOZPoyAYLn6sr1sP6B6BeA1DVts6sMV+W8utkyk 6yUr5COJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYkbTmQAKCRCcnaoHP2RA2f9ZCA CJvM5GqNh1tkRBF7ZMfvem9eJyrsBfcCdjLIQUr0x161VHmVWW0olOHmpVvIMzDU22Cej93QjJny4W 7L3GZ3Oyn28x2qRdQ4igdN36nToUKfET6ePIKtsiNcyIMH5PDx3e0S8A9tJZG4MSX1OxIsLkfX+P4D 5O8a0F5zyhj6LsjtDno80fzX+I1NbVG49uOmLfy091Zy/iHabL5czlKsZ/VaoZwl7KNkPN3+ly4grB 4/QeYjus+cKEEeH2GmgcIK4I74RGbEenIC8XUcQj4+FHMLTzdtDQaPMW+wEyc4ayc+b7lDSN0CrRzL YFhTPCWswM93VFKNs7YOszcYj9nQP1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

here is the seventh version of my patches to fix use-after-free issues in BFQ
when processes with merged queues get moved to different cgroups. Kuai has
confirmed that patches now fix all the issues his reproducer was able to
trigger so I've just added some tags, codewise this is the same as v6. Paolo,
can you please check whether the patches look good to you so that Jens can
merge them? Thanks!

Changes since v6:
* Added some Tested-by, Fixes, and CC tags

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
Link: http://lore.kernel.org/r/20220330123438.32719-1-jack@suse.cz # v6
