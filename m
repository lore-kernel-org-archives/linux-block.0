Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC5C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 19:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0DC2080D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 19:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0DC2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeKQFls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:41:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbeKQFlr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Nov 2018 00:41:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FCD2306B58C;
        Fri, 16 Nov 2018 19:28:06 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4131219C7D;
        Fri, 16 Nov 2018 19:28:03 +0000 (UTC)
Date:   Fri, 16 Nov 2018 14:28:02 -0500
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
Message-ID: <20181116192802.GA30057@redhat.com>
References: <20181114053837.GA15086@redhat.com>
 <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com>
 <20181116091458.GA17267@lst.de>
 <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
 <20181116094947.GA19296@lst.de>
 <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de>
 <20181116101752.GA21531@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116101752.GA21531@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 16 Nov 2018 19:28:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16 2018 at  5:17am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Nov 16, 2018 at 11:06:32AM +0100, Hannes Reinecke wrote:
> > Ok, so would you be happy with making ANA support configurable?
> 
> I've looked a bit over the whole situation, and what I think we need
> to do is:
> 
>  a) warn if we see a ANA capable device without multipath support
>     so people know it is not going to work properly.

I disagree with your cynicism but v2 of this patch now emits a warning
accordingly.

>  b) deprecate the multipath module option.  It was only intended as
>     a migration for any pre-existing PCIe multipath user if there
>     were any, not to support any new functionality.  So for 4.20
>     put in a patch that prints a clear warning when it is used,
>     including a link to the nvme list, and then for 4.25 or so
>     remove it entirely unless something unexpected come up.

You rejected the idea of allowing fine-grained control over whether
native NVMe multipathing is enabled or not on a per-namespace basis.
All we have is the coarse-grained nvme_core.multipath=N knob.  Now
you're forecasting removing even that.  Please don't do that.

> This whole drama of optional multipath use has wasted way too much
> of everyones time already.

It has wasted _way_ too much time.

But the drama is born out of you rejecting that we need to preserve
multipath-tools and dm-multipath's ability to work across any
transport.  You don't need to do that work: Hannes, myself and others
have always been willing and able -- if you'd let us.

IIRC it was at 2016's LSF in Boston where Ewan Milne and I had a
face-to-face conversation with you in the hallway track where you agreed
that ANA support would be activated if the capability was advertised by
the target.  The model we discussed is that it would be comparable to
how ALUA gets enabled during SCSI LUN discovery.

I hope you can see your way forward to be more accommodating now.
Especially given the proposed changes are backed by NVMe standards.

Please, PLEASE take v2 of this patch.. please? ;)

Thanks,
Mike
