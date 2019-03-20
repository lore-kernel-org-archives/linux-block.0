Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5486EC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE162184D
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 11:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfCTLrg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:47:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727673AbfCTLrg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84ED2AC6C;
        Wed, 20 Mar 2019 11:47:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 408661E4255; Wed, 20 Mar 2019 12:47:34 +0100 (CET)
Date:   Wed, 20 Mar 2019 12:47:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>,
        Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block_dev: fix crash on chained bios with O_DIRECT
Message-ID: <20190320114734.GB9485@quack2.suse.cz>
References: <20190320081253.129688-1-hare@suse.de>
 <9cec723b-d0d0-859f-37c2-bfdccb898071@suse.de>
 <e9953e6c-fd4c-cde5-976e-a5831d7c79a3@suse.com>
 <abd08aa4-f5fd-8ed1-1ae2-9987f6a43dc7@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd08aa4-f5fd-8ed1-1ae2-9987f6a43dc7@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 20-03-19 09:53:10, Johannes Thumshirn wrote:
> On 20/03/2019 09:51, Hannes Reinecke wrote:
> > Yeah, should work, too.
> > But we should be calling bio_uninit() for all bios.
> 
> Yup, probably.
> 
> > Will you be sending an updated patch?
> 
> Let's wait what other's thing first.

FWIW I'm OK with either solution. Yours seems a bit more future-proof so I
like it a bit more.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
