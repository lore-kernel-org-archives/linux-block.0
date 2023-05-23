Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B196C7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbjEWWlG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbjEWWkz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 18:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F22185
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 15:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E1E626A9
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 22:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F287C4339C;
        Tue, 23 May 2023 22:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684881648;
        bh=WDtLQ6cO38jXrysxt4NSmuvWhGPW6R9ocWFYuLDofmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArYRb1XzmrKr4370O3pcI0XIG9RC2ParvBBoSDVY+NIhKMzsCtsymK0rr6IkWO4SV
         wL0wuekqFrcqvtoGtIoQpo0mOUb2Gybp8zy+h/GHwY2QhPRVUI4Qhl5/dAiPjfo/cI
         PDDfDBos9LuJOpHYsxQgtNaW6d8bqQaDQIxmfn2wWH25vVqQiVWklxp9/SUSCrSsjE
         y3TobmZJvLlkRdQMTgOUfAPcjqR3a8uBW7exX8MT7z8YeFo5jfEvXhN4SibjZKAnLp
         /DmdGlAm/mlw2ncJhyCp/E4lzXClX0Zp2mTuUdYBtVvuFeG54W6JePC/iGB3fOzfTp
         VXZ+gfx1jYUFA==
Date:   Tue, 23 May 2023 22:40:47 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "J. corwin Coburn" <corwin@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        vdo-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 00/39] Add the dm-vdo deduplication and
 compression device mapper target.
Message-ID: <20230523224047.GE888341@google.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 05:45:00PM -0400, J. corwin Coburn wrote:
> The dm-vdo target provides inline deduplication, compression, zero-block
> elimination, and thin provisioning. A dm-vdo target can be backed by up to
> 256TB of storage, and can present a logical size of up to 4PB. This target
> was originally developed at Permabit Technology Corp. starting in 2009. It
> was first released in 2013 and has been used in production environments
> ever since. It was made open-source in 2017 after Permabit was acquired by
> Red Hat.

As with any kernel patchset, please mention the git commit that it applies to.
This can be done using the --base option to 'git format-patch'.

- Eric
