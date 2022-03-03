Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF069C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 00:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiCCA5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiCCA5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 19:57:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1C2BB1B;
        Wed,  2 Mar 2022 16:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YYLgeMF5YnFMGTtJnuFo/ahZYnFHuXykSNrnMr7pvUI=; b=MwgYUdbPY5nov/nL5hZklw87lX
        J871ElUjlBLH/c+QuoMt5b4mpoa5Hz8A7Twe0DlHAR0uxwOhwOF7vqRkMEVA8uDSt4b2WyxBv/71g
        Kyb9ZBGAuDPkCWnUqgHuqjy6N02yfurArbBr1n3g1JvxLdVhNK9LZQDfSchMjjlvH+UR8h853az6Y
        y7snNzsR+/Xs8T2MazGyRFnmXp5C3Giyq3KT11/a7027Ye6Tm/0yZLWDQI8xyacrdb+PyFSGh8RgD
        ocYNAbiiYcsNTgc60682oX/louWvk5KMgMM7Iv+PL/M+R0RsjRlG7kxFYNSdF01v/bhrw1MbcWW09
        nj31an5w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPZm2-004tUo-89; Thu, 03 Mar 2022 00:56:54 +0000
Date:   Wed, 2 Mar 2022 16:56:54 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org
Cc:     Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>, mcgrof@kernel.org
Subject: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thinking proactively about LSFMM, regarding just Zone storage..

I'd like to propose a BoF for Zoned Storage. The point of it is
to address the existing point points we have and take advantage of
having folks in the room we can likely settle on things faster which
otherwise would take years.

I'll throw at least one topic out:

  * Raw access for zone append for microbenchmarks:
  	- are we really happy with the status quo?
	- if not what outlets do we have?

I think the nvme passthrogh stuff deserves it's own shared
discussion though and should not make it part of the BoF.

  Luis
