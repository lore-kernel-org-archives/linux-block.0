Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD79C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 10:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377734AbiDTKjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377720AbiDTKjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 06:39:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC121E11
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 03:36:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A38571F750;
        Wed, 20 Apr 2022 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650450988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nE9ejF0uN7/UhQ5WhYz8z7DMRlddxoOcgzZ1ba4TBHc=;
        b=l4Pk9PhBAVoP94IAiFODngxmRqH6XDNodMvcNemAtCwR/95mbZCEDERlA91pzUZfqLK4wf
        h5ILrmHJKC9kT5DXQYCJMn6zzvo+hYFzTIm1e5DwGWX9J5M08WMioKABjF1FJcRXJ5fE+z
        AP/BU8qTlabqC6qvmYgPsNTpi0F2QRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650450988;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nE9ejF0uN7/UhQ5WhYz8z7DMRlddxoOcgzZ1ba4TBHc=;
        b=BTA+ccQQu9Acf2tFnFgIJQGxRCHZjheuVAzKdsQxISRVhZh2bkuFQx6lNmxuBQDmX993fp
        1JIj12GLDnlYqcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D59313AD5;
        Wed, 20 Apr 2022 10:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2fqOHCziX2KYLwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 20 Apr 2022 10:36:28 +0000
Message-ID: <4454d299-1890-a60b-b931-0d33a007a1fe@suse.de>
Date:   Wed, 20 Apr 2022 12:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
 <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
 <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: can't run nvme-mp blktests
In-Reply-To: <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/22 20:09, Bart Van Assche wrote:
> On 4/15/22 10:59, Luis Chamberlain wrote:
>> That's about 3 block folks not being sure whether or not it helps. And
>> the complexities of it, to test it, requiring a different kernel seems
>> just stupid. So I'm going to drop the tests from kdevops and not bother
>> with them.
> 
> How about modifying the nvmeof-mp tests such that these use NVMe
> multipathing instead of the dm-multipath driver?
> 
I'd rather enable the nvme tests to work with rdma_rxe / siw. It should 
already work with TCP, so hooking in rdma_rxe and/or siw would be the 
logical step.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
