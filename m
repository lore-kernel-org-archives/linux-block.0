Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:32812 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbcHBLdK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2016 07:33:10 -0400
Received: by mail-oi0-f52.google.com with SMTP id j185so231569934oih.0
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2016 04:31:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <yq1mvkvzzvu.fsf@sermon.lab.mkp.net>
References: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
 <yq1shv1bh75.fsf@sermon.lab.mkp.net> <CAHJVUejnP=sxzrryZDPz4Y_PutF8yAV3LJSdQJGnvD+Cy==08g@mail.gmail.com>
 <yq1oa5j7sqx.fsf@sermon.lab.mkp.net> <CAHJVUejV6d0qk-Yrjqu+OfUoLrus8JctXuzwsNgMyfumUs6_+g@mail.gmail.com>
 <yq1h9b92pfc.fsf@sermon.lab.mkp.net> <CAHJVUeik5+3mYSFqaONu50XF9sV5+tMpTXqM-Kcijzwj+f6vDg@mail.gmail.com>
 <yq1mvkvzzvu.fsf@sermon.lab.mkp.net>
From: =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?=
	<florian-ewald.mueller@profitbricks.com>
Date: Tue, 2 Aug 2016 13:31:05 +0200
Message-ID: <CAHJVUegURaUeiDq-wx8bYYEO7jYw6z5-xJ7dvupoA8EtxaD8LQ@mail.gmail.com>
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Martin,

I totally agree with better having a common block layer infrastructure
to handle such discard misfit cases.
But, for now, I do not have a good idea of how to aggregate in the
block layer discard chunks (< discard_granularity) and issue later
only a big one (== discard_granularity) to underlying block device in
a generic and persistent fashion.

For me, the current handling of discards by the block layer
[blk_stack_limits() + blk_bio_discard_split()] seems to be
inconsistent with the handling of normal (rd/wr) IO.
It makes the life of block drivers developers harder as they can not
rely on blk_queue_split() doing its job on discard bio's.

Regards,
Florian

On Tue, Aug 2, 2016 at 4:08 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> Florian-Ewald Müller <florian-ewald.mueller@profitbricks.com> writes:
>
> Florian-Ewald,
>
>> Now my experiments show that, at least, dm-cache doesn't complain nor
>> rejects those smaller discards than its discard_granularity, but
>> possibly turning them into noop (?).
>
> Correct. Anything smaller than (an aligned) multiple of the discard
> granularity will effectively be ignored.
>
> In practice this means that your device should allocate things in
> aligned units of the underlying device's discard granularity.
>
>> May be that the needed functionality of accumulating small discards to
>> a big one covering its own granularity (similar to SSDs block erasure)
>> should be done at that driver level.
>
> Do you allocate blocks in a predictable pattern between your nodes?
>
> For MD RAID0, for instance, we issue many small discard requests. But
> for I/Os that are bigger than the stripe width we'll wrap around and do
> merging so that for instance blocks 0, n, 2*n, 3*n, etc. become part of
> the same discard request sent to the device.
>
> If you want discards smaller than the underlying granularity to have an
> effect then I'm afraid the burden is on you to maintain a bitmap of each
> granularity sized region. And then issue a deferred discard when all
> blocks inside that region have been discarded by the application or
> filesystem above.
>
> If you want to pursue partial block tracking it would be good to come up
> with a common block layer infrastructure for it. dm-thin could benefit
> from it as well...
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
