Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8302C38A02
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 08:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ1Ibb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJ1Iba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 04:31:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0777E81B
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 01:31:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6493068BEB; Fri, 28 Oct 2022 10:31:27 +0200 (CEST)
Date:   Fri, 28 Oct 2022 10:31:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, oren@nvidia.com,
        chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Message-ID: <20221028083127.GB1043@lst.de>
References: <20221002082851.13222-1-mgurtovoy@nvidia.com> <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me> <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com> <20221025151914.GA23422@lst.de> <Y1hsoZNjDMhDbemd@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1hsoZNjDMhDbemd@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 05:09:21PM -0600, Keith Busch wrote:
> As far as naming them goes, if the only usage is its definition, then
> what's the point? If there's a use for a named enum somewhere else, then
> yah, that improves readability.

I think it is nice bit of documentation.  E.g. if the enum is for the
bits or value in a nvme filed naming it after that field can be handy.
