Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3213ECAAA1
	for <linux-block@archiver.kernel.org>; Fri, 16 Sep 2022 18:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIPSEP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Sep 2022 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIPSEO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 14:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83338B6D21
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663351452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1Y0WCFyP/xwaopES4fLdWeNPtgD6wFT9927YdVHjxA=;
        b=R6UmTAooTjPGG1eD6g0Bl3UNXD0szNzqM3i7w6+WrWfrQ3JATrrWUcXZcdx7pQOAMwdEuh
        1lqdXt2ZnTOTQK0JGyVIC2qFSSdzG33wRTQ91OMNJaOkCvhJ1UYmVaLztATZYYDzYX+rBI
        pmLPNxGDqm9P9byOBnvdKXs8hz9kyCw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-baAkPmkxOVuZo4tH66GGoQ-1; Fri, 16 Sep 2022 14:04:11 -0400
X-MC-Unique: baAkPmkxOVuZo4tH66GGoQ-1
Received: by mail-qk1-f198.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso19297354qkp.21
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 11:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+1Y0WCFyP/xwaopES4fLdWeNPtgD6wFT9927YdVHjxA=;
        b=r9q+qgPjCS9+NM7USTROq4+MAa0xSQyddPlXXeJNCHLH+r45DMrkR/mUPcLI9Wczxl
         RI65V3y0meudBuy39HtsL4bE6dgd+IK1Y77i64GM6wxWZs/N0KBUw4JfYGksjgTVznPu
         yMXcs9wsIaUIONK1K/TE6ExVbTWXtfAY5KwRMMJrNX2D3QAlns9nllvzYoefWduy77ir
         3aI4vaJRZvAeKh5ChILmy4IbIWvmGLQtFhceHTQsVVHNedomNBsmy1JT8sdgzX3XAVIv
         FfiwvDtiRqq7OsAfoR2Xp++7cFwIZM273h73EIhzUQ7EU1Lyb6Uvy7/geIWfDbmJ7olM
         IHlA==
X-Gm-Message-State: ACrzQf3Zp2eO+xfrOX7fOwqAokTSvHFzoZy9y2cB9B66ZgutDUAR7/Vz
        r2D5ijrde1WANwafACepxOe0Mvjp5ON9bb69a7XyqQLcH6PrsapgEL4g70XuFQ4QQWz3c1higei
        ShOlZfdc7hn4k0yiqQSgsMw==
X-Received: by 2002:a05:622a:310:b0:344:89e4:cf8a with SMTP id q16-20020a05622a031000b0034489e4cf8amr5512032qtw.206.1663351450847;
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4avfW/4YAwR1npdBqO0O8h7AEDzFTbb8jsyKyqwPyhkUAoMtuvNzFwbiGDh+VRZqHyNgc5tQ==
X-Received: by 2002:a05:622a:310:b0:344:89e4:cf8a with SMTP id q16-20020a05622a031000b0034489e4cf8amr5512014qtw.206.1663351450637;
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a410f00b006b5df4d2c81sm7417854qko.94.2022.09.16.11.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
Date:   Fri, 16 Sep 2022 14:04:09 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org, linux-kernel@vger.kernel.org,
        Johannes.Thumshirn@wdc.com, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org, bvanassche@acm.org,
        gost.dev@samsung.com, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v13 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <YyS6mUzqjq9P0+OG@redhat.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5@eucas1p2.samsung.com>
 <20220912082204.51189-14-p.raghav@samsung.com>
 <YyIG3i++QriS9Gyy@redhat.com>
 <e42a0579-61b2-7b77-08cb-6723278490cc@samsung.com>
 <622ae86d-39ad-c45e-ec48-42abf4b257d2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622ae86d-39ad-c45e-ec48-42abf4b257d2@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 16 2022 at  1:57P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> >>
> >> Are you certain you shouldn't at least be exposing a different
> >> logical_block_size to upper layers?
> >>
> > To be honest, I tested my patches in QEMU with 4k Logical block size and on
> > a device with 4k LBA size.
> > 
> > I did a quick test with 512B LBA size in QEMU, and I didn't see any
> > failures when I ran my normal test suite.
> > 
> > Do you see any problem with exposing the same LBA as the underlying device?
> > 
> 
> Do you see any issues here? If not, I can send the next version with the
> other two changes you suggested.

That's fine, I just thought there might be special considerations
needed.  But if yo've tested it and upper layers work as expected then
obviously my concern wasn't applicable.

Thanks,
Mike

