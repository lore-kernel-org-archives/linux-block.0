Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE4C04A6A
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 19:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbjHHTpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjHHTpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 15:45:16 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6764E46FFB
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:48:38 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56c7f47ec42so4184328eaf.2
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513317; x=1692118117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Klg6b7rTmA3/2CEHhPBL9kFFomypTM/SqIrAORONAmA=;
        b=HrUbAcZIcVGRlX4zScFuELATxKdyvbp8EoYD8gur7LDE7cd5xkSvkeb+qNOJVt0CgL
         LpTgzCdKpBZ7s2chVEtBBqVGogsqFTl9bq6RmfljA1CUD35mRS6sBgjIzjTc6KlFC79F
         umcgeR/4HIAAj+b0Lo1DU1sFg1qCBjU/SiZgIMmR1BntscuFlo1j6GejwT7eEtpLimsN
         lnObmx/g9G7HFVlqt6LunRJL7bpGVgXibXcMV3yfTWBMs3vEBbwDfRHWh3hl06cisFnx
         ZoXASz3ETrAAJ6POgDAueIlxE0o+jAu1YzU7388HyDJPcK9lBbMWtdY9x8g7nQ7s0I3X
         PQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513317; x=1692118117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Klg6b7rTmA3/2CEHhPBL9kFFomypTM/SqIrAORONAmA=;
        b=b/saTCVGHesABv/ObF6fMq/SlovhCBjoSlH7C96C1CH1EbVqUiMoiV6MQt14zhQ7Ep
         eqp/40CBLDjQwFcJkeoxq5SfAJiQH48TBB7HOh3zTsj5xXthJiHrIW2ZT658nl55LM3H
         KvGhrra8llEDI/IV9RUfYfcn09B+rPk+pcVhNLk6ZfRgbNZEELD3ECzP6GPCfgtlQntB
         8mQpG0pv8r1p4Dy/lhc7e28aHe+ap+lkaGL3v4IHofNYCm4RDlQYKU7dkjm3lMDtL0VL
         ePGZCv97IbVk9RGzFk9SVsGORfqds7KXfuqBA2gCS1ZT8M97x56iGJJtI8lcvUcTaRiy
         RvHg==
X-Gm-Message-State: AOJu0YzxCelwXM0XFdwdkf89ww/6XqxZMZPrhNtv5ZEDxxNmS1feq9xY
        VIlXDoxz0FexjEqHu7E3qsuFFO/cgNmwGbXG8sxc4VMIHV3pVY54R5s=
X-Google-Smtp-Source: AGHT+IFyFm7A28IM+G0on9OcPQxQMVC4tFTmtVJz+gYpID8XubCbPflmb8sfgiBS79hEh9WW2BWOpIws/LS1JffnNds=
X-Received: by 2002:a05:6358:419b:b0:134:ca8a:7486 with SMTP id
 w27-20020a056358419b00b00134ca8a7486mr11887238rwc.28.1691492428398; Tue, 08
 Aug 2023 04:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689802933.git.daniel@makrotopia.org> <1ce5f56df546cec25ef741f381286f1d7c33d000.1689802933.git.daniel@makrotopia.org>
 <CAPDyKFqhZtCHVmCNnm_Qm7X+=GtJY8uNJOWOgZXuTTVEw0msNA@mail.gmail.com> <ZNGULFxXpLT7zn35@makrotopia.org>
In-Reply-To: <ZNGULFxXpLT7zn35@makrotopia.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:59:52 +0200
Message-ID: <CAPDyKFrpWgA=e-FSoKfYhWSOq5m5_pHjxgzaGeOFHFhU_mcmNw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] mmc: block: set fwnode of disk devices
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Aug 2023 at 03:02, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Hi Ulf,
>
> thank you for reviewing and suggesting ways to improve this series!
>
> On Mon, Aug 07, 2023 at 03:48:31PM +0200, Ulf Hansson wrote:
> > On Thu, 20 Jul 2023 at 00:02, Daniel Golle <daniel@makrotopia.org> wrote:
> > >
> > > Set fwnode of disk devices to 'block', 'boot0' and 'boot1' subnodes of
> > > the mmc-card. This is done in preparation for having the eMMC act as
> > > NVMEM provider.
> >
> > Sorry, but I don't quite understand what you are trying to do here.
> > Maybe you should re-order the patches in the series so it becomes
> > clear why this is needed?
> >
> > Moreover, I don't see any DT docs being updated as a part of the
> > series, which looks like it is needed too. That would also help to
> > understand what you are proposing, I think.
>
> I've prepared a tree on Github which now also includes commits adding
> dt-bindings for block devices and partitions, so they can be referenced
> as nvmem-cells provider.
>
> The dt-schema addition supposedly explaining this specific patch:
>
> https://github.com/dangowrt/linux/commit/b399a758f0e1c444ae9443dc80902a30de54af09
>
> The whole tree:
>
> https://github.com/dangowrt/linux/commits/for-nvmem-next

Thanks for sharing. However, allow people to review, I suggest you
post a new version with the updated DT bindings included.

The point is, we really need confirmation from the DT maintainers -
otherwise this is simply a no go.

>
> Most comments have been addressed, however, I still depend on using
> either a class_interface *or* adding calls to add/remove the NVMEM
> representation of a block device to block/genhd.c as well as
> block/partitions/core.c, simply because afaik there isn't any better
> way for in-kernel users of block devices to be notified about the
> creation or removal of a block device.

Okay, so that needs further discussions then. I will try to chim in.

[...]

Kind regards
Uffe
