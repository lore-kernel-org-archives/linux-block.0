Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFD0C7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 21:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0722B21900
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 21:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWMC3L/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfGVVbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:31:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41126 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfGVVbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 17:31:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id v22so29586061qkj.8;
        Mon, 22 Jul 2019 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bkMB9iLdWFSQkbPy5t3JV4F68RV6jUdrJD2bOwvoIn8=;
        b=iWMC3L/LEDt/vVKsPAdSv09UkpyAiOkpNWdyKMDQ4qn5+thSgKDnX58gIlCo4DoNxi
         C3lWKOEbiXHIBK8nK3usgWV8PbRWDhyRVFstWCg+XzVeeo/J52lRxI61zK/lK4utFsPg
         hCarZQxcXI5I3HSxxUSkhTDdp1NQP63hAu2G+Ie6OWwqio0azTTg3kHGHoFH6RkPWLV6
         5/WEGxN/+9HdYKyjrMXdavay3PlbXFIEr9a2QyvS18wAuJHdd2XLD6T/5lG7fRhaPHkO
         TJSFtElGws2zIsFGKEmkGDCFJuU0gJOvSCdZuAM9jAAnFGvbcaPrOLDFq5+FkATx8oA0
         2X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bkMB9iLdWFSQkbPy5t3JV4F68RV6jUdrJD2bOwvoIn8=;
        b=cGpaQVnnmDTc/G2tJsDyo7vtuUgtlV3jtN7zeezgODccHgJ6tO0trxbCh56VX5LHot
         pHOC+bSQ3kNUtHRFpiPzQLb9nv2Wd3kOY+MF+K28xQostISfeDcdi2DWy9NWQMBsg7Yv
         s8ZCduuAThk39kPyiPfWvqqasTGWI+f6tkreJYJYnaPlXDJ36arzYHu3PcfIvqo3HZ/i
         AhpMtC1K3Qnelz34aJP/9OAtDm6WORKHZjU9OxslI+CiG3fiUsBTEESapZ/+/H0fCh3K
         1x6dTCut2J2yPZEnynDu0hXGLnN7U+xMcPPtCvf+B1jJwe4yEuqIieZg8Rg7Tp9+Wi+p
         Aggg==
X-Gm-Message-State: APjAAAWHxb3+JzG7Wu9AKas25MRmq1+labwP4KFH8YH8bSCvRWnzB2zq
        f58YsGEnO869hymp8KwAWgxV/AEGz/WfoiaQG7AhRQ==
X-Google-Smtp-Source: APXvYqwU28I7FEeqRZ7j23Bk/5Hg6qUpt29zYyXnWc5oz7DnGYIqKvtek6EVowUlxJB6Y0AZq/4kLgLDlc2EVw1QrkE=
X-Received: by 2002:a37:4d82:: with SMTP id a124mr46359152qkb.72.1563831091271;
 Mon, 22 Jul 2019 14:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190702132918.114818-1-houtao1@huawei.com>
In-Reply-To: <20190702132918.114818-1-houtao1@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 22 Jul 2019 14:31:20 -0700
Message-ID: <CAPhsuW6yH7np1=+e5Rgutp3m1VA0TPvtANeX=0ZdpJaRKEvBkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] md: export internal stats through debugfs
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org, snitzer@redhat.com, agk@redhat.com,
        dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 2, 2019 at 6:25 AM Hou Tao <houtao1@huawei.com> wrote:
>
> Hi,
>
> There are so many io counters, stats and flags in md, so I think
> export these info to userspace will be helpful for online-debugging,
> especially when the vmlinux file and the crash utility are not
> available. And these info can also be utilized during code
> understanding.
>
> MD has already exported some stats through sysfs files under
> /sys/block/mdX/md, but using sysfs file to export more internal
> stats are not a good choice, because we need to create a single
> sysfs file for each internal stat according to the use convention
> of sysfs and there are too many internal stats. Further, the
> newly-created sysfs files would become APIs for userspace tools,
> but that is not we wanted, because these files are related with
> internal stats and internal stats may change from time to time.
>
> And I think debugfs is a better choice. Because we can show multiple
> related stats in a debugfs file, and the debugfs file will never be
> used as an userspace API.
>
> Two debugfs files are created to expose these internal stats:
> * iostat: io counters and io related stats (e.g., mddev->active_io,
>         r1conf->nr_pending, or r1confi->retry_list)
> * stat: normal stats/flags (e.g., mddev->recovery, conf->array_frozen)
>
> Because internal stats are spreaded all over md-core and md-personality,
> so both md-core and md-personality will create these two debugfs files
> under different debugfs directory.
>
> Patch 1 factors out the debugfs files creation routine for md-core and
> md-personality, patch 2 creates two debugfs files: iostat & stat under
> /sys/kernel/debug/block/mdX for md-core, and patch 3 creates two debugfs
> files: iostat & stat under /sys/kernel/debug/block/mdX/raid1 for md-raid1=
.
>
> The following lines show the hierarchy and the content of these debugfs
> files for a RAID1 device:
>
> $ pwd
> /sys/kernel/debug/block/md0
> $ tree
> .
> =E2=94=9C=E2=94=80=E2=94=80 iostat
> =E2=94=9C=E2=94=80=E2=94=80 raid1
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 iostat
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 stat
> =E2=94=94=E2=94=80=E2=94=80 stat
>
> $ cat iostat
> active_io 0
> sb_wait 0 pending_writes 0
> recovery_active 0
> bitmap pending_writes 0
>
> $ cat stat
> flags 0x20
> sb_flags 0x0
> recovery 0x0
>
> $ cat raid1/iostat
> retry_list active 0
> bio_end_io_list active 0
> pending_bio_list active 0 cnt 0
> sync_pending 0
> nr_pending 0
> nr_waiting 0
> nr_queued 0
> barrier 0

Hi,

Sorry for the late reply.

I think these information are really debug information that we should not
show in /sys. Once we expose them in /sys, we need to support them
because some use space may start searching data from them.

Thanks,
Song
