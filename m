Subject: Re: [PATCH 0/5] blk-mq: various blk-mq/blk-mq-sched fixes
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1f162b4f-7aa1-d19b-53d8-2b621da36d27@suse.de>
Cc: bart.vanassche@sandisk.com, hch@lst.de, osandov@fb.com,
 paolo.valente@linaro.org, hare@suse.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <25080b6c-47db-8db4-c0d4-a6f711fbd4bb@fb.com>
Date: Fri, 27 Jan 2017 07:40:26 -0700
MIME-Version: 1.0
In-Reply-To: <1f162b4f-7aa1-d19b-53d8-2b621da36d27@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/27/2017 05:10 AM, Hannes Reinecke wrote:
> On 01/26/2017 08:48 PM, Jens Axboe wrote:
>> I've been diving into the problems that Hannes reported, both the
>> stalls related to shared tag maps and multiple hardware queues,
>> but also the cases where we get suboptimal merging.
>>
>> This series attempts to fix that.
>>
>> Hannes, this should be identical to what I sent you as a bundled up
>> patch earlier today. Would be great if you could run this through
>> your testing.
>>
>> The patches are against for-4.11/block
>>
> Yep, full success:
> 
> 4k  seq read : io=59850MB, bw=997.36MB/s, iops=255241, runt= 60028msec
> 4k rand read : io=399676KB, bw=6127.9KB/s, iops=1531, runt= 65231msec
> 4k seq write: io=12194MB, bw=207576KB/s, iops=51893, runt= 60155msec
> 4k rand write: io=111100KB, bw=1315.7KB/s, iops=328, runt= 84445msec

Perfect, do you want to add a tested-by or something?

And how does performance compare to !mq with deadline or similar?

> Although I'm getting a lockdep splat:
> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 3211 at kernel/locking/lockdep.c:3514 lock_release+
> DEBUG_LOCKS_WARN_ON(depth <= 0)
> Modules linked in: nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs l
> uhci_hcd ahci ehci_hcd libahci ttm crc32c_intel serio_raw hpsa usbcore
> CPU: 4 PID: 3211 Comm: fio Not tainted 4.10.0-rc3+ #598
> Hardware name: HP ProLiant DL380p Gen8, BIOS P70 09/18/2013

That's a known issue in the base that I have, you're supposed to run
it with master pulled in. Annoying, sorry, but it's not my patches.

-- 
Jens Axboe
