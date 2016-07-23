Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36065 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcGWLUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sat, 23 Jul 2016 07:20:17 -0400
Received: by mail-oi0-f44.google.com with SMTP id w18so195852538oiw.3
        for <linux-block@vger.kernel.org>; Sat, 23 Jul 2016 04:20:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <yq1shv1bh75.fsf@sermon.lab.mkp.net>
References: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
 <yq1shv1bh75.fsf@sermon.lab.mkp.net>
From: =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?=
	<florian-ewald.mueller@profitbricks.com>
Date: Sat, 23 Jul 2016 13:19:57 +0200
Message-ID: <CAHJVUejnP=sxzrryZDPz4Y_PutF8yAV3LJSdQJGnvD+Cy==08g@mail.gmail.com>
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Martin,

My setup is a new developed distributed block device on top of dm-cache.
The dm-cache values are bigger than those needed by my (new developed)
block device.

Regards,
Florian

On Fri, Jul 22, 2016 at 9:34 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Florian-Ewald" == Florian-Ewald Müller <florian-ewald.mueller@profitbricks.com> writes:
>
> Florian-Ewald,
>
> Florian-Ewald> blk_stack_limits() can set discard_granularity bigger
> Florian-Ewald> than max_discard_sectors (in bytes).
>
> discard_granularity must be smaller than max_discard_sectors. The
> question is which storage device reported these values?
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
