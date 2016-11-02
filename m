Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:15592
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753083AbcKBTfs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Nov 2016 15:35:48 -0400
Subject: Re: [PATCH v5 0/14] Fix race conditions related to stopping block
 layer queues
To: Jens Axboe <axboe@fb.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <cfd115a1-78e1-7ed5-3c19-42334a5dbe72@fb.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <cb120a20-2a40-053a-5621-2209777b5ef4@sandisk.com>
Date: Wed, 2 Nov 2016 13:35:40 -0600
MIME-Version: 1.0
In-Reply-To: <cfd115a1-78e1-7ed5-3c19-42334a5dbe72@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/02/2016 01:08 PM, Jens Axboe wrote:
> Bart, I have applied the series, except patches 11+12. I don't mind
> taking them through the block tree, but they can go through the SCSI
> tree as well. Let me know what folks think.

Hello Jens,

Thanks for having applied this patch series. I will resend the SCSI 
patches to the SCSI maintainers. Since I am not aware of any bug report 
for which these patches are the proper fix I don't think there is any 
urgency to apply the SCSI patches.

Bart.

