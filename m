Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4575C433E1
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C3622C9C
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgGTNiv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:38:51 -0400
Received: from verein.lst.de ([213.95.11.211]:47004 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgGTNiu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 09:38:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B2BF68BFE; Mon, 20 Jul 2020 15:38:49 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:38:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] fs: fix kiocb ki_complete interface
Message-ID: <20200720133849.GA3342@lst.de>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com> <20200720132118.10934-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720132118.10934-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 20, 2020 at 10:21:17PM +0900, Johannes Thumshirn wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> The res and res2 fields of struct io_event are signed 64 bits values
> (__s64 type). Allow the ki_complete method of struct kiocb to set 64
> bits values in these fields by changin its interface from the long type
> to long long.

Which doesn't help if the consumers can't deal with these values.
But that shouldn't even be required for using zone append anyway..
