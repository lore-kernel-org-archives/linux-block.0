Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32435C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0714B214F1
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0714B214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbeKOBwq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:52:46 -0500
Received: from verein.lst.de ([213.95.11.211]:35778 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732950AbeKOBwq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:52:46 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A318868CF7; Wed, 14 Nov 2018 16:48:57 +0100 (CET)
Date:   Wed, 14 Nov 2018 16:48:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Block <bblock@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com, ooo@electrozaur.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] bsg-lib: handle bidi requests without block layer
 help
Message-ID: <20181114154857.GA28985@lst.de>
References: <20181111133211.13926-1-hch@lst.de> <20181111133211.13926-7-hch@lst.de> <20181113143520.GB7222@w530-pk1mzal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113143520.GB7222@w530-pk1mzal>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 13, 2018 at 03:35:20PM +0100, Benjamin Block wrote:
> This seems like a non-obvious user-breakage. So apart from removing the
> in-kernel stuff that uses bidirectional commands you also forbid
> userspace from every using them? That seems wrong to me.
> 
> There is other SCSI Command Sets than OSD that provide bidirectional
> commands, even SBC has some (i.e.  X*WRITE*, COMPARE AND WRITE).

Yes, there are a few.  But the only driver that even supports them
right now is iscsi_tcp to start with, and we have to drag a significant
amount of code around just to support this corner case.
