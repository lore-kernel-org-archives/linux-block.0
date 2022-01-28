Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402AEC433FE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 15:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiA1PQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240381AbiA1PQP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 10:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643382974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cp0i3c6pG+pEJXHv0A36Kn+qXCxSwpAB2eJIwbIKIC4=;
        b=ZmXNKcoZ5NE6dBY1tH8vQglhcT1bLHt+mUVarmRhFM15cUAUz0dZ5A35QL1fdWX3MVZkml
        i5kYwQ1aTjZm9xiOLIMocR/psOpGQdJrP7LIe5FLoie4pJI5XxTLdl1BAZX3VF/av4biK+
        zgTAfrELb6T49Jz4i8zQv0BOK/pedHM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-jynbamxxMjuxG3FHjbw8eQ-1; Fri, 28 Jan 2022 10:16:13 -0500
X-MC-Unique: jynbamxxMjuxG3FHjbw8eQ-1
Received: by mail-qk1-f199.google.com with SMTP id c128-20020a37b386000000b0047f37e77660so5005100qkf.12
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 07:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cp0i3c6pG+pEJXHv0A36Kn+qXCxSwpAB2eJIwbIKIC4=;
        b=MQGos/2SpbOyYyOBnv3SUIV7rR1M04gUSFmyK0FVJENTrM9rnxEPobhoaknW5BaMe2
         8f3nDuwsjMBVs0XLo2BzCmuAwXJ54+16hBYO+x8E90v4CyVzrI6Csq7L2pq8lMqbGDoN
         YWYykVNOiQP/JBm2DXIE4+i1rnPz2QUfE5unTi8Efb4OVxnWyPNqWQijQUB+W2VxoMpR
         jCq/tbplyjl0FUHNqzTHGGTR7nzhpVbYVMByBl7R144wfs+LF3g0ujYItyZPzmpLuRh+
         OSkqQWXkrZq07z8eClgeymVhGlBCsXBSxwtGrFOPzmj4WE4tCOfH4hbZ4hG/G61t1/67
         LkPg==
X-Gm-Message-State: AOAM530he+gXpR4DA0t8I/3WM8ciGA5T9gjZ2awn9APtFTL6/7qZ/ezO
        gvGlxblrCEuDGpkZD+segKkBbsFHXoi+MA9Omb3samrUuRUhTki+0ZOJN6VzWeyy2oBbNqFYLC4
        jJMFp+m1xEgycfiSSmfPSnw==
X-Received: by 2002:a37:ab16:: with SMTP id u22mr5925827qke.785.1643382972437;
        Fri, 28 Jan 2022 07:16:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxorxuH0ZTbxsfTu9vyCBb/9KxExCAwywc25dgZolCMmGt4Wh7UIiMndAOsMxO++QaFOONxkQ==
X-Received: by 2002:a37:ab16:: with SMTP id u22mr5925807qke.785.1643382972223;
        Fri, 28 Jan 2022 07:16:12 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 18sm3139119qty.36.2022.01.28.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 07:16:11 -0800 (PST)
Date:   Fri, 28 Jan 2022 10:16:10 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/3] block: add bio_start_io_acct_time() to control
 start_time
Message-ID: <YfQIus452oB6/zqy@redhat.com>
References: <20220128041753.32195-1-snitzer@redhat.com>
 <20220128041753.32195-2-snitzer@redhat.com>
 <20220128061308.GA1477@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128061308.GA1477@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 28 2022 at  1:13P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jan 27, 2022 at 11:17:51PM -0500, Mike Snitzer wrote:
> > +	__part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
> > +			     bio_op(bio), start_time);
> >  }
> > +EXPORT_SYMBOL_GPL(bio_start_io_acct_time);
> >  
> >  /**
> >   * bio_start_io_acct - start I/O accounting for bio based drivers
> > @@ -1084,14 +1096,15 @@ static unsigned long __part_start_io_acct(struct block_device *part,
> >   */
> >  unsigned long bio_start_io_acct(struct bio *bio)
> >  {
> > -	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio), bio_op(bio));
> > +	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
> > +				    bio_op(bio), jiffies);
> 
> Is droppingthe READ_ONCE safe here?  This is a honest question as these
> helpers still confuse me.

I'm not sure either, commit 956d510ee78ca ("block: add disk/bio-based
accounting helpers") doesn't offer any insight on the need.

Very little kernel code uses READ_ONCE(jiffies).

git diff 24d69293d9a561645e0b4d78c2fb179827e35f53^..e722fff238bbfe6308d7778a8c2163c181bf998a
shows that at the time the outgoing generic_{start,end}_io_acct didn't
use READ_ONCE (nor did any of the drivers that were updated to use the
new helpers).

ACCESS_ONCE() was used prior to READ_ONCE() -- see commit
cbbce82209490 and then 316c1608d15c7.

Anyway, looks to be cargo cult at this point right?
(if so, implies the use of READ_ONCE() in patch 3 isn't needed either)

> The rest looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.

