Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C80C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 06:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbiCOGxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 02:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbiCOGxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 02:53:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1CD49933
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 23:52:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73E332190B;
        Tue, 15 Mar 2022 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647327158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ar8v4BiBpmu/TvMCHiesaQ6mcYgVEFoLZ5vraRFMFk=;
        b=1LH4L1ys4/RMNOkXmvooKDn0VaMVYXLGK8c9bl94HWBjOXxG+aGxXXEJuUVK66JE5a/ebt
        OA1TUJSHNEuRrNLlDMRv7GCdPeijRDNYYLQy42+n7p4dvh5Ic2oubmDCvCFqQPNr8I9k7j
        LfCKCaiOl4PDJsChaLxZYyAAEDIjD+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647327158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ar8v4BiBpmu/TvMCHiesaQ6mcYgVEFoLZ5vraRFMFk=;
        b=BjUMJxoi7JQiS9Hc+jpYGFnIgMKRsj+pUlpWLZlBMdUuBnbJcgyC+ajllTxfQY8dgujIJX
        G/P4xu3H6hOWesAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 412C413B4E;
        Tue, 15 Mar 2022 06:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QPCSC7Y3MGKEQAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 15 Mar 2022 06:52:38 +0000
Message-ID: <c618c809-4ec0-69f9-0cab-87149ad6b45a@suse.de>
Date:   Tue, 15 Mar 2022 07:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
 <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/22 20:21, Bart Van Assche wrote:
> On 3/13/22 14:15, Sagi Grimberg wrote:
>>
>>> We don't want to re-use tcmu's interface.
>>>
>>> Bodo has been looking into on a new interface to avoid issues tcmu has
>>> and to improve performance. If it's allowed to add a tcmu like 
>>> backend to
>>> nvmet then it would be great because lio was not really made with mq and
>>> perf in mind so it already starts with issues. I just started doing the
>>> basics like removing locks from the main lio IO path but it seems like
>>> there is just so much work.
>>
>> Good to know...
>>
>> So I hear there is a desire to do this. So I think we should list the
>> use-cases for this first because that would lead to different design
>> choices.. For example one use-case is just to send read/write/flush
>> to userspace, another may want to passthru nvme commands to userspace
>> and there may be others...
> 
> (resending my reply without truncating the Cc-list)
> 
> Hi Sagi,
> 
> Haven't these use cases already been mentioned in the email at the start 
> of this thread? The use cases I am aware of are implementing 
> cloud-specific block storage functionality and also block storage in 
> user space for Android. Having to parse NVMe commands and PRP or SGL 
> lists would be an unnecessary source of complexity and overhead for 
> these use cases. My understanding is that what is needed for these use 
> cases is something that is close to the block layer request interface 
> (REQ_OP_* + request flags + data buffer).
> 

Curiously, the former was exactly my idea. I was thinking about having a 
simple nvmet userspace driver where all the transport 'magic' was 
handled in the nvmet driver, and just the NVMe SQEs passed on to the 
userland driver. The userland driver would then send the CQEs back to 
the driver.
With that the kernel driver becomes extremely simple, and would allow 
userspace to do all the magic it wants. More to the point, one could 
implement all sorts of fancy features which are out of scope for the 
current nvmet implementation.
Which is why I've been talking about 'inverse' io_uring; the userland 
driver will have to wait for SQEs, and write CQEs back to the driver.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
