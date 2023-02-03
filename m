Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3786DC636D3
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 02:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBCCp1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 21:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjBCCp0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 21:45:26 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5658418D
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 18:45:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lu11so11739650ejb.3
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 18:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWbXociyFkdQ7/TUxBgecQAZf00rOpeT9CPa5wmxf04=;
        b=YaKGyvJ6Rm9T6pGi9CEGpXW8/tz30eEJqTdZ5sDBSsYzk0uAWrcUii7GJ0X3HEcc99
         JU1KRKAuGsXkOPQQphxpo6Tqeuzfdnk1jed90PonrOQ2wqgxcNrim/zs9/T5faCpph6W
         eLdGzuoOIMPE7pbjD9jYVMehoHu6j3mjwcer0t4Q+queq4DbnOEnDMQoeJ8N+2QZ5+BA
         MK2JZjfSVzN5EDq3Yrjq8k/Fw1RTaGe2NT6wJPNN1xItRRRBTZGAkQWCQqH6eMuZjvhd
         /HIKTBZY9uP6Cuw5zPQKi25pV5dKG1xmRrdH3ft0oOECgs7usfZLRZ+sEU6vLm7V9yOp
         Q8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWbXociyFkdQ7/TUxBgecQAZf00rOpeT9CPa5wmxf04=;
        b=kv3TDaxuDghaX6hMw5YrJUEcdrH0oUaRTKkwTUGVt+klczIvQmvrNZGjb8QLZlRpn0
         Axb9Cc3iwrdAwe8Lj00rHzKVxe7QHysJp7BL4xApHVvwxmiLEpkjmzxWSRwBhKsBGoln
         2E3nAfZsM1o6WzqAS7JtE/dkHcOKQuq0R8LKAgWqkk+XfOR+1WhzWff4GGSr+BJIgaOX
         VlQJ6UoSzK/bZ8B9H8xMW1iRd/Zicq7AlcmIuQ+ADkS+PIfbvX7x9aEC5hlShXJ4U92n
         An/9aUbCgYvMtcnprlUl8muSeo0baVQXzMlxzRHBZ+xwZ7bgDlV06+SmfJulDL3r3jCr
         9gag==
X-Gm-Message-State: AO0yUKUq+Rw3/nbK7bzO4etHHd+4DI5MLJ6WDj0roqkzJi3y8iMhKuqR
        qXo1ZKyWnXPFrFyc2p0qtv+PAsuIyF0rgZMBuT8=
X-Google-Smtp-Source: AK7set94ceSpo/h1dUWbNI7qOd4aKf2weBp3h6HWl4TainLpBjMrdODUPEhcqOWYRNW+xnRXWSJ3FFHDrIf5QS/+xgk=
X-Received: by 2002:a17:906:eca:b0:883:5f37:5aea with SMTP id
 u10-20020a1709060eca00b008835f375aeamr2482984eji.10.1675392322931; Thu, 02
 Feb 2023 18:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20230202091151.855784-1-qkrwngud825@gmail.com> <202302030733.TVNhMvP4-lkp@intel.com>
In-Reply-To: <202302030733.TVNhMvP4-lkp@intel.com>
From:   Juhyung Park <qkrwngud825@gmail.com>
Date:   Fri, 3 Feb 2023 11:45:09 +0900
Message-ID: <CAD14+f2d2ggvTMO9oXF_6yhQYOsLjQKFd0hbCrBT2Whn3ad0kA@mail.gmail.com>
Subject: Re: [PATCH] block: remove more NULL checks after bdev_get_queue()
To:     kernel test robot <lkp@intel.com>
Cc:     linux-block@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        axboe@kernel.dk, johannes.thumshirn@wdc.com, p.raghav@samsung.com,
        kch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Welp, didn't have it build-tested with W=3D1 and it somehow didn't warn
me without it.

Just posted v2:
https://lore.kernel.org/all/20230203024029.48260-1-qkrwngud825@gmail.com/T/=
#u

Sorry for the inconvenience!
Thanks,

On Fri, Feb 3, 2023 at 9:05 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Juhyung,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on axboe-block/for-next]
> [also build test WARNING on linus/master v6.2-rc6 next-20230202]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Juhyung-Park/block=
-remove-more-NULL-checks-after-bdev_get_queue/20230202-171443
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block=
.git for-next
> patch link:    https://lore.kernel.org/r/20230202091151.855784-1-qkrwngud=
825%40gmail.com
> patch subject: [PATCH] block: remove more NULL checks after bdev_get_queu=
e()
> config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/202=
30203/202302030733.TVNhMvP4-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/f62253701c6bf7712=
27300ca8c572c778c2670bb
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Juhyung-Park/block-remove-more-N=
ULL-checks-after-bdev_get_queue/20230202-171443
>         git checkout f62253701c6bf771227300ca8c572c778c2670bb
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    block/blk-zoned.c: In function 'blkdev_report_zones_ioctl':
> >> block/blk-zoned.c:337:31: warning: variable 'q' set but not used [-Wun=
used-but-set-variable]
>      337 |         struct request_queue *q;
>          |                               ^
>    block/blk-zoned.c: In function 'blkdev_zone_mgmt_ioctl':
>    block/blk-zoned.c:392:31: warning: variable 'q' set but not used [-Wun=
used-but-set-variable]
>      392 |         struct request_queue *q;
>          |                               ^
>
>
> vim +/q +337 block/blk-zoned.c
>
> d41003513e61dd Christoph Hellwig 2019-11-11  327
> 56c4bddb970658 Bart Van Assche   2018-03-08  328  /*
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  329   * BLKREPORTZONE ioctl =
processing.
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  330   * Called from blkdev_i=
octl.
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  331   */
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  332  int blkdev_report_zones=
_ioctl(struct block_device *bdev, fmode_t mode,
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  333                         =
     unsigned int cmd, unsigned long arg)
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  334  {
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  335        void __user *argp=
 =3D (void __user *)arg;
> d41003513e61dd Christoph Hellwig 2019-11-11  336        struct zone_repor=
t_args args;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18 @337        struct request_qu=
eue *q;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  338        struct blk_zone_r=
eport rep;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  339        int ret;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  340
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  341        if (!argp)
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  342                return -E=
INVAL;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  343
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  344        q =3D bdev_get_qu=
eue(bdev);
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  345
> edd1dbc83b1de3 Christoph Hellwig 2022-07-06  346        if (!bdev_is_zone=
d(bdev))
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  347                return -E=
NOTTY;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  348
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  349        if (copy_from_use=
r(&rep, argp, sizeof(struct blk_zone_report)))
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  350                return -E=
FAULT;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  351
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  352        if (!rep.nr_zones=
)
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  353                return -E=
INVAL;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  354
> d41003513e61dd Christoph Hellwig 2019-11-11  355        args.zones =3D ar=
gp + sizeof(struct blk_zone_report);
> d41003513e61dd Christoph Hellwig 2019-11-11  356        ret =3D blkdev_re=
port_zones(bdev, rep.sector, rep.nr_zones,
> d41003513e61dd Christoph Hellwig 2019-11-11  357                         =
         blkdev_copy_zone_to_user, &args);
> d41003513e61dd Christoph Hellwig 2019-11-11  358        if (ret < 0)
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  359                return re=
t;
> d41003513e61dd Christoph Hellwig 2019-11-11  360
> d41003513e61dd Christoph Hellwig 2019-11-11  361        rep.nr_zones =3D =
ret;
> 82394db7383d33 Matias Bj=C3=B8rling   2020-06-29  362        rep.flags =
=3D BLK_ZONE_REP_CAPACITY;
> d41003513e61dd Christoph Hellwig 2019-11-11  363        if (copy_to_user(=
argp, &rep, sizeof(struct blk_zone_report)))
> d41003513e61dd Christoph Hellwig 2019-11-11  364                return -E=
FAULT;
> d41003513e61dd Christoph Hellwig 2019-11-11  365        return 0;
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  366  }
> 3ed05a987e0f63 Shaun Tancheff    2016-10-18  367
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
