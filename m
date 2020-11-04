Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E80DC2D0A3
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 14:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBF1206F4
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 14:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKDO0s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:26:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:52816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgKDO0s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Nov 2020 09:26:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13DBFAD5D;
        Wed,  4 Nov 2020 14:26:47 +0000 (UTC)
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
To:     "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Javier Gonzalez <javier.gonz@samsung.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de>
Date:   Wed, 4 Nov 2020 15:26:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102185851.GA21349@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/20 7:58 PM, hch@lst.de wrote:
> On Mon, Nov 02, 2020 at 10:33:55AM -0800, Keith Busch wrote:
>> I can see this going one of two ways:
>>
>>   a) Set up the existing controller character device with a generic
>>      disk-less request_queue to the IO queues accepting IO commands to
>>      arbitrary NSIDs.
>>
>>   b) Each namespace that can't be supported gets their own character
>>      device.
>>
>> I'm leaning toward option "a". While it doesn't create handles to unique
>> namespaces, it has more resilience to potentially future changes. And I
>> recall the target side had a potential use for that, too.
> 
> The problem with a) is that it can't be used to give users or groups
> access to just one namespaces, so it causes a real access control
> nightmare.  The problem with b) is that now applications will break
> when we add support for new command sets or features.  I think
> 
>    c) Each namespace gets its own character device, period.
> 
> is the only sensible option.
> 
I hardly dare to mention bsg here; but the is pretty similar to what it 
set out to do ...

Or yet another interface?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
