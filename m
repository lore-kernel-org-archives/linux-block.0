Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B34C4320E
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 19:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E45E61074
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 19:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbhIATmi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344221AbhIATmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 15:42:37 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA146C061575;
        Wed,  1 Sep 2021 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vWlTtF1Q8Qb+H9Mh5Lyd8cot75BUAmc8fIIm40WTtmY=; b=QJpDbxhMM7k2u/aLZK7AJ5/A6k
        Q2Hu2RuNltNyHzduekKTiEZSVz6hLOIkyWwcUuFc3o5HpS73E42l0WjHsFBSmNgX4nhddKyoTGXCY
        qJ4uWBhNaJljPYqJw9svvfSaliCUIprE8jPp9DOY53OcXpPjCohmfEUFdrC9dtQ9yjSOvmtdN6TJt
        jV+9UWZVPOgUSuRQClBs2WPEGHifPdTQnfIk2Up9ie5WLT4434KelFsys82JeT8WuqsxLCBz4I7qd
        9oCPifEZvFaptipbkFitoghG/b4lZCR85oNvrBf0jCvvnZVJmChcJkOdHkXFd0OWD+3HZVTP2XNdo
        RZWGZ5zw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLW6v-0077go-PV; Wed, 01 Sep 2021 19:41:25 +0000
Date:   Wed, 1 Sep 2021 12:41:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>, justin@coraid.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes.berg@intel.com>,
        chris.obbard@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, thehajime@gmail.com,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Tim Waugh <tim@cyberelk.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Lars Ellenberg <drbd-dev@lists.linbit.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] z2ram: add error handling support for add_disk()
Message-ID: <YS/XZeu3J3nAXUll@bombadil.infradead.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
 <20210830221000.179369-2-mcgrof@kernel.org>
 <CAMuHMdUUrp-ktVmOPRs7KinykrVKEMx-dG42RapPc-egxODNnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUrp-ktVmOPRs7KinykrVKEMx-dG42RapPc-egxODNnQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 01, 2021 at 03:41:47PM +0200, Geert Uytterhoeven wrote:
> > --- a/drivers/block/z2ram.c
> > +++ b/drivers/block/z2ram.c
> > @@ -333,8 +334,10 @@ static int z2ram_register_disk(int minor)
> >                 sprintf(disk->disk_name, "z2ram");
> >
> >         z2ram_gendisk[minor] = disk;
> > -       add_disk(disk);
> > -       return 0;
> > +       err = add_disk(disk);
> > +       if (err)
> > +               blk_cleaup_disk(disk);
> 
> blk_cleanup_disk()?

Fixed thanks.

  Luis
