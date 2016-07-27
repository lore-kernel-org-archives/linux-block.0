Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33544 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbcG0INr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 27 Jul 2016 04:13:47 -0400
Received: by mail-oi0-f52.google.com with SMTP id j185so7296594oih.0
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2016 01:13:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <yq1oa5j7sqx.fsf@sermon.lab.mkp.net>
References: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
 <yq1shv1bh75.fsf@sermon.lab.mkp.net> <CAHJVUejnP=sxzrryZDPz4Y_PutF8yAV3LJSdQJGnvD+Cy==08g@mail.gmail.com>
 <yq1oa5j7sqx.fsf@sermon.lab.mkp.net>
From: =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?=
	<florian-ewald.mueller@profitbricks.com>
Date: Wed, 27 Jul 2016 10:13:26 +0200
Message-ID: <CAHJVUejV6d0qk-Yrjqu+OfUoLrus8JctXuzwsNgMyfumUs6_+g@mail.gmail.com>
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Martin,

My (new developed) distributed block device uses a block size of 64K.
So, because of the distribution functionality to different underlying
slave (dm-cache) block devices, it has:
- max_discard_sectors: 128 (64K)
- discard_granularity: 65536 (64K)
The discard sizes of the (underlying) dm-cache devices are:
- max_discard_sectors: 536870912 (256G)
- discard_granularity: 268435456 (256M)

Regards,
Florian

On Wed, Jul 27, 2016 at 3:51 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Florian-Ewald" == Florian-Ewald Müller <florian-ewald.mueller@profitbricks.com> writes:
>
> Florian-Ewald,
>
> Florian-Ewald> My setup is a new developed distributed block
> Florian-Ewald> device on top of dm-cache.  The dm-cache values are
> Florian-Ewald> bigger than those needed by my (new developed) block
> Florian-Ewald> device.
>
> What are the actual values for granularity and max? For your device and
> dm-cache respectively.
>
> --
> Martin K. Petersen      Oracle Linux Engineering



-- 
Florian-Ewald Mueller

Architecture Board


ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin


Tel:       +49 30 577 008 331
Fax:      +49 30 577 008 598
Email:   florian-ewald.mueller@profitbricks.com
URL:     http://www.profitbricks.de

Sitz der Gesellschaft: Berlin.
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B.
Geschäftsführer: Andreas Gauger, Achim Weiss.

Please consider the environment before printing this email.
