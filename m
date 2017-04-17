Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 02/25] block: remove the blk_execute_rq return value
To: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-3-hch@lst.de> <1492113800.24345.9.camel@sandisk.com>
 <20170414082231.GC24901@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "roger.pau@citrix.com" <roger.pau@citrix.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "jbacik@fb.com" <jbacik@fb.com>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3257b684-8bec-f48a-e97e-5f2e8f3ca6e4@kernel.dk>
Date: Mon, 17 Apr 2017 10:01:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170414082231.GC24901@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/14/2017 02:22 AM, hch@lst.de wrote:
> On Thu, Apr 13, 2017 at 08:03:22PM +0000, Bart Van Assche wrote:
>> That blk_execute_rq() call can only be reached if a few lines above 0 was
>> assigned to the "error" variable. Since nfsd4_scsi_identify_device() returns
>> the value of the "error" variable I think -EIO should be assigned to that
>> variable before the "goto out_put_request" statement is reached.
> 
> You're right!  I'll fix it up.

Are you respinning this series for 4.12?

-- 
Jens Axboe
