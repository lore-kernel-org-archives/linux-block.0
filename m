Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF38C38145
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 11:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIBLAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 07:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiIBLAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 07:00:32 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E75C3FA1E;
        Fri,  2 Sep 2022 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1662116430; x=1693652430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+NMpbPFe8fp8R+B93WiLknkoUnpXkg4bwQ8Cau7P/jw=;
  b=eUT3bNHxAbf3EzctDr+zA5d6Z4YI73334F2O5qejKqg7rKmlHlG1RqcR
   Q7GFw2Us3C1uySQyH5MoWE3btt8BYlBBPQ9NB4nuF+idKgMVWkFnSXkrT
   xeLkzvatBQ/O4HUf+wn1ImNmXyf3yQctZZcInR/xi3Ng+3fwRG0jllDBI
   E=;
X-IronPort-AV: E=Sophos;i="5.93,283,1654560000"; 
   d="scan'208";a="222899704"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:00:13 +0000
Received: from EX13D05EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com (Postfix) with ESMTPS id 30D8345037;
        Fri,  2 Sep 2022 11:00:12 +0000 (UTC)
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D05EUB003.ant.amazon.com (10.43.166.253) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 2 Sep 2022 11:00:10 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.38 via Frontend Transport; Fri, 2 Sep 2022 11:00:09 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id D42F2275A; Fri,  2 Sep 2022 11:00:07 +0000 (UTC)
Date:   Fri, 2 Sep 2022 11:00:07 +0000
From:   Maximilian Heyne <mheyne@amazon.de>
To:     SeongJae Park <sj@kernel.org>
CC:     <jgross@suse.com>, <roger.pau@citrix.com>,
        <marmarek@invisiblethingslab.com>,
        <xen-devel@lists.xenproject.org>, <axboe@kernel.dk>,
        <ptyadav@amazon.de>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] xen-blk{front, back}: Fix the broken semantic and
 flow of feature-persistent
Message-ID: <20220902110007.GA100460@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
References: <20220831165824.94815-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831165824.94815-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 31, 2022 at 04:58:21PM +0000, SeongJae Park wrote:
> Changes from v1
> (https://lore.kernel.org/xen-devel/20220825161511.94922-1-sj@kernel.org/)
> - Fix the wrong feature_persistent caching position of blkfront
> - Set blkfront's feature_persistent field setting with simple '&&'
>   instead of 'if' (Pratyush Yadav)
> 
> This patchset fixes misuse of the 'feature-persistent' advertisement
> semantic (patches 1 and 2), and the wrong timing of the
> 'feature_persistent' value caching, which made persistent grants feature
> always disabled.
> 
> SeongJae Park (3):
>   xen-blkback: Advertise feature-persistent as user requested
>   xen-blkfront: Advertise feature-persistent as user requested
>   xen-blkfront: Cache feature_persistent value before advertisement
> 
>  drivers/block/xen-blkback/common.h |  3 +++
>  drivers/block/xen-blkback/xenbus.c |  6 ++++--
>  drivers/block/xen-blkfront.c       | 20 ++++++++++++--------
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> --
> 2.25.1
> 

I've tested this patch series in the following ways:
* Only applied the blkback patch but not the blkfront patches
* Only applied the blkfront patches but not the blkback patch
* Applied both

All scenarios worked, so

Tested-by: Maximilian Heyne <mheyne@amazon.de>

Actually I also wanted to test changing feature_persistent and try reconnecting
but I don't know how this is done. If anyone has a pointer here, I could test
that as well.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



