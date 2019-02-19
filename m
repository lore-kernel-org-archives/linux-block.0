Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7FC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 15:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F8C20700
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 15:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhzYKgUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBSPOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:14:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36901 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSPOk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 10:14:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so22384315wrs.4;
        Tue, 19 Feb 2019 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFuVH+ancUZJWyfoSb/YQJ3aFgwwD9rcaP9jNASv4Ig=;
        b=JhzYKgUwrMqtC6N+iJa+at/KERpE2/Mz2V4At9ryD25s6gOL6rbkBZ4KkQA7U0wnf6
         dl4ogAVrCX+VcSwTpQ9YL4w+vABj9RvFulPtVag/4u4RN8B70wwQwqR9+xZwrgbLCokY
         11B1nSAy9gsDWxM0GOJHhIbbnMa4NoxItOaoPzSg+2y+e8AqqPsLI+g5ob0yuQLmw5dr
         NCPzQ+D4R9jwMAClmNSy5KOT9iD2rLvet0odLORlEvFOmZWaaa5fUd07ssaMiWFjknyC
         2O2Ii3IwkSYMRbfyCJuPAGGAnNfXBuo7WK9GohvGr33UzmvnzjDpPlcYgGVEs6SvxHX4
         lZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFuVH+ancUZJWyfoSb/YQJ3aFgwwD9rcaP9jNASv4Ig=;
        b=XNBrlFvwXq0Pk3WuNrx2EsHNu0115h6tIba2T88tNliJ99j4ZDFrBd2ZSjSz6IgdHF
         6TOfEA6Lvqqq7+MYZ/vFS+8yD4+EIDgP93Rypq6uSe3Z8U3bMVOga7NmwIOCDPr3iyJZ
         et8frnTxF4qqfIjIV1+LuZtQRoosaly0DG8FQ3pueweC2J1J3Cbzn0oOxIU32XVoOMJj
         kwDyYYBm5ie9/0OLwmtRYc24dwOkeDthsnS1iWzuhdIRBvDa5AcS+AnAoM6WBXZnd0dU
         oQCKp37tKxJYO1jjfDEY02duIEmFOVbZaX8aDU5jYrhCjtVm/r7jc/sIBawwiqkJlzXE
         VmaA==
X-Gm-Message-State: AHQUAubes54s6O9jGn/A+VJBMRy46zOI2nPEfnMaDzHYe7xqjkUf3MUj
        M0+82JwI3Ymo97/qjoa7SQvdCTuudBlb/ZC9W7c=
X-Google-Smtp-Source: AHgI3IYPYlnk2bn+vSXPe5wwAN0p+PPBZFP8rYYwV0qFQTANdFMzSvv0br5OjsQqdR6+jSBhoXZSnYtPxKpou8Er1FA=
X-Received: by 2002:a05:6000:10c1:: with SMTP id b1mr19976521wrx.275.1550589278230;
 Tue, 19 Feb 2019 07:14:38 -0800 (PST)
MIME-Version: 1.0
References: <99dc311f-16b6-9b0d-e309-198dcc9dcde7@suse.de> <CACVXFVPj+zoT9FkE0UqagJMwTHXv8t6OzXM2KtsqrMp3=WMcEw@mail.gmail.com>
 <ff5c5a70-3c59-87fb-0d5f-5065335ed002@suse.de>
In-Reply-To: <ff5c5a70-3c59-87fb-0d5f-5065335ed002@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 19 Feb 2019 23:14:25 +0800
Message-ID: <CACVXFVOWoNY+L2oCtpCcBeRz6Yns8p-4prHK41bx6+yfdy2voQ@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Handling of managed IRQs when hotplugging CPUs
To:     Hannes Reinecke <hare@suse.de>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        SCSI Mailing List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 19, 2019 at 10:24 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 2/19/19 3:19 AM, Ming Lei wrote:
> > On Tue, Feb 5, 2019 at 11:30 PM Hannes Reinecke <hare@suse.de> wrote:
> >>
> >> Hi all,
> >>
> >> this came up during discussion on the mailing list (cf thread "Question
> >> on handling managed IRQs when hotplugging CPUs").
> >> The problem is that with managed IRQs and block-mq I/O will be routed to
> >> individual CPUs, and the response will be send to the IRQ assigned to
> >> that CPU.
> >>
> >> If now a CPU hotplug event occurs when I/O is still in-flight the IRQ
> >> will _still_ be assigned to the CPU, causing any pending interrupt to be
> >> lost.
> >> Hence the driver will never notice that an interrupt has happened, and
> >> an I/O timeout occurs.
> >
> > Lots of driver's timeout handler only returns BLK_EH_RESET_TIMER,
> > and this situation can't be covered by IO timeout for these devices.
> >
> > For example, we have see IO hang issue on HPSA, megaraid_sas
> > before when wrong msi vector is set on IO command. Even one such
> > issue on aacraid isn't fixed yet.
> >
> >>
> >> One proposal was to quiesce the device when a CPU hotplug event occurs,
> >> and only allow for CPU hotplugging once it's fully quiesced.
> >
> > That is the original solution, but big problem is that queue dependency
> > exists, such as loop/DM's queue depends on underlying's queue, NVMe
> > IO queue depends on  its admin queue.
> >
> >>
> >> While this would be working, it will be introducing quite some system
> >> stall, and it actually a rather big impact in the system.
> >> Another possiblity would be to have the driver abort the requests
> >> itself, but this requires specific callbacks into the driver, and, of
> >> course, the driver having the ability to actually do so.
> >>
> >> I would like to discuss at LSF/MM how these issues can be addressed best.
> >
> > One related topic is that the current static queue mapping without CPU hotplug
> > handler involved may waste lots of IRQ vectors[1], and how to deal
> > with this problem?
> >
> > [1] http://lists.infradead.org/pipermail/linux-nvme/2019-January/021961.html
> >
> Yes, ideally I would like to touch upon that, too.
> Additionally we have the issue raised by the mpt3sas folks [2], where
> they ran into a CPU lockup when having more CPU cores than interrupts.

In theory, if number of submission queues is bigger than number of completion
queues, the softlock issue might be triggered. But in reality, that often means
the irq handler takes too much CPU.

I saw such NVMe devices in which queue mapping is 2:1(2 submission: 1
completion)
and IOPS may reach millions without any soft lockup.

Threaded irq handler may help this case too, at least for avoiding soft lockup.

Thanks,
Ming Lei
