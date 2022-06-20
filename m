Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B55C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 16:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiFTQL5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbiFTQL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC820BCA
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 09:11:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3055021B8A;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KS9Qas2AKNbT45emJn1vsknvtdkh7G4s1et9fLBSW4A=;
        b=JOhdQHXyhCthixXaiIAuxXhZk1RK8eq1yparTfE9c/v/a7Deg640aco9MyoZXlrjTCnc/t
        WrMgHx1p34rLOdcjjTnHDbBB/YaQZNLZ1Jj9HDHUV5y+uUUO6R6mGatBYehUfplcydgIaz
        oJY+cHhEf+t8+e43X3YAsPP3AL/HuxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KS9Qas2AKNbT45emJn1vsknvtdkh7G4s1et9fLBSW4A=;
        b=ogMmyTcOpRYDy4w26LzPDlearrphBImxTPe6oT+51Vif5cisfK+uHO26VXfiQLzJvZwZ2a
        H9QrSduvF+BRUoDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A8BD12C143;
        Mon, 20 Jun 2022 16:11:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 345ADA0636; Mon, 20 Jun 2022 18:11:53 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/8 v3] block: Fix IO priority mess
Date:   Mon, 20 Jun 2022 18:11:41 +0200
Message-Id: <20220620160726.19798-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; h=from:subject:message-id; bh=sr6wqmHzC3RDNgh+Uyfr0Vc3FOdsGaeOOBjL4VpoIOk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisJwssxIFQJ47LP4yyYqkCMa/zDE7VBATIJzvhOms 9vvhNK+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrCcLAAKCRCcnaoHP2RA2XaHB/ 9APuEUAj5sRDSRjNRNscYBzER/XiIrPV0jeWWeb666KfdZi07VpIF6Xm+ZynQSrIhLLXHlzjz/FR0D QiPk8JSAwsD3RkveOVUQuGzVxJC5Vl3/AYQjZi242jK5ZNXjrgpaS6IyMsJdacc3LXeNXz+xOdxWjk gg5MfMCiO5B0e74+FrsF9ApveDWMm2PXuI9LFvJSV67fef7WWgHaLr33tXw/I7TO5k3I4Obsdj85bX eUPg+XyzjwryIYEfsrTPxDx4JnmUA6vgzFsOG2J1kYW05XxI/1/oFDkMcrLWkz2GWBfBBp4/IjG2wb edknl6vqlMn1DtcfTLfsqbgCzgAK+1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This is the third revision of my patches fixing IO priority handling in the
block layer.

Changes since v2:
* added some comments to better explain things
* changed handling of ioprio_get(2)
* a few small tweaks based on Damien's feedback

Original cover letter:
Recently, I've been looking into 10% regression reported by our performance
measurement infrastructure in reaim benchmark that was bisected down to
5a9d041ba2f6 ("block: move io_context creation into where it's needed"). This
didn't really make much sense and it took me a while to understand this but the
culprit is actually in even older commit e70344c05995 ("block: fix default IO
priority handling") and 5a9d041ba2f6 just made the breakage visible.
Essentially the problem was that after these commits some IO was queued with IO
priority class IOPRIO_CLASS_BE while other IO was queued with IOPRIO_CLASS_NONE
and as a result they could not be merged together resulting in performance
regression. I think what commit e70344c05995 ("block: fix default IO priority
handling") did is actually broken not only because of this performance
regression but because of other reasons as well (see changelog of patch 3/8 for
details). Besides this problem, there are multiple other inconsistencies in the
IO priority handling throughout the block stack we have identified when
discussing this with Damien Le Moal. So this patch set aims at fixing all these
various issues.

Note that there are a few choices I've made I'm not 100% sold on. In particular
the conversion of blk-ioprio from rqos is somewhat disputable since it now
incurs a cost similar to blk-throttle in the bio submission fast path (need to
load bio->bi_blkg->pd[ioprio_policy.plid]).  If people think the removed
boilerplate code is not worth the cost, I can certainly go via the "additional
rqos hook" path.

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20220601132347.13543-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20220615160437.5478-1-jack@suse.cz # v2
