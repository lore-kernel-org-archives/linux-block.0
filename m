Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:37193 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeDRFSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 01:18:15 -0400
Received: by mail-wr0-f174.google.com with SMTP id f14-v6so1090894wre.4
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 22:18:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <yq1y3hlpi7y.fsf@oracle.com>
References: <CAOLZvyFA8Dm1L1Dc0dJAVL8pZ9z3SwiLGvyxDNQ-Gkp40fbhJw@mail.gmail.com>
 <yq1y3hlpi7y.fsf@oracle.com>
From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Wed, 18 Apr 2018 07:17:33 +0200
Message-ID: <CAOLZvyEQH+8nvqyf492ikCui0C=5CR2utDi_ZE7nrD4MOBVZKQ@mail.gmail.com>
Subject: Re: Change device block count from userspace?
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 18, 2018 at 12:43 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Manuel,
>
>> I have a SATA SSD which suddenly reports its size as 2.2TB, 0xFFFFFFFF
>> block count:
>
> "Suddenly" as in out of the blue? Or after a drive firmware update? Or a
> kernel ditto?

Out of the blue, yes.  I think it's actually userspace (udev/udisks?)
which tries
to read a few block from the very end of the device, which confuses
the drive firmware.
Sometimes it recovers and then it can be mounted read-only without issues.
It's not a kernel fault, the drive is broken.

Still, is there a userspace option (sysfs attribute perhaps) to limit
disk capacity to
a certain block count?

Thank you!
     Manuel
