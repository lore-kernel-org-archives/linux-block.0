Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EEC433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 06:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiDHGyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 02:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDHGyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 02:54:44 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A476930CB8D
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 23:52:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9UYTiy_1649400756;
Received: from 30.82.254.90(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V9UYTiy_1649400756)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Apr 2022 14:52:37 +0800
Message-ID: <d2361ebc-1f04-dce5-744c-d4fcb8aca7aa@linux.alibaba.com>
Date:   Fri, 8 Apr 2022 14:52:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de> <YkCSVSk1SwvtABIW@T590>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <YkCSVSk1SwvtABIW@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi,

> On Tue, Feb 22, 2022 at 07:57:27AM +0100, Hannes Reinecke wrote:
>> On 2/21/22 20:59, Gabriel Krisman Bertazi wrote:
>>> I'd like to discuss an interface to implement user space block devices,
>>> while avoiding local network NBD solutions.  There has been reiterated
>>> interest in the topic, both from researchers [1] and from the community,
>>> including a proposed session in LSFMM2018 [2] (though I don't think it
>>> happened).
>>>
>>> I've been working on top of the Google iblock implementation to find
>>> something upstreamable and would like to present my design and gather
>>> feedback on some points, in particular zero-copy and overall user space
>>> interface.
>>>
>>> The design I'm pending towards uses special fds opened by the driver to
>>> transfer data to/from the block driver, preferably through direct
>>> splicing as much as possible, to keep data only in kernel space.  This
>>> is because, in my use case, the driver usually only manipulates
>>> metadata, while data is forwarded directly through the network, or
>>> similar. It would be neat if we can leverage the existing
>>> splice/copy_file_range syscalls such that we don't ever need to bring
>>> disk data to user space, if we can avoid it.  I've also experimented
>>> with regular pipes, But I found no way around keeping a lot of pipes
>>> opened, one for each possible command 'slot'.
>>>
>>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
>>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
>>>
>> Actually, I'd rather have something like an 'inverse io_uring', where an
>> application creates a memory region separated into several 'ring' for
>> submission and completion.
>> Then the kernel could write/map the incoming data onto the rings, and
>> application can read from there.
>> Maybe it'll be worthwhile to look at virtio here.
> IMO it needn't 'inverse io_uring', the normal io_uring SQE/CQE model
> does cover this case, the userspace part can submit SQEs beforehand
> for getting notification of each incoming io request from kernel driver,
> then after one io request is queued to the driver, the driver can
> queue a CQE for the previous submitted SQE. Recent posted patch of
> IORING_OP_URING_CMD[1] is perfect for such purpose.
>
> I have written one such userspace block driver recently, and [2] is the
> kernel part blk-mq driver(ubd driver), the userspace part is ubdsrv[3].
> Both the two parts look quite simple, but still in very early stage, so
> far only ubd-loop and ubd-null targets are implemented in [3]. Not only
> the io command communication channel is done via IORING_OP_URING_CMD, but
> also IO handling for ubd-loop is implemented via plain io_uring too.
>
> It is basically working, for ubd-loop, not see regression in 'xfstests -g auto'
> on the ubd block device compared with same xfstests on underlying disk, and
> my simple performance test on VM shows the result isn't worse than kernel loop
> driver with dio, or even much better on some test situations.
I also have spent time to learn your codes, its idea is really good, thanks for this
great work. Though we're using tcmu, indeed we just needs a simple block device
based on block semantics. Tcmu is based on scsi protocol, which is somewhat
complicated and influences small io request performance. So if you like, we're
willing to participate this project, and may use it in our internal business, thanks.

Another little question, why you use raw io_uring interface rather than liburing?
Are there any special reasons?

Regards,
Xiaoguang Wang
>
> Wrt. this userspace block driver things, I am more interested in the following
> sub-topics:
>
> 1) zero copy
> - the ubd driver[2] needs one data copy: for WRITE request, copy pages
>   in io request to userspace buffer before handling the WRITE IO by ubdsrv;
>   for READ request, the reverse copy is done after READ request is
>   handled by ubdsrv
>
> - I tried to apply zero copy via remap_pfn_range() for avoiding this
>   data copy, but looks it can't work for ubd driver, since pages in the
>   remapped vm area can't be retrieved by get_user_pages_*() which is called in
>   direct io code path
>
> - recently Xiaoguang Wang posted one RFC patch[4] for support zero copy on
>   tcmu, and vm_insert_page(s)_mkspecial() is added for such purpose, but
>   it has same limit of remap_pfn_range; Also Xiaoguang mentioned that
>   vm_insert_pages may work, but anonymous pages can not be remapped by
>   vm_insert_pages.
>
> - here the requirement is to remap either anonymous pages or page cache
>   pages into userspace vm, and the mapping/unmapping can be done for
>   each IO runtime. Is this requirement reasonable? If yes, is there any
>   easy way to implement it in kernel?
>
> 2) batching queueing io_uring CQEs
>
> - for ubd driver, batching is very sensitive to performance per my
>   observation, if we can run batch queueing IORING_OP_URING_CMD CQEs,
>   ubd_queue_rqs() can be wirted to the batching CQEs, then the whole batch
>   only takes one io_uring_enter().
>
> - not digging into io_uring code for this interface yet, but looks not
>   see such interface
>
> 3) requirement on userspace block driver
> - exact requirements from user viewpoint
>
> 4) apply eBPF in userspace block driver
> - it is one open topic, still not have specific or exact idea yet,
>
> - is there chance to apply ebpf for mapping ubd io into its target handling
> for avoiding data copy and remapping cost for zero copy?
>
> I am happy to join the virtual discussion on lsf/mm if there is and it
> is possible.
>
> [1] https://lore.kernel.org/linux-block/20220308152105.309618-1-joshi.k@samsung.com/#r
> [2] https://github.com/ming1/linux/tree/v5.17-ubd-dev
> [3] https://github.com/ming1/ubdsrv
> [4] https://lore.kernel.org/linux-block/abbe51c4-873f-e96e-d421-85906689a55a@gmail.com/#r
>
> Thanks,
> Ming

