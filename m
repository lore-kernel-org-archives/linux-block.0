Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD64C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 17:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiESR27 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiESR2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 13:28:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D91EBA8B;
        Thu, 19 May 2022 10:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FBCF6177E;
        Thu, 19 May 2022 17:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCB0C385AA;
        Thu, 19 May 2022 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652981226;
        bh=4itFkewiWfF9XED5N/WW15Cl1aze5PLwczBnF9c2DIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5BSN6YzTqdG7eo7erq6pOR3yt9465rNF+PM+4jVGHZFMXgJrUUnIHC7do6i6vi/u
         gDkd29xvspfRqPdwIHN6vQTloM0OR83D5QcrNtSEUspD85xlnR1Pbkd6jTE12ErSsd
         91MgsTQhxhU7OZepTmPooXQzzXYpxTdYVPY1aQDliGrAL+qTBEqOuvB9Z7/sg7NEtX
         L7huYS4YsTW0ILw/1IDnLmqHTTtbFPdvyEHgLuwxLTd2gwO2R18IIPhA1fgOrFBPXx
         eZMprnJn5uIkpzBtpDXf97aEI0ugohYrSZ2SeEIuS61eMp/kW4Us16X3L7p6YSbIWC
         NPCB/M3BbVGGA==
Date:   Thu, 19 May 2022 10:27:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoZ96LBMOiNwFhRZ@sol.localdomain>
References: <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
 <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
 <YoZ30XROoiFleT16@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZ30XROoiFleT16@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 11:01:05AM -0600, Keith Busch wrote:
> On Wed, May 18, 2022 at 10:56:04PM -0600, Keith Busch wrote:
> > On Wed, May 18, 2022 at 08:27:31PM -0700, Eric Biggers wrote:
> > > Note, there's also lots of code that assumes that bio_vec::bv_len is a multiple
> > > of 512.  
> > 
> > Could you point me to some examples?
> 
> Just to answer my own question, blk-crypto and blk-merge appear to have these
> 512 byte bv_len assumptions.

blk_bio_segment_split() and bio_advance_iter() are two more examples.

- Eric
