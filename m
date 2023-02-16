Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D9C61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 10:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBPKeo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 05:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBPKem (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 05:34:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A1454564
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 02:34:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso1243392wmo.3
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd/tLq1FjWUIoNedOrnIA+vdz3zc08/Jkg4WfyjY/gw=;
        b=wa0ebznXbZZLPQtjTXNjxjnGXjuYDkj0la0Noxvb3Rz25iUgO0VD0ej6XnDzBcfiHj
         UkpNJcYtAwNBgnkh7ZYwnQn+7qtd+BwOJAqCYq8rTSgdk5gRRGncZC04gHtSpsdzkDBL
         wEUyyHOAESU6faDOwLlCX4PLd9s4j3N/ugmqJuMYg1MuXIkgO8nbF8qsEt/JHxpWg9q5
         07yfEUPWh22Keik0B+sP63X2isxEnW8wYP0fNUOsoPYMhM0Y6ILeeTljpH70oML6IXD/
         80whU3ARS1+XKYjM2kgiBoiKdlqnLyA8mwFPJQpP1d6TkhY77Df5MWUVNS9GQmtyHwnS
         /8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd/tLq1FjWUIoNedOrnIA+vdz3zc08/Jkg4WfyjY/gw=;
        b=LJ+luwI0Qx4qqqwsX7VXAYTF0WnxuKySNgsymh7vRnivQI2etMdVPIWbpiphfx5Jel
         nKJPRz4TEtR4HDsNt6BaDlrfwWxZ377bw3oJWAGIaQoviNfSuNu3pmPeuFLq3ME0PYNE
         RBOd/VhkRqQZ7lh6aBW977AYfNsq5VOBFi33f6LoQzMy2Q5mp5BsKb/j7Yns8Atb5TJI
         dRUCibsgDQAsSsqeuBwUIdGHHOqjhIMQ+Bsn5A/V8HQHvJw7VeNGIr78UAff38FNE8ou
         y6clBkYxoUCGYhn8MKT18yrVflrspkCM+b4FHT01HeHh3Stty5hQzUhaPTNSHomZzR0T
         +NbQ==
X-Gm-Message-State: AO0yUKX+8x5/Gcfmh7j1tHfOiSU+8TCVyFzpjlDMEhZlbomYlHFBhNUR
        /yZA0lVVeHmQ40OO6w/dudYuTwoIAVFjZHLC
X-Google-Smtp-Source: AK7set/pA+3ZSvkkPrKGFGv2frqOJz/W46t8dHx9lppi8UsaPylZl+7zUDJI6jk7O4bJddE11oRUmw==
X-Received: by 2002:a05:600c:1da3:b0:3df:e57d:f4ba with SMTP id p35-20020a05600c1da300b003dfe57df4bamr4907786wms.7.1676543660046;
        Thu, 16 Feb 2023 02:34:20 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id y2-20020a7bcd82000000b003db01178b62sm4975647wmj.40.2023.02.16.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:34:19 -0800 (PST)
References: <Y+EWCwqSisu3l0Sz@T590> <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590> <Y+OSxh2K0/Lf0SAk@fedora> <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora> <Y+wsj2QqX+HMUJTI@T590>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Date:   Thu, 16 Feb 2023 10:44:02 +0100
In-reply-to: <Y+wsj2QqX+HMUJTI@T590>
Message-ID: <87bkltrj9x.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Ming,

Ming Lei <ming.lei@redhat.com> writes:

> On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
>> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
>> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
>> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
>> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
>> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
>> > > > > > Hello,
>> > > > > > 
>> > > > > > So far UBLK is only used for implementing virtual block device from
>> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
>> > > > > 
>> > > > > I won't be at LSF/MM so here are my thoughts:
>> > > > 
>> > > > Thanks for the thoughts, :-)
>> > > > 
>> > > > > 
>> > > > > > 
>> > > > > > It could be useful for UBLK to cover real storage hardware too:
>> > > > > > 
>> > > > > > - for fast prototype or performance evaluation
>> > > > > > 
>> > > > > > - some network storages are attached to host, such as iscsi and nvme-tcp,
>> > > > > > the current UBLK interface doesn't support such devices, since it needs
>> > > > > > all LUNs/Namespaces to share host resources(such as tag)
>> > > > > 
>> > > > > Can you explain this in more detail? It seems like an iSCSI or
>> > > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
>> > > > > What am I missing?
>> > > > 
>> > > > The current ublk can't do that yet, because the interface doesn't
>> > > > support multiple ublk disks sharing single host, which is exactly
>> > > > the case of scsi and nvme.
>> > > 
>> > > Can you give an example that shows exactly where a problem is hit?
>> > > 
>> > > I took a quick look at the ublk source code and didn't spot a place
>> > > where it prevents a single ublk server process from handling multiple
>> > > devices.
>> > > 
>> > > Regarding "host resources(such as tag)", can the ublk server deal with
>> > > that in userspace? The Linux block layer doesn't have the concept of a
>> > > "host", that would come in at the SCSI/NVMe level that's implemented in
>> > > userspace.
>> > > 
>> > > I don't understand yet...
>> > 
>> > blk_mq_tag_set is embedded into driver host structure, and referred by queue
>> > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
>> > that said all LUNs/NSs share host/queue tags, current every ublk
>> > device is independent, and can't shard tags.
>> 
>> Does this actually prevent ublk servers with multiple ublk devices or is
>> it just sub-optimal?
>
> It is former, ublk can't support multiple devices which share single host
> because duplicated tag can be seen in host side, then io is failed.
>

I have trouble following this discussion. Why can we not handle multiple
block devices in a single ublk user space process?

From this conversation it seems that the limiting factor is allocation
of the tag set of the virtual device in the kernel? But as far as I can
tell, the tag sets are allocated per virtual block device in
`ublk_ctrl_add_dev()`?

It seems to me that a single ublk user space process shuld be able to
connect to multiple storage devices (for instance nvme-of) and then
create a ublk device for each namespace, all from a single ublk process.

Could you elaborate on why this is not possible?

Best regards,
Andreas Hindborg
