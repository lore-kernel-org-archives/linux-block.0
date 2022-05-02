Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A16AC433F5
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 16:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiEBQUk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386223AbiEBQUi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 12:20:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558EDDFF8
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 09:17:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10A051F38D;
        Mon,  2 May 2022 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651508228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cP4Qz0W91FrPGrCzRyvm/zakMJGQvmqBxram4FxnEjU=;
        b=lDwxJihVLl/Bg65JyhDdIkOjyWJcob0/0sa94mEBA5Mzxnm2GkHnd130AeSRi60Xfd3p/I
        B45EpbwOHSHMvvUoqli0DqXAdkIitGIsZY1G0oo9Bt7xkFI/bZmIRTcA+gmdlBmWzcMXI4
        y2okroOSZtmPKdfMyfDJUPFcmMsMuRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651508228;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cP4Qz0W91FrPGrCzRyvm/zakMJGQvmqBxram4FxnEjU=;
        b=SK/unQU8nRRXiD9lo4vF3mayP0rJF1gUqgAJ4KG6XlVv39Wxua3NNpsNyKXHYLOcre63aY
        LNCTI2FsWuxL0+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14E6B13491;
        Mon,  2 May 2022 16:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LOO4NAEEcGKaZAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 02 May 2022 16:17:05 +0000
Message-ID: <44814263-1546-a450-e799-5039aa991ca6@suse.de>
Date:   Mon, 2 May 2022 09:17:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF TOPIC] block namespaces
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Christian Brauner <christian.brauner@microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
References: <7dca874a-b8ef-59bf-a368-595d0ed2838f@suse.de>
 <YnACIcvUBH8/eKdC@relinquished.localdomain>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YnACIcvUBH8/eKdC@relinquished.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/22 09:09, Omar Sandoval wrote:
> On Mon, May 02, 2022 at 01:14:48AM +0200, Hannes Reinecke wrote:
>> Hi Omar,
>>
>> here's a late topic for the I/O Track: Block namespaces
>>
>> We already proposed it for the (canceled) LSF last year, and now I found
>> that Christian Brauner is actually present here at LSF.
>>
>> What this is about: Similarly to network namespaces we'd like to explore the
>> possibility of block namespaces.
>> Canonical use-case here is iscsi sessions within containers: if one
>> container starts up an iscsi session, why should this session be visible to
>> the other containers?
>> The discussion should be about general design and possible use-cases.
> 
> Hey, Hannes,
> 
> How much does this overlap with Chris Leech's "network storage
> transports managed within a container" topic?

Hmm. Good question; I don't really know. But yeah, I guess there is some.
So we could lump both of them together I think.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
