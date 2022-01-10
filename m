Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE4FC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 19:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbiAJTDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:03:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242133AbiAJTDV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 14:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641841400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJVpXmFJvi99AqmLB99IJstD9nuMHAk3xaEQkzCNADQ=;
        b=hpvrBBftAYSRRGr1Jt2+WEQrFrsA38/szY7A0pDRaLskvn+xWdbzBz0Dz18zyXDNItQlq3
        xuhE8UneLIja/PfGFxM9sn+YAVLbbo+7gQ62aIO8wnUwrfGAcqnjjcAmGybLAgWhTEYkyU
        q+M7L1bFkYvkzgZOTn4VUQs3dx3yZsU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-HyAqCWztOJWHnsiP-wExaA-1; Mon, 10 Jan 2022 14:03:19 -0500
X-MC-Unique: HyAqCWztOJWHnsiP-wExaA-1
Received: by mail-qv1-f72.google.com with SMTP id kk20-20020a056214509400b004110a8ba7beso13986785qvb.20
        for <linux-block@vger.kernel.org>; Mon, 10 Jan 2022 11:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJVpXmFJvi99AqmLB99IJstD9nuMHAk3xaEQkzCNADQ=;
        b=Nwk6qQlRTso5r4t/jSBQ4Bt4NYQwZot8XfZrhWHD2b7ljREqs+MDmg5gH01FfQthEP
         MhIs7yGaRO26HTmncwUOrpTsZrPcK3dc7GOcG8jO54wIog4ocw0g9oy6VFClXfZZL5JT
         8JiX/wwL1P52davE8wVliO7gPn4M0L/nH5/q/1Hw3IomkzUqWYU/92/wBe1EbNzfnTPu
         DNpYKDSvmoB5sR+jwjVyhIBSDof1jjUV1FZKh1WhVtqgw0V743jLVv5XgBeGjat1yuDF
         cOY02O6HQe1WxRKpzVxQNUqciQl1oa1BaO2CHbbHOYv/zFndF8rYm4iUEJj0+Q3glngA
         h20g==
X-Gm-Message-State: AOAM532TelugPfvRBBdilS0LOe8NXmTYjzryi8K/xqDuGXugYxA8qDda
        MS3d2hQmHpeNXULsilAYyJyd7gx/2emjbNMD55YNytYYFKVovzOkfnwJfBywF6aq4tDwhBlBjQH
        33141z3tkCtpp4fFb2nBnAw==
X-Received: by 2002:a37:dc45:: with SMTP id v66mr833130qki.516.1641841398614;
        Mon, 10 Jan 2022 11:03:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDZRef9V/QtQImBhNEfUIX1j4IHs5Ip3sUthhzJGhtWzXF2cDrhAoBRB1f9r3zeMNRnQHO0A==
X-Received: by 2002:a37:dc45:: with SMTP id v66mr833116qki.516.1641841398397;
        Mon, 10 Jan 2022 11:03:18 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id j22sm2687451qko.117.2022.01.10.11.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:03:18 -0800 (PST)
Date:   Mon, 10 Jan 2022 14:03:16 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        lining <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH 1/2] block: add resubmit_bio_noacct()
Message-ID: <YdyC9KpQ7yC3l7RZ@redhat.com>
References: <20220110075141.389532-1-ming.lei@redhat.com>
 <20220110075141.389532-2-ming.lei@redhat.com>
 <YdxuWlZAPJkPyr3h@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxuWlZAPJkPyr3h@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10 2022 at 12:35P -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jan 10, 2022 at 03:51:40PM +0800, Ming Lei wrote:
> > Add block layer API of resubmit_bio_noacct() for handling blk-throttle
> > iops limit correctly. Typical use case is that bio split, and it isn't
> > good to export blk_throtl_charge_bio_split() for drivers, so add new API
> > for serving such purpose.
> 
> Umm, submit_bio_noacct is meant exactly for this case of resubmitting
> a bio.  We should not need another API for that.
> 

Ming is lifting code out of __blk_queue_split() for reuse (by DM in
this instance, because it has its own bio_split+bio_chain).

Are you saying submit_bio_noacct() should be made to call
blk_throtl_charge_bio_split() and blk_throtl_charge_bio_split() simply
return if not a split bio? (not sure bio has enough context to know,
other than looking at some side-effect change from bio_chain)

But Ming: your __blk_queue_split() change seems wrong.
Prior to your patch __blk_queue_split() did:

bio_chain(split, *bio);
submit_bio_noacct(*bio);
*bio = split;
blk_throtl_charge_bio_split(*bio);

After your patch (effectively):

bio_chain(split, *bio);
submit_bio_noacct(*bio);
blk_throtl_charge_bio_split(bio);
*bio = split;

Maybe that was intended? (or maybe it doesn't matter because bio_split
copies fields with bio_clone_fast())?  Regardless, it is subtle.

Should blk_throtl_charge_bio_split() just be pushed down to
bio_split()?

In general, such narrow hacks for how to properly resubmit split bios
are asking for further trouble.  As is, I'm having to triage new
reports of bio-based accounting issues (which has called into question
my hack/fix commit a1e1cb72d9649 ("dm: fix redundant IO accounting for
bios that need splitting") that papered over this bigger issue of
needing proper split IO accounting, so likely needs to be revisited).

We also have the much bigger issue of IO poll support (or
lack-there-of) for split bios.

Mike

