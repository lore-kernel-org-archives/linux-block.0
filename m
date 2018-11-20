Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F175C04EBC
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 13:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4E206BB
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 13:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB4E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeKUAGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:06:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKUAGi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 19:06:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B0A213A90;
        Tue, 20 Nov 2018 13:37:27 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89ABD60157;
        Tue, 20 Nov 2018 13:37:20 +0000 (UTC)
Date:   Tue, 20 Nov 2018 08:37:19 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        shenhong09@huawei.com, dm-devel@redhat.com,
        wangzhoumengjian@huawei.com, christophe.varoqui@opensvc.com,
        bmarzins@redhat.com, sschremm@netapp.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nvme: allow ANA support to be independent of native multipathing
Message-ID: <20181120133719.GB18991@redhat.com>
References: <20181115174605.GA19782@redhat.com>
 <20181116091458.GA17267@lst.de>
 <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
 <20181116094947.GA19296@lst.de>
 <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de>
 <20181116101752.GA21531@lst.de>
 <20181116192802.GA30057@redhat.com>
 <20181119093938.GA11757@lst.de>
 <20181119145650.GB13470@redhat.com>
 <20181120094201.GB7742@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120094201.GB7742@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 20 Nov 2018 13:37:27 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 20 2018 at  4:42am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Nov 19, 2018 at 09:56:50AM -0500, Mike Snitzer wrote:
> > SO: will you be taking my v2 patch for 4.21 or not?
> 
> No.

This isn't how a Linux maintainer engages in technical discussion.

You _clearly_ just want to prevent further use of multipath-tools and
DM-multipath.  You will resort to rejecting a patch that improves the
NVMe driver's standards compliance if it allows you hijack NVMe
multipathing because you think you have the best way and nobody else
should be allowed to use a well established competing _open_ _Linux_
solution.  Simple as that.

You haven't made a single technical argument against my v2 patch, yet
you're rejecting it.  Purely on the basis that having NVMe's ANA updates
work independent on native NVMe multipathing happens to benefit an
alternative (and that benefit is just to not have multipath-tools to be
so crude with a pure userspace ANA state tracking).

Jens, this entire situation has gotten well beyond acceptable and you or
other NVMe co-maintainers need to step in.  We need reasoned _technical_
discussion or this entire process falls apart.

Mike
