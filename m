Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598DDC433F5
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 15:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346445AbiATPhV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:37:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346547AbiATPhU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 10:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642693039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SmcLr0IIgjk5E/Z+252y945aI6lCNDB2A2KVxeXJlYE=;
        b=D07PNiqONIrY4DG9H1odpJpCq5rqsdJQo+vBODsQyaHEvs4Qcs5W8ZjHCoBqER5AN9fkTp
        54n+c8MCVVHMrMAaCN8l//6frNpgbj9vdcThHZffrlLTCbrr4HXhlOY34NyVgWKyrkmg65
        B6WExppuQICLi7A4Jeof37jj2cKyjRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-Or3o5Ri8M2ejhRrZ9kaIuw-1; Thu, 20 Jan 2022 10:37:16 -0500
X-MC-Unique: Or3o5Ri8M2ejhRrZ9kaIuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 052D7192D789;
        Thu, 20 Jan 2022 15:37:15 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC4A47D3DF;
        Thu, 20 Jan 2022 15:37:06 +0000 (UTC)
Date:   Thu, 20 Jan 2022 23:37:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <YemBnAvtNkIjVc7t@T590>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
 <20220120131936.mlug7nhnoe73abx5@carbon.lan>
 <Yelo1gx5cp1l4npK@T590>
 <20220120140126.ntzvrcmczd7pph75@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120140126.ntzvrcmczd7pph75@carbon.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 20, 2022 at 03:01:26PM +0100, Daniel Wagner wrote:
> On Thu, Jan 20, 2022 at 09:51:18PM +0800, Ming Lei wrote:
> > Then Can you figure out where blk_mq_queue_tag_busy_iter+0x1e4 points to
> > in source code? And what is NULL pointer?
> 
> Here we go:
> 
> /usr/src/debug/kernel-default-5.3.18-59.27.1.x86_64/linux-5.3/linux-obj/../include/linux/sbitmap.h: 249
> 0xffffffffb244a254 <blk_mq_queue_tag_busy_iter+484>:    mov    (%rax),%rdx
> 
> 234static inline void __sbitmap_for_each_set(struct sbitmap *sb,
> 235                                          unsigned int start,
> 236                                          sb_for_each_fn fn, void *data)
> 237{
> 238        unsigned int index;
> 239        unsigned int nr;
> 240        unsigned int scanned = 0;
> 241
> 242        if (start >= sb->depth)
> 243                start = 0;
> 244        index = SB_NR_TO_INDEX(sb, start);
> 245        nr = SB_NR_TO_BIT(sb, start);
> 246
> 247        while (scanned < sb->depth) {
> 248                unsigned long word;
> 249                unsigned int depth = min_t(unsigned int,
> 250                                           sb->map[index].depth - nr,
> 251                                           sb->depth - scanned);
> 

Seems more likely nvme recovery issue, tags is changed even though
->q_usage_counter is grabbed in blk_mq_queue_tag_busy_iter(), which is
added in v4.19.

You may check dmesg log and see if there is any nvme error recovery info.

Thanks,
Ming

