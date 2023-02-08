Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7E6C05027
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 07:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjBHHeB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBHHeA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 02:34:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EFE30B1B
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 23:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675841593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73aglTPUHS/85OtfenzciioO7I/A4+2ffz4/jBMkCu0=;
        b=djYuRwkiHAZ6avhsXliEdV7d5w1I5bpLKcaGYQqnji/6YlfS30PN6S56d1vDJsfUvxoAyY
        MJNJGLsj/FlPQzEPDn2vC+Jb4/oSBEl+sRamLdY+qQmWeVRaD66iPrYPlJAip+LnSsc17l
        zvgdaD2JV2eGJoGKs/QxVy8yX13oaFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-OxgCnEtoPTuqiZKfvXON_g-1; Wed, 08 Feb 2023 02:33:08 -0500
X-MC-Unique: OxgCnEtoPTuqiZKfvXON_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC5DB85A5B1;
        Wed,  8 Feb 2023 07:33:07 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5697F18EC5;
        Wed,  8 Feb 2023 07:33:02 +0000 (UTC)
Date:   Wed, 8 Feb 2023 15:32:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 02/19] blk-cgroup: delay blk-cgroup initialization until
 add_disk
Message-ID: <Y+NQKABK682e/30a@T590>
References: <20230201134123.2656505-1-hch@lst.de>
 <20230201134123.2656505-3-hch@lst.de>
 <Y+Ji4NL/WkTR8vml@T590>
 <20230208063552.GA15030@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208063552.GA15030@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 08, 2023 at 07:35:52AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 07, 2023 at 10:40:32PM +0800, Ming Lei wrote:
> > because disk->root_blkg is freed & set as NULL in del_gendisk().
> > 
> > by the following script:
> > 
> > 	modprobe -r scsi_debug
> > 	modprobe scsi_debug dev_size_mb=1024
> > 	
> > 	mkfs.xfs -f /dev/sdc	#suppose sdc is the scsi debug disk
> > 	mount /dev/sdc /mnt
> > 	echo 1 > /sys/block/sdc/device/delete
> > 	sleep 1
> > 	umount /mnt
> 
> Thank,
> 
> I've sent a fix.  Can you wire up your reproducer in blktests?

Yeah, it is already sent out:

https://lore.kernel.org/linux-block/20230208010235.553252-1-ming.lei@redhat.com/T/#u



Thanks,
Ming

