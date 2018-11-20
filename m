Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4996AC32789
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFD4206BB
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFD4206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeKUCxl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:53:41 -0500
Received: from verein.lst.de ([213.95.11.211]:46200 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeKUCxl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 21:53:41 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C20F268B03; Tue, 20 Nov 2018 17:23:43 +0100 (CET)
Date:   Tue, 20 Nov 2018 17:23:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        shenhong09@huawei.com, dm-devel@redhat.com,
        wangzhoumengjian@huawei.com, christophe.varoqui@opensvc.com,
        bmarzins@redhat.com, sschremm@netapp.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nvme: allow ANA support to be independent of native
 multipathing
Message-ID: <20181120162343.GB2774@lst.de>
References: <20181116091458.GA17267@lst.de> <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de> <20181116094947.GA19296@lst.de> <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de> <20181116101752.GA21531@lst.de> <20181116192802.GA30057@redhat.com> <20181119093938.GA11757@lst.de> <20181119145650.GB13470@redhat.com> <20181120094201.GB7742@lst.de> <20181120133719.GB18991@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120133719.GB18991@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 20, 2018 at 08:37:19AM -0500, Mike Snitzer wrote:
> This isn't how a Linux maintainer engages in technical discussion.

And this isn't a technical discussion.   As told before the only
reason to not build the multipath code is to save space, and
the only reason to disable multipath at runtime is for potential
pre-existing setups, which obviously are not ANA capable.

The right fix is to warn users if they use a driver without
CONFIG_NVME_MULTIPATH on a multi-port device and to phase out the
multipath=0 option in the long run, again with a warning.  Any new
additions to "improve" these cases simply don't make sense.
