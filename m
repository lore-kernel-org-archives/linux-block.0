Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1792 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeFYPhO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jun 2018 11:37:14 -0400
Subject: Re: [PATCH V2 1/2] scsi: read host_busy via scsi_host_busy()
To: Ming Lei <ming.lei@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>
References: <20180624140327.28146-1-ming.lei@redhat.com>
 <20180624140327.28146-2-ming.lei@redhat.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <c96152c4-1875-3ab0-f7e1-9c5eb102924b@wdc.com>
Date: Mon, 25 Jun 2018 08:37:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180624140327.28146-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/24/18 07:04, Ming Lei wrote:
> No functional change.
> 
> Just introduce scsi_host_busy() and replace the direct read of
> scsi_host->host_busy with this new API.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
