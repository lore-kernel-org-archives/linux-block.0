Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA7C001B0
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 07:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjHKHAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 03:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHKHAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 03:00:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8551FCF;
        Fri, 11 Aug 2023 00:00:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F4DC21869;
        Fri, 11 Aug 2023 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691737245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TvYKLMWI/NIom9JlPXN9nqU6UcIqiomj19OoorV1z4=;
        b=GUQUpr+co5mgg/Pi8/bOOJF9VT4yYnHTaeGqRgFmO7+hMcgg9QRNpBz+ilmjsf/jD71cJV
        ss2PLx92jRXMWTD3lTwW69vvl0LsjrovZbct3sAX4P0po50CUl6rUauhr7/CJsN5lOXUmw
        3O5w3A/wuoH4IHLmuA2jC2YCKDUFuik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691737245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TvYKLMWI/NIom9JlPXN9nqU6UcIqiomj19OoorV1z4=;
        b=Pb1Xp+tIIYlDANA863XfyQzRL1PduODU1FM+DkwqpQWBqULqBKvhcrPhXf5MNdyAWgATaq
        v0TU3tHT93fn8NCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4911113592;
        Fri, 11 Aug 2023 07:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Sa5EJ3c1WReWwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 07:00:45 +0000
Date:   Fri, 11 Aug 2023 09:00:47 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 00/12] Switch to allowed_host
Message-ID: <2u7xe3szftmoeicayxahqt6r44lgkwl6owvmlkjpby4mqvu6hh@pq2gfkgw6p6e>
References: <20230810111317.25273-1-dwagner@suse.de>
 <xpoocad2nthor6naxp35h5qiz3oqxpijp5qds5qao6aguh6fp5@6fyygawm7kfq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xpoocad2nthor6naxp35h5qiz3oqxpijp5qds5qao6aguh6fp5@6fyygawm7kfq>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 11, 2023 at 06:16:45AM +0000, Shinichiro Kawasaki wrote:
> > So we could return the nvmedev from _nvme_connect_subsys() but I don't know if
> > this a good idea.
> 
> IMO, it is a good idea to make _nvme_connect_subsys() return the device. The
> similar function _nvmet_passthru_target_connect() does that, so it is another
> small goodness to have consistency between the two.

Sure, I'll look into this when I remove the udev trigger filter code
again which resulted in this series. But let's get this series sorted
out first.

> > FWIW, it would also fix the current problem we face with
> > nvme/047 which seems to lack the second _find_nvme_dev() call.
> 
> I posted the fix patch for the nvme/047 problem reflecting your comments. I hope
> that fix settled before further refactoring.

Yep, let's get the bug fix in first.

> It is a fun to see the much of the boiler plates go away with the
> series :)

Ineed, makes the test way smaller.

BTW, what do you think about removing nvme/006 and nvme/007? They are
basically doing nothing anymore except setting up a target with either
device or file backing. We exercise this code now in all the other
tests. So this is bit redundant IMO.

> Thanks. I provided two minor comments on the 5th patch and 10th patch. Other
> than that, this series looks good to me. Also I did another trial run, and
> saw no regression. Good.

I've updated the series accordingly. Let me run a quick test and then I
post the update.
