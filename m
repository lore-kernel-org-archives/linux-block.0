Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45587 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFBWYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2017 18:24:46 -0400
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch\@lst.de" <hch@lst.de>, "axboe\@fb.com" <axboe@fb.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Block device integrity support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1496440434.1214.23.camel@sandisk.com>
Date: Fri, 02 Jun 2017 18:24:34 -0400
In-Reply-To: <1496440434.1214.23.camel@sandisk.com> (Bart Van Assche's message
        of "Fri, 2 Jun 2017 21:53:55 +0000")
Message-ID: <yq1lgpahvtp.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Bart,

>     modprobe scsi_debug delay=0 dif=3 dix=-1 dev_size_mb=16

                                  ^^^^^^^^^^^^

Those options don't make much sense.


> then the output shown below appears in the kernel log. Does anyone know how
> to fix this? Sorry but I'm not really familiar with the integrity
> code.

Dmitry posted a fix for this a few weeks ago.

-- 
Martin K. Petersen	Oracle Linux Engineering
