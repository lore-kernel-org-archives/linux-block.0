Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:45582 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbdLHA4c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Dec 2017 19:56:32 -0500
To: Ming Lei <ming.lei@redhat.com>
Cc: Holger =?utf-8?Q?Hoffst=C3=A4tte?=
        <holger@applied-asynchrony.com>, Jens Axboe <axboe@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] SCSI: run queue if SCSI device queue isn't ready and queue is idle
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171205075256.10319-1-ming.lei@redhat.com>
        <0352a2f1-d49b-aaa1-f8e9-10486bb5fa9d@applied-asynchrony.com>
        <20171207014002.GB10214@ming.t460p>
Date: Thu, 07 Dec 2017 19:54:52 -0500
In-Reply-To: <20171207014002.GB10214@ming.t460p> (Ming Lei's message of "Thu,
        7 Dec 2017 09:40:04 +0800")
Message-ID: <yq1shcmvy1v.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Ming,

> Jens, Martin, would any of you mind making this patch in V4.15? Since
> it fixes real use cases and this way is exact what we do before
> 0df21c86bdbf("scsi: implement .get_budget and .put_budget for blk-mq").

Applied to 4.15/scsi-fixes, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
