Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 20:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbiC1UVu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242674AbiC1UVs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 16:21:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB80E3FBF5
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 13:20:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 417791F432B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648498806;
        bh=wAuuLyABvD0PxQt8HNpAf1ZgVsHGsbuYyFn+5q4EtiQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Aw3Q8vCphP2hTg4a/jOLx/2VJQMw6IWTvhPcklamzICh8ukFfUz9eNj0KsRirkM/h
         1xpv8dgQiLgMxpKfEIwfrTzqwLIEXDSioi/zSg/y7E3ATQ99dm/wfok2IldgK1UsJs
         1o5Xs1217MPq4FJ4bsF+8Bxvn/CGiZbZRJp06xrwfEu5cTphJ2tZpbZhfpeYK9VkDJ
         sCDYqTcdefphphiVILUiiWA1BsBAIuj7ilw4vl/5jqcYBlK1k6uphGW1srnSEp9knA
         Ey1FMcevLOXIRFwv2cvKqSTsjIAqAfMJ1l5+ALnTXPQ+PV+k35E8Yj/GlNCcvbFXD0
         Nn/nfM1xTcqnA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Organization: Collabora
References: <87tucsf0sr.fsf@collabora.com>
        <986caf55-65d1-0755-383b-73834ec04967@suse.de> <YkCSVSk1SwvtABIW@T590>
Date:   Mon, 28 Mar 2022 16:20:03 -0400
In-Reply-To: <YkCSVSk1SwvtABIW@T590> (Ming Lei's message of "Mon, 28 Mar 2022
        00:35:33 +0800")
Message-ID: <87o81prfrg.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

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

Thanks for sharing.  This is a very interesting implementation that
seems to cover quite well the original use case.  I'm giving it a try and
will report back.

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

I've run into the same issue with my fd implementation and haven't been
able to workaround it.

> 4) apply eBPF in userspace block driver
> - it is one open topic, still not have specific or exact idea yet,
>
> - is there chance to apply ebpf for mapping ubd io into its target handling
> for avoiding data copy and remapping cost for zero copy?

I was thinking of something like this, or having a way for the server to
only operate on the fds and do splice/sendfile.  But, I don't know if it
would be useful for many use cases.  We also want to be able to send the
data to userspace, for instance, for userspace networking.

-- 
Gabriel Krisman Bertazi
