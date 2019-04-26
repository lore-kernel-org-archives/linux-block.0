Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92248C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBDF2077B
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfDZOtp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:49:45 -0400
Received: from verein.lst.de ([213.95.11.211]:46354 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZOtp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 10:49:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 753FB68BFE; Fri, 26 Apr 2019 16:49:28 +0200 (CEST)
Date:   Fri, 26 Apr 2019 16:49:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V3 1/3] lib/sg_pool.c: improve APIs for allocating sg
 pool
Message-ID: <20190426144928.GA18339@lst.de>
References: <20190426005346.27962-1-ming.lei@redhat.com> <20190426005346.27962-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426005346.27962-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 08:53:44AM +0800, Ming Lei wrote:
> Introduces __sg_alloc_table_chained() and __sg_free_table_chained() with
> one extra parameter to specify size of the pre-allocated SGL, then the
> 'first_chunk' SGL can include any number of entries.

Can you just update the existing sg_alloc_table_chained and
sg_free_table_chained chained instead?  We only have a handful users
of them in total, and most of them should eventually use your new
semantics anyway.
