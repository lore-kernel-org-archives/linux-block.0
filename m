Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:53082 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753710AbeDTBhv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Apr 2018 21:37:51 -0400
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: Change device block count from userspace?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAOLZvyFA8Dm1L1Dc0dJAVL8pZ9z3SwiLGvyxDNQ-Gkp40fbhJw@mail.gmail.com>
        <yq1y3hlpi7y.fsf@oracle.com>
        <CAOLZvyEQH+8nvqyf492ikCui0C=5CR2utDi_ZE7nrD4MOBVZKQ@mail.gmail.com>
Date: Thu, 19 Apr 2018 21:37:47 -0400
In-Reply-To: <CAOLZvyEQH+8nvqyf492ikCui0C=5CR2utDi_ZE7nrD4MOBVZKQ@mail.gmail.com>
        (Manuel Lauss's message of "Wed, 18 Apr 2018 07:17:33 +0200")
Message-ID: <yq1vacmiro4.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Manuel,

> It's not a kernel fault, the drive is broken.

Interesting, OK. Just wanted to make sure we didn't have a regression. I
tweaked the capacity reading code recently.

> Still, is there a userspace option (sysfs attribute perhaps) to limit
> disk capacity to a certain block count?

I'm afraid not.

-- 
Martin K. Petersen	Oracle Linux Engineering
