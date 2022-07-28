Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9045BC19F2C
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 14:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiG1Op5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiG1Opw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 10:45:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202674C60C
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 07:45:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8460F67373; Thu, 28 Jul 2022 16:45:48 +0200 (CEST)
Date:   Thu, 28 Jul 2022 16:45:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH blktests 1/6] common/rc: avoid module load in
 _have_driver()
Message-ID: <20220728144548.GB18285@lst.de>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com> <20220727085251.1474340-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727085251.1474340-2-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 27, 2022 at 05:52:46PM +0900, Shin'ichiro Kawasaki wrote:
> The helper function _have_driver() checks availability of the specified
> driver, or module, regardless whether it is loadable or not. When the
> driver is loadable, it loads the module for checking, but does not
> unload it. This makes following test cases fail.
> 
> Such failure happens when nvmeof-mp test group is executed after nvme
> test group with tcp transport. _have_driver() for tcp transport loads
> nvmet and nvmet-tcp modules. nvmeof-mp test group tries to unload the
> nvmet module but it fails because of dependency to the nvmet-tcp module.
> 
> To avoid the failure, do not load module in _have_driver() using -n
> dry run option of the modprobe command. While at it, fix a minor problem
> of modname '-' replacement. Currently, only the first '-' in modname is
> replaced with '_'. Replace all '-'s.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
