Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4687AC433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 23:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1A32078D
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 23:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLDXOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLDXOB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Dec 2020 18:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607123554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nGLJJ6FyjmrWrFyd2KGjSuAveY2hoRCzUyG+gMaaqXI=;
        b=Ry4TBFg0hl266vvaqv5ON5Mv1t9sVVhEqBKxeSgJDDHWLQz241gr7zxeDcDmNhgL4pQEu+
        Nnh05fjMN/2RnNKUSQiR6w1s1VE9vsjxHHA5Xb0pTQDEKOKho+EjP1AEfQif/XYlj7d4KN
        Nk/EboLV8VMANR4OgdJvoflweexdpXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-HKI4p-XSMWWHUZuLyg-Hyw-1; Fri, 04 Dec 2020 18:12:31 -0500
X-MC-Unique: HKI4p-XSMWWHUZuLyg-Hyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04281809DC3;
        Fri,  4 Dec 2020 23:12:30 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E857660918;
        Fri,  4 Dec 2020 23:12:26 +0000 (UTC)
Date:   Fri, 4 Dec 2020 18:12:26 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [git pull] device mapper induced block fix for 5.10-rc7
Message-ID: <20201204231225.GA4574@redhat.com>
References: <20201204210521.GA3937@redhat.com>
 <160711773655.16738.13830016046956700847.pr-tracker-bot@kernel.org>
 <20201204223742.GA82260@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204223742.GA82260@lobo>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus (and Jens),

Apologies for the glaring bug I introduced with my previous pull request!

The following changes since commit bde3808bc8c2741ad3d804f84720409aee0c2972:

  dm: remove invalid sparse __acquires and __releases annotations (2020-12-04 15:25:18 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-fixes-2

for you to fetch changes up to 65f33b35722952fa076811d5686bfd8a611a80fa:

  block: fix incorrect branching in blk_max_size_offset() (2020-12-04 17:27:42 -0500)

Please pull, thanks!
Mike

----------------------------------------------------------------
Fix incorrect branching at top of blk_max_size_offset().

----------------------------------------------------------------
Mike Snitzer (1):
      block: fix incorrect branching in blk_max_size_offset()

 include/linux/blkdev.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

