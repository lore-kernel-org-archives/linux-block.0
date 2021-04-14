Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB464C433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D99D61107
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 18:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348850AbhDNSk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 14:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234497AbhDNSk5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 14:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618425635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Kb6pl84RYbuABJ8TS43zZhYd/BdsMqVTZ8MQq2oc0eY=;
        b=Y+rhxI3AdWyyOdwp/YC76GK03Z3G9+joxTr3BdnZJ2201KMaAIbP1IjQsy8Ibr3zVue696
        76cQqtc3Z+T2IZdfl6n7OeGbRqRmjQularZNFxOU3SInLxJWS4JkXYnmFs9Y87hvEArO7u
        37wsqeF7aTQeDu9c0QPVAWy3XE/jJqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-_g9salM4NfeuxlOrfD4sQw-1; Wed, 14 Apr 2021 14:40:34 -0400
X-MC-Unique: _g9salM4NfeuxlOrfD4sQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F24D802B78;
        Wed, 14 Apr 2021 18:40:08 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F3415D9DE;
        Wed, 14 Apr 2021 18:40:08 +0000 (UTC)
Date:   Wed, 14 Apr 2021 14:40:07 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Jaegeuk Kim <jaegeuk@google.com>
Subject: [git pull] device mapper fix for 5.12 final
Message-ID: <20210414184007.GA8824@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes-3

for you to fetch changes up to 8ca7cab82bda4eb0b8064befeeeaa38106cac637:

  dm verity fec: fix misaligned RS roots IO (2021-04-14 14:28:29 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
Fix DM verity target FEC support's RS roots IO to always be
aligned. This fixes a previous stable@ fix that overcorrected for a
different configuration that also resulted in misaligned roots IO.

----------------------------------------------------------------
Jaegeuk Kim (1):
      dm verity fec: fix misaligned RS roots IO

 drivers/md/dm-verity-fec.c | 11 ++++++++---
 drivers/md/dm-verity-fec.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

