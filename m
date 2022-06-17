Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B2FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 14:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382921AbiFQOyf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377916AbiFQOyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 10:54:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A51903D
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 07:54:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9612A1F897;
        Fri, 17 Jun 2022 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655477671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akjka3CBR0FDkmWIsDtLaxLO7uM/QsUP4zBcXiHpcZQ=;
        b=TVnlIG0LtcA/I5Sta3ycbBwiP/VOVRTslpkOqYGJDVghVl6rq+HoqYiDYNduHRn7dbACjh
        KubQAIC560MzY5rDWo6AnbFU3jJP9kE98RYZx/PY3i48Zk6KWmVA5kQ89uJNN7Mul4MSsr
        A7A7YfU9VRcVhG9eBH4Cej/v97pnyNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655477671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akjka3CBR0FDkmWIsDtLaxLO7uM/QsUP4zBcXiHpcZQ=;
        b=KSXD9vkmm/4gMoXglkqae/5cjswv6ILUsqJy2heeu00PzTyySPSU41SUmAtWUYrBK5nE8I
        E9+GJ1vkmkZhlnAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CBCE92C141;
        Fri, 17 Jun 2022 14:54:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 490D3A0634; Fri, 17 Jun 2022 16:54:23 +0200 (CEST)
Date:   Fri, 17 Jun 2022 16:54:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Message-ID: <20220617145423.wiff6pn4kufgtwr2@quack3>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
 <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
 <20220616112303.wywyhkvyr74ipdls@quack3.lan>
 <20220616122405.qifuahpn2mhzogwd@quack3.lan>
 <6dc7d961-7129-e143-01be-5d086bf7be43@opensource.wdc.com>
 <20220617114933.vn3ffx5vqmjcbnsp@quack3>
 <ef6c0c90-2f9e-12ed-5ad1-8d1500f5f502@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6c0c90-2f9e-12ed-5ad1-8d1500f5f502@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 17-06-22 21:03:45, Damien Le Moal wrote:
> On 6/17/22 20:49, Jan Kara wrote:
> > On Fri 17-06-22 09:04:34, Damien Le Moal wrote:
> >> 2) If IOPRIO_WHO_USER is not set, ioprio_get(IOPRIO_WHO_USER) will also
> >> return the effective priority.
> > 
> > This is the same as above. Just the calls iterate over all tasks of the
> > given user...
> > 
> >> 3) if IOPRIO_WHO_PROCESS is not set, return ? I am lost for this one. Do
> >> you want to go back to IOPRIO_CLASS_NONE ? Keep default (IOPRIO_CLASS_BE)
> >> ? Or switch to using the effective IO priority ? Not that the last 2
> >> choices are actually equivalent if the user did not IO nice the process
> >> (the default for the effective IO prio is class BE)
> >  
> > I want to go back to returning IOPRIO_CLASS_NONE for tasks with unset IO
> > priority.
> 
> And that would be to retain the older (broken) behavior. Because if we
> consider the man page, tasks with an unset IO prio should be reported as
> having the effective IO nice based priority, which is class BE if IO nice
> is not set. Right ? I am OK with that, but I think we should add this
> explanation as a comment somewhere in the prio code. No ?

Adding a comment regarding this is certainly a good idea, I'll do that. WRT
whether the old behavior is broken or not - I actually think the old
behavior is more useful because it allows userspace to distinguish a
situation when IO priority is set based on nice value from a situation when
IO priority is set to a fixed value. Also the old behavior makes

  ioprio_set(pid, IOPRIO_WHO_PROCESS, ioprio_get(pid, IOPRIO_WHO_PROCESS))

a noop which is IMO a good property to have for a get/set APIs.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
