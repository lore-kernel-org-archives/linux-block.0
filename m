Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17C6C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 10:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BA8208E7
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 10:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BA8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLGKUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:20:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGKUM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 05:20:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A21B3078AB5;
        Fri,  7 Dec 2018 10:20:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82E145D9D6;
        Fri,  7 Dec 2018 10:20:05 +0000 (UTC)
Date:   Fri, 7 Dec 2018 18:20:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Subject: Re: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in
 blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
Message-ID: <20181207101959.GF29027@ming.t460p>
References: <1543943674.185366.194.camel@acm.org>
 <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
 <20181206003323.GB3015@ming.t460p>
 <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 07 Dec 2018 10:20:12 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 11:15:13AM +0530, Kashyap Desai wrote:
> >
> > If the 'tag' passed to scsi_host_find_tag() is valid, I think there
> > shouldn't have such issue.
> >
> > If you want to find outstanding IOs, maybe you can try
> > blk_mq_queue_tag_busy_iter()
> > or blk_mq_tagset_busy_iter(), because you may not know if the passed
> 'tag'
> > to
> > scsi_host_find_tag() is valid or not.
> 
> We tried quick change in mpt3sas driver using blk_mq_tagset_busy_iter and
> it returns/callback for valid requests (no stale entries are returned).
> Expected.
> Above two APIs are only for blk-mq.  What about non-mq case ? Driver
> should use scsi_host_find_tag for non-mq and blk_mq_tagset_busy_iter for
> blk-mq case ?

But your patch is only for blk-mq, is there same issue on non-mq case?

Thanks,
Ming
