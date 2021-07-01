Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C11C11F67
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 11:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FAF61492
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 11:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhGALJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 07:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236222AbhGALJg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 07:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625137625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWy1faEU2+6xPaNpOXpQc2Lrpi6aPT/25xHf/Z6cpbw=;
        b=H0SJN3MiJRegeQIjXCVad2NfAaKVcu7XPTJI2gacTZNsBrGi+7D0r6t5apEPxInZggqfYG
        eS+CCEUkGSS8VGOoFlvUP5HyD1Qz1NzljGiYj/Xgy+AbnAJ6ibk3gs2sOiF0ae5mzFyDpt
        cEJQU1iLQZjSqhw10v/u6wspGvmBsWE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-xpXmjMs5NVuqTv0vTE19qw-1; Thu, 01 Jul 2021 07:07:02 -0400
X-MC-Unique: xpXmjMs5NVuqTv0vTE19qw-1
Received: by mail-pg1-f197.google.com with SMTP id o9-20020a6561490000b0290226fc371410so3927485pgv.8
        for <linux-block@vger.kernel.org>; Thu, 01 Jul 2021 04:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWy1faEU2+6xPaNpOXpQc2Lrpi6aPT/25xHf/Z6cpbw=;
        b=EoVGRScB878AQEYOicti+gRdLbfdCj81AIsbx/+7P4N78ZusK/QbPclnlvy5peF50v
         oaLQXgRMaISj3yvBJ2nPC8Xwl720DnrPmUQJXZPwDTYS2n85gLpxVWOYZtaiwZCYT4zN
         b5/HhiS8GnWGzh893OuynH2qbO6C7CqoMzvbwUHXyWPj7uX2LDUMtR4cIb1p4foY3YUh
         E56u9oy7oWMIxl2g/ad+6+8aeskRwlqpWpyHoAGsxwlxUS7wGqLel4KISpXAoqwj9NNE
         zXpLA1c/V3cBDp3/AIrwke5gu4Vxzmk+9O2yNNk/4q9WuBgfIqwv4FNiLTf7+MQa9G2l
         rmyg==
X-Gm-Message-State: AOAM533PjM8R+k2IgHNe6bHQpmseajCKg4vY4KE3ILXwdsoABgtNR7IO
        H43JTlGuwt3FwL21I0PAitjFqFNa58H1GZmfIeT8/5oG/F79lOPu/oXhpjBUxaGKWVagNz9q/UL
        ojRn1kl+ItmIU17M29OWY7A34Cfbb24ou5XqdaY0=
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id e22-20020a62ee160000b02902feffcf775amr40043884pfi.59.1625137621555;
        Thu, 01 Jul 2021 04:07:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1kVwoyjnIR3qRD8QsEf+6pzFR5H2YZPuZNpfADIZAAKDrY4X0nTDNbSb/S3TOhjXbj1hLppeJRJPQxzNCLxU=
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id
 e22-20020a62ee160000b02902feffcf775amr40043852pfi.59.1625137621231; Thu, 01
 Jul 2021 04:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210628151558.2289-1-mwilck@suse.com> <20210628151558.2289-4-mwilck@suse.com>
 <20210701075629.GA25768@lst.de>
In-Reply-To: <20210701075629.GA25768@lst.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 1 Jul 2021 13:06:50 +0200
Message-ID: <CABgObfYi6TooJM1cCCQrj2pdzz+VHtC+-w1KTycvsSiC+koNVQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] dm mpath: add CONFIG_DM_MULTIPATH_SG_IO - failover
 for SG_IO
To:     Christoph Hellwig <hch@lst.de>
Cc:     Martin Wilck <mwilck@suse.com>, Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Nils Koenig <nkoenig@redhat.com>,
        Ewan Milne <emilne@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 1, 2021 at 9:56 AM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 28, 2021 at 05:15:58PM +0200, mwilck@suse.com wrote:
> > The qemu "pr-helper" was specifically invented for it. I
> > believe that this is the most important real-world scenario for sending
> > SG_IO ioctls to device-mapper devices.
>
> pr-helper obviously does not SG_IO on dm-multipath as that simply does
> not work.

Right, for the specific case of persistent reservation ioctls, SG_IO is
sent manually to each path via libmpathpersist.

Failover for SG_IO is needed for general-purpose commands (ranging
from INQUIRY/READ CAPACITY to READ/WRITE). The reason to use
SG_IO instead of syscalls is mostly to preserve sense data; QEMU does
have code to convert errno to sense data, but it's fickle. If QEMU can use
sense data directly, it's easier to forward conditions that the guest can
resolve itself (for example unit attentions) and to let the guest operate
at a lower level (e.g. host-managed ZBC can be forwarded and they just
work).

Of course, all this works only for SCSI. As NVMe becomes more common,
and Linux exposes more functionality to userspace with a fabric-neutral
API, QEMU's SBC emulation can start using that functionality and provide
low-level passthrough functionality no matter if the host is using SCSI
or NVMe. Again, the main obstacle for this is sense data; for example,
the SCSI subsystem rightfully eats unit attentions and converts them to
uevents if you go through read/write requests instead of SG_IO.

> More importantly - if you want to use persistent reservations use the
> kernel ioctls for that.  These work on SCSI, NVMe and device mapper
> without any extra magic.

If they provide functionality equivalent to libmpathpersist without having
to do the DM_TABLE_STATUS, I will certainly consider switching! The
only possible issue could be the lost unit attentions.

Paolo

> Failing over SG_IO does not make sense.  It is an interface specically
> designed to leave all error handling to the userspace program using it,
> and we should not change that for one specific error case.  If you
> want the kernel to handle errors for you, use the proper interfaces.
> In this case this is the persistent reservation ioctls.  If they miss
> some features that qemu needs we should add those.

