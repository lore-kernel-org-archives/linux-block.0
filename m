Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBD3C433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Apr 2022 01:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiDQB0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Apr 2022 21:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiDQB0Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Apr 2022 21:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 967366D84F
        for <linux-block@vger.kernel.org>; Sat, 16 Apr 2022 18:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650158625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z781wwa86GLbmKos8zoVf/9OVyjd0hUDM1gXB0rozMo=;
        b=hJN4jhr3tU0OqRnz5IbvbCQ07HV2ojE+8z5KlJIXlTB9OO06BgVzCOFZZjebzLi8r66UC9
        LYcRAjiwzPqRHzfzJCQrN1KZ134NA6qqn4J87I3v7r6B/hheJtZonVfdPepTAjMuJDmxhd
        bMZ8F1CRUaEh7oIT667IOb0r6ztzRCc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-kqOvaoRmOzCOBVX9mLuQrg-1; Sat, 16 Apr 2022 21:23:44 -0400
X-MC-Unique: kqOvaoRmOzCOBVX9mLuQrg-1
Received: by mail-qk1-f197.google.com with SMTP id j12-20020ae9c20c000000b0069e8ac6b244so350659qkg.1
        for <linux-block@vger.kernel.org>; Sat, 16 Apr 2022 18:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z781wwa86GLbmKos8zoVf/9OVyjd0hUDM1gXB0rozMo=;
        b=5sRa0FoGz4TvALCaBmABTklsy996hc8kxT0KozCo6l/0J6zEnK47ywZXV1geO5q7Yp
         6GN0ZGcAFKh8T4Hn3Rsf7+7g/soa33AbINqmU2PGA4fNseFWYAgpJfnOuhHpbKaHTgp0
         yci2gekYVDcqrAxDFBbO2ZlWGsvWYo/NfrSZujNBZFnwFYqFRUDKpOy2FOvBJF7FEwGo
         bRMR6L5jOaus6XMacWxO+7TlMKE6NG8IuV23/OCBSBuP6Yw81aplkxV3f6cow+yI/u/B
         +WhwyHFz1DwBdhACJ1aBm/i77oiG0MNuA3yympzwjsq7be4QCuHEJu4u5ay8qQ8GrSW9
         +paw==
X-Gm-Message-State: AOAM533ClZRZHdQ6MbeYPdZk2P2gkGMRP4F1NBaJ1+b8oEQ0qPaayxQb
        gN//5kIp+44LvdX2IbNG2uXyl2BJp3uG3YhZR9Qq237p7YjIBXxncuIYtX7g35NmCkk2+Jua0nA
        yO2vaj2c5+Vp94p12X1ocKQ==
X-Received: by 2002:a37:a8c3:0:b0:69e:5f25:3e60 with SMTP id r186-20020a37a8c3000000b0069e5f253e60mr3271080qke.58.1650158624172;
        Sat, 16 Apr 2022 18:23:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOQPbh4MUU/ec5E4VsecUK//kjDs1uWZh8pE6kTcSF5wGD/nyzJOW0hcWXcCR0DeC0WTSFZQ==
X-Received: by 2002:a37:a8c3:0:b0:69e:5f25:3e60 with SMTP id r186-20020a37a8c3000000b0069e5f253e60mr3271072qke.58.1650158623960;
        Sat, 16 Apr 2022 18:23:43 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id c20-20020a05622a025400b002e1dd71e797sm5648762qtx.15.2022.04.16.18.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 18:23:43 -0700 (PDT)
Date:   Sat, 16 Apr 2022 21:23:41 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/8] dm: io accounting & polling improvement
Message-ID: <YltsHc7lrGMzEEy1@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <YlWzoj+M1ykUubH+@redhat.com>
 <YlpbGbtc5NwD64KH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlpbGbtc5NwD64KH@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 16 2022 at  1:58P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Apr 12, 2022 at 01:15:14PM -0400, Mike Snitzer wrote:
> > I'll review this closely but, a couple weeks ago, I queued up quite a
> > lot of conflicting changes for 5.19 here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19
> 
> Can you please end them out to the device mapper list for review?

Yes, no problem. I brought my various earlier changes to the front,
dropped my changes for removing dm_io refcounting for normal r/w IO
(still visible in 'dm-5.19-v1'), and rebased Ming's series (now
visible in 'dm-5.19-v2').

Common: https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19
Old: https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19-v1
New: https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19-v2

I'll clean up the 'dm-5.19-v2' series further and likely post to the
list on Tuesday.

I discussed with Jens and we'll both be rebasing our 5.19 trees to
v5.18-rc3. dm will be rebasing on block (I can fix up Ming's patch for
bdev_{start,end}_io_acct based on your review and Jens can then pick
it up from the first patch in the series I post).

Mike

