Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE8CCA480
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 10:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348533AbiFUKZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiFUKY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 06:24:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA328983
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 03:24:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2300121C3D;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655807097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2CAXuLTDZIZNbf9vRD34yjqmPsqm43rIiepk0XWkSDk=;
        b=nT4btGae9ChFzIaygvNfKQHZnN6JaGb47STNjElj9QN8rjkVhGeCWX0N5lUCQlzpDfyHbN
        rYeMJpIVERznY5+j4Sp6HvvK3n8Li6Ap999zxy4xC0b9YPuXTXesLyoYSBeZstSVR01jGi
        k7fvfD/UgiPDXr6I4mp5vwaE2R5qOnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655807097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2CAXuLTDZIZNbf9vRD34yjqmPsqm43rIiepk0XWkSDk=;
        b=mlLtbUBjesINTerxtNnBGd4MVWVMk1nhtiFw64ik3rJV4cjz6gkFRI606F8/vBHP9HaeB4
        QI5AUzJStLeMwvDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B24542C143;
        Tue, 21 Jun 2022 10:24:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C795EA062B; Tue, 21 Jun 2022 12:24:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/9 v4] block: Fix IO priority mess
Date:   Tue, 21 Jun 2022 12:24:37 +0200
Message-Id: <20220621102201.26337-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; h=from:subject:message-id; bh=h3D7NBsFhH6HxjmHIGSnH0R7cWP35Tdb37tW3si15Tk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisZxfdrTRHeMsE1BPg5dt+gG08zdCDBK11tyzD9hy FTGYIIqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrGcXwAKCRCcnaoHP2RA2XvaCA CpRODIdiJsjAe+6wSllTXdQ16CB2WRUd22PSL2+e3Qcxz4TQvRywRXQnpsL5Jl65H+/TE67L4U/oYI VFw6tcRE56xx9D0zjoMHx7FrwrfWEtBAljW3jKfh60ApFv55QyN/i5iHGyetkkjm6WNpuzttOqnRnk iaX2BC+z7cNVxt1AfmY8gyKzEs9zjl2FMl+McscUuSs4iFLQfzGKRlQJO3oc5Jejnrtp7PGw9wc0HJ /T3/leJzro/qgfUaM1z3Rw291/gMd+BrdKEIpGEsWXEStIwup4LV2iCipHJeVhoj0gExR+UeLsWbdD RfmqVzh/GqBLfDkft/iJEUcSI0CVIf
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This is the fourth revision of my patches fixing IO priority handling in the
block layer.

Changes since v3:
* Added Reviewed-by tags from Damien
* Fixed build failure without CONFIG_BLOCK
* Separated refactoring of get_current_ioprio() into a separate patch

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
Link: http://lore.kernel.org/r/20220620160726.19798-1-jack@suse.cz # v3
