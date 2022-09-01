Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8305CECAAD1
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 01:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiIABeW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 21:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiIABeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 21:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F17E155A5D
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 18:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661996058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VuMDLHtMdhizH6iq4bHugnSO5cpHcYLImDJPvC8JjU=;
        b=J/BdiMjHQ58eS0n1MAeBk42X4PFlU+kdqSKqP56R/xY1fx3BpeQ9RbMdYJUQb4TMFdNchq
        Z0Cu6kPFy12SkQSpISrqD5I5aFM8KfC1lPbAnag5y7Ixqs5UHLzbWYJIvxYIjMUWc6f9qI
        fbk2XkML+x3ahFl+VWQmtbZ0ZRAhCv8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-I0FmLEsiMmyBdVGf5rk0dQ-1; Wed, 31 Aug 2022 21:34:14 -0400
X-MC-Unique: I0FmLEsiMmyBdVGf5rk0dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7C2C3803901;
        Thu,  1 Sep 2022 01:34:13 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44B1C2026D4C;
        Thu,  1 Sep 2022 01:34:06 +0000 (UTC)
Date:   Thu, 1 Sep 2022 09:34:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH] Docs: ublk: add ublk document
Message-ID: <YxAMDBCOshzQqSfq@T590>
References: <20220828045003.537131-1-ming.lei@redhat.com>
 <Yw4rcz23R3ofn6H6@fedora>
 <e9df4ed8-a0ea-661f-9947-b18fa1d2145f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9df4ed8-a0ea-661f-9947-b18fa1d2145f@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 31, 2022 at 02:31:12PM +0800, Ziyang Zhang wrote:
> On 2022/8/30 23:23, Stefan Hajnoczi wrote:
> > On Sun, Aug 28, 2022 at 12:50:03PM +0800, Ming Lei wrote:
> >> ublk document is missed when merging ublk driver, so add it now.
> >>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Richard W.M. Jones <rjones@redhat.com>
> >> Cc: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >> Cc: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >> ---
> >>  Documentation/block/ublk.rst | 203 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 203 insertions(+)
> >>  create mode 100644 Documentation/block/ublk.rst
> >>
> >> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> >> new file mode 100644
> >> index 000000000000..9e8f7ba518a3
> >> --- /dev/null
> >> +++ b/Documentation/block/ublk.rst
> >> @@ -0,0 +1,203 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +==========================================
> >> +Userspace block device driver(ublk driver)
> > 
> > Usually there is a space before '('. There are more instances throughout
> > the document.
> > 
> >> +==========================================
> >> +
> >> +Overview
> >> +========
> >> +
> >> +ublk is one generic framework for implementing block device logic from
> >> +userspace. It is very helpful to move virtual block drivers into userspace,
> >> +such as loop, nbd and similar block drivers. It can help to implement new
> >> +virtual block device, such as ublk-qcow2, and there was several attempts
> >> +of implementing qcow2 driver in kernel.
> > 
> > This paragraph doesn't give specific reasons why userspace block devices
> > are "very helpful".
> > 
> > Userspace block devices are attractive because:
> > - They can be written many programming languages.
> > - They can use libraries that are not available in the kernel.
> > - They can be debugged with tools familiar to application developers.
> > - Crashes do not kernel panic the machine.
> > - Bugs are likely to have a lower security impact than bugs in kernel
> >   code.
> > - They can be installed and updated independently of the kernel.
> > 
> > I think including this list makes it clear why userspace block devices
> > are appropriate in certain cases.
> 
> +1, this list is really attractive to ublk developers/users.
> 
> > 
> >> +
> >> +ublk block device(``/dev/ublkb*``) is added by ublk driver. Any IO request
> >> +submitted to ublk device will be forwarded to ublk's userspace part(
> >> +ublksrv [1]), and after the IO is handled by ublksrv, the result is
> >> +committed back to ublk driver, then ublk IO request can be completed. With
> >> +this way, any specific IO handling logic is totally done inside ublksrv,
> >> +and ublk driver doe _not_ handle any device specific IO logic, such as
> > 
> > s/doe/does/
> > 
> >> +loop's IO handling, NBD's IO communication, or qcow2's IO mapping, ...
> >> +
> >> +/dev/ublkbN is driven by blk-mq request based driver, each request is
> >> +assigned by one queue wide unique tag. ublksrv assigns unique tag to each
> >> +IO too, which is 1:1 mapped with IO of /dev/ublkb*.
> > 
> > Is "/dev/ublkbN" the same as "/dev/ublkb*"? Please use one term consistently.
> > 
> >> +
> >> +Both the IO request forward and IO handling result committing are done via
> >> +io_uring passthrough command, that is why ublk is also one io_uring based
> > 
> > s/also one/a/
> > 
> >> +block driver. It has been observed that io_uring passthrough command can get
> >> +better IOPS than block IO. So ublk is one high performance implementation
> >> +of userspace block device.
> > 
> > I think this sentence means "Therefore ublk uses io_uring passthrough
> > commands to implement userspace block devices in a performant way".
> > 
> >> Not only IO request communication is done by
> >> +io_uring, but also the preferred IO handling in ublksrv is io_uring based
> >> +approach too.
> >> +
> >> +ublk provides control interface to set/get ublk block device parameters, and
> >> +the interface is extendable and kabi compatible, so basically any ublk request
> >> +queue's parameter or ublk generic feature parameters can be set/get via this
> >> +extendable interface. So ublk is generic userspace block device framework, such
> >> +as, it is easy to setup one ublk device with specified block parameters from
> > 
> > "such as" -> "and as such"
> > 
> >> +userspace.
> >> +
> >> +How to use ublk
> >> +===============
> >> +
> >> +After building ublksrv[1], ublk block device(``/dev/ublkb*``) can be added
> > 
> > It might be worth separating two use cases:
> > 
> > - Quickstart and people who just want to use existing ublksrv
> >   functionality.
> > 
> > - Developers who are writing their own ublk server (e.g. rjones' nbdkit).
> > 
> > ublksrv isn't needed, it's possible to code directly against the ublk
> > driver UAPI. I think it's worth pointing this out so it's clear to
> > people when and why you would use ublksrv and also when to code against
> > the ublk driver UAPI.
> > 
> > The documentation currently leaves it to the reader to figure out that
> > ublksrv is just one possible userspace server implementation.
> 
> +1. Although now ublksrv seems to be the only one userspace implementation, I
> expect that developers can directly use ublk_drv's UAPI. Maybe I will do
> so while embedding ublk into our own backend.

Yeah, anyone can do that.

But when there is any bug you want to ask for help from community, can
you share your use case? Or is it easy for you to do so? At that time,
you still need to figure out how to trigger it in one open source
implementation, then share the use case. Otherwise, not sure if
community can help you easily.

There will be more functions or features added to ublksrv/ublk driver, it
really needs one open source project to verify/test. You may say the
feature is verified in your private/closed source environment, but
usually not good, cause no one can reproduce it.

> 
> > 
> >> +and deleted by the utility, then existed block IO applications can talk with
> >> +it.
> >> +
> >> +See usage details in README[2] of ublksrv, for example of ublk-loop:
> >> +
> >> +- add ublk device:
> >> +  ublk add -t loop -f ublk-loop.img
> >> +
> >> +- use it:
> >> +  mkfs.xfs /dev/ublkb0
> >> +  mount /dev/ublkb0 /mnt
> >> +  ....                     # all IOs are handled by io_uring!!!
> >> +  umount /mnt
> >> +
> >> +- get ublk dev info:
> >> +  ublk list
> >> +
> >> +- delete ublk device
> >> +  ublk del -a
> >> +  ublk del -n $ublk_dev_id
> >> +
> >> +Design
> >> +======
> >> +
> >> +Control plane
> >> +-------------
> >> +
> >> +ublk driver provides global misc device node(``/dev/ublk-control``) for
> >> +managing and controlling ublk devices with help of several control commands:
> >> +
> >> +- UBLK_CMD_ADD_DEV
> >> +  Add one ublk char device(``/dev/ublkc*``) which is talked with ublksrv wrt.
> > 
> > It may be clearer to say "the server" or "userspace" instead of
> > "ublksrv", since that is the name of a specific server implementation
> > and people may develop other servers.
> > 
> >> +  IO command communication. Basic device info is sent together with this
> >> +  command, see UAPI structure of ublksrv_ctrl_dev_info, such as nr_hw_queues,
> >> +  queue_depth, and max IO request buffer size, which info is negotiated with
> >> +  ublk driver and sent back to ublksrv. After this command is completed, the
> >> +  basic device info can't be changed any more.
> >> +
> >> +- UBLK_CMD_SET_PARAMS / UBLK_CMD_GET_PARAMS
> >> +  Set or get ublk device's parameters, which can be generic feature related,
> >> +  or request queue limit related, but can't be IO logic specific, cause ublk
> >> +  driver does not handle any IO logic. This command has to be sent before
> >> +  sending UBLK_CMD_START_DEV.
> >> +
> >> +- UBLK_CMD_START_DEV
> >> +  After ublksrv prepares userspace resource such as, creating per-queue
> >> +  pthread & io_ruing for handling ublk IO, this command is set for ublk
> > 
> > s/io_ruing/io_uring/
> > 
> >> +  driver to allocate & expose /dev/ublkb*. Parameters set via
> >> +  UBLK_CMD_SET_PARAMS are applied for creating /dev/ublkb*.
> >> +
> >> +- UBLK_CMD_STOP_DEV
> >> +  Quiesce IO on /dev/ublkb* and delete the disk. After this command returns,
> >> +  ublksrv can release resource, such as destroy per-queue pthread & io_uring
> >> +  for handling io command.
> >> +
> >> +- UBLK_CMD_DEL_DEV
> >> +  Delete /dev/ublkc*. After this command returns, the allocated ublk device
> >> +  number can be reused.
> >> +
> >> +- UBLK_CMD_GET_QUEUE_AFFINITY
> >> +  After /dev/ublkc is added, ublk driver creates block layer tagset, so each
> >> +  queue's affinity info is available, ublksrv sends UBLK_CMD_GET_QUEUE_AFFINITY
> >> +  to retrieve queue affinity info, so ublksrv can setup the per-queue context
> >> +  efficiently, such as bind affine CPUs with IO pthread, and try to allocate
> >> +  buffers in IO thread context.
> >> +
> >> +- UBLK_CMD_GET_DEV_INFO
> >> +  For retrieve device info of ublksrv_ctrl_dev_info. And it is ublksrv's
> >> +  responsibility to save IO target specific info in userspace.
> >> +
> >> +Data plane
> >> +----------
> >> +
> >> +ublksrv needs to create per-queue IO pthread & io_uring for handling IO
> >> +command (io_uring passthrough command), and the per-queue IO pthread
> >> +focuses on IO handling and shouldn't handle any control & management
> >> +task.
> >> +
> >> +ublksrv's IO is assigned by one unique tag, which is 1:1 mapping with IO
> >> +request of /dev/ublkb*.
> >> +
> >> +UAPI structure of ublksrv_io_desc is defined for describing each IO from
> >> +ublk driver. One fixed mmaped area(array) on /dev/ublkc* is provided for
> >> +exporting IO info to ublksrv, such as IO offset, length, OP/flags and
> >> +buffer address. Each ublksrv_io_desc instance can be indexed via queue id
> >> +and IO tag directly.
> >> +
> >> +Following IO commands are communicated via io_uring passthrough command,
> >> +and each command is only for forwarding ublk IO and committing IO result
> >> +with specified IO tag in the command data:
> >> +
> >> +- UBLK_IO_FETCH_REQ
> >> +  Sent from ublksrv IO pthread for fetching future coming IO request
> >> +  issued to /dev/ublkb*. This command is just sent once from ublksrv IO
> >> +  pthread for ublk driver to setup IO forward environment.
> >> +
> >> +- UBLK_IO_COMMIT_AND_FETCH_REQ
> >> +  After one IO request is issued to /dev/ublkb*, ublk driver stores this
> >> +  IO's ublksrv_io_desc to the specified mapped area, then the previous
> >> +  received IO command of this IO tag, either UBLK_IO_FETCH_REQ or
> >> +  UBLK_IO_COMMIT_AND_FETCH_REQ, is completed, so ulksrv gets the IO
> >> +  notification via io_uring.
> >> +
> >> +  After ublksrv handles this IO, this IO's result is committed back to ublk
> >> +  driver by sending UBLK_IO_COMMIT_AND_FETCH_REQ back. Once ublkdrv received
> >> +  this command, it parses the IO result and complete the IO request to
> >> +  /dev/ublkb*. Meantime setup environment for fetching future IO request
> >> +  with this IO tag. So UBLK_IO_COMMIT_AND_FETCH_REQ is reused for both
> >> +  fetching request and committing back IO result.
> >> +
> >> +- UBLK_IO_NEED_GET_DATA
> >> +  ublksrv pre-allocates IO buffer for each IO at default, any new project
> >> +  should use this IO buffer to communicate with ublk driver. But existed
> >> +  project may not work or be changed to in this way, so add this command
> >> +  to provide chance for userspace to use its existed buffer for handling
> >> +  IO.
> > 
> > I find it hard to understand this paragraph. It seems the
> > UBLK_IO_NEED_GET_DATA command allows userspace to set up something
> > related to IO buffers. What exactly does this command do?
> 
> Let me explain UBLK_IO_NEED_GET_DATA since it is designed by myself.
> 
> Without UBLK_IO_NEED_GET_DATA, ublk_drv will copy data from biovecs
> into a pre-allocated buffer(addr is passed with the last COMMIT_AMD_FETCH ioucmd)
> while processing a WRITE request. Please consider two cases:
> 
> (1)  if the backend(such as a dist-storage system using RPC) provides the data
>      buffer, it has to provide the buffer IN ADVANCE(before sending the last
>      COMMIT_AMD_FETCH) without knowing any knowledge of this incoming request.

The max buffer bytes is defined in ublksrv_ctrl_dev_info, and that is
max length of any incoming io request.

I explained it in last email, this way won't waste memory, and needn't extra
swap out too.

>      This makes existing backend very hard to adapt to ublk because they may
>      want to know the data length or other attributes of the new request.

It is just for existing project.

Any new project can read the data from the pre-allocated buffer
directly. That is exactly the handling flow: ublksrv gets one request from
ublk driver, then let backend handle the request.

> 
> (2) If the backend does not provide the data buffer IN ADVANCE, ublksrv must
>     pre-allocates data buffer. So a additional data copy from ublksrv to
>     the backend(such as a RPC mempool) is unavoidable.

Can you explain why backend can't use the pre-allocated buffer directly? Before
backend completes the io request, the io request and buffer won't be reused, that
is owned by this tag/slot.

> 
> With UBLK_IO_NEED_GET_DATA, the WRITE request will be firstly issued to ublksrv
> without data copy. Then, backend gets the request and it can allocate data
> buffer and embed its addr inside a new ioucmd. After the kernel driver gets the
> ioucmd, the data copy happens(from biovecs to backend's buffer). Finally,
> the backend gets the request again with data to be written and it can truly
> handle the request.

That is definitely inefficient, and I won't encourage any new project to
use this command.

> 
> > 
> >> +
> >> +- data copy between ublkserv IO buffer and ublk block IO request
> > 
> > s/ublkserv/ublksrv/
> > 
> >> +  ublk driver needs to copy ublk block IO request pages into ublksrv buffer
> >> +  (pages) first for WRITE before notifying ublksrv of the coming IO, so
> >> +  ublksrv can hanldle WRITE request.
> > 
> > s/hanldle/handle/
> > 
> >> +
> >> +  After ublksrv handles READ request and sends UBLK_IO_COMMIT_AND_FETCH_REQ
> >> +  to ublksrv, ublkdrv needs to copy read ublksrv buffer(pages) to the ublk
> >> +  IO request pages.
> 
> ublksrv sends UBLK_IO_COMMIT_AND_FETCH_REQ to "ublkdrv", not "ublksrv", I think.
> 
> BTW, "ublkdrv" is very similar to "ublksrv"... Maybe we should use "ublk_drv"?
> 
> > 
> > In the READ case userspace doesn't know exactly when the ublk driver is
> > done copying in the buffer. I guess this isn't a problem because the
> > userspace buffer will be reused when the next request is fetched?
> 
> In the READ case, userspace does not know exactly when the data copy happens.

ublksrv just needs to write data to the buffer, then send the buffer
with UBLK_IO_COMMIT_AND_FETCH_REQ to driver, and driver will copy the
data to request's pages.

Why does the userspace need to know when the copy happens?

> 
> The data buffer(add is passed with current UBLK_IO_COMMIT_AND_FETCH_REQ) is
> reused for a future request(the same tag).

Yeah, that is why it is completely safe since the future request can
only come _after_ ublk driver has copied the previous buffer to request
pages.

> 
> More specifically, whthout UBLK_IO_NEED_GET_DATA, if the future request is a
> write request, this buffer is filled with biovecs' data before ublk_drv passes
> the request to userspace. BTW, that's why UBLK_IO_NEED_GET_DATA is introduced.
> Otherwise the read buffer is actually reused for a future write buffer...

Not sure I get your point, but in short UBLK_IO_NEED_GET_DATA is only
for legacy uses.


Thanks,
Ming

