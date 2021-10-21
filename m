Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE016121E
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJUOaE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:30:04 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:49546 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhJUOaE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:30:04 -0400
X-Greylist: delayed 2705 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Oct 2021 10:30:04 EDT
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mdYIr-005EKC-4x; Thu, 21 Oct 2021 15:40:17 +0200
Date:   Thu, 21 Oct 2021 15:40:17 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] memremap: remove support for external pgmap refcounts
Message-ID: <YXFtwcAC0WyxIWIC@angband.pl>
References: <20211019073641.2323410-1-hch@lst.de>
 <20211019073641.2323410-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019073641.2323410-3-hch@lst.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 09:36:41AM +0200, Christoph Hellwig wrote:
> No driver is left using the external pgmap refcount, so remove the
> code to support it.

> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -109,8 +98,7 @@ struct dev_pagemap_ops {
>   */
>  struct dev_pagemap {
>  	struct vmem_altmap altmap;
> -	struct percpu_ref *ref;
> -	struct percpu_ref internal_ref;
> +	struct percpu_ref ref;
>  	struct completion done;
>  	enum memory_type type;
>  	unsigned int flags;

This breaks at least drivers/pci/p2pdma.c:222


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ Certified airhead; got the CT scan to prove that!
⠈⠳⣄⠀⠀⠀⠀
