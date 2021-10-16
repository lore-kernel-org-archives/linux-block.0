Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA2BC433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 00:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC6D611F0
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 00:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhJPAQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 20:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhJPAQF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 20:16:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6CC061570
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 17:13:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m21so9952274pgu.13
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQCqnCKj+Qob3RGhvKowF7vjQkMvz3jzVYQ6ojJDBgk=;
        b=22FCMxDjuptu5z2WXUhWAGeGxsQDD/V8j37BH7gzChQavhMTsYfwOs16+0368VAEwm
         H9Kn5GtjOlGOoLtQHyP63Q2TpGtOd+bYEeoJ7yrQrZF8Gd5SjSTBe4bjtPPHCkHVAMnX
         IKOrAb7pR6jb0J/r9z7kk4abkd4nzTZJqkNyspbONodFaBFVZGgHceRMhIUL1AnjE8EE
         QtZ+EolKR2dxl4bSkgWIlNfGf3FEfjjORJKFElmg1CgQAa4omqi87tX+bb0lzqw7atj/
         9H8nfrhpQOc6LGhupM+SVewu7XdQegTluU6pnHJSo4uAockAmkpsZzfTuVIRBEfs5F0h
         AY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQCqnCKj+Qob3RGhvKowF7vjQkMvz3jzVYQ6ojJDBgk=;
        b=Yg4y7YaC/efLalru0RhVKHVIxI3hPUjUdby/RD6WFhYl97aFJzFjl8PBPjYYI5efW2
         NkcMNJ0FRIaWJFQ8hXZ6X/t2iFWBfqnv58hxPqH+OOZrOmNSe71C5LBjDXm1IIpWbpxq
         8lLKmudf1P2F56+yh+DIg5n3KLTmi4V2rfJnkpwEAtjKllfMdHep+QUAm1zeM2LfwROK
         rNmUabnV5vhu/dGC25KysAqcvbALrEPo/lxExrhawOpVTfcHlWg7ylyqjhjSbjCZk1w2
         99dOmBJc6i+gg/8mtYEOi5jPXQCJuSUqXq1ewnezrxtDpTlf2S52MEEi3XsBLicHJLUH
         AlRw==
X-Gm-Message-State: AOAM533UOXLTt1QkjidsLfkQfui2vuyOJkzw0I9ypjXeWlydr89rUQlT
        PhRdZe5nNU00VjlNYX/tdEqFXiS4Tiay66i25q+HDQ==
X-Google-Smtp-Source: ABdhPJyHjqiChiYGgEV/QjEsOo/jEjfBLMsWIS4VVM51yMBTI+afNI+/nTgDPsjRchZ2uu+6VeHhZ/gjMvW7ySA684s=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr6607076pgc.356.1634343237273;
 Fri, 15 Oct 2021 17:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211015235219.2191207-1-mcgrof@kernel.org> <20211015235219.2191207-7-mcgrof@kernel.org>
In-Reply-To: <20211015235219.2191207-7-mcgrof@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Oct 2021 17:13:48 -0700
Message-ID: <CAPcyv4j+xLT=5RUodHWgnPjNq6t5OcmX1oM2zK2ML0U+OS_16Q@mail.gmail.com>
Subject: Re: [PATCH 06/13] nvdimm/blk: avoid calling del_gendisk() on early failures
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org,
        Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com,
        vigneshr@ti.com, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-mtd@lists.infradead.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> If nd_integrity_init() fails we'd get del_gendisk() called,
> but that's not correct as we should only call that if we're
> done with device_add_disk(). Fix this by providing unwinding
> prior to the devm call being registered and moving the devm
> registration to the very end.
>
> This should fix calling del_gendisk() if nd_integrity_init()
> fails. I only spotted this issue through code inspection. It
> does not fix any real world bug.
>

Just fyi, I'm preparing patches to delete this driver completely as it
is unused by any shipping platform. I hope to get that removal into
v5.16.
