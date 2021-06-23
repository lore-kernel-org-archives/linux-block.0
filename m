Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF31C4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 12:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E066661002
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 12:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFWMFq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 08:05:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38264 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 08:05:46 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 081741FD65;
        Wed, 23 Jun 2021 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624449808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTV0UJMvjAlHC0068bqJsxAfZBAJ3v623+Gud9Q+2ok=;
        b=JEwVwd5lWr59EcR28oxtQoQeflZEtZ6GtvIqFr+3qPap9DIqlIxS16dhKGeD88AdgHhrQK
        FnaGZl6LUbHmCXqawqEN/CTgAdCZYjbNY2Zq58VJ569soEXfRxCLgg/SnorvXx7d8ZtdW5
        YHjUElLq6Fyl98xM/jRHIF7FsABnP5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624449808;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTV0UJMvjAlHC0068bqJsxAfZBAJ3v623+Gud9Q+2ok=;
        b=NwoYa3wurxv0LfPJNjQb5ZEd1tVjfIl9pupg76GLbPUHgiC4wWiYX5RAAVvfb5RlyXPytc
        j4Nna4Tidn/PA9Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id ADCA511A97;
        Wed, 23 Jun 2021 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624449807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTV0UJMvjAlHC0068bqJsxAfZBAJ3v623+Gud9Q+2ok=;
        b=YF5l59Liz2PwKX7sWBCPjDz8AJ/4dt0uGGV+1XjZDof0eMiBagemhhka4asURm2hQLjPHk
        pToA+nVJaTwvciMnCOeiYAJllplYa7V3i+WBOd2tbr8Zr07nHtB757209mun/fOjmXwXHB
        FA7WEn/722VuFam8SwPykndZg7ENp4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624449807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTV0UJMvjAlHC0068bqJsxAfZBAJ3v623+Gud9Q+2ok=;
        b=phFHobecXngr10YyZGcNi33kkMtxHjkkaAk14F16/Y1M+JRLYUrn+0tW9Bj8hI1yrs1KWX
        xRKybiw+NIuYoXBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id rhDpKA8j02B6DwAALh3uQQ
        (envelope-from <hare@suse.de>); Wed, 23 Jun 2021 12:03:27 +0000
Subject: Re: [PATCH v3 0/6] block: add a sequence number to disks
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bfdd6f56-ce2b-ef74-27b1-83b922e5f7d9@suse.de>
Date:   Wed, 23 Jun 2021 14:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210623105858.6978-1-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/21 12:58 PM, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> With this series a monotonically increasing number is added to disks,
> precisely in the genhd struct, and it's exported in sysfs and uevent.
> 
> This helps the userspace correlate events for devices that reuse the
> same device, like loop.
> 
I'm failing to see the point here.
Apparently you are assuming that there is a userspace tool tracking 
events, and has a need to correlate events related to different 
instances of the disk.
But if you have an userspace application tracking events, why can't the 
same application track the 'add' and 'remove' events to track the 
lifetime of the devices, and implement its own numbering based on that?

Why do we need to burden the kernel with this?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
