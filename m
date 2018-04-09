Return-Path: <ming.lei@redhat.com>
Date: Mon, 9 Apr 2018 10:48:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
Message-ID: <20180409024853.GD26619@ming.t460p>
References: <20180408042112.GB19128@ming.t460p>
 <8b0a369fdb27a87287d07e6343b74b3468dce87f.camel@wdc.com>
 <dd1c2c64-2c8c-42f6-71fa-8952ee0da991@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd1c2c64-2c8c-42f6-71fa-8952ee0da991@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 09, 2018 at 09:33:08AM +0800, Joseph Qi wrote:
> Hi Bart,
> 
> On 18/4/8 22:50, Bart Van Assche wrote:
> > On Sun, 2018-04-08 at 12:21 +0800, Ming Lei wrote:
> >> The following kernel oops is triggered by 'removing scsi device' during
> >> heavy IO.
> > 
> > How did you trigger this oops?
> > 
> 
> I can reproduce this oops by the following steps:
> 1) start a fio job with buffered write;
> 2) remove the scsi device fio write to:
> echo "scsi remove-single-device ${dev}" > /proc/scsi/scsi

Yeah, it can be reproduced easily, and I usually remove scsi
device via 'echo 1 > /sys/block/sda/device/delete'

Thanks,
Ming
