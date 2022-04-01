Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024CFC433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 09:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbiDAJ2t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344541AbiDAJ2s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 05:28:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A24101F3E
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 02:26:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6E53521A91;
        Fri,  1 Apr 2022 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648805216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpxysyDXwYqqdrB/bQo/cYlqRkZUfYPrLNXnC7lzfYA=;
        b=DREBPebtANSdFlgWylrSbeNJDSoclwB6Um4FxY50X7VIrNXrZB8OsEMxolPx3wz8ip2e+u
        dL/h8be3ScpWA+LIIp/FVsUKx1aJNZg9lyz+y0Nc8JIQeE+EONTDFsqbCvn1Y2fMLDNpPJ
        GeWcqCe3hOBrk+N/JfiyHgCM3Ty0EvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648805216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpxysyDXwYqqdrB/bQo/cYlqRkZUfYPrLNXnC7lzfYA=;
        b=LI7lXFD9XtMRTl2bF/OlFRgAnwFNXL2YVib4T0dLSS2+/xWY2M+qzfLpyObr9SvnxOBqXK
        hmqLKu9xyouREpBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 51DE3A3B87;
        Fri,  1 Apr 2022 09:26:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B32E5A0610; Fri,  1 Apr 2022 11:26:55 +0200 (CEST)
Date:   Fri, 1 Apr 2022 11:26:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/9 v6] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220401092655.l4vnbnbzygld2v33@quack3.lan>
References: <20220330123438.32719-1-jack@suse.cz>
 <ab844fb5-ba5e-6007-91b5-a971c8712354@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab844fb5-ba5e-6007-91b5-a971c8712354@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 01-04-22 11:40:39, yukuai (C) wrote:
> 在 2022/03/30 20:42, Jan Kara 写道:
> > Hello,
> > 
> > with a big delay (I'm sorry for that) here is the sixth version of my patches
> > to fix use-after-free issues in BFQ when processes with merged queues get moved
> > to different cgroups. The patches have survived some beating in my test VM, but
> > so far I fail to reproduce the original KASAN reports so testing from people
> > who can reproduce them is most welcome. Kuai, can you please give these patches
> > a run in your setup? Thanks a lot for your help with fixing this!
> > 
> Hi, Jan
> 
> I ran the reproducer for more than 12 hours aready, and the uaf is not
> reporduced anymore. Before this patchset this problem can be reporduced
> within an hour.

Great to hear that! Thanks a lot for testing and help with analysis! Can I
add your Tested-by tag?

									Honza

> > Changes since v5:
> > * Added handling of situation when bio is submitted for a cgroup that has
> >    already went through bfq_pd_offline()
> > * Convert bfq to avoid using deprecated __bio_blkcg() and thus fix possible
> >    races when returned cgroup can change while bfq is working with a request
> > 
> > Changes since v4:
> > * Even more aggressive splitting of merged bfq queues to avoid problems with
> >    long merge chains.
> > 
> > Changes since v3:
> > * Changed handling of bfq group move to handle the case when target of the
> >    merge has moved.
> > 
> > Changes since v2:
> > * Improved handling of bfq queue splitting on move between cgroups
> > * Removed broken change to bfq_put_cooperator()
> > 
> > Changes since v1:
> > * Added fix for bfq_put_cooperator()
> > * Added fix to handle move between cgroups in bfq_merge_bio()
> > 
> > 								Honza
> > Previous versions:
> > Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
> > Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # v2
> > Link: http://lore.kernel.org/r/20220112113529.6355-1-jack@suse.cz # v3
> > Link: http://lore.kernel.org/r/20220114164215.28972-1-jack@suse.cz # v4
> > Link: http://lore.kernel.org/r/20220121105503.14069-1-jack@suse.cz # v5
> > .
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
