Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E7C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 18:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjC1SgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC1SgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 14:36:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2431FDB
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 11:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FB27B81E33
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 18:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5D9C433D2;
        Tue, 28 Mar 2023 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680028561;
        bh=kc5R6nXTzPfvlU6LuPQ145KHQ64nhKzvpe4FksK4B/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epsmqNnLEaujUCalH3zBcrtfn6n+EgCpaox+2i0zCM1W/bzqKGUZ2ta041G1Jnff0
         YVw4pvHnj1sA4eqhKRN3IHTZax6aOK7baDsoCgG4L0o3bmY/Czj+w/35zUDIIKqAqi
         x96ogSCggPATRJa5RH8/UEST/O9UJ+NZsZhmOXc2VyJF2AK41Kx5+J5j8MdTKP/Dbn
         6oZ9tKTRM3kcuBoZRT0Ms226kTzDPfIfmgCAqa5Ilnkr/gWXzmTMMVSrmPc0JA7bgG
         BCJBtQjPR4DiZbqexkGZ4u4WQd0T0ckmr6PBpXPBAR4IRRlzE6QTa4eu5Zuy/+6pWm
         8HTr2LpUpWneQ==
Date:   Tue, 28 Mar 2023 12:35:57 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Message-ID: <ZCMzjVs26imnywgo@kbusch-mbp.dhcp.thefacebook.com>
References: <20230322101648.31514-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322101648.31514-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 11:16:45AM +0100, Daniel Wagner wrote:
> Setup different queues, e.g. read and poll queues.

If you wanted to add a similar test for pci, you do it by echo'ing the desired
options to:

  /sys/modules/nvme/parameters/{poll_queues,write_queues}

Then do an 'nvme reset' on the target nvme pci device.

I'll just note that such a test will currently fail, and fixing that doesn't
look like fun. :)
