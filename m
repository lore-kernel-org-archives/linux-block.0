Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C200EC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A5D208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A5D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeKPTwQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:52:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:34652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbeKPTwQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 14:52:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 626E2AEDB;
        Fri, 16 Nov 2018 09:40:42 +0000 (UTC)
Subject: Re: [PATCH] nvme: allow ANA support to be independent of native
 multipathing
To:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        shenhong09@huawei.com, dm-devel@redhat.com,
        wangzhoumengjian@huawei.com, christophe.varoqui@opensvc.com,
        bmarzins@redhat.com, sschremm@netapp.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com>
 <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <20181113180008.GA12513@redhat.com> <20181114053837.GA15086@redhat.com>
 <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com> <20181116091458.GA17267@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
Date:   Fri, 16 Nov 2018 10:40:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116091458.GA17267@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 10:14 AM, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 12:46:05PM -0500, Mike Snitzer wrote:
>> Whether or not ANA is present is a choice of the target implementation;
>> the host (and whether it supports multipathing) has _zero_ influence on
>> this.  If the target declares a path as 'inaccessible' the path _is_
>> inaccessible to the host.  As such, ANA support should be functional
>> even if native multipathing is not.
>>
>> Introduce ability to always re-read ANA log page as required due to ANA
>> error and make current ANA state available via sysfs -- even if native
>> multipathing is disabled on the host (e.g. nvme_core.multipath=N).
> 
> The first part I could see, but I still want to make it conditional
> in some way as nvme is going into deeply embedded setups, and I don't
> want to carry the weight of the ANA code around for everyone.
> 
Can you clarify this a bit?
We _do_ have the NVME multipath config option to deconfigure the whole 
thing during compile time; that isn't influenced with this patch.
So are you worried about the size of the ANA implementation itself?
Or are you worried about the size of the ANA structures?

> The second I fundamentally disagree with.  And even if you found agreement
> it would have to be in a separate patch as it is a separate feature.
> 
Why? Where's the problem with re-reading the ANA log pages if we get an 
event indicating that we should?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
