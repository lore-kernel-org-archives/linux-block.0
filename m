Return-Path: <SRS0=37yO=WZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F22DC3A59F
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5CF22CED
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUBfjXSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfH2Pyo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:54:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46880 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfH2Pyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Aug 2019 11:54:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so2638556wrt.13
        for <linux-block@vger.kernel.org>; Thu, 29 Aug 2019 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Zw711UFue2XPJvQrIxeq0cr2kqhiz3iXHpuDshtFUe8=;
        b=QUBfjXSYRxN6j2dnL9EOI7t00MQ5GLhmzbKOOrVE90CSXNHDc6LeOE1cy9l0QdVcYI
         kjW9bgiR+DUaeBSGnfzEHr8BhRuL8edDDB4emPHNGTQOrhFiAiMabt84P2JYTnWdIQf2
         gf81Xblr7fjZqDIM0Nr9K9KZlwfsEg5qw2Yv+Xds1P9UiO5lOhhxQlisQCwNGnsB8fxY
         W2ERaNkLcRDNB4dqfubJg/dk6Y1rh5iu+f/w3mfiA71g20V+V7OFEytEzU1UvB1FpEN3
         OuKbPiFIhcYegCuIMakfjvA88477mnjRNhdnjpEYzD3ly1amCZ64M7jaiuLw6Vbq81zf
         2CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Zw711UFue2XPJvQrIxeq0cr2kqhiz3iXHpuDshtFUe8=;
        b=tQbERrzH5koTCrbhqhvpD3Wk5V8vSiY/HI6l6WE4Zs/5TM5zWPMdH+geyKU5ZTSOpZ
         QWu3+FtcU7r3NYelBHxNKi5doLFKxbdWycM9pfSwWFcrsZJ/hqS3rfi3xsLhvLqLJezp
         EsY2g6GqHvFrE/ELejxlHHq4BAJg8HgIC60X/MRRP6zv5OkEjr5SjxVaBTuaXbFch+o9
         rTxnJ7+UVJPCy5Ld4RHPyKdUZXBq+rM/kcolUnSiM4CJnN7bj/nPmh+o8gvepOUTbs8W
         po6OxlLUMCz+nIivLTgfuve9Ny22tmY9y1/jdpB0d2YS+hWkgQOgHJTFI4mzMGeDsRlN
         ziNQ==
X-Gm-Message-State: APjAAAWlJErkF1LRPui/th6ABCSxlKJSaq4tDOVUIoN/RUmYeAnDDwDz
        PzlQFPMjxSedScV0FwZuiL5VUQ==
X-Google-Smtp-Source: APXvYqxQydwc9C9FFhpf9zL2uKn3Hf8jJrLzxtPPRxn7IkRgx7b3G1ZFtNIV9bDV1dutNSSQwL4EQA==
X-Received: by 2002:adf:dbcd:: with SMTP id e13mr11977331wrj.314.1567094080292;
        Thu, 29 Aug 2019 08:54:40 -0700 (PDT)
Received: from [192.168.0.102] (88-147-32-64.dyn.eolo.it. [88.147.32.64])
        by smtp.gmail.com with ESMTPSA id r16sm5534583wrc.81.2019.08.29.08.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:54:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCHSET v3 block/for-linus] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
Date:   Thu, 29 Aug 2019 17:54:38 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <50384CF8-39F1-461C-9EC0-7314671E5604@linaro.org>
References: <20190828220600.2527417-1-tj@kernel.org>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
I see an important interface problem.  Userspace has been waiting for
io.weight to become eventually the file name for setting the weight
for the proportional-share policy [1,2].  If you use that name, how
will we solve this?

Thanks,
Paolo

[1] =
https://github.com/systemd/systemd/issues/7057#issuecomment-522747575
[2] https://github.com/systemd/systemd/pull/13335#issuecomment-523035303

> Il giorno 29 ago 2019, alle ore 00:05, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Changes from v2[2]:
>=20
> * Fixed a divide-by-zero bug in current_hweight().
>=20
> * pre_start_time and friends renamed to alloc_time and now has its own
>  CONFIG option which is selected by IOCOST.
>=20
> Changes from v1[1]:
>=20
> * Prerequisite patchsets had cosmetic changes and merged.  Refreshed
>  on top.
>=20
> * Renamed from ioweight to iocost.  All source code and tools are
>  updated accordingly.  Control knobs io.weight.qos and
>  io.weight.cost_model are renamed to io.cost.qos and io.cost.model
>  respectively.  This is a more fitting name which won't become a
>  misnomer when, for example, cost based io.max is added.
>=20
> * Various bug fixes and improvements.  A few bugs were discovered
>  while testing against high-iops nvme device.  Auto parameter
>  selection improved and verified across different classes of SSDs.
>=20
> * Dropped bpf iocost support for now.
>=20
> * Added coef generation script.
>=20
> * Verified on high-iops nvme device.  Result is included below.
>=20
> One challenge of controlling IO resources is the lack of trivially
> observable cost metric.  This is distinguished from CPU and memory
> where wallclock time and the number of bytes can serve as accurate
> enough approximations.
>=20
> Bandwidth and iops are the most commonly used metrics for IO devices
> but depending on the type and specifics of the device, different IO
> patterns easily lead to multiple orders of magnitude variations
> rendering them useless for the purpose of IO capacity distribution.
> While on-device time, with a lot of clutches, could serve as a useful
> approximation for non-queued rotational devices, this is no longer
> viable with modern devices, even the rotational ones.
>=20
> While there is no cost metric we can trivially observe, it isn't a
> complete mystery.  For example, on a rotational device, seek cost
> dominates while a contiguous transfer contributes a smaller amount
> proportional to the size.  If we can characterize at least the
> relative costs of these different types of IOs, it should be possible
> to implement a reasonable work-conserving proportional IO resource
> distribution.
>=20
> This patchset implements IO cost model based work-conserving
> proportional controller.  It currently has a simple linear cost model
> builtin where each IO is classified as sequential or random and given
> a base cost accordingly and additional size-proportional cost is added
> on top.  Each IO is given a cost based on the model and the controller
> issues IOs for each cgroup according to their hierarchical weight.
>=20
> By default, the controller adapts its overall IO rate so that it
> doesn't build up buffer bloat in the request_queue layer, which
> guarantees that the controller doesn't lose significant amount of
> total work.  However, this may not provide sufficient differentiation
> as the underlying device may have a deep queue and not be fair in how
> the queued IOs are serviced.  The controller provides extra QoS
> control knobs which allow tightening control feedback loop as
> necessary.
>=20
> For more details on the control mechanism, implementation and
> interface, please refer to the comment at the top of
> block/blk-iocost.c and Documentation/admin-guide/cgroup-v2.rst changes
> in the "blkcg: implement blk-iocost" patch.
>=20
> Here are some test results.  Each test run goes through the following
> combinations with each combination running for a minute.  All tests
> are performed against regular files on btrfs w/ deadline as the IO
> scheduler.  Random IOs are direct w/ queue depth of 64.  Sequential
> are normal buffered IOs.
>=20
>        high priority (weight=3D500)      low priority (weight=3D100)
>=20
>        Rand read                       None
>        ditto                           Rand read
>        ditto                           Seq  read
>        ditto                           Rand write
>        ditto                           Seq  write
>        Seq  read                       None
>        ditto                           Rand read
>        ditto                           Seq  read
>        ditto                           Rand write
>        ditto                           Seq  write
>        Rand write                      None
>        ditto                           Rand read
>        ditto                           Seq  read
>        ditto                           Rand write
>        ditto                           Seq  write
>        Seq  write                      None
>        ditto                           Rand read
>        ditto                           Seq  read
>        ditto                           Rand write
>        ditto                           Seq  write
>=20
> * 7200RPM SATA hard disk
>  * No IO control
>    https://photos.app.goo.gl/1KBHn7ykpC1LXRkB8
>  * iocost, QoS: None
>    https://photos.app.goo.gl/MLNQGxCtBQ8wAmjm7
>  * iocost, QoS: rpct=3D95.00 rlat=3D40000 wpct=3D95.00 wlat=3D40000 =
min=3D25.00 max=3D200.00
>    https://photos.app.goo.gl/XqXHm3Mkbm9w6Db46
> * NCQ-blacklisted SATA SSD (QD=3D=3D1)
>  * No IO control
>    https://photos.app.goo.gl/wCTXeu2uJ6LYL4pk8
>  * iocost, QoS: None
>    https://photos.app.goo.gl/T2HedKD2sywQgj7R9
>  * iocost, QoS: rpct=3D95.00 rlat=3D20000 wpct=3D95.00 wlat=3D20000 =
min=3D50.00 max=3D200.00
>    https://photos.app.goo.gl/urBTV8XQc1UqPJJw7
> * SATA SSD (QD=3D=3D32)
>  * No IO control
>    https://photos.app.goo.gl/TjEVykuVudSQcryh6
>  * iocost, QoS: None
>    https://photos.app.goo.gl/iyQBsky7bmM54Xiq7
>  * iocost, QoS: rpct=3D95.00 rlat=3D10000 wpct=3D95.00 wlat=3D20000 =
min=3D50.00 max=3D400.00
>    https://photos.app.goo.gl/q1a6URLDxPLMrnHy5
> * NVME SSD (ran with 8 concurrent fio jobs to achieve saturation)
>  * No IO control
>    https://photos.app.goo.gl/S6xjEVTJzcfb3w1j7
>  * iocost, QoS: None
>    https://photos.app.goo.gl/SjQUUotJBAGr7vqz7
>  * iocost, QoS: rpct=3D95.00 rlat=3D5000 wpct=3D95.00 wlat=3D5000 =
min=3D1.00 max=3D10000.00
>    https://photos.app.goo.gl/RsaYBd2muX7CegoN7
>=20
> Even without explicit QoS configuration, read-heavy scenarios can
> obtain acceptable differentiation.  However, when write-heavy, the
> deep buffering on the device side makes it difficult to maintain
> control.  With QoS parameters set, the differentiation is acceptable
> across all combinations.
>=20
> The implementation comes with default cost model parameters which are
> selected automatically which should provide acceptable behavior across
> most common devices.  The parameters for hdd and consumer-grade SSDs
> seem pretty robust.  The default parameter set and selection criteria
> for highend SSDs might need further adjustments.
>=20
> It is fairly easy to configure the QoS parameters and, if needed, cost
> model coefficients.  We'll follow up with tooling and further
> documentation.  Also, the last RFC patch in the series implements
> support for bpf-based custom cost function.  Originally we thought
> that we'd need per-device-type cost functions but the simple linear
> model now seem good enough to cover all common device classes.  In
> case custom cost functions become necessary, we can fully develop the
> bpf based extension and also easily add different builtin cost models.
>=20
> Andy Newell did the heavy lifting of analyzing IO workloads and device
> characteristics, exploring various cost models, determining the
> default model and parameters to use.
>=20
> Josef Bacik implemented a prototype which explored the use of
> different types of cost metrics including on-device time and Andy's
> linear model.
>=20
> This patchset is on top of the current block/for-next 53fc55c817c3
> ("Merge branch 'for-5.4/block' into for-next") and contains the
> following 10 patches.
>=20
> 0001-blkcg-pass-q-and-blkcg-into-blkcg_pol_alloc_pd_fn.patch
> 0002-blkcg-make-cpd_init_fn-optional.patch
> 0003-blkcg-separate-blkcg_conf_get_disk-out-of-blkg_conf_.patch
> 0004-block-rq_qos-add-rq_qos_merge.patch
> 0005-block-rq_qos-implement-rq_qos_ops-queue_depth_change.patch
> 0006-blkcg-s-RQ_QOS_CGROUP-RQ_QOS_LATENCY.patch
> 0007-blk-mq-add-optional-request-alloc_time_ns.patch
> 0008-blkcg-implement-blk-iocost.patch
> 0009-blkcg-add-tools-cgroup-iocost_monitor.py.patch
> 0010-blkcg-add-tools-cgroup-iocost_coef_gen.py.patch
>=20
> 0001-0007 are prep patches.
> 0008 implements blk-iocost.
> 0009 adds monitoring script.
> 0010 adds linear cost model coefficient generation script.
>=20
> The patchset is also available in the following git branch.
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
review-iow-v2
>=20
> diffstat follows, Thanks.
>=20
> Documentation/admin-guide/cgroup-v2.rst |   97 +
> block/Kconfig                           |   13=20
> block/Makefile                          |    1=20
> block/bfq-cgroup.c                      |    5=20
> block/blk-cgroup.c                      |   71=20
> block/blk-core.c                        |    4=20
> block/blk-iocost.c                      | 2395 =
++++++++++++++++++++++++++++++++
> block/blk-iolatency.c                   |    8=20
> block/blk-mq.c                          |   13=20
> block/blk-rq-qos.c                      |   18=20
> block/blk-rq-qos.h                      |   28=20
> block/blk-settings.c                    |    2=20
> block/blk-throttle.c                    |    6=20
> block/blk-wbt.c                         |   18=20
> block/blk-wbt.h                         |    4=20
> include/linux/blk-cgroup.h              |    4=20
> include/linux/blk_types.h               |    3=20
> include/linux/blkdev.h                  |   13=20
> include/trace/events/iocost.h           |  174 ++
> tools/cgroup/iocost_coef_gen.py         |  178 ++
> tools/cgroup/iocost_monitor.py          |  270 +++
> 21 files changed, 3272 insertions(+), 53 deletions(-)
>=20
> --
> tejun
>=20
> [1] http://lkml.kernel.org/r/20190614015620.1587672-1-tj@kernel.org
> [2] http://lkml.kernel.org/r/20190710205128.1316483-1-tj@kernel.org
>=20

