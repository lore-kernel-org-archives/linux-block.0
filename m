Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC3EC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 02:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCNCRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 22:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCNCRt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 22:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EE28B327;
        Mon, 13 Mar 2023 19:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D4B961568;
        Tue, 14 Mar 2023 02:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB2C433D2;
        Tue, 14 Mar 2023 02:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678760267;
        bh=zjoe8wzX//9XufWg6CmZJ12ZOLBQLD4CQOio3S+o3Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsezOV5GiZbY0SSwh5FAFlI2oUcdIYp2mYgmmlORMs8MyfNly5C93kHMiCOxVF+YI
         i7sZ5zGVDD15kryGH09iVc+u4Zwmn95s7Si1mNAxNBnhLkDAhoeYpa4rPL1i8vJN2k
         ngjKu15ahHeEYJKyN4Za+Gh39KLfaA4vxYpij5vS84QhScfzt5F/VPA9tgM+hHpY2E
         rIApNeUiF/FNmu7LgzCnB5v6cXgsTi3+utQGtw/kKfUz0RQ8oQDKQn4R9KAPnITq4z
         hNvdQaeIOwE+58JixrQ5jbc8gm2zxku8rjw8EqN3L/yCWo1yKWZc263w/Qmo9s5Gyw
         WCJ6TbhMogq2A==
Date:   Mon, 13 Mar 2023 22:17:46 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     stable@vger.kernel.org, linux-block@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH v5.10 0/5] bfq bic/cgroup interaction uaf fixes
Message-ID: <ZA/ZSuVSy/r8ANvy@sashalap>
References: <20230313222757.1103179-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230313222757.1103179-1-khazhy@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 13, 2023 at 03:27:52PM -0700, Khazhismel Kumykov wrote:
>Pulls in uaf fix for bfqq->bic along with fixups. I pulled in the
>backport dependencies that were also present in 5.15-lts.
>
>NeilBrown (1):
>  block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"
>
>Yu Kuai (4):
>  block, bfq: fix possible uaf for 'bfqq->bic'
>  block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq
>  block, bfq: replace 0/1 with false/true in bic apis
>  block, bfq: fix uaf for bfqq in bic_set_bfqq()
>
> block/bfq-cgroup.c  |  8 ++++----
> block/bfq-iosched.c | 19 +++++++++++++------
> 2 files changed, 17 insertions(+), 10 deletions(-)

Queued up, thanks!

-- 
Thanks,
Sasha
