Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDBC38A2B
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 02:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2756B21927
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 02:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Luc1YyQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDRCMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 22:12:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55162 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbgDRCMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 22:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587175919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=URlwbrXEDXEHxt2PEI/Shocf9FEZHJYwmhM7aRxcHa0=;
        b=Luc1YyQsULVJ3kmVsbB4KNtT13DtZ9N66R+xY2S3JHON8Tr7KKhHv4MGEXdGZRHWNCCGln
        6CcAScj7eFGYawae3zizUmxLOzljvBPhx1NLYS4I5n0h3gRX+tnkfK++1f9De2bswquZs8
        9S1GHvIkbf/X8rbbA6aA4MaJ7BE7SUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-h8MKemqiPkafrnvuMr2l5g-1; Fri, 17 Apr 2020 22:11:50 -0400
X-MC-Unique: h8MKemqiPkafrnvuMr2l5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B49B38017F3;
        Sat, 18 Apr 2020 02:11:48 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B59F711A028;
        Sat, 18 Apr 2020 02:11:40 +0000 (UTC)
Date:   Sat, 18 Apr 2020 10:11:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     yu kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, yi.zhang@huawei.com,
        yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] block: fix access of uninitialized pointer address in
 bt_for_each()
Message-ID: <20200418021136.GA17090@T590>
References: <20200417125134.45117-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417125134.45117-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 17, 2020 at 08:51:34PM +0800, yu kuai wrote:
> I recently got a KASAN warning like this in our 4.19 kernel:
> 
>  ==================================================================
>  BUG: KASAN: slab-out-of-bounds in bt_for_each+0x1dc/0x2c0
>  Read of size 8 at addr ffff8000c0865000 by task sh/2023305
> 
>  Call trace:
>  dump_backtrace+0x0/0x310
>  show_stack+0x28/0x38
>  dump_stack+0xd8/0x108
>  print_address_description+0x68/0x2d0
>  kasan_report+0x124/0x2e0
>  __asan_load8+0x88/0xb0
>  bt_for_each+0x1dc/0x2c0
>  blk_mq_queue_tag_busy_iter+0x1f0/0x3e8
>  blk_mq_in_flight+0xb4/0xe0
>  part_in_flight+0x124/0x178
>  part_round_stats+0x128/0x3b0

This code path is killed since 5b18b5a73760 ("block: delete part_round_stats and
switch to less precise counting").

However, it still can be triggered via readding proc & sysfs iostat.

Jian Chao worked patches for this issue before, please refer to:

https://lore.kernel.org/linux-block/1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com/

but didn't get chance to merge.

Thanks, 
Ming

