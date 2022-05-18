Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23432C433FE
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 07:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiERHdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 03:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiERHdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 03:33:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F67A80E
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 00:33:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 974471F9A5;
        Wed, 18 May 2022 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652859227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5i67IRZUWh6H4k0Lxd0QpcjTTp3wGYXXb5+WyloeGIA=;
        b=rs4YE8r81XygKk2RtwejdGcaj/+mXr+oykE8VQupYIpVIceyO0hlNhSfC7HI9gq4mc+IFO
        PCPivhzuA+VK4+zqxc+wdpNsXovbDNzcuOq1WtPWvZ5M7gBy4+U/zDYPO+vEO4MUivTLIf
        cZOQIMx0hDOPDzpwO4+pG583WTKGuzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652859227;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5i67IRZUWh6H4k0Lxd0QpcjTTp3wGYXXb5+WyloeGIA=;
        b=iJA93DJSCiaqjkuLAOEdGiXyOrAvScXoQI9Eb14jN52+xSIj45MSqycTDe2r/2H08U++wd
        DgeBI4NWp35bOpAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 871C4133F5;
        Wed, 18 May 2022 07:33:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LlavIFuhhGLtUQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 18 May 2022 07:33:47 +0000
Message-ID: <5ed3aa33-7188-4d84-218a-ae1a50af0ebf@suse.de>
Date:   Wed, 18 May 2022 09:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL] nvme updates for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YoSWZoB1/38DdP4S@infradead.org>
 <8ff06ce2-0aa7-5999-8987-1f9d9935e4e5@suse.de>
 <YoSf2UvYcW9fHebf@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YoSf2UvYcW9fHebf@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/22 09:27, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 09:23:45AM +0200, Hannes Reinecke wrote:
>> On 5/18/22 08:47, Christoph Hellwig wrote:
>>> The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:
>>>
>>>     loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)
>>>
>> Hmm. So how do we progress with the authentication patches?
>> Shall I resubmit them?
>> Will you be picking them up?
>> Is there anything I need to fix up?
> 
> I'm a little worried adding it this late in the cycle, especially with
> the (although rather trivial) crypto patches not having any reviews from
> the crypto maintainers.  If you can get those we should be ready early
> for the next merge window which is going to start in just a few days.

Right. Will see what I can do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
