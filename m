Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FBAC4332E
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E486365238
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCIQhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhCIQg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 11:36:57 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2F5C06175F
        for <linux-block@vger.kernel.org>; Tue,  9 Mar 2021 08:36:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w9so21363036edt.13
        for <linux-block@vger.kernel.org>; Tue, 09 Mar 2021 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/fpSmEn/Omnn9hT4CF3J0SxPNZ3B3Al6CQWKVqNiBQ=;
        b=StNMHMhRfB8T/5YxpdFifEdg64ybP3EsolQTfz9j8mT99xOZm4AP2PLj7Lj9Vz8yxG
         t5u2mGMp0ID0D2xI8sewZ7MWYrJpiZf9DOe+jqwFthRMU64XdYV/mO36V14t786ILnIk
         NTCWj5xpdpoohcsKdU048Qt/svji00BGtnFKLOPAz0HnCpdFfdFOseG6w2cbR0I61l+q
         ylc00Qdh7rjzdHbe91XpFhqJElhF8V1IG2GSkNBs613QrMQKTdnSt3JUBY4C0RzkWEie
         qpFxLVikQOfstznmBtOfKLxIaeAcH7Bsla0eOGj/AxQ+1Kaykq6N9GN770mMWhm9x6Dv
         Pq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/fpSmEn/Omnn9hT4CF3J0SxPNZ3B3Al6CQWKVqNiBQ=;
        b=Kfuki/4S99fxZjv3ymRqX7RMA3Sbkyx8CjX2vbxcn5uhdSmH9gkUoq0BdxTUxSS6yc
         aZXiRw9+HHrmogqVniRkPUgl/JObTlPF/IomvjMRc31WkWiSmSigbDrgI54YcXDvGuRQ
         78Sh1Y1MyXHb+uHThGAtI/1pDtd89outDM4JiAtJSNqQSixOplaljs97dlbS3Ccgtk7d
         r5VarYumt6lwteH9LpNpKgaM/Le01GrbmVI7vl2ZZwbbS0qx+bj0KMnOE9+sNn/WAZ+W
         h5rUPXa7Ycg90RkeLpKqye0u1nQ3VeLwmn/qHYeBXS4hYb9mBidLIJZZjvEPW7016Bm7
         3VIA==
X-Gm-Message-State: AOAM532tOFast17q2HA6TvXyAmWksD1L8iPV8559Hubwin5S8yvId8rE
        j7fT/vFefvdnfm+1HSlcOmdGBLT97PELlOCKLOouPA==
X-Google-Smtp-Source: ABdhPJyzPjVHBi3eKHJ3wMsoze0wVkKY9whBDXBrbn5HcD+NO5qt8MclSQ/sO8bdsyXTxsn1FW30Wg1M45vhSD/6jKQ=
X-Received: by 2002:aa7:cd87:: with SMTP id x7mr5285330edv.210.1615307815848;
 Tue, 09 Mar 2021 08:36:55 -0800 (PST)
MIME-Version: 1.0
References: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210309073110.GA3140@lst.de>
In-Reply-To: <20210309073110.GA3140@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Mar 2021 08:36:53 -0800
Message-ID: <CAPcyv4iQShzBxyZcn+H=2DGnnpifaV_e=5yBaGA1sF+ESS0jAQ@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Let revalidate_disk() revalidate region read-only
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 8, 2021 at 11:31 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Mar 08, 2021 at 10:54:22PM -0800, Dan Williams wrote:
> > Previous kernels allowed the BLKROSET to override the disk's read-only
> > status. With that situation fixed the pmem driver needs to rely on
> > revalidate_disk() to clear the disk read-only status after the host
> > region has been marked read-write.
> >
> > Recall that when libnvdimm determines that the persistent memory has
> > lost persistence (for example lack of energy to flush from DRAM to FLASH
> > on an NVDIMM-N device) it marks the region read-only, but that state can
> > be overridden by the user via:
> >
> >    echo 0 > /sys/bus/nd/devices/regionX/read_only
> >
> > ...to date there is no notification that the region has restored
> > persistence, so the user override is the only recovery.
>
> I've just resent my series to kill of ->revalidate_disk for good, so this
> obvious makes me a little unhappy.  Given that ->revalidate_disk
> only ends up beeing called from the same path that ->open is called,
> why can't you just hook this up from the open method?
>
> Also any reason the sysfs attribute can't just directly propagate the
> information to the disk?

I should have assumed that revalidate_disk() was on the chopping
block. Let me take a look at just propagating from the region update
down to all affected disks. There's already a notification path for
regions to communicate badblocks, should be straightforward to reuse
for read-only updates.
