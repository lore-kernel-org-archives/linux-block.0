Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF5C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 09:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCBJC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 04:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCBJCz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 04:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6273B868
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 01:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677747735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tm6wkEvcK5JOinYT3WE5vetqipJsQea+okdLlPIk/fo=;
        b=ITHPw2aCnOUsSNBpmrGPmVx51Ax56MwMDJHdX6mxx6BnZOMdWkZDY74recyr+dmt4uvjwy
        7ZF3icoDDEU9sWL2dWE4BZ+GWhJzYlaiCr5x0SrIQvGKVVbdPo4P1cK4C/NUr/TMRijaxi
        qtljctURg5eI42Cx4Lto5HjZXni3Now=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-DwMHQBfBPS2cTVqN8eUdXg-1; Thu, 02 Mar 2023 04:02:10 -0500
X-MC-Unique: DwMHQBfBPS2cTVqN8eUdXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61C93887400;
        Thu,  2 Mar 2023 09:02:10 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02621400EA93;
        Thu,  2 Mar 2023 09:01:58 +0000 (UTC)
Date:   Thu, 2 Mar 2023 17:01:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Message-ID: <ZABmAR6Du1tUVEa7@T590>
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZABfFW+28Jlxq+Ew@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
> On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
> > 

...

> > 
> > I agree about fetching more zones. However, it is no good to fetch up to
> > a max, since the requested zone report may less than max. I was
> 
> Short read should always be supported, so the interface may need to 
> return how many zones in single command, please refer to nvme_ns_report_zones().

blk_zone is part of uapi, maybe the short read can be figured out by
one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
reporting zones.


thanks,
Ming

