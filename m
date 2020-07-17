Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881ECC433E2
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 07:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EB220704
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 07:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCJAwdbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgGQHuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:50:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36238 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbgGQHuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 03:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594972220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2CJByoHfh711HpmsmJ/4zj0vzSbyLSiKqQWN6A7bpQ=;
        b=PCJAwdbRB64uSCEEDrcuUrQ/3dIJBlVlM8CWQJniSkYiEL/vfmQpnNoRLrI2rJtJM8Q4YP
        cQHWN+YgvU7ohY0ZICw/wDuxgEsS6qZ8srQ7ps6hAYotvg5A0yvAlJ4e3KZB02hA4aJBMQ
        mhyafRK2gpUkCegtmKdkUeryiKM1mp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-TcJb-h0WNJGOStvkzI7v5Q-1; Fri, 17 Jul 2020 03:50:18 -0400
X-MC-Unique: TcJb-h0WNJGOStvkzI7v5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1260F800597;
        Fri, 17 Jul 2020 07:50:17 +0000 (UTC)
Received: from T590 (ovpn-13-1.pek2.redhat.com [10.72.13.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15BA574F70;
        Fri, 17 Jul 2020 07:50:10 +0000 (UTC)
Date:   Fri, 17 Jul 2020 15:50:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Message-ID: <20200717075006.GA670561@T590>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
 <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 17, 2020 at 02:45:25AM +0000, Damien Le Moal wrote:
> On 2020/07/16 23:35, Christoph Hellwig wrote:
> > On Thu, Jul 16, 2020 at 07:09:33PM +0900, Johannes Thumshirn wrote:
> >> Max append sectors needs to be aligned to physical block size, otherwise
> >> we can end up in a situation where it's off by 1-3 sectors which would
> >> cause short writes with asynchronous zone append submissions from an FS.
> > 
> > Huh? The physical block size is purely a hint.
> 
> For ZBC/ZAC SMR drives, all writes must be aligned to the physical sector size.

Then the physical block size should be same with logical block size.
The real workable limit for io request is aligned with logical block size.

> However, sd/sd_zbc does not change max_hw_sectors_kb to ensure alignment to 4K
> on 512e disks. There is also nullblk which uses the default max_hw_sectors_kb to
> 255 x 512B sectors, which is not 4K aligned if the nullb device is created with
> 4K block size.

Actually the real limit is from max_sectors_kb which is <= max_hw_sectors_kb, and
both should be aligned with logical block size, IMO.


Thanks, 
Ming

