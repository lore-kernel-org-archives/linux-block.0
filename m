Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CFAC433EF
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 15:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiEXPij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiEXPii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 11:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DD560042;
        Tue, 24 May 2022 08:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52FDE61738;
        Tue, 24 May 2022 15:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2F6C34113;
        Tue, 24 May 2022 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653406715;
        bh=/C51yg+CCjCOCB+JuDI7mFSSoCnKtz1WFrfWQAnKBdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToxsMttbGO/2yHoHh0UE6b0LgwRjYUPCH/BMC4ShNwsw3lKLJXL9IjSK18LcwUL1I
         +29AGbloMBik4i4Ph1EXKu9LJqJ1/1OOPONb2y9IcL/RSH4MQiRWS3tcfR4vThgBN1
         T7n9JDlJ3+18i5F90xE1jhh7Y74Dcy7T6Zcyja4NBTnlGkalSjvfUTFYOOpdrrE6M7
         lN8sUVlodqf6+d6Fa5XHm3Lkbq75cg/C0G9sDbyUHvEhErpPFYXdQxYt7bPaHzk3j1
         7t0WAkdZGlbz+f9NFKPl5p+/AWL/Hu/mrH+7BRq/U/Sj1U43o7S62QbsGB5p2szS30
         0FGp/Qsp2DWyQ==
Date:   Tue, 24 May 2022 09:38:32 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pankaj Raghav <pankydev8@gmail.com>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org
Subject: Re: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Message-ID: <Yoz7+O2CAQTNfvlV@kbusch-mbp.dhcp.thefacebook.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-2-kbusch@fb.com>
 <20220524141754.msmt6s4spm4istsb@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524141754.msmt6s4spm4istsb@quentin>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 04:17:54PM +0200, Pankaj Raghav wrote:
> On Mon, May 23, 2022 at 02:01:14PM -0700, Keith Busch wrote:
> > -	if (WARN_ON_ONCE(!max_append_sectors))
> > -		return 0;
> I don't see this check in the append path. Should it be added in
> bio_iov_add_zone_append_page() function?

I'm not sure this check makes a lot of sense. If it just returns 0 here, then
won't that get bio_iov_iter_get_pages() stuck in an infinite loop? The bio
isn't filling, the iov isn't advancing, and 0 indicates keep-going.
