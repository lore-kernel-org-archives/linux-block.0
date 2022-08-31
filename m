Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5118C0502A
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 06:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiHaGbk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiHaGb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 02:31:26 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C16BD1E3;
        Tue, 30 Aug 2022 23:31:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VNq.3oq_1661927475;
Received: from 30.97.56.167(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNq.3oq_1661927475)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 14:31:15 +0800
Message-ID: <e9df4ed8-a0ea-661f-9947-b18fa1d2145f@linux.alibaba.com>
Date:   Wed, 31 Aug 2022 14:31:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] Docs: ublk: add ublk document
Content-Language: en-US
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220828045003.537131-1-ming.lei@redhat.com>
 <Yw4rcz23R3ofn6H6@fedora>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Yw4rcz23R3ofn6H6@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/8/30 23:23, Stefan Hajnoczi wrote:
> On Sun, Aug 28, 2022 at 12:50:03PM +0800, Ming Lei wrote:
>> ublk document is missed when merging ublk driver, so add it now.
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Richard W.M. Jones <rjones@redhat.com>
>> Cc: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>  Documentation/block/ublk.rst | 203 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 203 insertions(+)
>>  create mode 100644 Documentation/block/ublk.rst
>>
>> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
>> new file mode 100644
>> index 000000000000..9e8f7ba518a3
>> --- /dev/null
>> +++ b/Documentation/block/ublk.rst
>> @@ -0,0 +1,203 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +==========================================
>> +Userspace block device driver(ublk driver)
> 
> Usually there is a space before '('. There are more instances throughout
> the document.
> 
>> +==========================================
>> +
>> +Overview
>> +========
>> +
>> +ublk is one generic framework for implementing block device logic from
>> +userspace. It is very helpful to move virtual block drivers into userspace,
>> +such as loop, nbd and similar block drivers. It can help to implement new
>> +virtual block device, such as ublk-qcow2, and there was several attempts
>> +of implementing qcow2 driver in kernel.
> 
> This paragraph doesn't give specific reasons why userspace block devices
> are "very helpful".
> 
> Userspace block devices are attractive because:
> - They can be written many programming languages.
> - They can use libraries that are not available in the kernel.
> - They can be debugged with tools familiar to application developers.
> - Crashes do not kernel panic the machine.
> - Bugs are likely to have a lower security impact than bugs in kernel
>   code.
> - They can be installed and updated independently of the kernel.
> 
> I think including this list makes it clear why userspace block devices
> are appropriate in certain cases.

+1, this list is really attractive to ublk developers/users.

> 
>> +
>> +ublk block device(``/dev/ublkb*``) is added by ublk driver. Any IO request
>> +submitted to ublk device will be forwarded to ublk's userspace part(
>> +ublksrv [1]), and after the IO is handled by ublksrv, the result is
>> +committed back to ublk driver, then ublk IO request can be completed. With
>> +this way, any specific IO handling logic is totally done inside ublksrv,
>> +and ublk driver doe _not_ handle any device specific IO logic, such as
> 
> s/doe/does/
> 
>> +loop's IO handling, NBD's IO communication, or qcow2's IO mapping, ...
>> +
>> +/dev/ublkbN is driven by blk-mq request based driver, each request is
>> +assigned by one queue wide unique tag. ublksrv assigns unique tag to each
>> +IO too, which is 1:1 mapped with IO of /dev/ublkb*.
> 
> Is "/dev/ublkbN" the same as "/dev/ublkb*"? Please use one term consistently.
> 
>> +
>> +Both the IO request forward and IO handling result committing are done via
>> +io_uring passthrough command, that is why ublk is also one io_uring based
> 
> s/also one/a/
> 
>> +block driver. It has been observed that io_uring passthrough command can get
>> +better IOPS than block IO. So ublk is one high performance implementation
>> +of userspace block device.
> 
> I think this sentence means "Therefore ublk uses io_uring passthrough
> commands to implement userspace block devices in a performant way".
> 
>> Not only IO request communication is done by
>> +io_uring, but also the preferred IO handling in ublksrv is io_uring based
>> +approach too.
>> +
>> +ublk provides control interface to set/get ublk block device parameters, and
>> +the interface is extendable and kabi compatible, so basically any ublk request
>> +queue's parameter or ublk generic feature parameters can be set/get via this
>> +extendable interface. So ublk is generic userspace block device framework, such
>> +as, it is easy to setup one ublk device with specified block parameters from
> 
> "such as" -> "and as such"
> 
>> +userspace.
>> +
>> +How to use ublk
>> +===============
>> +
>> +After building ublksrv[1], ublk block device(``/dev/ublkb*``) can be added
> 
> It might be worth separating two use cases:
> 
> - Quickstart and people who just want to use existing ublksrv
>   functionality.
> 
> - Developers who are writing their own ublk server (e.g. rjones' nbdkit).
> 
> ublksrv isn't needed, it's possible to code directly against the ublk
> driver UAPI. I think it's worth pointing this out so it's clear to
> people when and why you would use ublksrv and also when to code against
> the ublk driver UAPI.
> 
> The documentation currently leaves it to the reader to figure out that
> ublksrv is just one possible userspace server implementation.

+1. Although now ublksrv seems to be the only one userspace implementation, I
expect that developers can directly use ublk_drv's UAPI. Maybe I will do
so while embedding ublk into our own backend.

> 
>> +and deleted by the utility, then existed block IO applications can talk with
>> +it.
>> +
>> +See usage details in README[2] of ublksrv, for example of ublk-loop:
>> +
>> +- add ublk device:
>> +  ublk add -t loop -f ublk-loop.img
>> +
>> +- use it:
>> +  mkfs.xfs /dev/ublkb0
>> +  mount /dev/ublkb0 /mnt
>> +  ....                     # all IOs are handled by io_uring!!!
>> +  umount /mnt
>> +
>> +- get ublk dev info:
>> +  ublk list
>> +
>> +- delete ublk device
>> +  ublk del -a
>> +  ublk del -n $ublk_dev_id
>> +
>> +Design
>> +======
>> +
>> +Control plane
>> +-------------
>> +
>> +ublk driver provides global misc device node(``/dev/ublk-control``) for
>> +managing and controlling ublk devices with help of several control commands:
>> +
>> +- UBLK_CMD_ADD_DEV
>> +  Add one ublk char device(``/dev/ublkc*``) which is talked with ublksrv wrt.
> 
> It may be clearer to say "the server" or "userspace" instead of
> "ublksrv", since that is the name of a specific server implementation
> and people may develop other servers.
> 
>> +  IO command communication. Basic device info is sent together with this
>> +  command, see UAPI structure of ublksrv_ctrl_dev_info, such as nr_hw_queues,
>> +  queue_depth, and max IO request buffer size, which info is negotiated with
>> +  ublk driver and sent back to ublksrv. After this command is completed, the
>> +  basic device info can't be changed any more.
>> +
>> +- UBLK_CMD_SET_PARAMS / UBLK_CMD_GET_PARAMS
>> +  Set or get ublk device's parameters, which can be generic feature related,
>> +  or request queue limit related, but can't be IO logic specific, cause ublk
>> +  driver does not handle any IO logic. This command has to be sent before
>> +  sending UBLK_CMD_START_DEV.
>> +
>> +- UBLK_CMD_START_DEV
>> +  After ublksrv prepares userspace resource such as, creating per-queue
>> +  pthread & io_ruing for handling ublk IO, this command is set for ublk
> 
> s/io_ruing/io_uring/
> 
>> +  driver to allocate & expose /dev/ublkb*. Parameters set via
>> +  UBLK_CMD_SET_PARAMS are applied for creating /dev/ublkb*.
>> +
>> +- UBLK_CMD_STOP_DEV
>> +  Quiesce IO on /dev/ublkb* and delete the disk. After this command returns,
>> +  ublksrv can release resource, such as destroy per-queue pthread & io_uring
>> +  for handling io command.
>> +
>> +- UBLK_CMD_DEL_DEV
>> +  Delete /dev/ublkc*. After this command returns, the allocated ublk device
>> +  number can be reused.
>> +
>> +- UBLK_CMD_GET_QUEUE_AFFINITY
>> +  After /dev/ublkc is added, ublk driver creates block layer tagset, so each
>> +  queue's affinity info is available, ublksrv sends UBLK_CMD_GET_QUEUE_AFFINITY
>> +  to retrieve queue affinity info, so ublksrv can setup the per-queue context
>> +  efficiently, such as bind affine CPUs with IO pthread, and try to allocate
>> +  buffers in IO thread context.
>> +
>> +- UBLK_CMD_GET_DEV_INFO
>> +  For retrieve device info of ublksrv_ctrl_dev_info. And it is ublksrv's
>> +  responsibility to save IO target specific info in userspace.
>> +
>> +Data plane
>> +----------
>> +
>> +ublksrv needs to create per-queue IO pthread & io_uring for handling IO
>> +command (io_uring passthrough command), and the per-queue IO pthread
>> +focuses on IO handling and shouldn't handle any control & management
>> +task.
>> +
>> +ublksrv's IO is assigned by one unique tag, which is 1:1 mapping with IO
>> +request of /dev/ublkb*.
>> +
>> +UAPI structure of ublksrv_io_desc is defined for describing each IO from
>> +ublk driver. One fixed mmaped area(array) on /dev/ublkc* is provided for
>> +exporting IO info to ublksrv, such as IO offset, length, OP/flags and
>> +buffer address. Each ublksrv_io_desc instance can be indexed via queue id
>> +and IO tag directly.
>> +
>> +Following IO commands are communicated via io_uring passthrough command,
>> +and each command is only for forwarding ublk IO and committing IO result
>> +with specified IO tag in the command data:
>> +
>> +- UBLK_IO_FETCH_REQ
>> +  Sent from ublksrv IO pthread for fetching future coming IO request
>> +  issued to /dev/ublkb*. This command is just sent once from ublksrv IO
>> +  pthread for ublk driver to setup IO forward environment.
>> +
>> +- UBLK_IO_COMMIT_AND_FETCH_REQ
>> +  After one IO request is issued to /dev/ublkb*, ublk driver stores this
>> +  IO's ublksrv_io_desc to the specified mapped area, then the previous
>> +  received IO command of this IO tag, either UBLK_IO_FETCH_REQ or
>> +  UBLK_IO_COMMIT_AND_FETCH_REQ, is completed, so ulksrv gets the IO
>> +  notification via io_uring.
>> +
>> +  After ublksrv handles this IO, this IO's result is committed back to ublk
>> +  driver by sending UBLK_IO_COMMIT_AND_FETCH_REQ back. Once ublkdrv received
>> +  this command, it parses the IO result and complete the IO request to
>> +  /dev/ublkb*. Meantime setup environment for fetching future IO request
>> +  with this IO tag. So UBLK_IO_COMMIT_AND_FETCH_REQ is reused for both
>> +  fetching request and committing back IO result.
>> +
>> +- UBLK_IO_NEED_GET_DATA
>> +  ublksrv pre-allocates IO buffer for each IO at default, any new project
>> +  should use this IO buffer to communicate with ublk driver. But existed
>> +  project may not work or be changed to in this way, so add this command
>> +  to provide chance for userspace to use its existed buffer for handling
>> +  IO.
> 
> I find it hard to understand this paragraph. It seems the
> UBLK_IO_NEED_GET_DATA command allows userspace to set up something
> related to IO buffers. What exactly does this command do?

Let me explain UBLK_IO_NEED_GET_DATA since it is designed by myself.

Without UBLK_IO_NEED_GET_DATA, ublk_drv will copy data from biovecs
into a pre-allocated buffer(addr is passed with the last COMMIT_AMD_FETCH ioucmd)
while processing a WRITE request. Please consider two cases:

(1)  if the backend(such as a dist-storage system using RPC) provides the data
     buffer, it has to provide the buffer IN ADVANCE(before sending the last
     COMMIT_AMD_FETCH) without knowing any knowledge of this incoming request.
     This makes existing backend very hard to adapt to ublk because they may
     want to know the data length or other attributes of the new request.

(2) If the backend does not provide the data buffer IN ADVANCE, ublksrv must
    pre-allocates data buffer. So a additional data copy from ublksrv to
    the backend(such as a RPC mempool) is unavoidable.

With UBLK_IO_NEED_GET_DATA, the WRITE request will be firstly issued to ublksrv
without data copy. Then, backend gets the request and it can allocate data
buffer and embed its addr inside a new ioucmd. After the kernel driver gets the
ioucmd, the data copy happens(from biovecs to backend's buffer). Finally,
the backend gets the request again with data to be written and it can truly
handle the request.

> 
>> +
>> +- data copy between ublkserv IO buffer and ublk block IO request
> 
> s/ublkserv/ublksrv/
> 
>> +  ublk driver needs to copy ublk block IO request pages into ublksrv buffer
>> +  (pages) first for WRITE before notifying ublksrv of the coming IO, so
>> +  ublksrv can hanldle WRITE request.
> 
> s/hanldle/handle/
> 
>> +
>> +  After ublksrv handles READ request and sends UBLK_IO_COMMIT_AND_FETCH_REQ
>> +  to ublksrv, ublkdrv needs to copy read ublksrv buffer(pages) to the ublk
>> +  IO request pages.

ublksrv sends UBLK_IO_COMMIT_AND_FETCH_REQ to "ublkdrv", not "ublksrv", I think.

BTW, "ublkdrv" is very similar to "ublksrv"... Maybe we should use "ublk_drv"?

> 
> In the READ case userspace doesn't know exactly when the ublk driver is
> done copying in the buffer. I guess this isn't a problem because the
> userspace buffer will be reused when the next request is fetched?

In the READ case, userspace does not know exactly when the data copy happens.

The data buffer(add is passed with current UBLK_IO_COMMIT_AND_FETCH_REQ) is
reused for a future request(the same tag).

More specifically, whthout UBLK_IO_NEED_GET_DATA, if the future request is a
write request, this buffer is filled with biovecs' data before ublk_drv passes
the request to userspace. BTW, that's why UBLK_IO_NEED_GET_DATA is introduced.
Otherwise the read buffer is actually reused for a future write buffer...

Regards,
Zhang.

