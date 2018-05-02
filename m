Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:55059 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeEBKjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 May 2018 06:39:05 -0400
Received: by mail-it0-f50.google.com with SMTP id z6-v6so12960804iti.4
        for <linux-block@vger.kernel.org>; Wed, 02 May 2018 03:39:04 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <3f49cb1f5a04fd61a73fe9f033868278@mail.gmail.com>
 <20180502094713.GA31961@ming.t460p> <0efdcd2c4aa241f5d9d6acad915ee4fe@mail.gmail.com>
 <20180502103403.GB31961@ming.t460p>
In-Reply-To: <20180502103403.GB31961@ming.t460p>
MIME-Version: 1.0
Date: Wed, 2 May 2018 16:09:02 +0530
Message-ID: <5bb14f3f91dcc1d8ff04de4f01904932@mail.gmail.com>
Subject: RE: Performance drop due to "blk-mq-sched: improve sequential I/O performance"
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> > I have created internal code changes based on below RFC and using irq
> > poll CPU lockup issue is resolved.
> > https://www.spinics.net/lists/linux-scsi/msg116668.html
>
> Could we use the 1:1 mapping and not apply out-of-tree irq poll in the
> following test? So that we can keep at same page easily.

Above RFC changes are not used in my testing.  I used same inbox driver
from 4.17-rc.

>
> Thanks,
> Ming
