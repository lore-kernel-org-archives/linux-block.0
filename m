Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B41CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 15:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686D161251
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 15:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhJVPq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhJVPq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 11:46:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A395C061764
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 08:44:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so2352619pje.0
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iD/YdYWU0CibrUrNT2AHjd524fNyniaHzDz+a4Nr73I=;
        b=0P231w6Ya6SVWz0/xgd/baLTyoWwmKPsCCxX4cZneaql942u/6wi4RJfkEJ1WkQt7O
         7ftFeAD+cVcpIQ/Ej4JqtqDJ4au0y94b0Hxj+jJ0eNOTPgq9MAU5rbz/2wtN9/QbqpXF
         GYDkKo7pZPviDpMthPDr7IEkHYfCOF+ahRj9Hmhl8d81dVSf/klHN5vliDINeCl0rUX+
         iVt/tBiAzg8cy4vcHMVVyGXJ91OIQHY3qWRFOR2JxNq3GoekC2TNVw9P8WE4XMYY8N5v
         ISJGLd34fCPlWm56jbR2Skn8Cz3PpIoVlqslPi+nPI/Nrky1oAOB9Z+9rhbEu+OVC1+B
         rAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iD/YdYWU0CibrUrNT2AHjd524fNyniaHzDz+a4Nr73I=;
        b=aYmtBcD+8+muZ9LRLI/oOP+446uKgn23QqfcGsu7+AoPC56aYmAvAsXqkr5cMTTlSz
         Hv0CVKupQIrUoD6cs6REkoY/l0O3yoiaAxYcOHZC5pV3pmptCARO1V8XHocsRikAS8f1
         JkloCx1k80yB7M5+B62AWbIvxi2yLIRu+10KeCoDizR4JQzGIb/bRz3xmmH322AjkqpZ
         Y4md28DoWLac/GSawkxoMawQoNgQqVXGglmMYEfuewf+mbletmifriOcZxm+rhVxBrQP
         IGzAo3BSWeUrA2H8YDF5pum0qvh3GyMa51bhhpix7sHdMC4qqtaix743JiFavFaVKzM1
         G4Iw==
X-Gm-Message-State: AOAM530S3SsB0w7UzrLBGjxpinpVd5V0NfhSVN0UIEAG6qWuK1Y9TSRh
        YmVE4+iKzmX11xhy2U6bJUurUrTAocXaBPlEXgWd5w==
X-Google-Smtp-Source: ABdhPJwvGEiemHTU2PuYQrPBVLwNnk1G6dXjNp0/LHArCCIpY/aqRwNrqc0oa8rEc/+wcjTuGy7ilzYJj6grslSTWo8=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr15376908pjp.8.1634917448922;
 Fri, 22 Oct 2021 08:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211019073641.2323410-1-hch@lst.de> <20211019073641.2323410-3-hch@lst.de>
 <YXFtwcAC0WyxIWIC@angband.pl> <20211022055515.GA21767@lst.de>
In-Reply-To: <20211022055515.GA21767@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Oct 2021 08:43:58 -0700
Message-ID: <CAPcyv4joX3K36ovKn2K95iDtW77jJwoAgAs5JSRMcETff=-brg@mail.gmail.com>
Subject: Re: [PATCH 2/2] memremap: remove support for external pgmap refcounts
To:     Christoph Hellwig <hch@lst.de>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 21, 2021 at 10:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Oct 21, 2021 at 03:40:17PM +0200, Adam Borowski wrote:
> > This breaks at least drivers/pci/p2pdma.c:222
>
> Indeed.  I've updated this patch, but the fix we need to urgently
> get into 5.15-rc is the first one only anyway.
>
> nvdimm maintainers, can you please act on it ASAP?

Yes, I have been pulled in many directions this past week, but I do
plan to get this queued for v5.15-rc7.
