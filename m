Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD54C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 01:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiBXBdc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Feb 2022 20:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBXBdb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Feb 2022 20:33:31 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B7B49C9E
        for <linux-block@vger.kernel.org>; Wed, 23 Feb 2022 17:32:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V5LZavj_1645664314;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V5LZavj_1645664314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Feb 2022 08:58:35 +0800
Date:   Thu, 24 Feb 2022 08:58:33 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YhbYOeMUv5+U1XdQ@B-P7TQMD6M-0146.local>
Mail-Followup-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
 <a55211a1-a610-3d86-e21a-98751f20f21e@opensource.wdc.com>
 <YhXsQdkOpBY2nmFG@B-P7TQMD6M-0146.local>
 <3702afe7-2918-42e7-110b-efa75c0b58e8@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3702afe7-2918-42e7-110b-efa75c0b58e8@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 24, 2022 at 07:40:47AM +0900, Damien Le Moal wrote:
> On 2/23/22 17:11, Gao Xiang wrote:
> > On Wed, Feb 23, 2022 at 04:46:41PM +0900, Damien Le Moal wrote:
> >> On 2/23/22 14:57, Gao Xiang wrote:
> >>> On Mon, Feb 21, 2022 at 02:59:48PM -0500, Gabriel Krisman Bertazi wrote:
> >>>> I'd like to discuss an interface to implement user space block devices,
> >>>> while avoiding local network NBD solutions.  There has been reiterated
> >>>> interest in the topic, both from researchers [1] and from the community,
> >>>> including a proposed session in LSFMM2018 [2] (though I don't think it
> >>>> happened).
> >>>>
> >>>> I've been working on top of the Google iblock implementation to find
> >>>> something upstreamable and would like to present my design and gather
> >>>> feedback on some points, in particular zero-copy and overall user space
> >>>> interface.
> >>>>
> >>>> The design I'm pending towards uses special fds opened by the driver to
> >>>> transfer data to/from the block driver, preferably through direct
> >>>> splicing as much as possible, to keep data only in kernel space.  This
> >>>> is because, in my use case, the driver usually only manipulates
> >>>> metadata, while data is forwarded directly through the network, or
> >>>> similar. It would be neat if we can leverage the existing
> >>>> splice/copy_file_range syscalls such that we don't ever need to bring
> >>>> disk data to user space, if we can avoid it.  I've also experimented
> >>>> with regular pipes, But I found no way around keeping a lot of pipes
> >>>> opened, one for each possible command 'slot'.
> >>>>
> >>>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> >>>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> >>>
> >>> I'm interested in this general topic too. One of our use cases is
> >>> that we need to process network data in some degree since many
> >>> protocols are application layer protocols so it seems more reasonable
> >>> to process such protocols in userspace. And another difference is that
> >>> we may have thousands of devices in a machine since we'd better to run
> >>> containers as many as possible so the block device solution seems
> >>> suboptimal to us. Yet I'm still interested in this topic to get more
> >>> ideas.
> >>>
> >>> Btw, As for general userspace block device solutions, IMHO, there could
> >>> be some deadlock issues out of direct reclaim, writeback, and userspace
> >>> implementation due to writeback user requests can be tripped back to
> >>> the kernel side (even the dependency crosses threads). I think they are
> >>> somewhat hard to fix with user block device solutions. For example,
> >>> https://lore.kernel.org/r/CAM1OiDPxh0B1sXkyGCSTEpdgDd196-ftzLE-ocnM8Jd2F9w7AA@mail.gmail.com
> >>
> >> This is already fixed with prctl() support. See:
> >>
> >> https://lore.kernel.org/linux-fsdevel/20191112001900.9206-1-mchristi@redhat.com/
> > 
> > As I mentioned above, IMHO, we could add some per-task state to avoid
> > the majority of such deadlock cases (also what I mentioned above), but
> > there may still some potential dependency could happen between threads,
> > such as using another kernel workqueue and waiting on it (in principle
> > at least) since userspace program can call any syscall in principle (
> > which doesn't like in-kernel drivers). So I think it can cause some
> > risk due to generic userspace block device restriction, please kindly
> > correct me if I'm wrong.
> 
> Not sure what you mean with all this. prctl() works per process/thread
> and a context that has PR_SET_IO_FLUSHER set will have PF_MEMALLOC_NOIO
> set. So for the case of a user block device driver, setting this means
> that it cannot reenter itself during a memory allocation, regardless of
> the system call it executes (FS etc): all memory allocations in any
> syscall executed by the context will have GFP_NOIO.

I mean,

assuming PR_SET_IO_FLUSHER is already set on Thread A by using prctl,
but since it can call any valid system call, therefore, after it
received data due to direct reclaim and writeback, it is still
allowed to call some system call which may do something as follows:

   Thread A (PR_SET_IO_FLUSHER)   Kernel thread B (another context)

   (call some syscall which)

   submit something to Thread B
                                  
                                  ... (do something)

                                  memory allocation with GFP_KERNEL (it
                                  may trigger direct memory reclaim
                                  again and reenter the original fs.)

                                  wake up Thread A

   wait Thread B to complete

Normally such system call won't cause any problem since userspace
programs cannot be in a context out of writeback and direct reclaim.
Yet I'm not sure if it works under userspace block driver
writeback/direct reclaim cases.

> 
> If the kernel-side driver for the user block device driver does any
> allocation that does not have GFP_NOIO, or cause any such allocation
> (e.g. within a workqueue it is waiting for), then that is a kernel bug.
> Block device drivers are not supposed to ever do a memory allocation in
> the IO hot path without GFP_NOIO.

Yes, all in-kernel driver implementations needs to be audited with
proper memory allocation with GFP_NOIO, but userspace programs are
allowed to call any system call. And such system call can rely on
another process context with can do __GFP_FS allocation again. 

Thanks,
Gao Xiang

> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> >>
> >>
> >> -- 
> >> Damien Le Moal
> >> Western Digital Research
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
