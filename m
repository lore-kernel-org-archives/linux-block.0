Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EA5C7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 06:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjDXGLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 02:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXGLG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 02:11:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E7CA
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 23:11:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 889181FD7B;
        Mon, 24 Apr 2023 06:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682316660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/dJBKipj2BTYlAHwALrSBvABtFqG0TvrGDD9iTnPQE=;
        b=odY6KUD+HvzBFk5FATpkTmwmlDN4b/LjIeJY36wvs58PftePjyBOI96nhM1RGwbP7+LKwH
        YdY7XeFH+tXCQ2y3pBCiO1z+bpaL+C5pCpeQkB5/328AaXoStq8EpJ7hQwwsKwehVG5c7x
        wIBWZtEv01tz09D8LIGgzkk9MW+3nn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682316660;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/dJBKipj2BTYlAHwALrSBvABtFqG0TvrGDD9iTnPQE=;
        b=sXmMQxHxR+heL5M0+44KuS3Bg25M7m3SagAFUNxEANoaAnn5taAdc/uXETxV5XShElqMKw
        mbV2+7femH7VdABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E95513780;
        Mon, 24 Apr 2023 06:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0351CXQdRmTHIAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 24 Apr 2023 06:11:00 +0000
Message-ID: <5b7ca121-2b85-ddd0-d94b-1739cc5dcbec@suse.de>
Date:   Mon, 24 Apr 2023 08:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 0/2] Fix failover to non integrity NVMe path
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     martin.petersen@oracle.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
        israelr@nvidia.com
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
 <20230424051144.GA9288@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230424051144.GA9288@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/23 07:11, Christoph Hellwig wrote:
> On Sun, Apr 23, 2023 at 05:13:28PM +0300, Max Gurtovoy wrote:
>> Hi Christoph/Sagi/Martin,
>>
>> We're encountered a crash while testing failover between NVMeF/RDMA
>> paths to a target that expose a namespace with metadata. The scenario is
>> the following:
>> Configure one initiator/host path on PI offload capable port (e.g ConnectX-5
>> device) and configure second initiator/host path on non PI offload capable
>> port (e.g ConnectX-3).
> 
> Hmm.  I suspect the right thing to do here is to just fail the second
> connect.

Yeah, I'm slightly unhappy with this whole setup.
If we were just doing DIF I guess the setup could work, but then we have 
to disable DIX (as we cannot support integrity data on the non-PI path).
But we would need an additional patch to disable DIX functionality in 
those cases.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

