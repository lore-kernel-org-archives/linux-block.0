Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE43C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 07:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjG0HTt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 03:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjG0HT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 03:19:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E254459FA;
        Thu, 27 Jul 2023 00:12:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F137921A5E;
        Thu, 27 Jul 2023 07:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690441892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=at8qZJllNklpGVvIglzagPpypbwOZ001CdqDVCWZu6k=;
        b=w7UDgFoQSOafNyVdsVyqv/2IIJgCUEPKxyO6lVBGxD2hkzElIAWs9IXUBr2sCFROV55N9N
        p11HN0kvLet0EapcAlhM56qUtMNDb4h4afvc0mACYm6uo1q665exjOuQuDHM+l5c3fnoEu
        ISIOteqUwr9dXDRLGhd9m3iUlXNIx/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690441892;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=at8qZJllNklpGVvIglzagPpypbwOZ001CdqDVCWZu6k=;
        b=y3J02R5VwGsZCFslJw1lvKSEl5FQRLBcjcU3HlZVi0UhXYU+IAvHBxUtrKec8eIz1S5/0U
        cqaGUlNAgZ+wyWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2C7A138E5;
        Thu, 27 Jul 2023 07:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L5vVNqQYwmSeKgAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 27 Jul 2023 07:11:32 +0000
Date:   Thu, 27 Jul 2023 09:11:32 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Message-ID: <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
 <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 26, 2023 at 07:54:24AM -0700, Bart Van Assche wrote:
> On 7/26/23 05:46, Daniel Wagner wrote:
> > Group all variable declarations together at the beginning of the
> > function.
> 
> An explanation of why this change has been proposed is missing from the
> patch description.

Sure, I'll add one. The coding style to declare all local variables at the
beginning of the function.

> I think the current style, with variable declarations occurring just before
> the first use of a variable, is on purpose. I like that style.

The majority of functions declare variables at the beginning of the functions.
As you can see these are only a handful of declerations which do not adhere to
the coding style.
