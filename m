Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCF1C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 15:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjHJP6l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjHJP6l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 11:58:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39BF270E
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 08:58:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E7A367373; Thu, 10 Aug 2023 17:58:36 +0200 (CEST)
Date:   Thu, 10 Aug 2023 17:58:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Chuck Lever <cel@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH RFC] block: Revert 615939a2ae73
Message-ID: <20230810155835.GF28000@lst.de>
References: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net> <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk> <20230809161105.GA2304@lst.de> <9BADCC53-72E9-44FB-80C8-CEBC9897809D@oracle.com> <20230809214913.GA9902@lst.de> <86ce2299-ce42-c0bb-e577-9d23f8af494c@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ce2299-ce42-c0bb-e577-9d23f8af494c@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 11:42:50AM +0800, Chengming Zhou wrote:
> Christoph, it would be very helpful if you share some thoughts
> and directions.

I am not quite sure where the problems could even be.  I think the
interesting aspects are:

 - we are not directly processing through the normal submission path
   instead of adding the command to the flush_data_in_flight list and
   then going through blk_kick_flush.  So a command now gets executed
   earlier than it did before.

 - given that it only happens with SATA, it must be in some way related
   to the fact that ATA flush commands are not queud, that is when a
   flush is outstanding no other command can't.

