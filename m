Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FE1C04A95
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 03:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiI1D4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 23:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI1D4l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 23:56:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5261129F7
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 20:56:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cj27so7275170qtb.7
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=VdDdT0KA+qYfMvfk0utv752G9/f13S09k+XIMqQkf2Y=;
        b=WNsHLip4DFniGLTPsxPL7KTTmwHvOn2zwTOlMu+NitwYCgUYEb/QxiK3wfybBIkqlj
         KrzJC7WnxYlyD6Y+33ZvOXJKCtHwPGputwN7IyYjGtdMQ3pVVM9rJjxmh81CPJjXv23F
         GAiKkdae6RM3y2i0Ax47pf0iaA+KwkCJ/v0JLiyIhlnYK3AhrEvnbRcKsfCRiSBY/l99
         e+iL+lQRIDMd15zJK+N+EUuY8S+6sW+empuJOfQOW/yK0QJbxckUzh9mYbiv20cqegCG
         sYcPc1y5T82pm9z/Mawmkeqt8O6pI+9ZADEmyxWxAlLX8Gsgcf0Tu450iRlatWgR/4c7
         GmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=VdDdT0KA+qYfMvfk0utv752G9/f13S09k+XIMqQkf2Y=;
        b=Id2Vp/8jPk/26BCarUzlqEP6GDqsn5pHvIZceGlA7652wPZEK2iPkyQnmN3CrBnvzp
         yUTx/xyscCheBqYLNsTLWMK72/Sz8jvMcl2reFNqMTFCVT7+QLkKFVCuTQB1bZq0C154
         j2eWVwIekBIenNdWRiTCTVe7yaVUbHDzpkgMO7bp9+V1x4wvym2JLCCUwG/aidwgI2wu
         AKRPdYz+s8sPJcq4nUTMDybN1y+7tXgyzuJROD04Omi24v949EoswIHoN87Pxeb33B9z
         FHYPXksV+0eQ5iDnSYoqsfbrCPLhz0f6QhbYt2a57Gn1A4kfVui3sjyHe3N0q8XA/CsX
         Ejhg==
X-Gm-Message-State: ACrzQf0zNndwKzzwMLcuDai7qvuSjHlHzL/ndn/ccllfoWzkXKN4lVYY
        BDkpn05t7bM0MZtjfMCQShsxhw==
X-Google-Smtp-Source: AMsMyM5k5oRHIaGJ7yBwqCbbvF8BNAalVg8m9DiF5TK3zvaMWlSYkhP/VtQ64rUJ+2ViKvdU3Kg2cg==
X-Received: by 2002:a05:622a:207:b0:35d:539e:99f0 with SMTP id b7-20020a05622a020700b0035d539e99f0mr2230422qtx.512.1664337399901;
        Tue, 27 Sep 2022 20:56:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 139-20020a370691000000b006cf14cc6740sm2163079qkg.70.2022.09.27.20.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 20:56:39 -0700 (PDT)
Date:   Tue, 27 Sep 2022 20:56:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jan Kara <jack@suse.cz>
cc:     Hugh Dickins <hughd@google.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <20220927103123.cvjbdx6lqv7jxa2w@quack3>
Message-ID: <2b931ee7-1bc9-e389-9d9f-71eb778dcf1@google.com>
References: <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3> <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com> <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
 <391b1763-7146-857-e3b6-dc2a8e797162@google.com> <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com> <20220926114416.t7t65u66ze76aiz7@quack3> <4539e48-417-edae-d42-9ef84602af0@google.com> <20220927103123.cvjbdx6lqv7jxa2w@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 27 Sep 2022, Jan Kara wrote:
> On Mon 26-09-22 20:39:03, Hugh Dickins wrote:
> 
> So my thinking was that instead of having multiple counters, we'd have just
> two - one counting completions and the other one counting wakeups and if
> completions - wakeups > batch, we search for waiters in the wait queues,
> wake them up so that 'wakeups' counter catches up. That also kind of
> alleviates the 'wake_index' issue because racing updates to it will lead to
> reordering of wakeups but not to lost wakeups, retries, or anything.
> 
> I also agree with your wake_up_nr_return() idea below, that is part of this
> solution (reliably waking given number of waiters) and in fact I have
> already coded that yesterday while thinking about the problem ;)

Great - I'm pleasantly surprised to have been not so far off,
and we seem to be much in accord.

(What I called wake_up_nr_return() can perfectly well be wake_up_nr()
itself: I had just been temporarily avoiding a void to int change in
a header file, recompiling the world.)

Many thanks for your detailed elucidation of the batch safety,
in particular: I won't pretend to have absorbed it completely yet,
but it's there in your mail for me and all of us to refer back to.

> > TBH I have not tested this one outside of that experiment: would you
> > prefer this patch to my first one, I test and sign this off and send?
> 
> Yes, actually this is an elegant solution. It has the same inherent
> raciness as your waitqueue_active() patch so wakeups could be lost even
> though some waiters need them but that seems pretty unlikely. So yes, if
> you can submit this, I guess this is a good band aid for the coming merge
> window.

No problem in the testing, the v2 patch follows now.

> 
> > > 2) Revert Yu Kuai's original fix 040b83fcecfb8 ("sbitmap: fix possible io
> > > hung due to lost wakeup") and my fixup 48c033314f37 ("sbitmap: Avoid leaving
> > > waitqueue in invalid state in __sbq_wake_up()"). But then Keith would have
> > > to redo his batched accounting patches on top.
> > 
> > I know much too little to help make that choice.
> 
> Yeah, I guess it is Jens' call in the end. I'm fine with both options.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
