Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D163C433FE
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbiERSdS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbiERSdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 14:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFF15AB00
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 11:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F3F66184A
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 18:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78622C385A5;
        Wed, 18 May 2022 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652898795;
        bh=qa5MenrssBSWl9CFr/93UYUY4h6ovIiEO7Gae/Wk6JA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r92vkjkJJ/coVmWOksRubE8C8eWhtzdw5hcSSCZdqgzut/JsgsdySX9/Us5NjkAPe
         4T8rgClCz+95Vd6gVXGgw0zNcc+DXg6vG5Qsh9LiuaEU1Og+jSuZypxKaPDQo6j/8q
         Y4L4fTJgjgEOMDtAEIfY6r20sD3fnLh9s19D3/DaCivlBkvy6i7nTt1u/BZeCxUHVC
         yGxHrIgFHigmCEJMx8yDktEG2/qPwipFH6wu8E8jPzahbmQ5xpBSs5/AymGmKW4nSg
         pwBKIH0aPmiq3aMnvLFhTu9u1ik3VShk2+GyISwNmIgKmqb0YyIV1gVaDV/Snv6Uzh
         f7xbCdZQ4wnvg==
Date:   Wed, 18 May 2022 11:33:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jasper Surmont <surmontjasper@gmail.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [Question] Editing a bio write request
Message-ID: <YoU76RzXfV6Js9T7@sol.localdomain>
References: <CAH4tiUssBd1vKjUMtbNcmHt8X+-TzdgSFCfT=3coZZedGVESsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH4tiUssBd1vKjUMtbNcmHt8X+-TzdgSFCfT=3coZZedGVESsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 18, 2022 at 01:56:31PM +0300, Jasper Surmont wrote:
> I'm writing a device-mapper which has to edit incoming writes, for
> example: Incoming bio request contains a biovec with a page full of 0
> bytes, and I want to change it to all 0xFF bytes.
> 
> I tried using bvec_kmap_local() to get the page address, to then read
> the data and if needed adjust it using memcpy or similar. Initial
> tests seemed to work, but if I execute things like mkfs on the created
> dm, I get a lot of segmentation faults. I narrowed down the problem
> that this only happens if I actually write something to the mapped
> page. However, I see no reason why it should cause this fault as I
> (after checking probably 100 times) don't access invalid memory. I'm
> wondering whether my method of editing the write is actually correct,
> or if I am doing something else very stupid.
 
Data in bios can't be modified in-place, as submitters of writes (e.g.,
filesystems) expect that their data buffers aren't modified.  To modify the data
you'd need to allocate a new bio with new pages and submit that instead.  See
dm-crypt for an example of a device-mapper target which does this.

What sort of device-mapper target are you trying to implement, anyway?  If
you're trying to do encryption, dm-crypt already solves that problem.

- Eric
