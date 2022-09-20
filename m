Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E1C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 20:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiITUMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiITUMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 16:12:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747A7392C;
        Tue, 20 Sep 2022 13:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AEFBB82C38;
        Tue, 20 Sep 2022 20:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7595DC433C1;
        Tue, 20 Sep 2022 20:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663704755;
        bh=mA6F5Rs7YLS3kSgm8MvttCkRAWeXhJQeNN+8JgY3X4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjKiNY//+ZIgovgAnlytfiF1B3LpbEe2Z6EsmWejJ2cqgpu363b6rnbOLgAlrEA2T
         oligCR1bz1zlWIwngsQW1uYrEZM56LLGTO0/F8DcGMFLbGElVT6diJ5y33oZmELWM/
         Ca+41Cy15Pe50+8yIdpE7W++tw7EZKTlQTHuqrTJHs4ebqSp1NPqIG3Gc7oC/NF5lx
         xH1u3wwOKJjCJVC0Esr4RkgDsh3NYto2k9cdXBfJjdocuGOn6IY3v3i8T7NMCId81S
         0RJXgSIddizUCcoV3xRBhho6t+GiOxEQf4Vm4Js/Cbw2Pn8VjqwlzeLKZ0NhJvfNis
         Az3PXXTsjJcLQ==
Date:   Tue, 20 Sep 2022 14:12:31 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Alexander V. Buev" <a.buev@yadro.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
Subject: Re: [PATCH v5 0/3] implement direct IO with integrity
Message-ID: <Yyoer7aEPBWGQCfR@kbusch-mbp.dhcp.thefacebook.com>
References: <20220920144618.1111138-1-a.buev@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920144618.1111138-1-a.buev@yadro.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20, 2022 at 05:46:15PM +0300, Alexander V. Buev wrote:
> This series of patches makes possible to do direct block IO
> with integrity payload using io uring kernel interface.
> Userspace app can utilize new READV_PI/WRITEV_PI operation with a new
> fields in sqe struct (pi_addr/pi_len) to provide iovec's with
> integrity data.

Is this really intended to be used exclusively for PI? Once you give use space
access to extended metadata regions, they can use it for whatever the user
wants, which may not be related to protection information formats. Perhaps a
more generic suffix than "_PI" may be appropriate like _EXT or _META?
