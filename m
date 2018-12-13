Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB52C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE462086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE462086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeLMVA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:00:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45273 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMVA5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 16:00:57 -0500
Received: from 201-68-129-100.dsl.telesp.net.br ([201.68.129.100] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gXY6H-0008DV-Hv; Thu, 13 Dec 2018 21:00:54 +0000
Date:   Thu, 13 Dec 2018 19:00:43 -0200
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
Message-ID: <20181213210042.GC5321@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
 <20181213143218.GA8723@lst.de>
 <20181213152532.GA5321@calabresa>
 <20181213202016.GA15992@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213202016.GA15992@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 09:20:16PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 13, 2018 at 01:25:33PM -0200, Thadeu Lima de Souza Cascardo wrote:
> > > And I've checked back - lsblk actually works just fine at the moment.
> > > But it turns out once we create the slave links it stops working,
> > > which is a really good argument against the first two patches, which
> > > would otherwise seem nice..
> > 
> > Which is why I have sent the "paths/" patchset in the first place. Because I
> > did some homework and read the previous discussion about this, and how lsblk
> > failure to behave with slave links led to the revert of the slaves/holders
> > patch by Dr. Hannes.
> 
> Sorry, I did not actually notice that Hannes patch manually created
> the same slaves/holders link we otherwise create using the block layer
> APIs.  Had I realized those actually were the same that had saved
> me some work.
> 
> So I guess the v2 paths/ link patch from you is the least of all evils.
> Hannes, can you look over that one?

No hard feelings. Sorry we had to go through all these messages to make that
clear.

This should be Message-Id: <20181101232955.19329-1-cascardo@canonical.com> and
Hannes was on Cc as well.

Regards.
Cascardo.
