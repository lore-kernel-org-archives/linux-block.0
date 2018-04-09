Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180408042112.GB19128@ming.t460p>
 <8b0a369fdb27a87287d07e6343b74b3468dce87f.camel@wdc.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <dd1c2c64-2c8c-42f6-71fa-8952ee0da991@linux.alibaba.com>
Date: Mon, 9 Apr 2018 09:33:08 +0800
MIME-Version: 1.0
In-Reply-To: <8b0a369fdb27a87287d07e6343b74b3468dce87f.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

On 18/4/8 22:50, Bart Van Assche wrote:
> On Sun, 2018-04-08 at 12:21 +0800, Ming Lei wrote:
>> The following kernel oops is triggered by 'removing scsi device' during
>> heavy IO.
> 
> How did you trigger this oops?
> 

I can reproduce this oops by the following steps:
1) start a fio job with buffered write;
2) remove the scsi device fio write to:
echo "scsi remove-single-device ${dev}" > /proc/scsi/scsi
