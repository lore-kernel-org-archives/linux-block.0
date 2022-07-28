Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CB1C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 14:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiG1Oq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiG1Oq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 10:46:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60481186EB
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 07:46:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C220567373; Thu, 28 Jul 2022 16:46:25 +0200 (CEST)
Date:   Thu, 28 Jul 2022 16:46:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH blktests 2/6] nbd/rc: load nbd module explicitly
Message-ID: <20220728144625.GC18285@lst.de>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com> <20220727085251.1474340-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727085251.1474340-3-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 27, 2022 at 05:52:47PM +0900, Shin'ichiro Kawasaki wrote:
> After the commit "common/rc: avoid module load in _have_driver()",
> _have_driver() no longer loads specified module. However, nbd test cases
> and _have_nbd_netlink() function assume that the module is loaded by
> calling _have_driver(). This causes test case failures and unexpected
> skips. To fix them, load and unload modules explicitly in functions
> _start_nbd_server*(), _stop_nbd_server*() and _have_nbd_netlink().

Did you test this with built-in nbd? 
