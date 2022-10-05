Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4292C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 18:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiJESxc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiJESxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 14:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E56B8E5
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664996008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HPnzSvz7gpUQEyqnkkIzyCoNfuBnokFipEjO0B1LdyM=;
        b=flsZD34Uzt/lz0ASGIFRd3O1FJphQpeHcesDcxQKtDSv3Z2urEOHXvPrqKTkxFDxi7O8C3
        XB4wetCqolNP6FtNhEDAc+dVdrkCJzIdrenZaltU1vfkpgP0zWgPfykH2NgAHsJZiT4Y08
        A08/wSRqgGTgdrGM7MxyJlUYbZFxyy0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-50phQH7jMiK1cVm_rm4GRw-1; Wed, 05 Oct 2022 14:53:27 -0400
X-MC-Unique: 50phQH7jMiK1cVm_rm4GRw-1
Received: by mail-qk1-f200.google.com with SMTP id bm21-20020a05620a199500b006cf6a722b16so14824155qkb.0
        for <linux-block@vger.kernel.org>; Wed, 05 Oct 2022 11:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HPnzSvz7gpUQEyqnkkIzyCoNfuBnokFipEjO0B1LdyM=;
        b=ctmUqL/pPhdHUR1MAUO0eZf7FmNMhaKrbAfrnOP+JiIOukVDBgE7TPet/V0gyUCiW7
         RDk6sRthU992Rw22bOUlG8pmv9L3zNyaWrauoWUpktvbqcUbgzbFlaqQOpR81ZiuXArP
         c54kZb5qHGKXEEWp0bZeXlEm24UI3ZZFCJWmoAhunVnHtpDTjpzvCKxJ3VnG2SWtAn6Z
         BbmbeMHU1qZoPcWU1kmVNWyLiMPloepuVg6G1uYdEzY9Qf3xa9kC0WpMI+TtQ+OpJJyp
         WfrMWjlBWeBT+JKZbcJDZQrhMMNqTNldecbte3Fa2+fuN00OJvX+FrrLA2l+y1xUMC5s
         MdTg==
X-Gm-Message-State: ACrzQf3HtVxC1X1AWJkwC56XdyL4slrcAqFsO5TKW2spaCgHQaJvpzoI
        asEbUCxYVQgr8PdmLTh9r3qcXG5Vg6zAFSk7Hydl7G6Sa2Azksn9OWk5YpmoVUodf49Gh3CeGAu
        nykuxA6oZRsPgJ6XvTsx243E=
X-Received: by 2002:a05:6214:21a5:b0:4b1:8955:5146 with SMTP id t5-20020a05621421a500b004b189555146mr899596qvc.56.1664996006897;
        Wed, 05 Oct 2022 11:53:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4T2B9Gq+0ujGCrs2K5+UrBVUMpiN5YTxvudB7QxLvi6HQLVBLNszZHEEQUvgXwe9VwqdDLYg==
X-Received: by 2002:a05:6214:21a5:b0:4b1:8955:5146 with SMTP id t5-20020a05621421a500b004b189555146mr899577qvc.56.1664996006673;
        Wed, 05 Oct 2022 11:53:26 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id l7-20020ac87247000000b0035a6f972f84sm14376453qtp.62.2022.10.05.11.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:53:26 -0700 (PDT)
Date:   Wed, 5 Oct 2022 14:53:23 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/6] null_blk: allow write zeores on membacked
Message-ID: <Yz3So0+WoFH7e4p3@bfoster>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-3-kch@nvidia.com>
 <Yz28aEOOUqrCUhe2@bfoster>
 <09793b3d-b1f9-9755-f3cc-1f0cfcaeded0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09793b3d-b1f9-9755-f3cc-1f0cfcaeded0@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 05, 2022 at 06:45:35PM +0000, Chaitanya Kulkarni wrote:
> 
> >> @@ -875,6 +877,24 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
> >>   	}
> >>   }
> >>   
> >> +static void null_zero_sector(struct nullb_device *d, sector_t sect,
> >> +			     sector_t nr_sects, bool cache)
> >> +{
> > 
> > Any reason to not just pass the tree root directly here instead of the
> > cache boolean? It might make the callers more readable and also
> > eliminates the need to pass the nullb_device.
> > 
> > Brian
> > 
> 
> I kept the style similar to null_free_sector() where root is calculated 
> inside the helper acting on the sector, if we change that for 
> null_zero_sector() then I think we need to change for null_free_sector() 
> for consistency, unless you strongly object it for some reason.
> 

Nope, just a nit that stood out to me when skimming the patches. Not a
big deal at all.

Brian

> -ck
> 

