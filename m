Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458AEC25B06
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 18:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiHFSbD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiHFSa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 14:30:58 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1D0BF59
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 11:30:56 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id cr9so813788qtb.13
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 11:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pxCEjkAH/HtacRN5ao0Jtr5KjS1Q4esBp2dJmtS6eP8=;
        b=XoymoGcL5Ear0u2gGaPtznuLkOm/BfdooLjwC8lORFYv8pYBQEZg8VZ97xHYZq8uo+
         PHJ805MAWKOrcoOjoYnLUFF/bdjzHH13lrqtA4arZE2xNB+/zodva2z8hmwSRJsIrNo3
         zmPqYHo7kMbdKl0OVBzlDBDd4vmjPIYt82ELyfPiZSgcK4MDyUPrMraXZ77KrYsRWHDt
         mIM7R1K+l8+6wkiOT2JKZPDbFMM6njGw98febdp5Ybyw5aQm5sOhCoAI1IfQe8fyy9mM
         8RobIVfg2uyqrc7iPNNtJQUGE+N8J9gjAUwql2+fURZv0r7Uk11yYqKahhTX+w/6Tw1R
         ebCg==
X-Gm-Message-State: ACgBeo2+ED7eEXBjKH5VP8xszxRo9LV9n7xAY4iiba1Mdhjvffr/M3v/
        WQGJnKTg+oR8ytTxMreyWqj6
X-Google-Smtp-Source: AA6agR66ihkCqXOqjW9lbXOY78rAT6SFbRYf/9ykxcxvIFPf9ZA8xJwQD2o96NeUzK/ApPFqy2zDuw==
X-Received: by 2002:a05:622a:81:b0:33f:f102:2845 with SMTP id o1-20020a05622a008100b0033ff1022845mr10327415qtw.30.1659810655165;
        Sat, 06 Aug 2022 11:30:55 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id dm16-20020a05620a1d5000b006b8cb64110bsm6053398qkb.45.2022.08.06.11.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 11:30:54 -0700 (PDT)
Date:   Sat, 6 Aug 2022 14:30:53 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [git pull] Additional device mapper changes for 6.0
Message-ID: <Yu6zXVPLmwjqGg4V@redhat.com>
References: <YugiaQ1TO+vT1FQ5@redhat.com>
 <Yu1rOopN++GWylUi@redhat.com>
 <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 06 2022 at  2:09P -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Aug 5, 2022 at 12:10 PM Mike Snitzer <snitzer@kernel.org> wrote:
> >
> > All said: I think it worthwhile to merge these changes for 6.0, rather
> > than hold until 6.1, now that we have confidence this _optional_ DM
> > verity feature is working as expected. Please be aware there was a
> > small linux-next merge fixup needed:
> > https://lore.kernel.org/all/20220805125744.475531-1-broonie@kernel.org/T/
> 
> Well, more importantly, the verity_target version numbers clash.
> 
> I used the newer "{1, 9, 0}" version number, but if you want it to be
> "{1, 9, 1}" to show that it's a superset of the previous one, you
> should do that yourself.

You did the right thing.
 
> That said, the best option would be to remove version numbers
> entirely. They are a completely broken concept as an ABI, and *never*
> work.
> 
> Feature bitmasks work. Version numbers don't. Version numbers
> fundamentally break when something is backported or any other
> non-linearity happens.
> 
> Please don't use version numbers for ABI issues. Version numbers are
> for human consumption, nothing more, and shouldn't be used for
> anything that has semantics.

Yes, I know you mentioned this before and I said I'd look to switch to
feature bitmasks. Yet here we are. Sorry about that, but I will take
a serious look at fixing this over the next development cycle(s).

There is just quite a bit of innertia in these version numbers across
all the disparate userspace tools that use DM. So the transition needs
some design, planning and coordination but I'll get it done. Really ;)

Thanks,
Mike
