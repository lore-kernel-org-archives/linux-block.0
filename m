Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419A3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 09:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574462AbiAYJe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:34:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380431AbiAYJ2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 04:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643102887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0UnVACW1GCfh61iqXb5gSodARCGb9Db4K+Avgvqrl0=;
        b=Q44NHJ0QtpQq53PhrjJnqaee4DG5OEqddmYY4J4sSq6Kz53Mtr8o1vQjVvFWFDL2Lb8Yaj
        k0egYsX6JuRpTshb9hjEf57OFVeba2l06RVAanHS0RsMl8Vz4XJ5OS1PXSYnNH8Ob/podY
        gnjHm64qN6Oxls4DtvH58BCpxC03BNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-U0aZt6GVOUqp2Zrx6Arb_g-1; Tue, 25 Jan 2022 04:28:05 -0500
X-MC-Unique: U0aZt6GVOUqp2Zrx6Arb_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8A281091DA0;
        Tue, 25 Jan 2022 09:28:04 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00B984F86D;
        Tue, 25 Jan 2022 09:27:41 +0000 (UTC)
Date:   Tue, 25 Jan 2022 17:27:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>, Pei Zhang <pezhang@redhat.com>
Subject: Re: [PATCH V2] block: loop:use kstatfs.f_bsize of backing file to
 set discard granularity
Message-ID: <Ye/CiFZSHmHQ3Pfu@T590>
References: <20220125044005.211943-1-ming.lei@redhat.com>
 <20220125061057.GA26444@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125061057.GA26444@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 25, 2022 at 07:10:57AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 25, 2022 at 12:40:05PM +0800, Ming Lei wrote:
> >  	} else {
> > +		struct kstatfs sbuf;
> > +
> >  		max_discard_sectors = UINT_MAX >> 9;
> > -		granularity = inode->i_sb->s_blocksize;
> > +		if (!vfs_statfs(&file->f_path, &sbuf))
> > +			granularity = sbuf.f_bsize;
> > +		else
> > +			granularity = PAGE_SIZE;
> 
> If vfs_statfs fails we're pretty much toast and there isn't really any
> point in continuing here.

But it is configure code path, even though vfs_statfs() fails,
loop_config_discard() still need to keep discard setting consistent.

Setting granularity as PAGE_SIZE is just for making discard granularity
matched with max_discard_sectors. Or you have better/simpler handling?


Thanks,
Ming

