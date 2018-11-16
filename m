Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5BBC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4812087A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4812087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeKPT0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:26:25 -0500
Received: from verein.lst.de ([213.95.11.211]:48196 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeKPT0Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 14:26:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1810A68D60; Fri, 16 Nov 2018 10:14:58 +0100 (CET)
Date:   Fri, 16 Nov 2018 10:14:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        shenhong09@huawei.com, dm-devel@redhat.com,
        wangzhoumengjian@huawei.com, christophe.varoqui@opensvc.com,
        bmarzins@redhat.com, sschremm@netapp.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: allow ANA support to be independent of native
 multipathing
Message-ID: <20181116091458.GA17267@lst.de>
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com> <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com> <20181112215323.GA7983@redhat.com> <20181113161838.GC9827@localhost.localdomain> <20181113180008.GA12513@redhat.com> <20181114053837.GA15086@redhat.com> <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de> <20181114174746.GA18526@redhat.com> <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de> <20181115174605.GA19782@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115174605.GA19782@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:46:05PM -0500, Mike Snitzer wrote:
> Whether or not ANA is present is a choice of the target implementation;
> the host (and whether it supports multipathing) has _zero_ influence on
> this.  If the target declares a path as 'inaccessible' the path _is_
> inaccessible to the host.  As such, ANA support should be functional
> even if native multipathing is not.
> 
> Introduce ability to always re-read ANA log page as required due to ANA
> error and make current ANA state available via sysfs -- even if native
> multipathing is disabled on the host (e.g. nvme_core.multipath=N).

The first part I could see, but I still want to make it conditional
in some way as nvme is going into deeply embedded setups, and I don't
want to carry the weight of the ANA code around for everyone.

The second I fundamentally disagree with.  And even if you found agreement
it would have to be in a separate patch as it is a separate feature.
