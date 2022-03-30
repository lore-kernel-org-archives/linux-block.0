Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08230C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 18:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350111AbiC3SZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351384AbiC3SYx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 14:24:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F7B4B419
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 11:22:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5FDC81F45F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648664543;
        bh=sYm9jFXdrgdVFCDucYlpXP1Kp/s8ldkKOJ7mfqFc47g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aIZcFo5g1HqWaoOkPGUjVdIx3TE8m0Li0nQHSAI+ebjOiNJ4Bttags1vgirq7SeEz
         rOFHGLfBfkeKZaS6uGONwAjzX9p/MrcACJlMlxxcBceoZK2oMf1oq+aiXBlGBQKeUv
         Zp+GzlarvnxVmLOlYnDgIcZL2B5CD1RyCZtV9V+Wtq1kyPBVxoGJHO6jiY3Sg81KI5
         /tomjYsrjzmSzs95G7/aE0Fr2FDB8uq0zShFL5LqHpIDZHJfaD37O8kzh0pGei9sad
         ZFIcBbu76ONDUE3nQ5JmjBI81oUWjOVaSa/QNBd21I5b4sZlBUUIsUUmVSAlNzhOBd
         YyHBv/J9UBZhA==
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
        <87o81prfrg.fsf@collabora.com> <YkJTQW7aAjDGKL9p@T590>
        <87bkxor7ye.fsf@collabora.com> <YkO4rFBHCdjCJndV@T590>
Date:   Wed, 30 Mar 2022 14:22:20 -0400
In-Reply-To: <YkO4rFBHCdjCJndV@T590> (Ming Lei's message of "Wed, 30 Mar 2022
        09:55:56 +0800")
Message-ID: <87tubfpag3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

> On Tue, Mar 29, 2022 at 01:20:57PM -0400, Gabriel Krisman Bertazi wrote:
>> Ming Lei <ming.lei@redhat.com> writes:
>> 
>> >> I was thinking of something like this, or having a way for the server to
>> >> only operate on the fds and do splice/sendfile.  But, I don't know if it
>> >> would be useful for many use cases.  We also want to be able to send the
>> >> data to userspace, for instance, for userspace networking.
>> >
>> > I understand the big point is that how to pass the io data to ubd driver's
>> > request/bio pages. But splice/sendfile just transfers data between two FDs,
>> > then how can the block request/bio's pages get filled with expected data?
>> > Can you explain a bit in detail?
>> 
>> Hi Ming,
>> 
>> My idea was to split the control and dataplanes in different file
>> descriptors.
>> 
>> A queue has a fd that is mapped to a shared memory area where the
>> request descriptors are.  Submission/completion are done by read/writing
>> the index of the request on the shared memory area.
>> 
>> For the data plane, each request descriptor in the queue has an
>> associated file descriptor to be used for data transfer, which is
>> preallocated at queue creation time.  I'm mapping the bio linearly, from
>> offset 0, on these descriptors on .queue_rq().  Userspace operates on
>> these data file descriptors with regular RW syscalls, direct splice to
>> another fd or pipe, or mmap it to move data around. The data is
>> available on that fd until IO is completed through the queue fd.  After
>> an operation is completed, the fds are reused for the next IO on that
>> queue position.
>> 
>> Hannes has pointed out the issues with fd limits. :)
>
> OK, thanks for the detailed explanation!
>
> Also you may switch to map each request queue/disk into a FD, and every
> request is mapped to one fixed extent of the 'file' via rq->tag since we
> have max sectors limit for each request, then fd limits can be avoided.
>
> But I am wondering if this way is friendly to userspace side implementation,
> since there isn't buffer, only FDs visible to userspace.

The advantages would be not mapping the request data in userspace if we
could avoid it, since it would be possible to just forward the data
inside the kernel.  But my latest understanding is that most use cases
will want to directly manipulate the data anyway, maybe to checksum, or
even for sending through userspace networking.  It is not clear to me
anymore that we'd benefit from not always mapping the requests to
userspace.

I've been looking at your implementation and I really like how simple it
is. I think it's the most promising approach for this feature I've
reviewed so far.  I'd like to send you a few patches for bugs I found
when testing it and keep working on making it upstreamable.  How can I
send you those patches?  Is it fine to just email you or should I also
cc linux-block, even though this is yet out-of-tree code?

-- 
Gabriel Krisman Bertazi
