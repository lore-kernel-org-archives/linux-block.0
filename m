Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C247FC433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 19:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957B0650A6
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 19:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCET1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230050AbhCET0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Mar 2021 14:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614972411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=GY+uKh6sS0CGlfkrX+aRF2CjNhAbEJ9WWwro18686IM=;
        b=Hujsn7qx2BMUxXujqMhWolaPypM5Fwx1a6z+9iVpQ/GWUXaTrp9OfVUHhvPqKw1M2MfoVH
        nuckaCBgI/7CJrY9mpzLVkTgazhSdinzleSamiD9cSN+Rt99MWo40o6OZo7JyXisAE5FfL
        18g3ENR9VyzT18e8D1GeTpsW6jPa41w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-lnRSfnIGNWCYUrUQRRKDww-1; Fri, 05 Mar 2021 14:26:47 -0500
X-MC-Unique: lnRSfnIGNWCYUrUQRRKDww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6990A87A82A;
        Fri,  5 Mar 2021 19:26:46 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C89D1349A;
        Fri,  5 Mar 2021 19:26:43 +0000 (UTC)
Date:   Fri, 5 Mar 2021 14:26:42 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [git pull] device mapper fixes for 5.12-rc2
Message-ID: <20210305192641.GA21876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit a666e5c05e7c4aaabb2c5d58117b0946803d03d2:

  dm: fix deadlock when swapping to encrypted device (2021-02-11 09:45:28 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes

for you to fetch changes up to df7b59ba9245c4a3115ebaa905e3e5719a3810da:

  dm verity: fix FEC for RS roots unaligned to block size (2021-03-04 15:08:18 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
Fix DM verity target's optional Forward Error Correction (FEC) for
Reed-Solomon roots that are unaligned to block size.

----------------------------------------------------------------
Mikulas Patocka (1):
      dm bufio: subtract the number of initial sectors in dm_bufio_get_device_size

Milan Broz (1):
      dm verity: fix FEC for RS roots unaligned to block size

 drivers/md/dm-bufio.c      |  4 ++++
 drivers/md/dm-verity-fec.c | 23 ++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

