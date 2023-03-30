Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7D6C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 17:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjC3Rzh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjC3Rzf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 13:55:35 -0400
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [IPv6:2001:41d0:1004:224b::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C39DCA30
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 10:55:31 -0700 (PDT)
Date:   Thu, 30 Mar 2023 13:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680198929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPNJJiq4961Alex7wQuB9qz7b+RqDrA7sJot4b5JPCY=;
        b=u6UMhIg/xEzp2vBN3rKqogxCAl7TFQsZEJYnKjGtnkWRaFbBjMQ4xxuRANBOMqYc4Z7gNK
        BcAVOewzeCnqa4h1D2kfMiXeb1OScqJNzflLOLJrJf52cZbGFl5CexDdB/QohKoWoLS4QK
        pDiEozbTfDu45VmH4hb4k7eLukgq6r4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] block: Rework bio_for_each_segment_all()
Message-ID: <ZCXNDQ6Eslhj+9g5@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-2-kent.overstreet@linux.dev>
 <52a5bd5c-d3a1-71d7-e1e5-7965501818bd@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a5bd5c-d3a1-71d7-e1e5-7965501818bd@squashfs.org.uk>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 29, 2023 at 05:50:27PM +0100, Phillip Lougher wrote:
> There is a problem with the above code, on testing I get the following
> results:
> 
> Index 78018785329, offset 49, bvec.bv_len 1024: In same bio, metadata length
> 32780

Could you share how you're doing your testing? I set up a basic test
(created images using every compression type, tested reading them) and
so far I'm not able to reproduce this.
