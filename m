Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F8BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 19:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiGOTwC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGOTwB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 15:52:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB5374350
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 12:52:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r2so7116113wrs.3
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/F5vpQ46NuoBpqVudLRR0ofzSsF7XdQq8nDMs9AbuEM=;
        b=js49Vuv+dqdpAQkHI9F+F/qf8Kw2nyiSwKlBIFQQHL7uM7G/SRteANKwRC0D5rutBM
         lRuJ2gi7kPkZDetRJeDugTcS3gtBv1nmqHP8R5VNWwq6v4T1aR3AERqkKtE3B2/cSn2w
         fvkDOT3RSZSEbMjkvSci+PeP6MNGVYzG8f2i65yt77cl/vOjOuR09OrR4tgP2Is8XhXo
         RQSpjQwTlQ/k/CvARRkb9P3CyCFKFRkgFlfuha9660OVH5gAbAniaXjf60OMuXxfq+5g
         jaTWgugHEjZyQFwbx7VEijdfxPo5hzyShYea+6a1HL5g2vXfKHW5bpNf6AR9vvKooiR6
         Av7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/F5vpQ46NuoBpqVudLRR0ofzSsF7XdQq8nDMs9AbuEM=;
        b=LRH3fiDQ9J6JT5zFAIhFXi8zkHnP8BI7uCD7hOtBPrFS0JkDlVE0kaOOMaqy6l57I6
         a5+/xj8M6Dd6gDfjBxTnCt2gtRLEn7grY1oPDdPAeLCTdnlHc3olbCbTuBQT5CDtwH96
         LWWP0vDBSM+mtfF/7vkP6fI8Xw8Ah3+XWR5bjt4WNepe28xu4RtoHxo4jCwYTfstE9aG
         hXaTZ+4sUmAM7yii7pKTn7PU/C5lLtIqRjsJZ8dseWLUDyLPKFO4SHqHUKVQva4TehWT
         Zp+K4eq19XS6JdJ/LeGAM1UBHAOoiLVJR3pc2DQfLqKI7Is5r6C4GTXrcot6OyUX8LSm
         jRlA==
X-Gm-Message-State: AJIora9/Koh6c7uEyaVUfT3mZltMxiQZojZ5hLHiZsLvmeLK0yVUUOia
        mYMjyWLqErkC7B2qN1Qpa7mUoZ6SmL9KNplOqYLi
X-Google-Smtp-Source: AGRyM1tKdyxJ6v9iK9VYvhls34IXjSi0vTfVMFlwee16Wy9Y/gwgKOIz8VCFowTfs82eiFn6mMPxqXEzbs16sJVwfo8=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr13851074wrp.161.1657914719053; Fri, 15
 Jul 2022 12:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220714000536.2250531-1-mcgrof@kernel.org> <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org> <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <YtG5zRPFV967/y0v@bombadil.infradead.org>
In-Reply-To: <YtG5zRPFV967/y0v@bombadil.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Jul 2022 15:51:48 -0400
Message-ID: <CAHC9VhS_dy_qeY=7KnSqs0ZT9dzAbSEyq5WMNKvZTD5=oreGew@mail.gmail.com>
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file op
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     casey@schaufler-ca.com, axboe@kernel.dk, joshi.k@samsung.com,
        linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 15, 2022 at 3:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Fri, Jul 15, 2022 at 02:46:16PM -0400, Paul Moore wrote:
> > It looks like I owe you an apology, Luis.  While my frustration over
> > io_uring remains, along with my disappointment that the io_uring
> > developers continue to avoid discussing access controls with the LSM
> > community, you are not the author of the IORING_OP_URING_CMD.   You
> > are simply trying to do the right thing by adding the necessary LSM
> > controls and in my confusion I likely caused you a bit of frustration;
> > I'm sorry for that.
>
> No frustration caused, I get it.

Thanks for your understanding, I appreciate it as well as your help in
this area.

> > Well, we're at -rc6 right now which means IORING_OP_URING_CMD is
> > happening and it's unlikely the LSM folks are going to be able to
> > influence the design/implementation much at this point so we have to
> > do the best we can.  Given the existing constraints, I think your
> > patch is reasonable (although please do shift the hook call site down
> > a bit as discussed above), we just need to develop the LSM
> > implementations to go along with it.
> >
> > Luis, can you respin and resend the patch with the requested changes?
>
> Sure thing.
>
> > I also think we should mark the patches with a 'Fixes:' line that
> > points at the IORING_OP_URING_CMD commit, ee692a21e9bf ("fs,io_uring:
> > add infrastructure for uring-cmd").
>
> I'll do that.

Great, thanks again for the help.

-- 
paul-moore.com
