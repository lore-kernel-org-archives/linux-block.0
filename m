Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D84C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 03:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B8422360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 03:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2WFICzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B8422360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeKNNE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 08:04:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41572 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKNNE0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 08:04:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id v18-v6so15563225wrt.8;
        Tue, 13 Nov 2018 19:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XakKHfbteu9i+l/XQgHp9yYrj1g+x4wUT+yvDsNsnj0=;
        b=b2WFICzKad46mDPjA5inLNHah11nxdqhZDjvQSIBeLdP4nWlGx1fPb9VpMeYUbpKwu
         /rBOyUNS2C8Vx3l0RuxepTi5fwAJr7uOD3SZSljVF4Q6MzWEPpv8d8sYV5DyYvxuigv1
         qwYf0Qe1fMCHsgyiMxQ4rbqGOCdqm09wu7nKc7G7kQPo/VP3Koy2TTdlQYApwGZFPPei
         Zqc7N5iDv5dGRDG0HZ6kfJiiiRcZ0+HHllho9Bnnn9vh+fSTwK2m9QrX4uG0c2mtDLqq
         U9Ibq2peYCTAfbJNi17YkbNrWc8w+PZzxeiVJqF3U1GaCB+3w8/QgAU27skZJbCALh/D
         8YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XakKHfbteu9i+l/XQgHp9yYrj1g+x4wUT+yvDsNsnj0=;
        b=FTHM1qUuSprUe/VBIzUTIYYEDu9byoAhRy5eYoOJe3sgg/GRZrm+z2+etdIfCFlH3V
         lXoVQ5ivuWfRW7dUOkiyM+MpLOAyzIn0GlP+lvGh9zBLzKvT4YJcCKTBZZHd7thvcj0X
         HKWvDqZIec16YmcVD3WYQqTJkOKo/yvdMFjwQHw6LdoWn2G7ChOmx0I49QTjFTXS0pl7
         Ea5FbnEj24wG2TtyWusnIP9/6IGi9papxJdjU19fknhI9uXuxl7iwwiKYQmnxkEOlghG
         T/aYqBjQ/afrzqD1fsoZ1+fbTfYBfSEIfgemZPFCFYmE7K/dhcFH9Dl/XvbGvLYdvWCh
         0p7A==
X-Gm-Message-State: AGRZ1gIJJIykz/pHqOm0Ndoizpkmir3JT3WeZqcmMq9pBpM+FIpJQhge
        qew00I2EphggBLvDu7qHTiQ+xsfswN0zVGqlg28=
X-Google-Smtp-Source: AJdET5dT1MqIkWHupq7/AJlWxsqiASPJc8w57zlwL8dDRR8/BDjL3BGjEm6ptmSliEow2//Npcz4Jji7nS1NUhIxUzk=
X-Received: by 2002:adf:ce0f:: with SMTP id p15-v6mr110048wrn.324.1542164590891;
 Tue, 13 Nov 2018 19:03:10 -0800 (PST)
MIME-Version: 1.0
References: <1542103016-21037-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542103016-21037-4-git-send-email-jianchao.w.wang@oracle.com>
 <d8d88eff-e3eb-542d-d4fa-06b6aff97ba0@kernel.dk> <94ec3d97-f75f-645d-94f1-24d3fd476940@oracle.com>
In-Reply-To: <94ec3d97-f75f-645d-94f1-24d3fd476940@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 14 Nov 2018 11:02:59 +0800
Message-ID: <CACVXFVNZ1p4wV6S_FRyKssbUT9CV-aXZ=iRGQ-tY05v_7vxPnw@mail.gmail.com>
Subject: Re: [PATCH V6 3/5] blk-mq: ensure hctx to be ran on mapped cpu when
 issue directly
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 10:15 AM jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
> Hi Jens
>
> Thanks for your kindly response.
>
> On 11/13/18 9:44 PM, Jens Axboe wrote:
> > On 11/13/18 2:56 AM, Jianchao Wang wrote:
> >> When issue request directly and the task is migrated out of the
> >> original cpu where it allocates request, hctx could be ran on
> >> the cpu where it is not mapped.
> >> To fix this,
> >>  - insert the request forcibly if BLK_MQ_F_BLOCKING is set.
> >>  - check whether the current is mapped to the hctx, if not, insert
> >>    forcibly.
> >>  - invoke __blk_mq_issue_directly under preemption disabled.
> >
> > I'm not too crazy about this one, adding a get/put_cpu() in the hot
> > path, and a cpumask test. The fact is that most/no drivers care
> > about strict placement. We always try to do so, if convenient,
> > since it's faster, but this seems to be doing the opposite.
> >
> > I'd be more inclined to have a driver flag if it needs guaranteed
> > placement, using one an ops BLK_MQ_F_STRICT_CPU flag or similar.
> >
> > What do you think?
> >
>
> I'd inclined blk-mq should comply with a unified rule, no matter the
> issuing directly path or inserting one. Then blk-mq would have a simpler
> model. And also this guarantee could be a little good for drivers,
> especially the case where cpu and hw queue mapping is 1:1.

I guess it is quite hard to respect this rule 100%, such as in case of
CPU hotplug.

Thanks,
Ming Lei
