Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF8EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 13:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF2NUv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjF2NUv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 09:20:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F6F213D
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 06:20:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D34F121860;
        Thu, 29 Jun 2023 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688044848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTPz/0S5t8N6Y/Ld/7flnTAQfJ+yK7PmtkcvKny5djE=;
        b=OoaBK71uyQBvCESxRlCOa1LGhiO2Z7QQePxf1fUhW0SAs5w/+uiYrnkphQ9ikYkmPvuRZx
        Id5VNJDJXcpY7xtgFZT9rn2cpz5Ctjq0/SabOyuZL1Chy9DrDs7ssXc9jyQDn5ovpRpsyJ
        sPp4iaPaFsHTs+kAhg4hL3wI9fl9rRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688044848;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTPz/0S5t8N6Y/Ld/7flnTAQfJ+yK7PmtkcvKny5djE=;
        b=/vDXQyaY6OVb6S5wFP7m5nGyO7r3Vds2wToPArmbm7rae5tKhSb/oVvAnZI3EGNkGMrAOx
        0gctPXz7rT0lraBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4961139FF;
        Thu, 29 Jun 2023 13:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PAj8LzCFnWTRdAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 29 Jun 2023 13:20:48 +0000
Date:   Thu, 29 Jun 2023 15:20:48 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Message-ID: <ajcm6yupguickaucansiuzjqatyz5qijnnp4topxv64cisbblc@4sgv3bd3jl4q>
References: <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
 <d5d9bd87-1d5b-d66c-39c4-e35c0e5ddc48@nvidia.com>
 <94785130-4f40-aa29-9232-af8a8f1ca1c9@nvidia.com>
 <7d6m3ha3rqc73q22d4bsxtc4u2cqb4ryp6f4q7ajvazdpek2ko@nh6a6biyryxd>
 <0ad16fbf-6835-50ac-443b-46443c8656e8@nvidia.com>
 <yqwto3tm4wjgowmavc3unucq47hf5xeeqsp5baqggtzo75nmu2@4o5pbethrqcw>
 <f2dbfd74-32ec-6a4a-bec3-2007b3588154@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2dbfd74-32ec-6a4a-bec3-2007b3588154@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 29, 2023 at 03:18:26PM +0300, Max Gurtovoy wrote:
> > Is there a specific reason why we want to read the /etc/nvme/hostnqn file at
> > all? Can't we just use a fixes hostid/hostnqn?
> 
> Yes, this will do the job but I guess the initial thought was to use the
> same hostnqn/hostid that one configured to the host also for testing.
> 
> I don't have a real preference between the two.

If we don't use the host hostnqn, we can make the connect attempt filtering more
relieable. This didn't matter so far for tcp/rdma/loop but with the fc enabling
it gets relevant. I think we could get away with using the host hostnqn but I
am not convienced we have all corner cases covered yet. We can add some more
test with fancy setups for this specific scenario later. I'd just like to have
blktests as reliable as possible.

Here some more background on this:

https://lore.kernel.org/linux-nvme/ygfgqglmntpqiopzq44aqegehnlroarteqjtmih7mulan4oukv@jmtupz2jnafv/
