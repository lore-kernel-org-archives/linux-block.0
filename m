Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901B9C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 11:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBPL0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 06:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBPL0q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 06:26:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F115546
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 03:26:45 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id he5so1309224wmb.3
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 03:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2YC56It+6c6cuIQlqyCwu+Mv01RIdVHCg8Jq7MqNrEY=;
        b=zf0NZ5hVF7V5ziGN0v+GovqEmV5NNS1D/l6yQx0Nw1OhQlfUWF1a1gMOYyus5uH0IY
         +FEHzfxv6BYcPI6FRgmc8QPTD+kc8IJW4GlwdVNyoKt/zKZA7bHESuEFVkYz7tHNqOSz
         fkI3haZaUz9WwmV0Mb1gsaPSClVQ0pF1HUSVkCCOFilt3PSwmtkrHiWbUPHdZAfqEr54
         58XoXtVzCOrrQVTs3l7FWPfYpwh8UDniLT5i9aQ2mmc5bJPDzsEmdjh5ytXnTN6yMNh9
         3YwtESby//OZET0JEPxr1j+7K13iMaeEscKsJQcXVrgnv6ePxeATDAZ18nL0Hk8T8a6W
         05rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YC56It+6c6cuIQlqyCwu+Mv01RIdVHCg8Jq7MqNrEY=;
        b=5bxJ7UClSF9fqvu2XkToTsFHfsjbp6TsyrFw/8S3qmvE9K2JU7NXzOqFPTFekauexo
         ia29QCyX2PRpyhOF9FgFIW0a+5mST+mXFMmVIf3035MArZg7koxyeShVLF02PTMDJoo3
         8NhruDLOwN6xjk9UFXoPv6YslWFq6/+fxkVvEXCkf9VGoPAkEAWwjyTKX9sTxHIq8mb6
         fM6UP6zAd9L8UOV7Iv4GrQsd+RLbcjb39qFXabpoNoDK54uMB4o3h0Ude+BThGlV8JWb
         WrKL7mhDjw4P5+0HrM1L4J6scIPdBqXT9L9RJjXa7NpuvCg7NAnpEh9uCi3OkGzeiD9i
         OhMg==
X-Gm-Message-State: AO0yUKXMjcLraxibnL3c4V5hw5L8i1dXFcRSKMYSuHtS+V8pfvP7r0vC
        yiMdYtIwc1aR8OBZ60XChUP97w==
X-Google-Smtp-Source: AK7set83WlDMhLzxvqXV33kCqS6qKAERIiNXs9puX/8ebu+HpZGOfvrTjwzUG9tpvt2iM7ghGLb/kg==
X-Received: by 2002:a05:600c:a287:b0:3e2:180f:382a with SMTP id hu7-20020a05600ca28700b003e2180f382amr401053wmb.1.1676546803943;
        Thu, 16 Feb 2023 03:26:43 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003dd1bd66e0dsm1431083wme.3.2023.02.16.03.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 03:26:43 -0800 (PST)
References: <Y+EWCwqSisu3l0Sz@T590> <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590> <Y+OSxh2K0/Lf0SAk@fedora> <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora> <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk> <Y+4JVgd338R0x1m4@T590>
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
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Date:   Thu, 16 Feb 2023 12:21:32 +0100
In-reply-to: <Y+4JVgd338R0x1m4@T590>
Message-ID: <877cwhrgul.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wrote:
>> 
>> Hi Ming,
>> 
>> Ming Lei <ming.lei@redhat.com> writes:
>> 
>> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
>> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
>> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
>> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
>> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
>> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
>> >> > > > > > Hello,
>> >> > > > > > 
>> >> > > > > > So far UBLK is only used for implementing virtual block device from
>> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
>> >> > > > > 
>> >> > > > > I won't be at LSF/MM so here are my thoughts:
>> >> > > > 
>> >> > > > Thanks for the thoughts, :-)
>> >> > > > 
>> >> > > > > 
>> >> > > > > > 
>> >> > > > > > It could be useful for UBLK to cover real storage hardware too:
>> >> > > > > > 
>> >> > > > > > - for fast prototype or performance evaluation
>> >> > > > > > 
>> >> > > > > > - some network storages are attached to host, such as iscsi and nvme-tcp,
>> >> > > > > > the current UBLK interface doesn't support such devices, since it needs
>> >> > > > > > all LUNs/Namespaces to share host resources(such as tag)
>> >> > > > > 
>> >> > > > > Can you explain this in more detail? It seems like an iSCSI or
>> >> > > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
>> >> > > > > What am I missing?
>> >> > > > 
>> >> > > > The current ublk can't do that yet, because the interface doesn't
>> >> > > > support multiple ublk disks sharing single host, which is exactly
>> >> > > > the case of scsi and nvme.
>> >> > > 
>> >> > > Can you give an example that shows exactly where a problem is hit?
>> >> > > 
>> >> > > I took a quick look at the ublk source code and didn't spot a place
>> >> > > where it prevents a single ublk server process from handling multiple
>> >> > > devices.
>> >> > > 
>> >> > > Regarding "host resources(such as tag)", can the ublk server deal with
>> >> > > that in userspace? The Linux block layer doesn't have the concept of a
>> >> > > "host", that would come in at the SCSI/NVMe level that's implemented in
>> >> > > userspace.
>> >> > > 
>> >> > > I don't understand yet...
>> >> > 
>> >> > blk_mq_tag_set is embedded into driver host structure, and referred by queue
>> >> > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
>> >> > that said all LUNs/NSs share host/queue tags, current every ublk
>> >> > device is independent, and can't shard tags.
>> >> 
>> >> Does this actually prevent ublk servers with multiple ublk devices or is
>> >> it just sub-optimal?
>> >
>> > It is former, ublk can't support multiple devices which share single host
>> > because duplicated tag can be seen in host side, then io is failed.
>> >
>> 
>> I have trouble following this discussion. Why can we not handle multiple
>> block devices in a single ublk user space process?
>> 
>> From this conversation it seems that the limiting factor is allocation
>> of the tag set of the virtual device in the kernel? But as far as I can
>> tell, the tag sets are allocated per virtual block device in
>> `ublk_ctrl_add_dev()`?
>> 
>> It seems to me that a single ublk user space process shuld be able to
>> connect to multiple storage devices (for instance nvme-of) and then
>> create a ublk device for each namespace, all from a single ublk process.
>> 
>> Could you elaborate on why this is not possible?
>
> If the multiple storages devices are independent, the current ublk can
> handle them just fine.
>
> But if these storage devices(such as luns in iscsi, or NSs in nvme-tcp)
> share single host, and use host-wide tagset, the current interface can't
> work as expected, because tags is shared among all these devices. The
> current ublk interface needs to be extended for covering this case.

Thanks for clarifying, that is very helpful.

Follow up question: What would the implications be if one tried to
expose (through ublk) each nvme namespace of an nvme-of controller with
an independent tag set? What are the benefits of sharing a tagset across
all namespaces of a controller?

Best regards,
Andreas
