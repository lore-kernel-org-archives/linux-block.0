Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7172C001E0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 14:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjHJOsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjHJOsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6C211C
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691678846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZfBQqwYZwDy7AS4zOLhF6hi2Hsl9Nr/pxSmeJlJBgQ=;
        b=h3A9LAjWYKmPTLRO4yPQAT7tMVWsyyslElHf/NhK2FL4cwY0dLucPV3gb8C949daVem1Rv
        5Q6hPvLxbuw7EGvyNlqWsfM48iW7fR3L5mdfwNamSfBp0vp0OiIz38BgzQSmFCWioy5N2j
        FWL3alyV+TnWC83XPFV3UK2CJuHY7WU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-roNj9TVIPRmFTbF2c2YNIw-1; Thu, 10 Aug 2023 10:47:23 -0400
X-MC-Unique: roNj9TVIPRmFTbF2c2YNIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA2A0856DED;
        Thu, 10 Aug 2023 14:47:22 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 855BB2026D68;
        Thu, 10 Aug 2023 14:47:19 +0000 (UTC)
Date:   Thu, 10 Aug 2023 22:47:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Message-ID: <ZNT4cjB7bh4jDaNl@fedora>
References: <20230810124326.321472-1-ming.lei@redhat.com>
 <ZNThwMBAqqVUGtek@x1-carbon>
 <ZNTtbpNCiXPvRlvI@fedora>
 <ZNTytlego591Zmin@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNTytlego591Zmin@x1-carbon>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 02:22:50PM +0000, Niklas Cassel wrote:
> On Thu, Aug 10, 2023 at 10:00:14PM +0800, Ming Lei wrote:
> > On Thu, Aug 10, 2023 at 01:10:30PM +0000, Niklas Cassel wrote:
> > > On Thu, Aug 10, 2023 at 08:43:26PM +0800, Ming Lei wrote:
> 
> (snip)
>  
> > UBLK_IO_OP_ZONE_* is part of ublk UAPI, but REQ_OP_ZONE_* is just kernel
> > internal definition which may be changed time by time, so we can't use
> > REQ_OP_ZONE_* directly.
> > 
> > Here you can think of UBLK_IO_OP_ZONE_* as interface between driver and
> > hardware, so UBLK_IO_OP_ZONE_* has to be defined independently.
> > 
> > > but if you want to keep this pattern, then perhaps you want
> > > to define UBLK_IO_OP_ZONE_RESET_ALL to 17.
> > 
> > Why do you think that 17 is better than 14?
> 
> I never said that it was better :)
> I even said: "I don't see any obvious advantage of keeping them the same" :)

OK, maybe I misunderstood your point.

> 
> Just that it would follow the existing pattern of keeping
> UBLK_IO_OP_ZONE_* in sync with REQ_OP_ZONE_*.

No matter 14 or 17, it does sync with REQ_OP_ZONE_*, even though it
isn't necessary to do so.

Then your all comment on this patch should be addressed, right?

> 
> 
> > 
> > I'd rather use 14 to fill the hole, meantime the two ZONE_RESET OPs
> > can be kept together.
> 
> Ok, but then, considering that UBLK_IO_OP_ZONE_* is not part of any official
> kernel release, and that the highest UBLK_IO_OP is currently defined as 5:

I don't think it is necessary, see below.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/ublk_cmd.h?h=v6.5-rc5#n237
> 
> why not define:
> +#define		UBLK_IO_OP_ZONE_OPEN		6
> +#define		UBLK_IO_OP_ZONE_CLOSE		7
> +#define		UBLK_IO_OP_ZONE_FINISH		8
> +#define		UBLK_IO_OP_ZONE_APPEND		9
> +#define		UBLK_IO_OP_ZONE_RESET		10
> +#define		UBLK_IO_OP_ZONE_RESET_ALL	11
> 
> instead of, like it currently is in linux-block/for-next (this patch included):
> 
> +#define		UBLK_IO_OP_ZONE_OPEN		10
> +#define		UBLK_IO_OP_ZONE_CLOSE		11
> +#define		UBLK_IO_OP_ZONE_FINISH		12
> +#define		UBLK_IO_OP_ZONE_APPEND		13
> +#define		UBLK_IO_OP_ZONE_RESET_ALL	14
> +#define		UBLK_IO_OP_ZONE_RESET		15
> 
> Because, even after this patch, you would still have a hole between
> UBLK_IO_OP_ value 5 and 10.

(5, 10) can be reserved for some more generic normal IOs, maybe new kind
of READ/WRITE, or whatever.

We have 256 OP available, which is big enough for future extend, and OP
code can be used from any offset, but still more readable to group them
according to their category. And it isn't big deal to use which number
for which command, what matters is that we can extend, and keep
compatible.


Thanks,
Ming

