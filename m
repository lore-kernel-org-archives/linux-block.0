Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C04BC001DC
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 15:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjG0PaQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 11:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjG0P35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 11:29:57 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690F31BE4
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 08:29:54 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 391C983618;
        Thu, 27 Jul 2023 11:29:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1690471793; bh=EAIF5K7fLXgJUjG8uJaxVI7wJVdzXdwKiDhuCYySz9o=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=vQOPuSUlVrN/zz7kZTq6jjNePgcrc/0CLVzWduJVxhXFrN/uw39WxKQ2/pYxzfpxc
         /h0049AE2SMN+7LS8j8vq9z+PNkvJd5ROgQODveVjTwPH0tUp7FTCAPaIKlMYsaCKO
         ZLXHl3OJT5mztQj55kDFbv+GAUcCYDezuTA73jjmvrysssiPmQ1Lds1eepjZC1kKqJ
         tzutFPz4oubGGSL7ccTFVkkkeP8gfWIz5BlKwqmQjBa08+xbOG5eD1MafOxLASdS3n
         Fjfyb0Bw6eMlUOO/GNPkBjdo41i8ZQjEBElVkDb2gzlYr/Pr6kCaBBrld9PgrXS3Cj
         DGkhbW0VfWEhQ==
Message-ID: <f62c9dd4-08e6-4b00-a05d-4071e87405a7@dorminy.me>
Date:   Thu, 27 Jul 2023 11:29:51 -0400
MIME-Version: 1.0
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [vdo-devel] [PATCH v2 00/39] Add the dm-vdo deduplication and
 compression device mapper target.
To:     Ken Raeburn <raeburn@redhat.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        vdo-devel@redhat.com, dm-devel@redhat.com, ebiggers@kernel.org,
        tj@kernel.org
References: <20230523214539.226387-1-corwin@redhat.com>
 <ZLa086NuWiMkJKJE@redhat.com>
 <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
 <509f4916-a95f-216e-b0ab-7b7a108a48a0@dorminy.me> <87bkfy9riw.fsf@redhat.com>
Content-Language: en-US
In-Reply-To: <87bkfy9riw.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> 
>> If kernel workqueues have higher overhead per item for the lightweight
>> work VDO currently does in each step, perhaps the dual of the current
>> scheme would let more work get done per fixed queuing overhead, and
>> thus perform better? VIOs could take locks on sections of structures,
>> and operate on multiple structures before requeueing.
> 
> Can you suggest a little more specifically what the "dual" is you're
> picturing?

It sounds like your experiment consisted of one kernel workqueue per 
existing thread, with VIOs queueing on each thread in turn precisely as 
they do at present, so that when the VIO work item is running it's 
guaranteed to be the unique actor on a particular set of structures 
(e.g. for a physical thread the physical zone and slabs).

I am thinking of an alternate scheme where e.g. each slab, each block 
map zone, each packer would be protected by a lock instead of owned by a 
thread. There would be one workqueue with concurrency allowed where all 
VIOs would operate.

VIOs would do an initial queuing on a kernel workqueue, and then when 
the VIO work item would run, they'd take and hold the appropriate locks 
while they operated on each structure. So they'd take and release slab 
locks until they found a free block; send off to UDS and get requeued 
when it came back or the timer expired; try to compress and take/release 
a lock on the packer while adding itself to a bin and get requeued if 
appropriate when the packer released it; write and requeue when the 
write finishes if relevant. Then I think the 'make whatever modification 
to structures is relevant' part can be done without any requeue: take 
and release the recovery journal lock; ditto on the relevant slab; again 
the journal; again the other slab; then the part of the block map; etc.

Yes, there's the intriguing ordering requirements to work through, but 
maybe as an initial performance experiment the ordering can be ignored 
to get an idea of whether this scheme could provide acceptable performance.

> There are also occasionally non-VIO objects which get queued to invoke
> actions on various threads, which I expect might further complicate the
> experiment.

I think that's the easy part -- queueing a work item to grab a lock and 
Do Something seems to me a pretty common thing in the kernel code. 
Unless there are ordering requirements among the non-vios I'm not 
calling to mind.
