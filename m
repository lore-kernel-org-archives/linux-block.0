Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF50FC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 02:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2BC2147A
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 02:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ4TzZjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfBSCUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:20:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38354 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfBSCUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 21:20:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so20415521wrw.5;
        Mon, 18 Feb 2019 18:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agxbP0AQ1b+LcN9EvsfaxtHIbOGCh3JxR6EwJPrXbz4=;
        b=IQ4TzZjfwbALKWeR3drtc0jD6vDkmWoCSAiqIfec99TPKvao567WpZWm2om8MGinJh
         mr0SzSBsKpIdk0Ejiupo8YBkmtdMhpC6EI0IJ/JO1YRAkCTVcaDbJLXBQo1O+iZg6uVr
         zH/3648cdhWnDb+z1cjKuNdUcJBcD27XRftOI6Z1xoRfux4mBXu3aNYPkinR+90ZFPcB
         SclQwoSo+BOlhkseNgQxrwKQGwp3tkQX5zK4bGPOMLBH/Ojje/dYGOKV4b/4o1VihWyk
         9gKF6TUvz+n2J9kKp7tQJX95i+7fYJ3OosMw4h8+jtp2Yq4zyflhBwLYVd6fdwB96kpr
         yRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agxbP0AQ1b+LcN9EvsfaxtHIbOGCh3JxR6EwJPrXbz4=;
        b=Svfv2U8MnLQRvCegbiw6Fv1eFeCJVVc6oTSo1UkUQscX888O2o1+6AxPRynNVYcbY0
         E9CF3MwRmrCd8llMmNrxEnkmiFdvX0bpyFCW0sqsXbtuhcTCghRohnQfz7zEhZ3xPtF6
         P+OxTLU9pE/SLkSopPw5u4RRIHr6fcMwKXkI30weHOSTXISIbmusIl7OIyjayVFUUVCk
         MZXF7Q5uNazLq7HnDKnAYPZx7qkdlFTSv6eMIep8a7Iajya7K+MqUbQ+r5LhRjR7xN1i
         2Mn0mlJ09hbjq/QyMMsnfyDSd4+uC7cmM4CCkpuYpgAmsMS0ctEoxQ5F4m6jG/vKyyKl
         vTCA==
X-Gm-Message-State: AHQUAubBHrvSmhjTN9erqXrgAdaz7LVdJ1EuMHZ9/HmCOUY4AsR10xUm
        ReGBhqy8pJS39kC9uIP1xM0z1KNSstBIWa4dY88=
X-Google-Smtp-Source: AHgI3IbXfF5oQzqDof+XtOVZ+22uYrApUeViFpDPguUR4u2fUoYZys7K3IJifZ/N6KNA6Iajk5yoGpi4Pe/x5tcA1SY=
X-Received: by 2002:a5d:668b:: with SMTP id l11mr18242555wru.116.1550542803358;
 Mon, 18 Feb 2019 18:20:03 -0800 (PST)
MIME-Version: 1.0
References: <99dc311f-16b6-9b0d-e309-198dcc9dcde7@suse.de>
In-Reply-To: <99dc311f-16b6-9b0d-e309-198dcc9dcde7@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 19 Feb 2019 10:19:51 +0800
Message-ID: <CACVXFVPj+zoT9FkE0UqagJMwTHXv8t6OzXM2KtsqrMp3=WMcEw@mail.gmail.com>
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

On Tue, Feb 5, 2019 at 11:30 PM Hannes Reinecke <hare@suse.de> wrote:
>
> Hi all,
>
> this came up during discussion on the mailing list (cf thread "Question
> on handling managed IRQs when hotplugging CPUs").
> The problem is that with managed IRQs and block-mq I/O will be routed to
> individual CPUs, and the response will be send to the IRQ assigned to
> that CPU.
>
> If now a CPU hotplug event occurs when I/O is still in-flight the IRQ
> will _still_ be assigned to the CPU, causing any pending interrupt to be
> lost.
> Hence the driver will never notice that an interrupt has happened, and
> an I/O timeout occurs.

Lots of driver's timeout handler only returns BLK_EH_RESET_TIMER,
and this situation can't be covered by IO timeout for these devices.

For example, we have see IO hang issue on HPSA, megaraid_sas
before when wrong msi vector is set on IO command. Even one such
issue on aacraid isn't fixed yet.

>
> One proposal was to quiesce the device when a CPU hotplug event occurs,
> and only allow for CPU hotplugging once it's fully quiesced.

That is the original solution, but big problem is that queue dependency
exists, such as loop/DM's queue depends on underlying's queue, NVMe
IO queue depends on  its admin queue.

>
> While this would be working, it will be introducing quite some system
> stall, and it actually a rather big impact in the system.
> Another possiblity would be to have the driver abort the requests
> itself, but this requires specific callbacks into the driver, and, of
> course, the driver having the ability to actually do so.
>
> I would like to discuss at LSF/MM how these issues can be addressed best.

One related topic is that the current static queue mapping without CPU hotplug
handler involved may waste lots of IRQ vectors[1], and how to deal
with this problem?

[1] http://lists.infradead.org/pipermail/linux-nvme/2019-January/021961.html

Thanks,
Ming Lei
