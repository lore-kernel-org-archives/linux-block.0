Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF39FC433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 07:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiAQHzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiAQHzj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 02:55:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD45C061574
        for <linux-block@vger.kernel.org>; Sun, 16 Jan 2022 23:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QJoKabHCJyjMHl+asLl43wZb7zsct5+NVbZkfh+AIdg=; b=CLTLapTtvfn+zeSUyRi67dv8eR
        GAAr3QPmjQotElvNBw2fm87EZcnXjncqaNzNsJ4VdCzeucRpJAiyJ5MSYU02qBnKeA3TVCfi+igqV
        bTSsCNu0dxzlwJw94z53paZrM+msCBtBaDkWVpEwSYc20q2nYXnGv2jaVl/yfO5mM//DFPjw+ndCE
        VI1lNuVdN6mVI333ctG9/GWmtfxgVmNWBtNpVoEyYO8bJwuYSC7N1dFz66MmYO5NEEIfx4Eeh1bem
        qV5mLkaAbdodMhzLey7ZwYfw6h3l1033STaYxMUq57Tvo2OzfVmyC0OALONnL6XRVZKTpEbqX7Toj
        YlNwcgfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9MrV-00Dzst-1f; Mon, 17 Jan 2022 07:55:33 +0000
Date:   Sun, 16 Jan 2022 23:55:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     dougmill@linux.vnet.ibm.com, jonathan.derrick@intel.com,
        revanth.rajashekar@intel.com, linux-block@vger.kernel.org,
        hch@infradead.org, sbauer@plzdonthack.me
Subject: Re: [PATCH V2] block: sed-opal: Add ioctl to return device status
Message-ID: <YeUg9QmITYUTqia3@infradead.org>
References: <612795b5.tj7FMS9wzchsMzrK%dougmill@linux.vnet.ibm.com>
 <93f6c52690fb84fc79cc634f451a5c5d52df6c5f.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f6c52690fb84fc79cc634f451a5c5d52df6c5f.camel@debian.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please resend the patch.
