Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D464C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 02:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiBOCk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 21:40:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiBOCk4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 21:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1547117C80
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 18:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644892846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7xZ94wx0xxHGjFOz2gdvaz5q0yIBiNDZwqvRJ9bfyDQ=;
        b=OuoG0q+cann5V33Kla2L1ey+EqCZ2vPSHN0GtU0qRU9ULJZEYLxLZve8uifXBvwVymgits
        C1aV1RoCxoVipOuA2stytp4IaC1lQn63phFE7JKNHFjRylnnoBsN/qpJsww+2iHvyvZKbq
        y+qCbbRUKso5eLbobGRaViO7cWTETlg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-nNqbnRIeOAGZWIGq2Hr1rg-1; Mon, 14 Feb 2022 21:40:43 -0500
X-MC-Unique: nNqbnRIeOAGZWIGq2Hr1rg-1
Received: by mail-qv1-f70.google.com with SMTP id g2-20020a0562141cc200b004123b0abe18so13110719qvd.2
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 18:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xZ94wx0xxHGjFOz2gdvaz5q0yIBiNDZwqvRJ9bfyDQ=;
        b=D+IM1GElFd8FskvVW/j6zU3NP6EObtDw7CDomnt8qIftuubwsoSR1HRTOqfnlMymGv
         X2nsUdVlMXRYtDuLIaJFeV6ubXbPvTDAsx/0dwOBaqLkVgvYSH6As0dAmapsQixS2AKT
         F2zeP/7Agc/i1mHvCf2FYFNA4uCg6BR2vG4T9b20rOEDsySR6lS2n2n69t3p6TnuBX19
         ZfxYxFisFPb29sKPWB43LJhU3wWKbDt/RSwYuuak2VCP4JYiiU0ox8s7y4cvHy38p6yA
         awpvwIWiYcCchU4+91nieyrVpTOCBdukRwAUJCGDQE2c9YGQvtB15f90Jt8oAPdr2SxF
         TGBw==
X-Gm-Message-State: AOAM531AjwRi0PjLPzTvBG/u8G+Yr+9TqVmjZnB62i9hlBCF0YGprjso
        rL5UA7agECKppnkaz/3R3gzGEMridsvL+d/QoSLnEx9BkxNWerpeLKJNYqS+BnK1TBjeE4uIY5q
        4zo9uD08Wc3CTO0ZqJGQcKg==
X-Received: by 2002:ad4:576b:: with SMTP id r11mr1174314qvx.34.1644892834729;
        Mon, 14 Feb 2022 18:40:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjUxIh8PAkN+Wc/wo+m+HrG05WY5hQjIOeVqxluyBFBdCgdkI1egd9MPDeXG+iCh1nwO6+rA==
X-Received: by 2002:ad4:576b:: with SMTP id r11mr1174306qvx.34.1644892834506;
        Mon, 14 Feb 2022 18:40:34 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r2sm19304798qta.15.2022.02.14.18.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:40:34 -0800 (PST)
Date:   Mon, 14 Feb 2022 21:40:33 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 10/14] block: add bio_start_io_acct_remapped for the
 benefit of DM
Message-ID: <YgsSoZvc8YHBflfM@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
 <20220211214057.40612-11-snitzer@redhat.com>
 <YgphC67SVZIWfhhs@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgphC67SVZIWfhhs@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 14 2022 at  9:02P -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Feb 11, 2022 at 04:40:53PM -0500, Mike Snitzer wrote:
> > DM needs the ability to account a clone bio's IO to the original
> > block_device. So add @orig_bdev argument to bio_start_io_acct_time.
> > 
> > Rename bio_start_io_acct_time to bio_start_io_acct_remapped.
> > 
> > Also, follow bio_end_io_acct and bio_end_io_acct_remapped pattern by
> > moving bio_start_io_acct to blkdev.h and have it call
> > bio_start_io_acct_remapped.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks.

But turns out I don't need this patch afterall.

DM can't account IO to the DM device in terms of clone bios because
they may not be simple remaps, the payload could change in size such
that the original vs clone varies widely.  Also, dmstats imposes the
additional constraint that the same bio be used for the
{start,end}_io_acct's calls to dm_stats_account_io().

