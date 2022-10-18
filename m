Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019E4C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiJRVNS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJRVNP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 17:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E3C695F
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666127593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/gc72XiUFWICKTdAlvnq76Fw5Q77LW9+ndBebJynHs=;
        b=U8FPrFYo39rEbPjMXg6KlKwFIxKNAve6v2Ag5Emct80obz8D1IP95TfRImvc/+xZwVG0MR
        7mxpAxgXjbiV88YXAaN7xqSCH0tApiGeuwYUF9YK9joN7diqqKT2uMsJwwSMmnrsCCOEwZ
        AzeVd6IzFnq5PM97mdN9L368lZNtzRs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-s1hj2CdNMsqZTFHgeEakvA-1; Tue, 18 Oct 2022 17:13:11 -0400
X-MC-Unique: s1hj2CdNMsqZTFHgeEakvA-1
Received: by mail-qv1-f71.google.com with SMTP id eu10-20020ad44f4a000000b004b18126c4bfso9373832qvb.11
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 14:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/gc72XiUFWICKTdAlvnq76Fw5Q77LW9+ndBebJynHs=;
        b=BA7ajAoZDScVnLyWJ0JwUVN3hHS360Tc6emrWzrS89VXfBPLxpL5mc4cIJp+Ek3q0m
         MQiLxAUeaURyyNbkJDdU/i6xunGhT7nbcjSxtmor3B/3c2SWzMZGpS+5NJEK33HFldgY
         oYtmxEFDf2ffp3Z8w9CQcDiCRxYkUhdGf14Wv7x5PmLu/Hr2FlTJaq4erUn7mObIkAa5
         ce7hxHypd94pZQBHnP8KOBUfaL5kg4YdhwS7y6FnPHedIMgRok5In490iY6A2TRD19p8
         SbmanKg2/QfaUaGdZNF/kxYttlrY19esRMPEK83srCgqDsEACJ5TE1j8WNusEbSrGkzL
         nMBw==
X-Gm-Message-State: ACrzQf0dr5NZ0vsIWto5F84ZGRhnYGScmB2SWG8fU7skS1di2tuDNqzN
        X0UjdqC+hq/GuQlyajYOKSka4Oxo0FJxn8tsglsjOkgi6o4KG/8SLzuP8c1FdhJh7l/mqVYVtny
        Ms5jcpm+U4DfjtUxdPjXlTg==
X-Received: by 2002:a05:620a:14a3:b0:6ee:c7a4:b4b with SMTP id x3-20020a05620a14a300b006eec7a40b4bmr3389195qkj.659.1666127591439;
        Tue, 18 Oct 2022 14:13:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tprRqPkzOHwP2yvNh0ctg1/eFfU8Q5Y12c9iV6fTHVoljBTgNHbU/J+eSkAsn2Djn7+d+dA==
X-Received: by 2002:a05:620a:14a3:b0:6ee:c7a4:b4b with SMTP id x3-20020a05620a14a300b006eec7a40b4bmr3389177qkj.659.1666127591182;
        Tue, 18 Oct 2022 14:13:11 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a258500b006bb366779a4sm3085799qko.6.2022.10.18.14.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 14:13:10 -0700 (PDT)
Date:   Tue, 18 Oct 2022 17:13:09 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Milan Broz <gmazyland@gmail.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [git pull] device mapper changes for 6.1
Message-ID: <Y08W5Tj1YC8/BZDM@redhat.com>
References: <Y07SYs98z5VNxdZq@redhat.com>
 <Y07twbDIVgEnPsFn@infradead.org>
 <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
 <CAHk-=wiE_p66JtpfsM2GMk0ctuLcP+HBuNOEnpZRY0Ees8oFXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiE_p66JtpfsM2GMk0ctuLcP+HBuNOEnpZRY0Ees8oFXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18 2022 at  3:19P -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Oct 18, 2022 at 11:54 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But no, we absolutely do *not* want to emulate that particular horror
> > anywhere else.
> 
> Side note: if DM people go "Hmm, a lot of our management really does
> have the exact same issues as 'mount()' and friends, and doing the
> same things as mount does with the whole string interface and logging
> sounds like a good idea", I want to nip that in the bud.
> 
> It's most definitely *not* a good idea. The mount thing is nasty, it's
> just that we've always had the odd string interface, and it's just
> grown from "const void *data" to be a whole complicated set of context
> handling.
> 
> So don't even think about duplicating that thing.
> 
> Now, if some "inspired" person then thinks that instead of duplicating
> it, you really would want to do device mapper *as* a filesystem and
> actually using the fsconfig() model directly and natively, that is at
> least conceptually not necessarily wrong. At what point does a
> "translate disk blocks and munge contents" turn from "map devices into
> other devices" to a "map devices into a filesystem"? We've had loop
> devices forever, and they already show how filesystems and block
> devices can be a mixed concept.
> 
> And no, I'm not seriously suggesting that as a "do this instead".
> 
> I'm just saying that from an interface standpoint, we _do_ have an
> interface that is kind of doing this, and that is already an area
> where a lot of people think there is a lot of commonalities (ie a
> number of filesystems end up doing their own device mapping
> internally, and people used to say "layering violation - please use dm
> for that" before they got used/resigned to it because the filesystem
> people really wanted to control the mapping).
> 
> In the absence of that kind of unification, just use 'errno'.

Mikulas touches on why why using errno isn't useful for DM. And for
DM's device stacking it is hard to know which error spewed to dmesg
(via DMERR, DMCRIT, DMINFO, etc) is relevant to a particular admin
interface issuing the DM ioctl.

So the idea to send the (hopefully useful) error string back up to the
relevant userspace consumer was one task that seemed needed (based on
Milan Broz's various complaints against DM.. which sprang from your
regular remainder that DM's version numbers are broken and need to be
removed/replaced).

Making DM errors more useful to the endpoints causing them was dealt
with head-on with a couple small changes in this pull request. I
didn't think sending useful error strings to userspace was such a
contested design point.

All said, we'll have a look at dealing with your suggested fsconfig
unification (but it seems really awkward on the surface, maybe we can
at least distill out some subset that is common).

Mike

