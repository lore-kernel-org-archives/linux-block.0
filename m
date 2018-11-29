Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A1C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 08:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0EC20834
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 08:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0EC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeK2TRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:17:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeK2TRH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 14:17:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E708630001E8;
        Thu, 29 Nov 2018 08:12:35 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B052661520;
        Thu, 29 Nov 2018 08:12:26 +0000 (UTC)
Date:   Thu, 29 Nov 2018 16:12:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
Message-ID: <20181129081214.GD23249@ming.t460p>
References: <20181126165430.4519-1-keith.busch@intel.com>
 <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
 <20181128021959.GG11128@ming.t460p>
 <20181128070010.GA20369@lst.de>
 <20181128100659.GA16495@ming.t460p>
 <20181128100848.GA23567@lst.de>
 <20181129021521.GB23390@ming.t460p>
 <yq1woowzjwv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1woowzjwv.fsf@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 29 Nov 2018 08:12:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 09:39:44PM -0500, Martin K. Petersen wrote:
> 
> Ming,
> 
> > On Wed, Nov 28, 2018 at 11:08:48AM +0100, Christoph Hellwig wrote:
> >> On Wed, Nov 28, 2018 at 06:07:01PM +0800, Ming Lei wrote:
> >> > > Is this the nvme target on top of null_blk?
> >> > 
> >> > Yes.
> >> 
> >> And it goes away if you revert just the last patch?
> >
> > Today I run this test again and can't reproduce it any more.
> >
> > So maybe not a new issue, and it is just triggered in yesterday's
> > for-4.21/block, :-)
> 
> Can you reproduce with yesterday's tree then?
> 
> I'm obviously a bit concerned about merging something without knowing
> the cause of the problems you were seeing.

Hi Martin,

The panic is triggered on my auto daily test on yesterday's
for-4.21/block.

It isn't triggered in today's for-4.21/block. Also not triggered any more
when I run same test again on yesterday's for-4.21/block(5f0ed774ed29).


Thanks,
Ming
