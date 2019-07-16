Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6935BC76188
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 07:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279492145D
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 07:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnJPg2QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfGPHTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 03:19:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37156 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfGPHTD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 03:19:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so17492141wme.2;
        Tue, 16 Jul 2019 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bx/KFm3cqSlZyhuHDofn606P1oa0FUQNCP5QNNyOFgw=;
        b=nnJPg2QZh53Zas817XMxn8lisZXZUCOcFwQcwa8yxYdfnKunVhSfStLFPLxTp+waPL
         NBLucqxAUNbcAbkCmlAn/MyTyCIdNbyy1+VrmjlfAcVeuIMuK4+Da6FqQBtLU8Yh6LmC
         xS/LcX9ME5DBB3JJxi9lkgvaFFDtYiPYIW3Obw4aeqP6sMyE8yRCT81eZcOIYRXnorG4
         Q1YXktXid1gl95/ptR43r7Tei6uSpLIQDnebW3yL76KDUy20/mm6Wi4B5IlihtqQg13F
         VK+d+4o5J0COvu4jmZy5Gw1DP3N4KpreVGG0P1QR8JkH7NYaFkaLZUc1Ei4DaXgWvEB7
         na7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bx/KFm3cqSlZyhuHDofn606P1oa0FUQNCP5QNNyOFgw=;
        b=HbAHTbICKh6778rjGGhx+fKus9CDjPj1RBooNZFQk3GGpRrOrQwQ/+/nmULDLA7a4e
         cpRsSKF5mCjGouhU48fJCOSPd75SV6EQz5gS1VavmRn9mOLFNsO+sxL13JJkoh3E13XM
         7IDtEgnbJPbc5IAHlo/szXfwfKCRwnoaFz9EGWfF+ebyR1yr5nNJfufgAKO9f9EyIMor
         Kz6N0msSVKXTMvb8WWGXhAsd6d1hkdxIAnlwUQHBnJ3XQX9OlXbtUtg5bUAryRuxt5O0
         1JPLLXbIOqxpWUexftjC9Mi0NMKYQhTtDeTtHhiaAx/uyQqtjiXpnk9OkJNfemONC8j8
         SkIA==
X-Gm-Message-State: APjAAAWF6icDwOzacqQ7zrMe2ab/kRzY24vaC2+UETGtP/Tfu5Xd/IV0
        kuwhUhaSFWZItcv/gxbLlENc++fvvDZEZqOTK+k=
X-Google-Smtp-Source: APXvYqzfvuRmeyaOz0YgxOuMDaMxzw0ByeQOZXOD9qSWJreRuAldWETn7V+LIMoUVps8poILPN6LlqNHBEYQtZwi7E4=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr27210181wme.173.1563261541440;
 Tue, 16 Jul 2019 00:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190712024726.1227-1-ming.lei@redhat.com> <c2c83d98-2012-13af-ab46-5a28303c0f87@huawei.com>
In-Reply-To: <c2c83d98-2012-13af-ab46-5a28303c0f87@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 16 Jul 2019 15:18:49 +0800
Message-ID: <CACVXFVPz49Sp7cOE-HLKWp9iMC-XJVaROx8L5Oj+-+GvK4QhCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] blk-mq: improvement on handling IO during CPU hotplug
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi John,

On Tue, Jul 16, 2019 at 2:55 PM John Garry <john.garry@huawei.com> wrote:
>
> =E5=9C=A8 12/07/2019 10:47, Ming Lei =E5=86=99=E9=81=93:
> > Hi,
> >
> > Thomas mentioned:
> >      "
> >       That was the constraint of managed interrupts from the very begin=
ning:
> >
> >        The driver/subsystem has to quiesce the interrupt line and the a=
ssociated
> >        queue _before_ it gets shutdown in CPU unplug and not fiddle wit=
h it
> >        until it's restarted by the core when the CPU is plugged in agai=
n.
> >      "
> >
> > But no drivers or blk-mq do that before one hctx becomes dead(all
> > CPUs for one hctx are offline), and even it is worse, blk-mq stills tri=
es
> > to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> >
> > This patchset tries to address the issue by two stages:
> >
> > 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> >
> > - mark the hctx as internal stopped, and drain all in-flight requests
> > if the hctx is going to be dead.
> >
> > 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx become=
s dead
> >
> > - steal bios from the request, and resubmit them via generic_make_reque=
st(),
> > then these IO will be mapped to other live hctx for dispatch
> >
> > Please comment & review, thanks!
> >
>
> Hi Ming,
>
> FWIW, to me this series looks reasonable.

Thanks!

>
> So you have plans to post an updated "[PATCH 0/9] blk-mq/scsi: convert
> private reply queue into blk_mq hw queue" then?

V2 has been in the following tree for a while:

https://github.com/ming1/linux/commits/v5.2-rc-host-tags-V2

It works, however the implementation is a bit ugly even though the idea
is simple.

So I think we may need to think of it further, for better implementation or
approach.

Thanks,
Ming Lei
