Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3FBC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC8B208E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC8B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeKPUBY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:01:24 -0500
Received: from verein.lst.de ([213.95.11.211]:48408 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbeKPUBY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 15:01:24 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E3C6B68D60; Fri, 16 Nov 2018 10:49:47 +0100 (CET)
Date:   Fri, 16 Nov 2018 10:49:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        shenhong09@huawei.com, dm-devel@redhat.com,
        wangzhoumengjian@huawei.com, christophe.varoqui@opensvc.com,
        bmarzins@redhat.com, sschremm@netapp.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: allow ANA support to be independent of native
 multipathing
Message-ID: <20181116094947.GA19296@lst.de>
References: <20181112215323.GA7983@redhat.com> <20181113161838.GC9827@localhost.localdomain> <20181113180008.GA12513@redhat.com> <20181114053837.GA15086@redhat.com> <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de> <20181114174746.GA18526@redhat.com> <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de> <20181115174605.GA19782@redhat.com> <20181116091458.GA17267@lst.de> <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 10:40:40AM +0100, Hannes Reinecke wrote:
>>> Introduce ability to always re-read ANA log page as required due to ANA
>>> error and make current ANA state available via sysfs -- even if native
>>> multipathing is disabled on the host (e.g. nvme_core.multipath=N).
>>
>> The first part I could see, but I still want to make it conditional
>> in some way as nvme is going into deeply embedded setups, and I don't
>> want to carry the weight of the ANA code around for everyone.
>>
> Can you clarify this a bit?
> We _do_ have the NVME multipath config option to deconfigure the whole 
> thing during compile time; that isn't influenced with this patch.
> So are you worried about the size of the ANA implementation itself?
> Or are you worried about the size of the ANA structures?

I just see the next step of wanting to move ANA code into the core
which is implied above.
>
>> The second I fundamentally disagree with.  And even if you found agreement
>> it would have to be in a separate patch as it is a separate feature.
>>
> Why? Where's the problem with re-reading the ANA log pages if we get an 
> event indicating that we should?

"second" here means the sysfs file.
