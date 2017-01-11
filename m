Return-Path: <axboe@kernel.dk>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
To: "hch@infradead.org" <hch@infradead.org>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com> <20170111161238.GA18881@infradead.org>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "Linux-scsi@vger.kernel.org" <Linux-scsi@vger.kernel.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5b2229ee-a225-b59f-ccdf-710767941920@kernel.dk>
Date: Wed, 11 Jan 2017 09:15:26 -0700
MIME-Version: 1.0
In-Reply-To: <20170111161238.GA18881@infradead.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/11/2017 09:12 AM, hch@infradead.org wrote:
> On Wed, Jan 11, 2017 at 04:08:31PM +0000, Bart Van Assche wrote:
>> A typical Ethernet network adapter delays the generation of an interrupt
>> after it has received a packet. A typical block device or HBA does not delay
>> the generation of an interrupt that reports an I/O completion.
> 
> NVMe allows for configurable interrupt coalescing, as do a few modern
> SCSI HBAs.

Unfortunately it's way too coarse on NVMe, with the timer being in 100
usec increments... I've had mixed success with the depth trigger.

-- 
Jens Axboe
