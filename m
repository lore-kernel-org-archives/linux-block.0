Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9B7C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 06:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E529E20870
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 06:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgEHGpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 02:45:33 -0400
Received: from verein.lst.de ([213.95.11.211]:50727 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgEHGpd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 02:45:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D163268B05; Fri,  8 May 2020 08:45:30 +0200 (CEST)
Date:   Fri, 8 May 2020 08:45:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Coly Li <colyli@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: Need part_in_flight() to be non-static
Message-ID: <20200508064530.GA29430@lst.de>
References: <005a742e-380e-da51-d17e-072221871330@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005a742e-380e-da51-d17e-072221871330@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 02:41:23PM +0800, Coly Li wrote:
> Is is possible to convert part_in_flight() to be non-static back ? If it
> is not possible, is there any other routines I can use to make
> part_round_stats_single() working ?

No.  Convert the driver to blk-mq and submit it upstream if you care
enough.
