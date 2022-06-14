Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78341C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 13:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245092AbiFNNSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245034AbiFNNSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 09:18:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C25E3B005
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 06:18:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F1F001F938;
        Tue, 14 Jun 2022 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655212683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k7ik43IYpCqlEUWd+PaN9CxA5BJQymri7NcHlOhPJso=;
        b=CnY2eLiIoofDRwEnJRPtnWniNrjh+JDI4rzky1cNT7BOzQhEBEHXKgmqkF+otvXeQLJmX5
        JQILfp6GAOx8tTdnygVbd20sYOegGnaEG9S9zQWU7mcqqRxXxTsXcWvW/C1KFTjMBt5oQM
        cx9eRyAIe3pJLY6dZbMOOnLne2sBUVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655212683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k7ik43IYpCqlEUWd+PaN9CxA5BJQymri7NcHlOhPJso=;
        b=jodfOgAesKydB8FC01HQpzqwY3wZSx8VD5/q6agnrqPyVWaKOt3+kxt0cYxtDZrBbuXOuc
        MlvkySppca7eUOAQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4CA82C141;
        Tue, 14 Jun 2022 13:18:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 88AECA062E; Tue, 14 Jun 2022 15:18:03 +0200 (CEST)
Date:   Tue, 14 Jun 2022 15:18:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jan Kara <jack@suse.cz>, "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: Ignore errors from wait(1)
Message-ID: <20220614131803.hwoykpwzfh6pxmda@quack3.lan>
References: <20220613151721.18664-1-jack@suse.cz>
 <20220614070454.5tcyunt53nqf3y7q@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614070454.5tcyunt53nqf3y7q@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 14-06-22 07:04:54, Shinichiro Kawasaki wrote:
> On Jun 13, 2022 / 17:17, Jan Kara wrote:
> > Multiple blktests use wait(1) to wait for background tasks. However in
> > some cases tasks can exit before wait(1) is called and in that case
> > wait(1) complains which breaks expected output. Make sure we ignore
> > output from wait(1) to avoid this breakage.
> 
> Hi Jan, thanks for the patch.
> 
> May I know how to create the wait(1) complaint message? I added sleep
> command before the waits to ensure the background tasks completed, but
> was not able to see message by wait on my test system. I suspect it may
> depend on bash version.

Yes, I suspect it depends on the shell as well (because otherwise I expect
people would hit this much earlier than me :). The bash I have is
"4.4.23(1)-release" - the one in openSUSE 15.3 and it shows the error
pretty reliably...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
