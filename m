Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CACC433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 15:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiCGPpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiCGPpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 10:45:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E376E1A;
        Mon,  7 Mar 2022 07:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Ou9QJwFaomPgiuepXAK3z2reqVCh8KUpveq8UjfyWU=; b=g14tomR0Ur5/KJ1lgH95fYB6OP
        glmT9B3LaXUekGwiXTvSYpA/h0gXDnWb70Ef3lqq6YalkgG5IrtE6IYu9sCNDqG+VnlXRufw0dktQ
        vPjG1QML5bpsJgDRjIFNtNQjpTBIGaH9WhIlBVuspbjMBkHjUaWK81ZnClPeO5F7whVsiHJdk7SVA
        gsEMgk/9BLqIfBeoxzAPN7tYA1/JmuYlI39+8E6U3LfE0UFrSQTpOIUjIhYy15YNuYN9Wmy5KmeEl
        /doSZkCqrtvcQ8PVzPWjyBpxAK/wcVSVDF1UM5vaHyTZQLR4/QYJZzWNAcj3c/EtmBQCXfJaYnxOT
        Rltv3gKg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRFX4-000fQy-HV; Mon, 07 Mar 2022 15:44:22 +0000
Date:   Mon, 7 Mar 2022 07:44:22 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <YiYoVmQE54mVFzHL@bombadil.infradead.org>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <e2aeff43-a8e6-e160-1b35-1a2c1b32e443@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2aeff43-a8e6-e160-1b35-1a2c1b32e443@opensource.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07, 2022 at 08:56:30AM +0900, Damien Le Moal wrote:
> btrfs maps zones to block groups and the sectors between zone capacity
> and zone size are marked as unusable. The report above is not showing
> that. The coding is correct though. The block allocation will not be
> attempted beyond zone capacity.

That does not explain or justify why zone size was used instead of zone
capacity. Using the zones size gives an incorrect inflated sense of actual
capacity, and users / userspace applications can easily missuse that.

Should other filesystems follow this logic as well? If so why?

  Luis
