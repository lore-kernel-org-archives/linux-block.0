Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEABC433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 17:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiC2RWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiC2RWt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 13:22:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818417B0E2
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 10:21:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 273861F43829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648574462;
        bh=MKEFh39BbVWWkFq3HEcuavmMNzOKW96accRddIjlml0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HOBxHKk1TrEFQCjB9ARCB9ak6RO7J4j6jzvIoI3f5oo4PnxH0fCcJxOqI6bO9lK3k
         A5UmKzQaTLlglOk+kKNyNYSuXwnAQ7bWLj+SGhVxr3Yie8rUBLLj/exU4ZuMJtq9Ub
         nYjoocAREzu9PeQXudeKZiTr+PRkUg4IgG0G44v+Ld+pnAtk0C6CiyJQGiTM9qeYcp
         zBOsbfGn0XUWgSSXOETC+u9b5U8Et1NFSK3tVAUBo45PWcShUxNee0PFMHZE+++XqR
         Z4RkUMIWZDRWGdWQzcsJMb3prkriXziLViRKQY6cnjhBr3gnvljAtk1232nZxNtrP3
         bAgon0hOGcmbA==
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
Date:   Tue, 29 Mar 2022 13:20:57 -0400
In-Reply-To: <YkJTQW7aAjDGKL9p@T590> (Ming Lei's message of "Tue, 29 Mar 2022
        08:30:57 +0800")
Message-ID: <87bkxor7ye.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

>> I was thinking of something like this, or having a way for the server to
>> only operate on the fds and do splice/sendfile.  But, I don't know if it
>> would be useful for many use cases.  We also want to be able to send the
>> data to userspace, for instance, for userspace networking.
>
> I understand the big point is that how to pass the io data to ubd driver's
> request/bio pages. But splice/sendfile just transfers data between two FDs,
> then how can the block request/bio's pages get filled with expected data?
> Can you explain a bit in detail?

Hi Ming,

My idea was to split the control and dataplanes in different file
descriptors.

A queue has a fd that is mapped to a shared memory area where the
request descriptors are.  Submission/completion are done by read/writing
the index of the request on the shared memory area.

For the data plane, each request descriptor in the queue has an
associated file descriptor to be used for data transfer, which is
preallocated at queue creation time.  I'm mapping the bio linearly, from
offset 0, on these descriptors on .queue_rq().  Userspace operates on
these data file descriptors with regular RW syscalls, direct splice to
another fd or pipe, or mmap it to move data around. The data is
available on that fd until IO is completed through the queue fd.  After
an operation is completed, the fds are reused for the next IO on that
queue position.

Hannes has pointed out the issues with fd limits. :)

> If block layer is bypassed, it won't be exposed as block disk to userspace.

I implemented it as a block-mq driver, but it still only supports one
queue.

-- 
Gabriel Krisman Bertazi
