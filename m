Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F516C433E0
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B9723119
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YLgp5kIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgHFRYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgHFREz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 13:04:55 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CDC061A32
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 05:31:50 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z22so12101430oid.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=XJnGQ196bV3DG6WDX/7IGBMLELLOJ3Q8bWtsboroDLM=;
        b=YLgp5kIilD8pmbKmsXH5m0rEms+wZ1NVhPWBe0FRs+ttAxnxM5JoQOCHiANs468qcm
         jfbC/889zty4oq7MPZr+4fHEGWcvHeBIa9BsYZZT+b/BS553QJI0pWCrSDax/AjFjj03
         gaVGQ9z417Sdn0qEiVTPYl4GQEl7zx9puTSo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=XJnGQ196bV3DG6WDX/7IGBMLELLOJ3Q8bWtsboroDLM=;
        b=TOlA+MdsFb1zWEUxYaD9G6u90JKqtLoNjq5u5SXJivKQ23ZgDGQ6vPtmidIbmIgR6N
         gLJAplxI3/QqFtsyP4lLd8uph4OztPqmcTImldKiuxUsVQAooEEoU7Ll8go7Km9EYRLd
         +9ULjAg/5bdtviqENIuCMiUdFQnZ+ea6EeLB9dS3iWPfm2K/ovQ04bSH0PrDvfPFQhgs
         f5am99kzkQWbw1PJdECs59jgPrMS6w4yRNgvxQtKhbTI/YO1x+niHJt7pq1XKS4fBV30
         DgyuCUDOkb5reNFPnGBlVsgLKhQBbWnPiohrmpQZeyrfHWifbgMiAw+TJXkyaCjQ0zof
         1Jig==
X-Gm-Message-State: AOAM5301WO8huO/hQXiYqzNZhLxOcEKbwP/jBNn8ngagyEVFdxatFrvl
        upSRKlV6F3h6P7+SHpaHtbNVbKnceAscdeXXRtx/Ug==
X-Google-Smtp-Source: ABdhPJyH0/q1DwYdc78RBBSRXWb6p1cc7lF7eGuIw9zH5oLQ1X8ics0oScK4fD/ivmpcD0ouBnMbGpckr8zlxuFR/7w=
X-Received: by 2002:aca:b988:: with SMTP id j130mr1723105oif.87.1596717108513;
 Thu, 06 Aug 2020 05:31:48 -0700 (PDT)
From:   Muneendra Kumar M <muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-2-git-send-email-muneendra.kumar@broadcom.com>
 <20200804113130.qfi5agzilso3mlbp@beryllium.lan> <20200804142123.GA4819@mtj.thefacebook.com>
 <b35e0e83-eb6c-4282-5142-22d9a996d260@broadcom.com> <CACVXFVPVM-xU0d2nETztPrS_EpacMy8A4x8FbShhLYt2iV_ouw@mail.gmail.com>
 <227c7f27-c6c7-5db1-59ac-2dd428f5a42a@suse.de> <20200805143913.GC4819@mtj.thefacebook.com>
 <c40bc34840566366177a84b0d8b7ae90@mail.gmail.com> <CACVXFVOYc9KAaLsQ1kPa_bW_MsUgcxhqec45f24pB62=r-KXPg@mail.gmail.com>
In-Reply-To: <CACVXFVOYc9KAaLsQ1kPa_bW_MsUgcxhqec45f24pB62=r-KXPg@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
thread-index: AQIDyhmBPqdmqCKUdNTZliBUbPkt/AIVs741AOV8stoBvB2xRwGs7Aj/AfU+Z6cCXn8lCgHQWH25AVoqZXEB1thjAKhSey1A
Date:   Thu, 6 Aug 2020 18:01:45 +0530
Message-ID: <52249efd20f42271ef31767e84ac9b8c@mail.gmail.com>
Subject: RE: [RFC 01/16] blkcg:Introduce blkio.app_identifier knob to blkio controller
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ewan Milne <emilne@redhat.com>, mkumar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming Lei,
Thanks for the input.
We will consider the points which you and Tejun has suggested .

Regards,
Muneendra.

-----Original Message-----
From: Ming Lei [mailto:tom.leiming@gmail.com]
Sent: Thursday, August 6, 2020 7:52 AM
To: Muneendra Kumar M <muneendra.kumar@broadcom.com>
Cc: Tejun Heo <tj@kernel.org>; Hannes Reinecke <hare@suse.de>; James Smart
<james.smart@broadcom.com>; Daniel Wagner <dwagner@suse.de>; linux-block
<linux-block@vger.kernel.org>; Linux SCSI List <linux-scsi@vger.kernel.org>;
Paolo Bonzini <pbonzini@redhat.com>; Ewan Milne <emilne@redhat.com>;
mkumar@redhat.com
Subject: Re: [RFC 01/16] blkcg:Introduce blkio.app_identifier knob to blkio
controller

On Thu, Aug 6, 2020 at 1:15 AM Muneendra Kumar M
<muneendra.kumar@broadcom.com> wrote:
>
> Hi Tejun,
> Our main requirement is to track the bio requests coming from
> different VM /container applications  at the blk device
> layer(fc,scsi,nvme).
> By the time IO request comes to the blk device layer, the context of
> the application is lost and we can't track whose IO this belongs.
>
> In our approach we used the block cgroup to achieve this requirement.
> Since Requests also have access to the block cgroup via
> bio->bi_blkg->blkcg, and from there we can get the VM UUID.
> Therefore we added the VM UUID(app_identifier) to struct blkcg and
> define the accessors in blkcg_files and blkcg_legacy_files.
>
> Could you please let me know is there any another way where we can get
> the VM UUID info with the help of blkcg.

As Tejun suggested, the mapping between bio->bi_blkg->blkcg and the unique
ID could be built in usage scope, such as fabric infrastructure, something
like xarray/hash may help to do that without much difficulty.

Thanks,
Ming
