Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A6EB64DD
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 05:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjGDFHC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 01:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGDFHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 01:07:01 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE01AD;
        Mon,  3 Jul 2023 22:07:00 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qGYFc-000G9U-89; Tue, 04 Jul 2023 07:06:56 +0200
Received: from p57bd997f.dip0.t-ipconnect.de ([87.189.153.127] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qGYFc-000aQy-0H; Tue, 04 Jul 2023 07:06:56 +0200
Message-ID: <5dcbbcf69462141ab7cd9679b7577b8047b97f29.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block <linux-block@vger.kernel.org>
Date:   Tue, 04 Jul 2023 07:06:55 +0200
In-Reply-To: <45d9f890-ebe2-4014-2411-953fd9741c2b@gmail.com>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
         <1885875.tdWV9SEqCh@lichtvoll.de>
         <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
         <4858801.31r3eYUQgx@lichtvoll.de>
         <947340d9-b640-0910-317b-5c8022220a55@xenosoft.de>
         <80266037-f808-c448-c3c7-9d5d5f4253a7@xenosoft.de>
         <45d9f890-ebe2-4014-2411-953fd9741c2b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.127
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael!

On Tue, 2023-07-04 at 09:24 +1200, Michael Schmitz wrote:
> Hi Christian,
> 
> On 4/07/23 02:59, Christian Zigotzky wrote:
> > > I am very happy that this bug is fixed now but we have to explain it 
> > > to our customers why they can't mount their Linux partitions on the 
> > > RDB disk anymore. Booting is of course also affected. (Mounting the 
> > > root partition)
> > > 
> > > But maybe simple GParted instructions are a good solution.
> > You can apply the patch. I will revert this patch until I find a 
> > simple solution for our community.
> > 
> > Thank you for fixing this issue!
> 
> Thanks for testing - I'll add your Tested-by: tag now. I have to correct 
> the Fixes: tag anyway.

Have we actually agreed now that this is a bug and not just an effect of the
corrupted RDB that Christian provided?

> Jens - is the bugfix patch enough, or do you need a new version of the 
> entire series?

But the series has already been applied and released in 6.4, hasn't it?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
