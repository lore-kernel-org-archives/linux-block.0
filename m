Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D3C4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 08:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiLBIs4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 03:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiLBIsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 03:48:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012DBAD9B7
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 00:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E85E61EDD
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 08:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AD3C433D6;
        Fri,  2 Dec 2022 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669970929;
        bh=dw6rMzcyrokKg/12eBotrepw58qwc2s0itO2kJ9wBpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S93DCOvXs2LidLfXyhovRt5au5ssrtV9t87q9tWEt/VuCB8TxUDTxGQBxOMY4YmhE
         kQDn1UXI+ggTZz01Pr6g4duVXsoGYLNV5vmGfsPbwmntD0ww0Pjju0sAzOe6h8rZEy
         527/w/sFC9KjVTFqzp0vg9YKbifGGOleLjFaHX7OuDr5t8fDw8kDy+UyL9Wkd4muDe
         ZbVhwAM04s8YWqQepLLXhkXJcnBGxDr5gThbqIQYtvPs29YD3SuZxBLlARTHUzerXZ
         30duloBxGYwzX3RIST/atXayHO89xBSCTiSBEZr0rYJ464XP9uRm5Whk1plPNQx87I
         LACPgBPux3klA==
Date:   Fri, 2 Dec 2022 09:48:45 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     luca.boccassi@gmail.com
Cc:     linux-block@vger.kernel.org, jonathan.derrick@linux.dev,
        gmazyland@gmail.com, axboe@kernel.dk, stepan.horacek@gmail.com
Subject: Re: [PATCH] sed-opal: if key is available from IOC_OPAL_SAVE use it
 when locking
Message-ID: <20221202084845.66mn2m3srfabehnu@wittgenstein>
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202003610.100024-1-luca.boccassi@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 02, 2022 at 12:36:10AM +0000, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> Usually when closing a crypto device (eg: dm-crypt with LUKS) the
> volume key is not required, as it requires root privileges anyway, and
> root can deny access to a disk in many ways regardless. Requiring the
> volume key to lock the device is a peculiarity of the OPAL
> specification.
> 
> Given we might already have saved the key if the user requested it via
> the 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no
> key was provided here and the locking range matches. This allows
> integrating OPAL with tools and libraries that are used to the common
> behaviour and do not ask for the volume key when closing a device.
> 
> If the caller provides a key on the other hand it will still be used as
> before, no changes in that case.
> 
> Suggested-by: Štěpán Horáček <stepan.horacek@gmail.com>
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---

But it would be quite the change in behavior for existing users, no?

It might be better to add an ioctl that would allow to set an option on
the opal device after it was opened which marks it as closable without
providing the key?
