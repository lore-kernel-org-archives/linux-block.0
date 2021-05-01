Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF188C433ED
	for <linux-block@archiver.kernel.org>; Sat,  1 May 2021 11:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30A8613E1
	for <linux-block@archiver.kernel.org>; Sat,  1 May 2021 11:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhEAL6w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 May 2021 07:58:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhEAL6w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 May 2021 07:58:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9486AB1B1;
        Sat,  1 May 2021 11:58:01 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to work
 well with dm-multipath
To:     Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210420093720.GA28874@lst.de> <20210420143852.GB14523@redhat.com>
 <6a22337b0d15830d9117640bd227711ba8c8aef8.camel@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f2df22ef-583e-1d80-6ea7-2edfe61b9b53@suse.de>
Date:   Sat, 1 May 2021 13:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6a22337b0d15830d9117640bd227711ba8c8aef8.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/21 5:46 PM, Laurence Oberman wrote:
[ .. ]
> 
> Let me add some reasons why as primarily a support person that this is
> important and try avoid another combative situation.
> 
> Customers depend on managing device-mapper-multipath the way it is now
> even with the advent of nvme-over-F/C. Years of administration and
> management for multiple Enterprise O/S vendor customers (Suse/Red Hat,
> Oracle) all depend on managing multipath access in a transparent way.
> 
> I respect everybody's point of view here but native does change log
> alerting and recovery and that is what will take time for customers to
> adopt.
> 
> It is going to take time for Enterprise customers to transition so all
> we want is an option for them. At some point they will move to native
> but we always like to keep in step with upstream as much as possible.
> 
> Of course we could live with RHEL-only for while but that defeats our
> intention to be as close to upstream as possible.
> 
> If we could have this accepted upstream for now perhaps when customers
> are ready to move to native only we could phase this out.
> 
> Any technical reason why this would not fly is of course important to
> consider but perhaps for now we have a parallel option until we dont.
> 
Curiously, we (as in we as SLES developers) have found just the opposite.
NVMe is a new technology, and out of necessity there will not be any 
existing installations where we have to be compatible with.
We have switched to native NVMe multipathing with SLE15, and decided to 
educate customers that NVMe is a different concept than SCSI, and one 
shouldn't try treat both the same way. This was helped by the fact the 
SLE15 is a new release, so customers were accustomed to having to change 
bits and pieces in their infrastructure to support new releases.

Overall it worked reasonably well; we sure found plenty of bugs, but 
that was kind of expected, and for bad or worse nearly all of them 
turned out to be upstream issues. Which was good for us (nothing beats 
being able to blame things on upstream, if one is careful to not linger 
too much on the fact that one is part of upstream); and upstream these 
things will need to be fixed anyway.
So we had a bit of a mixed experience, but customers seemed to be happy 
enough with this step.

Sorry about that :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
