Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89896C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 19:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiCWTnj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344323AbiCWTnj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 15:43:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9860C8B6F5
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:42:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DDF751F44C3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648064528;
        bh=jaSlGEWNNc5/heOq1AHMdWQOmAzG5eDPGZkTrS0x1Wg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ldj8DuSqrt6OXxElXNi9MAKJvo0e9gBtZLdVjSE2ae5C2z17URQ67w8ik0+/cEQf1
         /zXSQFUNWj9co/eSJ+b5vP84eh6VSk0R6X45xbqDecHKDuT1J+SgnDkGyXiCn/c6Ln
         14M+j/3pS5DcdskX0GqXttw0xsqnaarQQ3Eq+1JxTqxnEO6dYYXdu6pKotVLMBP0cc
         Ei7wn2nH8kBWq0t9ymo6vT+wq4GdXsQ17WpdOeMQQ8sU1hDM3f50p3aeIlyy6J3cl3
         r4zZSMPK9LnDgWnTrXgouqajFZ6pdFmPJwBfSTpT80pi+L9b35TuxRWrzhRu//FUQv
         R2arglUru/y0A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Organization: Collabora
References: <87tucsf0sr.fsf@collabora.com>
        <986caf55-65d1-0755-383b-73834ec04967@suse.de>
        <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
        <87bkyyg4jc.fsf@collabora.com>
        <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
        <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
        <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
        <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
        <c618c809-4ec0-69f9-0cab-87149ad6b45a@suse.de>
        <d2950977-9930-1e80-a46d-8311935e8da4@grimberg.me>
        <YjBKaoBYtofJXrgw@infradead.org>
        <1cec32d1-511e-1a78-b157-9ecaebc72c66@grimberg.me>
Date:   Wed, 23 Mar 2022 15:42:04 -0400
In-Reply-To: <1cec32d1-511e-1a78-b157-9ecaebc72c66@grimberg.me> (Sagi
        Grimberg's message of "Tue, 15 Mar 2022 10:38:24 +0200")
Message-ID: <87bkxwqwvn.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sagi Grimberg <sagi@grimberg.me> writes:

>> FYI, I have absolutely no interest in supporting any userspace hooks
>> in nvmet.
>
> Don't think we are discussing adding anything specific to nvmet, a
> userspace backend will most likely sit behind a block device exported
> via nvmet (at least from my perspective). Although I do see issues
> with using the passthru interface...
>
>> If you want a userspace nvme implementation please use SPDK.
>
> The original use-case did not include nvmet, I may have stirred
> the pot saying that we have nvmet loopback instead of a new kind
> of device with a new set of tools.
>
> I don't think that spdk meets even the original android use-case.
>
> Not touching nvmet is fine, it just eliminates some of the possible
> use-cases. Although personally I don't see a huge issue with adding
> yet another backend to nvmet...

After discussing with google for the r/w/flush use-case (cloud, not
android), they are interested in avoiding the source of complexity that
arises from implementing the NVMe protocol in the interface.  Even if it
is hidden behind a userspace library, it means converting block
rq->nvme->block rq, which might have a performance impact?

From your previous message, I think we can move forward with dissociating
the original use case from nvme passthrough, and have the userspace hook
as a block driver?

-- 
Gabriel Krisman Bertazi
