Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10575C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 18:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiKBS61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiKBS61 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 14:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C1261
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 11:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E61C61B7F
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 18:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F30C433C1;
        Wed,  2 Nov 2022 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667415502;
        bh=KoWsvC25pqd9GJz44PRzSoXtSOS/iLxxlcYDL+YwZqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOp9gPjFIkpCzrlTjyW/j9lY78yfC6TXIU3E+lwfqAZwIfgnyLndRGyLUEZil7ugi
         pa3Vx+oqN8NHZjJE4uUeTIyE81pUWRb4zFZhB3gd2gFR1uCYQeAy5TSuvHe1XYNjBU
         LotKRdmb4tUiFOfBhjCyXQsg9t8Y9RpkSV0Cmbm/UiknzAQcF1+6ocgHYkmlPeYLuL
         nF19FtOybXfD7fhYY/w36mQkzxsCj32+cgOvaChsGwhcIkF+Jxxq7pZrMNyInOEFi5
         i1pVaGzIUIq3OpQCguix4JoQEmKFxJG3kf4GharFStgCY4uffWHVUPMHaQJ5pz0cZU
         zmzRH/HtiHMzw==
Date:   Wed, 2 Nov 2022 12:58:19 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [dm-devel] Regression: wrong DIO alignment check with dm-crypt
Message-ID: <Y2K9y5zfUcn87e09@kbusch-mbp.dhcp.thefacebook.com>
References: <Y2Hf08vIKBkl5tu0@sol.localdomain>
 <alpine.LRH.2.21.2211021434180.2087@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2211021434180.2087@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 02, 2022 at 02:45:10PM -0400, Mikulas Patocka wrote:
> On Tue, 1 Nov 2022, Eric Biggers wrote:
> > Hi,
> > 
> > I happened to notice the following QEMU bug report:
> > 
> > https://gitlab.com/qemu-project/qemu/-/issues/1290
> > 
> > I believe it's a regression from the following kernel commit:
> > 
> >     commit b1a000d3b8ec582da64bb644be633e5a0beffcbf
> >     Author: Keith Busch <kbusch@kernel.org>
> >     Date:   Fri Jun 10 12:58:29 2022 -0700
> > 
> >         block: relax direct io memory alignment
> 
> I suggest to revert this patch.

I hope we can make that option a last resort.
 
> > The bug is that if a dm-crypt device is set up with a crypto sector size (and
> > thus also a logical_block_size) of 4096, then the block layer now lets through
> > direct I/O requests to dm-crypt when the user buffer has only 512-byte
> > alignment, instead of the 4096-bytes expected by dm-crypt in that case.  This is
> > because the dma_alignment of the device-mapper device is only 511 bytes.
> 
> Propagating dma_alignment through the device mapper stack would be hard 
> (because it is not in struct queue_limits). Perhaps we could set 
> dma_alignment to be the equivalent to logical_block_size, if the above 
> patch could not be reverted - but the we would hit the issue again when 
> someone stacks md or other devices over dm.

It looks straight forward to relocate the attribute to the the
queue_limits. If it stacks correctly, then no one would encounter a
problem no matter what md/dm combination you have.

I have something that looks promising, but I'm trying to give it a
thorough test before sending out another incomplete patch. Hopefully
ready by end of the day.
