Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C5EC28B2B
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 17:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351947AbiHSRnU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349610AbiHSRmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 13:42:55 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BD133A78
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 10:02:16 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id z23so471142uap.10
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 10:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Yo4HQghq96bfV4LNacSeJI1n2EGdkEyWB3i5OegOjHQ=;
        b=bCiWFEo086tnCMudf3YkBoPVmvvM5C8JOuHVW1sAKiXYG/OYLrbdhYxjkJKCJ+qep9
         LuVM4SLR5pXcvZesh3Qc++Z5lUFEFSVtdaQjOtiOh8jmEl5r6MlMRHqncJwzwMVdi6DK
         KEBv3cE6SPpj/dv4U3WMxOL/FfInKKm/pkf3pwvyR9JEL7o7p6qzpy5v8K6bZdCwOpPY
         kjvXiUUjBPrE+tv5h8Lrk158t8CnPeGxbMjPNw0FwzP1Tkoekc5FONnGiUWY2X9V9i4u
         VMwRhdlHQY1M0EVDV4NsZjnFCFjiFG9d88dgGp2W98IsEOKu9u6KyM+UJeaYBo+ZEk88
         GM1g==
X-Gm-Message-State: ACgBeo2rHNGipfkzgGHY6N1Tn39QXF2XXtfppgDGt9Fk3XK6z12P+cri
        aZMYMjTpjptS+4AvePyRasYnhow1TmzM9Q==
X-Google-Smtp-Source: AA6agR5d35CroRzROB1OzgRfE0tc1+jy8zSkIdw0qxnZ2p4UeaBBoIu23+MdK/hVWYHalaq9txJw2g==
X-Received: by 2002:ab0:2684:0:b0:38d:25e:9444 with SMTP id t4-20020ab02684000000b0038d025e9444mr3178958uao.92.1660928534378;
        Fri, 19 Aug 2022 10:02:14 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id s5-20020ac5cb45000000b0037772cb2458sm2852043vkl.25.2022.08.19.10.01.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 10:01:34 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id g17so1445659vkk.6
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 10:01:11 -0700 (PDT)
X-Received: by 2002:a1f:a856:0:b0:376:c61f:2f1e with SMTP id
 r83-20020a1fa856000000b00376c61f2f1emr3331263vke.35.1660928468150; Fri, 19
 Aug 2022 10:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220816140713.84893-1-luca.boccassi@gmail.com>
 <CAMw=ZnRSV3uF+HFjvL5Fdb_S_RB=3YrWT4ZqtG9e4ZmJTpehVQ@mail.gmail.com> <36444e6a-c766-051c-011d-2e28b63ac714@kernel.dk>
In-Reply-To: <36444e6a-c766-051c-011d-2e28b63ac714@kernel.dk>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 19 Aug 2022 18:00:56 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnTeyRtQPvYiPF4w9XkzsQ3+pciCR3_-ei6-HwP3HLGtvA@mail.gmail.com>
Message-ID: <CAMw=ZnTeyRtQPvYiPF4w9XkzsQ3+pciCR3_-ei6-HwP3HLGtvA@mail.gmail.com>
Subject: Re: [PATCH v7] block: sed-opal: Add ioctl to return device status
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 19 Aug 2022 at 17:53, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/19/22 4:45 AM, Luca Boccassi wrote:
> > On Tue, 16 Aug 2022 at 15:07, <luca.boccassi@gmail.com> wrote:
> >>
> >> From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> >>
> >> Provide a mechanism to retrieve basic status information about
> >> the device, including the "supported" flag indicating whether
> >> SED-OPAL is supported. The information returned is from the various
> >> feature descriptors received during the discovery0 step, and so
> >> this ioctl does nothing more than perform the discovery0 step
> >> and then save the information received. See "struct opal_status"
> >> and OPAL_FL_* bits for the status information currently returned.
> >>
> >> This is necessary to be able to check whether a device is OPAL
> >> enabled, set up, locked or unlocked from userspace programs
> >> like systemd-cryptsetup and libcryptsetup. Right now we just
> >> have to assume the user 'knows' or blindly attempt setup/lock/unlock
> >> operations.
> >>
> >> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> >> Tested-by: Luca Boccassi <bluca@debian.org>
> >> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> >> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> >> ---
> >> v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> >> v3: resend on request, after rebasing and testing on my machine
> >>     https://patchwork.kernel.org/project/linux-block/patch/20220125215248.6489-1-luca.boccassi@gmail.com/
> >> v4: it's been more than 7 months and no alternative approach has appeared.
> >>     we really need to be able to identify and query the status of a sed-opal
> >>     device, so rebased and resending.
> >> v5: as requested by reviewer, add __32 reserved to the UAPI ioctl struct to align to 64
> >>     bits and to reserve space for future expansion
> >> v6: as requested by reviewer, update commit message with use case
> >> v7: as requested by reviewer, remove braces around single-line 'if'
> >>     added received acked-by/reviewed-by tags
> >>
> >>  block/opal_proto.h            |  5 ++
> >>  block/sed-opal.c              | 89 ++++++++++++++++++++++++++++++-----
> >>  include/linux/sed-opal.h      |  1 +
> >>  include/uapi/linux/sed-opal.h | 13 +++++
> >>  4 files changed, 96 insertions(+), 12 deletions(-)
> >
> > Hello Jens,
> >
> > Is there anything else I can do for this patch? I've got two acks. We
> > really need this interface in place to start working on supporting
> > sed/opal in cryptsetup.
>
> It's just bad timing, since we just left the merge window. I'll queue it
> up when I open up the block bits for 6.1.
>
> --
> Jens Axboe

Thanks!

Kind regards,
Luca Boccassi
