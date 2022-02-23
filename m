Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F287BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 05:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiBWF5w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Feb 2022 00:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbiBWF5v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Feb 2022 00:57:51 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2087512AA1
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 21:57:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V5Gmabj_1645595835;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V5Gmabj_1645595835)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Feb 2022 13:57:17 +0800
Date:   Wed, 23 Feb 2022 13:57:15 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
Mail-Followup-To: Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tucsf0sr.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 21, 2022 at 02:59:48PM -0500, Gabriel Krisman Bertazi wrote:
> I'd like to discuss an interface to implement user space block devices,
> while avoiding local network NBD solutions.  There has been reiterated
> interest in the topic, both from researchers [1] and from the community,
> including a proposed session in LSFMM2018 [2] (though I don't think it
> happened).
> 
> I've been working on top of the Google iblock implementation to find
> something upstreamable and would like to present my design and gather
> feedback on some points, in particular zero-copy and overall user space
> interface.
> 
> The design I'm pending towards uses special fds opened by the driver to
> transfer data to/from the block driver, preferably through direct
> splicing as much as possible, to keep data only in kernel space.  This
> is because, in my use case, the driver usually only manipulates
> metadata, while data is forwarded directly through the network, or
> similar. It would be neat if we can leverage the existing
> splice/copy_file_range syscalls such that we don't ever need to bring
> disk data to user space, if we can avoid it.  I've also experimented
> with regular pipes, But I found no way around keeping a lot of pipes
> opened, one for each possible command 'slot'.
> 
> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html

I'm interested in this general topic too. One of our use cases is
that we need to process network data in some degree since many
protocols are application layer protocols so it seems more reasonable
to process such protocols in userspace. And another difference is that
we may have thousands of devices in a machine since we'd better to run
containers as many as possible so the block device solution seems
suboptimal to us. Yet I'm still interested in this topic to get more
ideas.

Btw, As for general userspace block device solutions, IMHO, there could
be some deadlock issues out of direct reclaim, writeback, and userspace
implementation due to writeback user requests can be tripped back to
the kernel side (even the dependency crosses threads). I think they are
somewhat hard to fix with user block device solutions. For example,
https://lore.kernel.org/r/CAM1OiDPxh0B1sXkyGCSTEpdgDd196-ftzLE-ocnM8Jd2F9w7AA@mail.gmail.com

Thanks,
Gao Xiang

> 
> -- 
> Gabriel Krisman Bertazi
