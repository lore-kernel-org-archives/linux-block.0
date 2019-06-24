Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF99DC43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 08:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959812089F
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 08:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfFXIoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:44:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFXIoX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 04:44:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 485AF31628FA;
        Mon, 24 Jun 2019 08:44:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B0AC1001B01;
        Mon, 24 Jun 2019 08:43:57 +0000 (UTC)
Date:   Mon, 24 Jun 2019 16:43:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] block: null_blk: introduce module parameter of
 'g_host_tags'
Message-ID: <20190624084351.GA10941@ming.t460p>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-3-ming.lei@redhat.com>
 <2f592878-4381-b6bb-2023-200a7df7093c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f592878-4381-b6bb-2023-200a7df7093c@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 24 Jun 2019 08:44:23 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 31, 2019 at 08:39:04AM -0700, Bart Van Assche wrote:
> On 5/30/19 7:27 PM, Ming Lei wrote:
> > +static int g_host_tags = 0;
> 
> Static variables should not be explicitly initialized to zero.

OK

> 
> > +module_param_named(host_tags, g_host_tags, int, S_IRUGO);
> > +MODULE_PARM_DESC(host_tags, "All submission queues share one tags");
>                                                             ^^^^^^^^
> Did you perhaps mean "one tagset"?

tagset means one set of tags, here all submission queues share one
single tag space(tags), see 'struct blk_mq_tags'.


thanks, 
Ming
