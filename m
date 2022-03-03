Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59112C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 07:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiCCHJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 02:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiCCHJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 02:09:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC161164D1D
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 23:09:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC123218A9;
        Thu,  3 Mar 2022 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646291341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKrRZM4mv547TIZGH2rQfsMnVirG04TIkxo5MtzU8CI=;
        b=M8eWfQocMHqRfCvPrW4InuFGa2EcmLXQWrOiuSwebRT6UC+McTNNm7dC/YwXvWWFNFuhrX
        F2fc39LoczKAxHCAT4Itbmy3hwpFsNsDWT5SRuy9RrvpPvFnejYY6WY0kO+nqN3gCadO8H
        W8OVA486FdfYcLVOIZZo43WTQwQL924=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646291341;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKrRZM4mv547TIZGH2rQfsMnVirG04TIkxo5MtzU8CI=;
        b=w7RsDCz+rBgKUdu6STy9vcEGUslALHZAgY+Zp6WXJPp7pLgV7hxvu/fInQN6j2sjsD7HH6
        /DWgOKOl3fSRQuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8791D13AB4;
        Thu,  3 Mar 2022 07:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 27SWH41pIGJNLwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 03 Mar 2022 07:09:01 +0000
Message-ID: <57af4fe0-9042-729a-18e9-839a5f0a84ac@suse.de>
Date:   Thu, 3 Mar 2022 08:09:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <526a8360-d7d3-1211-087b-c86d5a68380b@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <526a8360-d7d3-1211-087b-c86d5a68380b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/22 17:52, Mike Christie wrote:
> On 2/21/22 1:59 PM, Gabriel Krisman Bertazi wrote:
>> I'd like to discuss an interface to implement user space block devices,
>> while avoiding local network NBD solutions.  There has been reiterated
> 
> Besides the tcmu approach, I've also worked on the local nbd based
> solution like here:
> 
> https://github.com/gluster/nbd-runner
> 
> Have you looked into a modern take that uses io_uring's socket features
> with the zero copy work that's being worked on for it? If so, what are
> the issues you have hit with that? Was it mostly issues with the zero
> copy part of it?
> 
> 
Problem is that we'd need an _inverse_ io_uring interface.
The current io_uring interface writes submission queue elements,
and waits for completion queue elements.

For this use-case we'd need to convert it to wait for submission queue 
elements, and write completion queue elements.

IE completely invert the operation.

Not sure if we can convert it _that_ easily ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
