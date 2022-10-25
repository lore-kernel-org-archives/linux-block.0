Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1463CECDFA1
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 23:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiJYXJh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJYXJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 19:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C3EF7
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 16:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5603561BE6
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 23:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A3AC433D6;
        Tue, 25 Oct 2022 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666739364;
        bh=qXV1N5AKEWYecLSXfGCSgGxs5o9LCx1bJAfsulfc5Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjDd0U0F2OoXbekqFRjqb3s/W48Cuh+oqk2oy+Ac9OxFFqoyt+ieE64Z1ucRgfMiB
         L2PfT0rpmyTvHtMW3eYaa/VBacQgzc5VIfxK9ntw1YYxWS/xRDUtfk/EPhT4Bw85SR
         AfJJEKb9rZBWfuIe4kWTJn6vFGMhMlTIx4JUvvdwxV1JutQm3zxI9J9XB5CVvWPvlt
         nCf2+QRvU9N1Vy8jSnUpm01UI7K1XAtZyrcYMmCHRZcrakXsKoCQcx7ahNzHodfIUk
         dedGaKza/pqZPMp28jvw1bD54MfB7c567risFLqF4PWEh6jygeaSzk7W5wjdmSv2S/
         cTh6rRfm7NtGw==
Date:   Tue, 25 Oct 2022 17:09:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, oren@nvidia.com,
        chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Message-ID: <Y1hsoZNjDMhDbemd@kbusch-mbp.dhcp.thefacebook.com>
References: <20221002082851.13222-1-mgurtovoy@nvidia.com>
 <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me>
 <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com>
 <20221025151914.GA23422@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025151914.GA23422@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 05:19:14PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 03, 2022 at 01:16:36PM +0300, Max Gurtovoy wrote:
> >> I'd make this named nvme_pr_type
> >
> > Most of the enums of this header are not named.
> >
> > I don't understand what is the convention here.
> >
> > Usually, if it's not a new header file I'm trying to keep the file 
> > convention and this is what I did.
> >
> > If all agree on named, I'll send another version.
> 
> I think named is better, nvme has some weird unnamed enums that
> even combine totally unrelated fields which I always found confusing.

It's carry-over from the early days when structures had so few constants
that giving each field values their own enum looked a bit silly, and
enums were considered better than a bunch of #define's.

As far as naming them goes, if the only usage is its definition, then
what's the point? If there's a use for a named enum somewhere else, then
yah, that improves readability.
