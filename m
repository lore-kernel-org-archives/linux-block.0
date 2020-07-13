Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DBAC433E0
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 07:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957D120702
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 07:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dWXhlmpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgGMHzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgGMHzm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 03:55:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465CC061794
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 00:55:42 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so11359890qkg.1
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=ShBbu9sSYjap4DNNY3AXNyJIdESjeWRe5yF7SlDXnuM=;
        b=dWXhlmpWo5QoCPI2izE2yTmGwoKzRlwOsgOZwO875I7HbgY5tyXt+83r4yacOebEBs
         u+YeHsZHh9nuo05CLbNQk9lDe6gs/lgBcxcg0moedib5WQizGbTxfZNsplw8/xK5cVru
         2VWdTpnmGVW+kqHX1dwLe9ZdCEm6Ayrjz2hDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=ShBbu9sSYjap4DNNY3AXNyJIdESjeWRe5yF7SlDXnuM=;
        b=AUWWpMUCuBlkF+qCv0Xww9U1ONJfcg91+9wdoMEqz1yHVQBkpT4B33H5HpXBUBr1JA
         dOUIdESMQOfC5+6EZMzvW+GiS1rOYDrxM4gBx2DUq0AS4FyU+X3gjkFm1KLINRwLuTk7
         p8g35Ve3Sgwtw8YcQQ+cabBI5YWIbMsAZ9KFBi30h6wjMovO0cC90svMU2Hrvme+uLcn
         4xT995nmaTACR44WYXFOTopeyXv5uoMSG6c486MR0KijfAHpcfGYmOF7EXkJEg7wBwQE
         IxM8B0R2TRPWK0M/B4/0dgYIKNKJxdzjlfDcXKHdZJoj1JFLCbhy3vMAH93+u5apIHG5
         gcEw==
X-Gm-Message-State: AOAM531TOGfnfJUSDIvGSa5PwGtghbwxFQJRgb5njLT9IDzfVEx3lMBK
        CWfO9lE6Qs3aBV2dQoakggHgTsFRQb1bnucraFSv2w==
X-Google-Smtp-Source: ABdhPJy2hEhEZRa0fM9TYLsRxdVxdjIA2gv9Xrbar7MUzaUTDRZ/fV2dWEMyqlQiRZC2SKNDqA3BYHY52EIFKXPyBG8=
X-Received: by 2002:a37:aa87:: with SMTP id t129mr80362516qke.70.1594626941585;
 Mon, 13 Jul 2020 00:55:41 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
 <1591810159-240929-11-git-send-email-john.garry@huawei.com>
 <d55972999b9370f947c20537e41b49bf@mail.gmail.com> <e61593f8-5ee7-5763-9d02-d0ea13aeb49f@huawei.com>
 <92ba1829c9e822e4239a7cdfd94acbce@mail.gmail.com> <10d36c09-9d5b-92e9-23ac-ea1a2628e7d9@huawei.com>
 <0563e53f843c97de1a5a035fae892bf8@mail.gmail.com> <61299951-97dc-b2be-c66c-024dfbd3a1cb@huawei.com>
 <b49c33ebda36b8f116a51bc5c430eb9d@mail.gmail.com> <13d6b63e-3aa8-68fa-29ab-a4c202024280@huawei.com>
In-Reply-To: <13d6b63e-3aa8-68fa-29ab-a4c202024280@huawei.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQBVjmvxAE7FMYb7GtMRWGcwtMcECgFIs823Ad7lfqMBmFaE1AGZowweAlKrFcUB/hGY5AG4aoXNAvsHUMYCeW9VQ6t3/AoA
Date:   Mon, 13 Jul 2020 13:25:36 +0530
Message-ID: <34a832717fef4702b143ea21aa12b79e@mail.gmail.com>
Subject: RE: [PATCH RFC v7 10/12] megaraid_sas: switch fusion adapters to MQ
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, Sumit Saxena <sumit.saxena@broadcom.com>,
        ming.lei@redhat.com, bvanassche@acm.org, hare@suse.com, hch@lst.de,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, chenxiang66@hisilicon.com,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > Looking at description of above patch and changes, it looks like
> > megaraid_sas driver can still work without shared host tag for this
> > feature.
> >
> > I observe CPU hotplug works irrespective of shared host tag
>
> Can you be clear exactly what you mean by "irrespective of shared host
> tag"?
>
> Do you mean that for your test Scsi_Host.nr_hw_queues is set to expose hw
> queues and scsi_host_template.map_queues = blk_mq_pci_map_queues(),
> but you just don't set the host_tagset flag?

Yes. I only disabled "host_tagset". <map_queue> is still hooked.

>
>   in megaraid_sas
> > on 5.8-rc.
> >
> > Without shared host tag, megaraid driver will expose single hctx and
> > all the CPU will be mapped to hctx0.
>
> right
>
> > Any CPU offline event will have " blk_mq_hctx_notify_offline" callback
> > in blk-mq module. If we do not have this callback/patch, we will see
> > IO timeout.
> > blk_mq_hctx_notify_offline callback will make sure all the outstanding
> > on
> > hctx0 is cleared and only after it is cleared, CPU will go offline.
>
> But that is only for when the last CPU for the hctx is going offline. If
> nr_hw_queues == 1, then hctx0 would cover all CPUs, so that would never
> occur during normal operation. See initial check in
> blk_mq_hctx_notify_offline():
>
> static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node
> *node) {
> 	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> 	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> 		return 0;
>

Thanks John for this pointer. I missed this part and now I understood what
was happening in my testing.
There were more than one CPU mapped to one msix index in my earlier testing
and because of that I could see Interrupt migration happens on available CPU
from affinity mask. So my earlier testing was incorrect.

Now I am consistently able to reproduce issue - Best setup is have 1:1
mapping of CPU to MSIX vector mapping. I used 128 logical CPU and 128 msix
vectors and I noticed IO timeout without this RFC (without host_tagset).
I did not noticed IO timeout with RFC (with host_tagset.) I will update this
data in Driver's commit message.

Just for my understanding -
What if we have below code in blk_mq_hctx_notify_offline, CPU hotplug should
work for megaraid_sas driver without this RFC (without shared host tagset).
Right ?
If answer is yes, will there be any side effect of having below code in
block layer ?

static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node
 *node) {
 	if (hctx->queue->nr_hw_queues > 1
	    && (!cpumask_test_cpu(cpu, hctx->cpumask) ||
 	    !blk_mq_last_cpu_in_hctx(cpu, hctx)))
 		return 0;

I also noticed nr_hw_queues are now exposed in sysfs -

/sys/devices/pci0000:85/0000:85:00.0/0000:86:00.0/0000:87:04.0/0000:8b:00.0/0000:8c:00.0/0000:8d:00.0/host14/scsi_host/host14/nr_hw_queues:128
