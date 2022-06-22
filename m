Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE97C43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 16:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376653AbiFVQYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376990AbiFVQXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 12:23:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57241263C
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 09:23:47 -0700 (PDT)
Received: from localhost (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B415B66015CD;
        Wed, 22 Jun 2022 17:23:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655915025;
        bh=7jK8s9/W/gt2U4aZWS65uxMScHOkggxJ2GOomjy9Ydg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EvTErX90SwKDAtdVEE1TPddu7wzpiy6HsN9CEskwm80kJOWUgxZp5Gkr9T3tn2ZM4
         5bBfimBG9qtHlSNFCWzMIDCKAUBG9l62L49RJg46/AcOo9M4QvLKISX7HkLuUl6Gb4
         Ep5rLKm/Y5Nj2zV8UgWHSA+DyTwGQB6j3CpTpBxUTcp6VXEA7wvJXLaNz0fcxb1xUI
         GGWmyj7p/jP27ypk/3U48vjTSNW4LUpup07asPUz3abYaa4wbhvC3kcFkc7cMnG3WC
         t7+ho184z/lP/vZGl72RB6IG1jtkEvTjPAYMeLPIkCpvIwImvxGwZ4NSSxN0GoPVBO
         5G2myywKlp/lg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH ubdsrv] tgt_null: Return number of sectors read/written
Organization: Collabora
References: <20220621224839.76007-1-krisman@collabora.com>
        <YrJgDO9JD/le5tKK@T590>
Date:   Wed, 22 Jun 2022 12:23:42 -0400
In-Reply-To: <YrJgDO9JD/le5tKK@T590> (Ming Lei's message of "Wed, 22 Jun 2022
        08:19:24 +0800")
Message-ID: <87k0983bw1.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

> On Tue, Jun 21, 2022 at 06:48:39PM -0400, Gabriel Krisman Bertazi wrote:
>> Hi Ming,
>> 
>> I wrote this against your devel-v3 branch.  I'm wondering if you plan to
>> send a new version of the kernel patch soon? From the latest
>
> Yeah, that is on my todo list:
>
> https://github.com/ming1/linux/commits/my_for-5.19-ubd-devel_v3
>
> there has lots cleanup & improvement.
>
>> discussions, I don't think there were major issues found on review. :)
>
> One problem is the driver name, and Christoph thought we have
> 'arch/um/drivers/ubd*.c'. Not thought of one good candidate yet.

Hi Ming,

Thanks for the info, and sorry for not noticing the fix merged on Jun, 3rd
on the master branch.  I will follow that branch when testing and submit
fixes I find along the way.

I guess you have considered a lot of names, but I'd suggest any of:

 * blkuser,
 * ublk
 * BUSE (as in Block FUSE, though there is another non-upstream
project with that name),
 * UBIO (as in UIO, but for Block IO)
 * B2U (Block IO Backed by userspace) :-P

TBH, my favorite is ublk.

Thank you,

-- 
Gabriel Krisman Bertazi
