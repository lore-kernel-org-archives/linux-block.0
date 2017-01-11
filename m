Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Wed, 11 Jan 2017 08:12:38 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        "Linux-scsi@vger.kernel.org" <Linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
Message-ID: <20170111161238.GA18881@infradead.org>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484150893.2619.1.camel@sandisk.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 11, 2017 at 04:08:31PM +0000, Bart Van Assche wrote:
> A typical Ethernet network adapter delays the generation of an interrupt
> after it has received a packet. A typical block device or HBA does not delay
> the generation of an interrupt that reports an I/O completion.

NVMe allows for configurable interrupt coalescing, as do a few modern
SCSI HBAs.
