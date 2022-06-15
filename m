Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A8FCCA473
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 23:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbiFOXNj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350548AbiFOXNg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 19:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D7922E9D2
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655334814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhMuwxHqfosW3sDO+A+XNbEnO/HpuOv59r7ZSdjm4Q8=;
        b=fBN6s6pP4m2CDcTPhVVmCItNEMHPURBaS4uFFa9AGuYZ84vhMobdhVjH9WCcv2f52X4w6l
        pAU5jGx6vdzEtQcCpaCRjO4k4QZIXlXYHlcbO/lwC0KgXySgKc9ugJkCxXN2uyfxP/6/K7
        HdGdGIiBfigOKCd1xMaS7n1hv5F7xGg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-4gc4lOZKMfyGia7zXY3VFw-1; Wed, 15 Jun 2022 19:13:33 -0400
X-MC-Unique: 4gc4lOZKMfyGia7zXY3VFw-1
Received: by mail-pj1-f70.google.com with SMTP id ob5-20020a17090b390500b001e2f03294a7so92542pjb.8
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 16:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhMuwxHqfosW3sDO+A+XNbEnO/HpuOv59r7ZSdjm4Q8=;
        b=QsNc5/mqDFkPVfx4Z7UOlqaaFgUNGahoS4QUsF+qzoSWHTBM0d/zQYMyJxho4l3Pzm
         eT0/lmByRqZrVR7guCqZhQWTPfS8U1A4zISSmGVITM3VXU/nw7fGTndylGMnmCne7oJn
         4WLOU81/bIG8PQazpD1UpDVnhrdVIYur1/0J1auvjGZZ7lTMSg2a3SxlWVjcLDyZJwu+
         D9yVSNaSMUiuN+NxCFBmOmK0pirPFkq8fPRAam6CdZMVdGgOzYZshoSW7ouwG0KucWdy
         GFsaIVgPqICy+dQNmlHpSp3+wgm0cbHDT7C68x/CJkUsIh0oGtofGY8Jyg3/kYxB0Vlc
         Ph8w==
X-Gm-Message-State: AJIora+5EQub4LtvzRixblYcgvabgS898UOioBKgOJ34UfJgX+tijuuQ
        Gx1U1fXMnwBmpiTjGjemYja1My/1qlorLZ7yTX46vnI+uz5xnf8i17Mny9ueNzz1DkLnKGo2Asj
        jYMWpQ3PB1CIVwIp2Hu/BJnxcpYvZ4ItbxlICWvQ=
X-Received: by 2002:a05:6a00:2291:b0:51b:e4c5:627 with SMTP id f17-20020a056a00229100b0051be4c50627mr1837919pfe.20.1655334812011;
        Wed, 15 Jun 2022 16:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sg+mVCN3WuVePBvyzN+o71gqddvsTeRC94xefuc698SvRbjp423NUsbHPJxu4Wg5t3ZOUyX2uinaLerv8Pyyg=
X-Received: by 2002:a05:6a00:2291:b0:51b:e4c5:627 with SMTP id
 f17-20020a056a00229100b0051be4c50627mr1837892pfe.20.1655334811679; Wed, 15
 Jun 2022 16:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220615194727.GA1022614@bhelgaas> <cfaee02b-0390-6e1c-e26c-fa0ba3689704@nvidia.com>
In-Reply-To: <cfaee02b-0390-6e1c-e26c-fa0ba3689704@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 16 Jun 2022 07:13:19 +0800
Message-ID: <CAHj4cs88gLYMMefQVrH_+kSsrZhV+VJa5yapEaYXc1Cjnd2w_Q@mail.gmail.com>
Subject: Re: blktests failures with v5.19-rc1
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 16, 2022 at 6:01 AM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 6/15/22 12:47, Bjorn Helgaas wrote:
> > On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> >> On Jun 14, 2022 / 02:38, Chaitanya Kulkarni wrote:
> >>> Shinichiro,
> >>>
> >>> On 6/13/22 19:23, Keith Busch wrote:
> >>>> On Tue, Jun 14, 2022 at 01:09:07AM +0000, Shinichiro Kawasaki wrote:
> >>>>> (CC+: linux-pci)
> >>>>> On Jun 11, 2022 / 16:34, Yi Zhang wrote:
> >>>>>> On Fri, Jun 10, 2022 at 10:49 PM Keith Busch <kbusch@kernel.org> wrote:
> >>>>>>>
> >>>>>>> And I am not even sure this is real. I don't know yet why
> >>>>>>> this is showing up only now, but this should fix it:
> >>>>>>
> >>>>>> Hi Keith
> >>>>>>
> >>>>>> Confirmed the WARNING issue was fixed with the change, here is
> >>>>>> the log:
> >>>>>
> >>>>> Thanks. I also confirmed that Keith's change to add
> >>>>> __ATTR_IGNORE_LOCKDEP to dev_attr_dev_rescan avoids the fix, on
> >>>>> v5.19-rc2.
> >>>>>
> >>>>> I took a closer look into this issue and found The deadlock
> >>>>> WARN can be recreated with following two commands:
> >>>>>
> >>>>> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/rescan
> >>>>> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/remove
> >>>>>
> >>>>> And it can be recreated with PCI devices other than NVME
> >>>>> controller, such as SCSI controller or VGA controller. Then
> >>>>> this is not a storage sub-system issue.
> >>>>>
> >>>>> I checked function call stacks of the two commands above. As
> >>>>> shown below, it looks like ABBA deadlock possibility is
> >>>>> detected and warned.
> >>>>
> >>>> Yeah, I was mistaken on this report, so my proposal to suppress
> >>>> the warning is definitely not right. If I run both 'echo'
> >>>> commands in parallel, I see it deadlock frequently. I'm not
> >>>> familiar enough with this code to any good ideas on how to fix,
> >>>> but I agree this is a generic pci issue.
> >>>
> >>> I think it is worth adding a testcase to blktests to make sure
> >>> these future releases will test this.
> >>
> >> Yeah, this WARN is confusing for us then it would be valuable to
> >> test by blktests not to repeat it. One point I wonder is: which test
> >> group the test case will it fall in? The nvme group could be the
> >> group to add, probably.
> >>
>
> since this issue been discovered with nvme rescan and revmoe,
> it should be added to the nvme category.

We already have nvme/032 which tests nvme rescan/reset/remove and the
issue was reported by running this one, do we still need one more?

>
> >> Another point I wonder is other kernel test suite than blktests.
> >> Don't we have more appropriate test suite to check PCI device
> >> rescan/remove race ? Such a test sounds more like a PCI bus
> >> sub-system test than block/storage test.
>
> I don't think so we could have caught it long time back,
> but we clearly did not.
>
> >
> > I'm not aware of such a test, but it would be nice to have one.
> >
> > Can you share your qemu config so I can reproduce this locally?
> >
> > Thanks for finding and reporting this!
> >
> > Bjorn
>
> -ck
>
>


-- 
Best Regards,
  Yi Zhang

