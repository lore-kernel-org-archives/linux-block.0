Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90CC433EF
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 19:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387081AbiEBT1k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiEBT1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 15:27:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3979FF1
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 12:24:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82B3A210DF;
        Mon,  2 May 2022 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651519448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jB06ZjGgCFi9ydefF5+kUaL6A3A4igL9SQzYqrgttU=;
        b=SmYHx7yCMMBSmsE+FUo+Q1QD0Egb6bS17fRBWv9zSpdwhsRF5QJHdkiKvp8J1e88JWdYqs
        MzMJYD6d1RiE4dHcO46+nr1U3FWiNU3quaj5cOHfk/h1/Ub2zt27OQAZ4OUUDGiZVNd8LD
        4tB5iF6lY5wBXr7cWzx04fEXq9l90OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651519448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jB06ZjGgCFi9ydefF5+kUaL6A3A4igL9SQzYqrgttU=;
        b=NeLSrVEPUYnr4u+Cr5rDbMYB4XGuBysuj5/DGl/N8fizDCOcVh67fW00LqiIFRU9scbaev
        +WSDRWaW0/mpc/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD03B133E5;
        Mon,  2 May 2022 19:24:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 03zWIdYvcGLhLQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 02 May 2022 19:24:06 +0000
Message-ID: <d78b3d02-99a5-7876-2a6a-8b5f52a05def@suse.de>
Date:   Mon, 2 May 2022 12:24:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
 <YnAgJZUzDTTbAOXY@relinquished.localdomain>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YnAgJZUzDTTbAOXY@relinquished.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/22 11:17, Omar Sandoval wrote:
> On Mon, May 02, 2022 at 09:21:31AM -0700, Hannes Reinecke wrote:
>> Hi Omar,
>>
>> and another topic which came up during discussion yesterday:
>>
>> eBPF for block devices
>> It would be useful to enable eBPF for block devices, such that we could do
>> things like filtering bios on bio type, do error injection by modifying the
>> bio result etc.
>> This topic should be around how it could be implemented and what additional
>> use-cases could be supported.
>>
>> Cheers,
>>
>> Hannes
> 
> Do you want to try to coordinate a joint session with BPF, or were you
> planning on brainstorming what we need just in the IO track and tracking
> down the BPF folks offline?
> 
> +Alexei and Daniel

Coordinated session, please.
We need to get some common understandig of those things we're trying to 
do are properly eBPF-ish, and alse make the eBPF people aware of the 
issue we're facing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
