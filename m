Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DB8C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 10:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CEE22419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 10:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CEE22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbeKNUjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:39:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:46666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbeKNUjP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 15:39:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DE2AB015;
        Wed, 14 Nov 2018 10:36:33 +0000 (UTC)
Message-ID: <3ade435ef087d61a293863a62c1b794ecf8dba14.camel@suse.de>
Subject: Re: [dm-devel] multipath-tools: add ANA support for NVMe device
From:   Martin Wilck <mwilck@suse.de>
To:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>, axboe@kernel.dk,
        hch@lst.de, Mike Snitzer <snitzer@redhat.com>
Cc:     xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        lijie <lijie34@huawei.com>, shenhong09@huawei.com,
        wangzhoumengjian@huawei.com, linux-nvme@lists.infradead.org,
        sschremm@netapp.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Nov 2018 11:36:31 +0100
In-Reply-To: <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com>
         <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
         <20181112215323.GA7983@redhat.com>
         <20181113161838.GC9827@localhost.localdomain>
         <20181113180008.GA12513@redhat.com> <20181114053837.GA15086@redhat.com>
         <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-11-14 at 08:49 +0100, Hannes Reinecke wrote:
> On 11/14/18 6:38 AM, Mike Snitzer wrote:
> > 
> > Not holding my breath BUT:
> > if decoupling the reading of ANA state from native NVMe
> > multipathing
> > specific work during nvme request completion were an acceptable
> > advancement I'd gladly do the work.
> > 
> I'd be happy to work on that, given that we'll have to have 'real'
> ANA 
> support for device-mapper anyway for SLE12 SP4 etc.

So, what's the way ahead for multipath-tools? 

Given that, IIUC, at least one official kernel (4.19) has been released
with ANA support but without the ANA sysfs attributes exported to user
space, multipath-tools can't rely on them being present. I for one have
no issue with copying code from nvme-cli and doing NVMe ioctls from
multipath-tools, as in Lijie's patch. When those sysfs attributes are
added (and work as expected), we will use them, but IMO we'll need to
fall back to ioctls until then, and also afterwards, because we can't
assume to be always running on the latest kernel.

Best,
Martin


