Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 19 Jan 2022 21:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357423AbiASVeW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jan 2022 16:34:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59882 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbiASVeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jan 2022 16:34:20 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C87B2212C2;
        Wed, 19 Jan 2022 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642628058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/XD3BhU9gKU6gAhDDZMnCRRvpLQmbyUu0KFdcA/+FM=;
        b=d1Y9dir3vbQ88YRRr8cpBXogIS0z8g1Z7eBbii9rTQCuxdpc8geXPRcFkhjk/an+zRReEG
        DcWUltC4KVzTIQ2ouhrWxEXH/PDxax8jsk4D0MYoljBZZCXKwzwsEBk4kOYWnznrlpC14n
        7Lm78SE7j1AoUF0251OQRKWpULOHCi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642628058;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/XD3BhU9gKU6gAhDDZMnCRRvpLQmbyUu0KFdcA/+FM=;
        b=iRNVDL5z+sK4C7mvJiGxjDeKzCUnPIOiIzQFqbEFShGktrxp+sznR8ygTBoO4n70OLWAV3
        8UWH8wiNv5/rEnBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BAFA7A3B83;
        Wed, 19 Jan 2022 21:34:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39CA8A05E7; Wed, 19 Jan 2022 22:34:15 +0100 (CET)
Date:   Wed, 19 Jan 2022 22:34:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, util-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: Racy loop device reuse logic
Message-ID: <20220119213415.csieaktdqmshemiy@quack3.lan>
References: <20220113154735.hdzi4cqsz5jt6asp@quack3.lan>
 <20220119085247.duhblxzp6joukarw@quack3.lan>
 <28a360a3-b559-24ec-6c3d-3fe6e8302393@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a360a3-b559-24ec-6c3d-3fe6e8302393@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 19-01-22 20:30:52, Tetsuo Handa wrote:
> I found a way to avoid this race by splitting lo_open() into two phases
> using task_work_add().  Christoph Hellwig is trying to take a look at
> https://lkml.kernel.org/r/f6b947d0-1047-66b3-0243-af5017c9ab55@I-love.SAKURA.ne.jp
> .

No, you have found a way to make the race window for mount(8) smaller. And
I still disagree with that kernel change because it is making kernel more
complex only to make the race window smaller. On another machine or with
different scheduling decisions, you can still hit this race. This problem
must be fixed in mount...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
