Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C04C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EEC2082F
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeLPQJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:09:57 -0500
Received: from verein.lst.de ([213.95.11.211]:57766 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbeLPQJ5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:09:57 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7F77C68DD3; Sun, 16 Dec 2018 17:09:55 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:09:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/2] blk-mq-debugfs: support rq_qos
Message-ID: <20181216160955.GA9957@lst.de>
References: <20181214113926.7451-1-ming.lei@redhat.com> <20181214113926.7451-2-ming.lei@redhat.com> <1544814707.185366.425.camel@acm.org> <68f580d7-b704-c4cf-dbca-558ad5b5ea98@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68f580d7-b704-c4cf-dbca-558ad5b5ea98@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 09:04:37AM -0700, Jens Axboe wrote:
> It would fit better with the style in that code do to:
> 
> rqos = q->rq_qos;
> while (rqos) {
>     ....
>     rqos = rqos->next;
> }

But that is just a really strangly written for loop to start with..

Maybe Bart need to send a cleanup patch for the whole file, especially
given that this patch has been applied already.
