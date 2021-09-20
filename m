Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6004C433FE
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BBE611ED
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbhIUCRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbhIUBwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 21:52:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF7BC0363FB
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:29:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k17so3351088pff.8
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdIITPa+h+RUAqAcyjeuboukXybzolW0ivWD6AWeUMU=;
        b=X9tlk2jzFFqSeCp70vdHnCTWnmqEPXquFDjwWPOJI8unenxFU/BN/Zcr0l06PPO/Nw
         68yaK8I5y7PK0iQrFywmlFda49a7HJGTTqb4GRbCzktgHWVq2O1CjwziUGBOUTqyBQ2V
         olE3t6bDgK8vhGzW9ngMeNr0hp18YaVN6GWy+Qno6dgP3i6MVTc/04bBSI3K2HxSUsut
         D7054X0wSG1pERkhnbJiBtSNFgAQOjTwr0FLE3SDkoSHHiyB5Gp71oadlPIVyhN1fPmb
         SWT2BIz9JEk8KWmCUMiWuZ6dHF24sFGPcCnv6EgJediTXc7+OuwQXesMgQptYjHxm6aA
         VK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdIITPa+h+RUAqAcyjeuboukXybzolW0ivWD6AWeUMU=;
        b=sqbp3bJ/ACEaShREnoyAOIF4LFVIjuce1rH5G5AjoIUlXXQy5yaMbsYd0/D30n/o8V
         Dl4pmWLNHd5pqPUZxBWJnhQtUbDuT/aYSPPTo4RTgVaW4xVLWR86G8qK/Obo9CyBLxAf
         +qVS7H8R7mXcbTQWKpsPxapdBdPPZvL5ytA9j8O5mxfFi7ScB1aM8Wol7nUWXKTwEBi7
         VM98PT3XQRKIjuh4IxiWZTGo22hw8VjPl2JI+6SR02FfOjTBGm/Wols9lFS4tGbwIoC1
         uHEPVOsm7e+Dh+ZOY9waJ7o3i66bZPiiWCkSTIEpRNf4rI4U3FjhjAhc0NGxbPyHtHin
         0CIg==
X-Gm-Message-State: AOAM5300HlhNkrjuRxDzDRrWV7XZMeGUYWlJsBchHTwr6AClQDSnnDJF
        bSBP1Lp7Ywzgs7nnfFq44kraM25Td5+l8cSoHxnc0w==
X-Google-Smtp-Source: ABdhPJxn4C76fLh6bn5Au+td56tzpPGHrUMWl9Eu9RjmbbiNq8TyPELKCaIaZ9A+uEFKfwgHII0LOr1njoqPscbuGoo=
X-Received: by 2002:a63:3545:: with SMTP id c66mr25377409pga.377.1632180584639;
 Mon, 20 Sep 2021 16:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210920072726.1159572-3-hch@lst.de> <202109210155.7rqblE6U-lkp@intel.com>
In-Reply-To: <202109210155.7rqblE6U-lkp@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Sep 2021 16:29:33 -0700
Message-ID: <CAPcyv4gPf74k7Lz8Uh2ni1bv7Po3pDPyBr24w4ea6ZzdvRjOQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvdimm/pmem: move dax_attribute_group from dax to pmem
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        kbuild-all@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 11:01 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Christoph,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on axboe-block/for-next]
> [also build test ERROR on linus/master v5.15-rc2 next-20210920]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Christoph-Hellwig/nvdimm-pmem-fix-creating-the-dax-group/20210920-162804
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: riscv-buildonly-randconfig-r006-20210920 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/1a16d0f32f70bcd159a9f8cf32794f4024e8711e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Christoph-Hellwig/nvdimm-pmem-fix-creating-the-dax-group/20210920-162804
>         git checkout 1a16d0f32f70bcd159a9f8cf32794f4024e8711e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/dax/super.c:375:6: error: no previous prototype for 'run_dax' [-Werror=missing-prototypes]
>      375 | void run_dax(struct dax_device *dax_dev)
>          |      ^~~~~~~

In this new -Werror world drivers/dax/bus.c needs:

#include "bus.h"

> >> drivers/dax/super.c:70:27: error: 'dax_get_by_host' defined but not used [-Werror=unused-function]
>       70 | static struct dax_device *dax_get_by_host(const char *host)
>          |                           ^~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

Nice additional cleanup that now fs_dax_get_by_bdev() is the only
caller of dax_get_by_host().
