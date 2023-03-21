Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC023C74A5B
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 11:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCULoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 07:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCULop (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 07:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171973802F
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679399041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ip0ypPWj0y6T3kRIH9Tya2rrM/dKmttRsWWLGVarwIU=;
        b=TLJLimf1KXPkh81bTaQltMx2kUo60lPvXbj+WVhjqFFaFmUMUA51gYWpRXli3vyJfcS1Ps
        Q9uNyCLbP8fFMQEjCI6BLzs/9zts/ZTpACJ8YM+mGkMrLfg2aRC/oSle4NebNtzAv5egvP
        fTlb7kBKy9LPkxRDRLu9f2W0cb7yXwA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-zDzNZeAJNaCSu7nOK5F_fQ-1; Tue, 21 Mar 2023 07:43:59 -0400
X-MC-Unique: zDzNZeAJNaCSu7nOK5F_fQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 156C529AB3EA;
        Tue, 21 Mar 2023 11:43:59 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACA531121314;
        Tue, 21 Mar 2023 11:43:51 +0000 (UTC)
Date:   Tue, 21 Mar 2023 19:43:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hare@suse.de, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        ming.lei@redhat.com
Subject: Re: [PATCH -next 0/2] block: fix scan partition for exclusively open
 device again
Message-ID: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 17, 2023 at 10:21:58AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes from RFC:
>  - remove the patch to factor out GD_NEED_PART_SCAN
> 
> Yu Kuai (2):
>   block: Revert "block: Do not reread partition table on exclusively
>     open device"
>   block: fix scan partition for exclusively open device again

Hi Yu kuai,

Looks the original issue starts to re-appear now with the two patches:

https://lore.kernel.org/linux-block/20221130135344.2ul4cyfstfs3znxg@quack3/

And underlying disk partition and raid partition can be observed at the
same time.

Can you take a look?

Follows the script, which isn't 100% triggered, but still easy.

#create level 1 with 2 devices, meta 1.0
mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0

#create partition 0, start from 0 sector, size 100MiB
sgdisk -n 0:0:+100MiB /dev/md0

#observe partitions
cat /proc/partitions

#stop the array
mdadm -S /dev/md0

#re-assemble 
mdadm -A /dev/md0 /dev/sda /dev/sdb
cat /proc/partitions


Thanks,
Ming

