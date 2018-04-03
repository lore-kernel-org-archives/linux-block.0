Return-Path: <axboe@kernel.dk>
Subject: Re: bcache: bad block header
To: Nikolaus Rath <nikolaus@rath.org>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org
References: <1522782091.951690.1325310168.33572B11@webmail.messagingengine.com>
Cc: Michael Lyle <mlyle@lyle.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e9abd200-1718-7975-b3e5-d05473e7d2d4@kernel.dk>
Date: Tue, 3 Apr 2018 16:38:29 -0600
MIME-Version: 1.0
In-Reply-To: <1522782091.951690.1325310168.33572B11@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

CC'ing Mike

On 4/3/18 1:01 PM, Nikolaus Rath wrote:
> [ Re-send to both linux-block and linux-bcache ]
> 
> Hi,
> 
> A few days ago, my system refused to boot because it couldn't find the root filesystem anymore. The root filesystem is ext4 on LVM on dm-crypt on bcache, using kernel 4.9.92 (from Debian stretch). Booting from a recovery medium with Kernel 4.16, I got:
> 
> [   84.551715] bcache: register_bcache() error /dev/sda4: device already registered
> [   84.553188] bcache: register_bcache() error /dev/sdc2: device already registered
> [   84.616438] bcache: error on 1330b5f6-0c13-43ec-b925-2ee2734b135f:
> [   84.616440] bad btree header at bucket 85065, block 0, 0 keys
> [   84.616442] , disabling caching
> [   84.616445] bcache: register_cache() registered cache device sdb2
> [   84.616597] bcache: cache_set_free() Cache set 1330b5f6-0c13-43ec-b925-2ee2734b135f unregistered
> [   85.375933]  sdb: sdb1 sdb2 sdb4 < sdb5 >
> [   85.416610] bcache: error on 1330b5f6-0c13-43ec-b925-2ee2734b135f:
> [   85.416612] bad btree header at bucket 85065, block 0, 0 keys
> [   85.416614] , disabling caching
> [   85.416618] bcache: register_cache() registered cache device sdb2
> [   85.416624] bcache: register_bcache() error /dev/sdc2: device already registered
> [   85.416626] bcache: register_bcache() error /dev/sda4: device already registered
> [   85.416796] bcache: cache_set_free() Cache set 1330b5f6-0c13-43ec-b925-2ee2734b135f unregistered
> [   85.488246] bcache: error on 1330b5f6-0c13-43ec-b925-2ee2734b135f:
> [   85.488249] bad btree header at bucket 85065, block 0, 0 keys
> [   85.488251] , disabling caching
> [   85.488254] bcache: register_cache() registered cache device sdb2
> [   85.488429] bcache: cache_set_free() Cache set 1330b5f6-0c13-43ec-b925-2ee2734b135f unregistered
> [   85.560003] bcache: error on 1330b5f6-0c13-43ec-b925-2ee2734b135f:
> [   85.560006] bad btree header at bucket 85065, block 0, 0 keys
> [   85.560008] , disabling caching
> [   85.560013] bcache: register_cache() registered cache device sdb2
> [   85.560017] bcache: register_bcache() error /dev/sda4: device already registered
> [   85.560217] bcache: cache_set_free() Cache set 1330b5f6-0c13-43ec-b925-2ee2734b135f unregistered
> [   85.571950] bcache: register_bcache() error /dev/sdc2: device already registered
> [   85.580628] bcache: register_bcache() error /dev/sdc2: device already registered
> [   85.761969] bcache: register_bcache() error /dev/sda4: device already registered
> [   85.792749] bcache: register_bcache() error /dev/sda4: device already registered
> [   85.952931] bcache: register_bcache() error /dev/sda4: device already registered
> [   85.955640] bcache: register_bcache() error /dev/sda4: device already registered
> [...]
> 
> These are the first messages that mention bcache. Note that the first message is that the device is already registered - is that normal?
> 
> smartctl does not report any errors on backing or caching disks, and the system was shutdown cleanly.
> 
> The only possibly related thing that comes to mind is that a few days ago I hibernated and resumed the system (this is something I normally don't do). Resume worked fine as far as I could tell though, and there have been no unclean shutdowns.
> 
> Is there a way to narrow down what may have caused this corruption?
> 
> And, is there a way to gracefully recover from this situation without wiping everything? Since the message mentions only problems with one block, can I maybe tell bcache to just ignore/drop this specific block?
> 
> Thanks!
> -Nikolaus
> --
> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
> 
>              »Time flies like an arrow, fruit flies like a Banana.«
> 


-- 
Jens Axboe
