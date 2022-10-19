Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B934C433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 06:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJSGTA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 02:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJSGS7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 02:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F68604B1
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 23:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02BD61775
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 06:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE66CC433C1;
        Wed, 19 Oct 2022 06:18:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eEj3ILsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666160335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lgNruFtZc4EKeZifv/B1Sh7sE++KTxKWx6axbdbs9c=;
        b=eEj3ILsAwSrt6IrLPjuIVL/NWdn4sGrSHjvuJKsnEk9/EhTdzvdYKRlrKzPCwLHIA4BXrK
        wuiZZn5VxOzZ6+q2dsdZ8OKhy0jEA3k3RaN/MMhPoS8wsuPt07Rly4AmMV2wS30GZeRptB
        cowUjDOvEeFgtMTmB0VGl9vvQetfLBU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f995c9c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Oct 2022 06:18:54 +0000 (UTC)
Date:   Wed, 19 Oct 2022 00:18:52 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: Re: [git pull] device mapper changes for 6.1
Message-ID: <Y0+WzAZMiQAhQdgj@zx2c4.com>
References: <Y07SYs98z5VNxdZq@redhat.com>
 <Y07twbDIVgEnPsFn@infradead.org>
 <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 11:54:49AM -0700, Linus Torvalds wrote:
> I think we have one major interface that is string-based (apart from
> the obvious pathname ones and the strings passed to 'execve()').
> 
> It's 'mount()' (and now fsconfig() etc), and it's string-based mainly
> because it has that nasty "arbitrary things that different filesystem
> may need for configuration"). And it has some nasty logging model
> associated with it too for output.
> 
> But no, we absolutely do *not* want to emulate that particular horror
> anywhere else.

This might ruin your day, but FYI, Netlink

   [...did you already run off screaming at the mention of Netlink?...]

Netlink has the whole "extack" extended acknowledgement mechanism, in
which netlink replies can and do contain error strings. Grep the kernel
for NL_SET_ERR_MSG and you'll see a bunch of these. (And as you
suggested, I wouldn't be surprised if some bad userspaces parse them.)

Jason
