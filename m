Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC60C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E72760D07
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 12:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhJNMw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 08:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNMw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 08:52:57 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3AC061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 05:50:52 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r134so3572871iod.11
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zYN1i5zaMpEs3Nbm90rS5ks/fbV0O60nkRjOqMetRbY=;
        b=cLPkjmDfipxnmR8c746vJ01TgviyH5bxn5lFcxJ6m0GagzCCkTm/StbaPU9HjR182H
         VUZXkCcomsi9Z2lTiWnEp1sKudwVhDMosW0x2P6Ov+a+bK+fyQ9PFOPlnB3bw/SIY7+M
         IEF7A159E4/5AXo0pIHm5zBYEs4vjrMb4IODLbtT4mrZermFbcqS0mmNJhAbPlZrUMKx
         sykfKGgwkNmdNkWJaxtJF1P5WjSVV/TJm/E9Sr0y6tNdqvnlMX/jMY9t9D4pGnjRmzrO
         V1724tryLdEcTacnOtL0derFy3fgvQnNRfbVpPyYdyxmDab3ETdmh/mfXAz2tGRaD842
         B9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zYN1i5zaMpEs3Nbm90rS5ks/fbV0O60nkRjOqMetRbY=;
        b=Vxy80OK2VtvlLLHeBE9nTFdgPndgQOQAOvZKKkuQ5Ij4e5wi8oCghJF8qAUyeUQs1X
         r5+VugzCh0zBSooX0uco3kom4N35kiQD3WvIu3EXP9MZ4bQyFiraKa25Mz4NfTJil8Rz
         vN+VfGTX++LSiIouWBFkx0HEO6jk142xRwdk+Aipn2lmKhKy493gXUVheuesx5siwpNy
         eJRh763kW9/1hkEyxIyHvBoZ+AJvxqlEnfac8B048GMJ75HMmsAMQLTbpTG3XViy6npI
         sr6lKMbm5m3fXRegpqxElnrpqtvfcKtqZpKF5BGltwEbssblY76W1uqNvNPGUYMzwmFo
         GhVw==
X-Gm-Message-State: AOAM533kjoZszswsl5fwBBKuaXfg6FTUz635nCsi576yKumh3ohzF1cQ
        2yqUvLG63Rrfvs6qmkkYA3mDttgZ2cBkxw==
X-Google-Smtp-Source: ABdhPJzaZx9Q0i874k5WnZXpqPsLEgSwJ8gD3NtVMwrvV6GCFsW2UtCHS/3mcer4ETecwn+nKndh5g==
X-Received: by 2002:a05:6602:1410:: with SMTP id t16mr2279607iov.160.1634215852156;
        Thu, 14 Oct 2021 05:50:52 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b13sm1133295ioq.26.2021.10.14.05.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 05:50:51 -0700 (PDT)
Subject: Re: [PATCH] block: remove plug based merging
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <f17bf111-d625-88a1-238c-842e11b10c55@kernel.dk>
 <YWe+I6pG4zQxvGDm@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2772be81-721e-9013-52e7-12369c67d09e@kernel.dk>
Date:   Thu, 14 Oct 2021 06:50:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWe+I6pG4zQxvGDm@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:20 PM, Christoph Hellwig wrote:
> On Tue, Oct 12, 2021 at 12:12:39PM -0600, Jens Axboe wrote:
>> It's expensive to browse the whole plug list for merge opportunities at
>> the IOPS rates that modern storage can do. For sequential IO, the one-hit
>> cached merge should suffice on fast drives, and for rotational storage the
>> IO scheduler will do a more exhaustive lookup based merge anyway.
> 
> I don't really want to argue, but maybe some actual measurements to
> support the above claims would be useful in the commit log?

Sure, I do need to pad the commit messages a bit. One example - running
an IOPS bound worload caps out at ~5.6M IOPS and if you check the profile
this is top of the list:

  Overhead  Command   Shared Object     Symbol                                         
+   20.89%  io_uring  [kernel.vmlinux]  [k] blk_attempt_plug_merge
+    4.98%  io_uring  [kernel.vmlinux]  [k] io_submit_sqes
+    4.78%  io_uring  [kernel.vmlinux]  [k] blkdev_direct_IO
+    4.61%  io_uring  [kernel.vmlinux]  [k] blk_mq_submit_bio
+    3.67%  io_uring  [nvme]            [k] nvme_queue_rq

Disabling merging or applying the patch, we run at ~7.4M IOPS instead.
That's about a 33% improvement from killing a silly merge loop that
isn't even marked as an expensive merge.

I'll rework the patch, we can probably retain it is a last-insert kind
of merge point. But browsing the whole plug list for a merge candidate
is stupidity, regardless of the class of workload and storage.

-- 
Jens Axboe

