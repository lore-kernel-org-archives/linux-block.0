Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:34219 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbdKGDx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2017 22:53:56 -0500
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch\@infradead.org" <hch@infradead.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe\@fb.com" <axboe@fb.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "osandov\@fb.com" <osandov@fb.com>,
        "john.garry\@huawei.com" <john.garry@huawei.com>,
        "loberman\@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH] SCSI: don't get target/host busy_count in scsi_mq_get_budget()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171104015534.32684-1-ming.lei@redhat.com>
        <1509991480.2409.54.camel@wdc.com> <20171107021929.GC15090@ming.t460p>
Date: Mon, 06 Nov 2017 22:53:12 -0500
In-Reply-To: <20171107021929.GC15090@ming.t460p> (Ming Lei's message of "Tue,
        7 Nov 2017 10:19:30 +0800")
Message-ID: <yq1fu9q3ftj.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Ming,

>> Since this is a SCSI patch the SCSI maintainer, Martin Petersen,
>> should have been Cc-ed for this patch. Additionally, I think that
>> this patch should not have been queued by Jens before Martin had
>> approved this patch.
>
> This patch has been CCed to SCSI list.

I don't need a personal CC, linux-scsi is sufficient. However, as a
general rule, changes to any file in drivers/scsi needs go through the
SCSI tree.

We sometimes make exceptions to facilitate the merge process. In those
cases an Acked-by: will be provided to indicate that it is OK that the
patch goes through a different tree.

-- 
Martin K. Petersen	Oracle Linux Engineering
