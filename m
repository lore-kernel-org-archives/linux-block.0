Return-Path: <m@bjorling.me>
Return-Path: <m@bjorling.me>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Keith Busch <keith.busch@intel.com>, Simon Lund <slund@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Subject: gendisk and lightnvm
Cc: linux-block@vger.kernel.org
Message-ID: <5742B023.2040503@bjorling.me>
Date: Mon, 23 May 2016 09:24:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Jens, Christoph, and Keith,

I have been pondering for a couple of weeks on how to integrate lightnvm 
into the sysfs stack. Lightnvm does not currently expose a "physical" 
device. During device registration, the block device name is simply 
stored, which the user may then use as an id later, and expose through a 
target implementation.

Until then, the device is left "dangling" in the kernel, without any 
good way to reference it other than asking the lightnvm manager. This 
also includes device driver specific configuration, such as power and mq 
sysfs entries.

It would be great to have a common way to expose the lightnvm subsystem 
through the block storage stack.

With block devices, the device driver centric information includes:

/sys/block/*/
   inflight
   removable
   serial
   /mq
   /power

Simon has currently built an RFC patch that wires lightnvm devices up in 
/sys/devices/virtual/misc/lightnvm/*, without any access to the above 
entries.

What would be the best way to approach this?

1. Simply set genhd device capacity to 0, and let entries and block 
device be exposed through the common stack.

2. Add a GENHD_FL_BLKLESS_DEV flag, and use it in genhd.c and block 
layer to filter out block device specific entries.

3. Write a shim layer that exposes a semi genhd, with only the device 
driver sysfs entries exposed.

4. Any other?

Thank you,
Matias
