Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A1C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 14:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2C52087C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 14:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2C52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeKQAZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:25:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbeKQAZI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 19:25:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E3ED169739;
        Fri, 16 Nov 2018 14:12:34 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD075611C3;
        Fri, 16 Nov 2018 14:12:30 +0000 (UTC)
Date:   Fri, 16 Nov 2018 09:12:29 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        shenhong09@huawei.com, dm-devel@redhat.com,
        wangzhoumengjian@huawei.com, christophe.varoqui@opensvc.com,
        bmarzins@redhat.com, sschremm@netapp.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nvme: allow ANA support to be independent of native multipathing
Message-ID: <20181116141229.GC28870@redhat.com>
References: <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <20181113180008.GA12513@redhat.com>
 <20181114053837.GA15086@redhat.com>
 <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com>
 <20181116091458.GA17267@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116091458.GA17267@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 16 Nov 2018 14:12:34 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16 2018 at  4:14am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Nov 15, 2018 at 12:46:05PM -0500, Mike Snitzer wrote:
> > Whether or not ANA is present is a choice of the target implementation;
> > the host (and whether it supports multipathing) has _zero_ influence on
> > this.  If the target declares a path as 'inaccessible' the path _is_
> > inaccessible to the host.  As such, ANA support should be functional
> > even if native multipathing is not.
> > 
> > Introduce ability to always re-read ANA log page as required due to ANA
> > error and make current ANA state available via sysfs -- even if native
> > multipathing is disabled on the host (e.g. nvme_core.multipath=N).
> 
> The first part I could see, but I still want to make it conditional
> in some way as nvme is going into deeply embedded setups, and I don't
> want to carry the weight of the ANA code around for everyone.

So disabling CONFIG_NVME_MULTIPATH isn't adequate?  You see a need for
enabling CONFIG_NVME_MULTIPATH but disallowing consideration of ANA
state management for these embedded cases?  That doesn't make much sense
in that ANA won't be enabled on the target, and if it is then shouldn't
the NVMe host enable ANA support?
 
> The second I fundamentally disagree with.  And even if you found agreement
> it would have to be in a separate patch as it is a separate feature.

In a later mail you clarified that by "second" you meant the sysfs
export.

nvme_ns_id_attrs_are_visible() calls nvme_ctrl_use_ana() to know whether
to export the ana state via sysfs.  Makes no sense to enable ANA to
work, independent of native multipathing, and then even though ANA is
active disallow exporting the associated ANA state.  We need
consistency.. if the sysfs file exists it means ANA state is being
managed.

All I can figure is that what you're suggesting is born out of
disallowing uses you fundamentally disagree with (e.g. multipath-tools
reading the ANA state from this sysfs file).

Mike
