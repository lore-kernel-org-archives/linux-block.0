Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE63C433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 06:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853EE2065D
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 06:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXVh+DJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRGTR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:19:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55851 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726228AbgHRGTQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 02:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597731554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VEmycD9ZVYDedbBhweOxYQh/jRe9COYJffBIue5qWk=;
        b=IXVh+DJMqwtH82SFcSo94Wl+sPfSWFpJQrU+2e8r51gBVxAzAmAaqFd0GmqfuWA51wCyWN
        zZbD+dZI0pqbQajiSuWqZs9jWvfnw0zBKaatqbnB6QlxTFoXnnfO1VL/fbCk8w90s20xEl
        EHPFMG28Gxl9FpqX5KGQwTQ7LKHz0Xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-XVFfAjWkNdSMXyXcUR7maA-1; Tue, 18 Aug 2020 02:19:09 -0400
X-MC-Unique: XVFfAjWkNdSMXyXcUR7maA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD973801AE6
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 06:19:08 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B71855D9D2
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 06:19:08 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id ABFAE4EE1C;
        Tue, 18 Aug 2020 06:19:08 +0000 (UTC)
Date:   Tue, 18 Aug 2020 02:19:08 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Message-ID: <1382840777.8967687.1597731548544.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200818022905.GB2507595@T590>
References: <94883604.6936811.1596720770623.JavaMail.zimbra@redhat.com> <1929570063.6965184.1596736053281.JavaMail.zimbra@redhat.com> <20200818022905.GB2507595@T590>
Subject: Re: [bug] mkfs.ext[23] hangs on loop device (aarch64, 5.8+)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.12, 10.4.195.14]
Thread-Topic: mkfs.ext[23] hangs on loop device (aarch64, 5.8+)
Thread-Index: Jl48YJuhCHipj59WvXfhgmpRaHsfww==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> I saw this kind io hang in ltp/fs_fill test reliably and the loop is
> over image in tmpfs:
> 
> https://lkml.org/lkml/2020/7/26/77
> 
> And I have verified that the following patch can fix the issue:
> 
> https://lore.kernel.org/linux-block/bc5fa941-3b7c-f28e-dd46-1a1d6e5c40a8@kernel.dk/T/#t

Thanks, I'll test your patch with my setup.

In my case, I traced requests going up to blk_mq_sched_insert_requests(),
but they never made it to loop driver code (loop_queue_rq / lo_complete_rq),
so I assumed they are getting lost somewhere in mq scheduling.

After hang, there were always several requests stuck "inflight":
# cat /sys/kernel/debug/block/loop0/rqos/wbt/inflight
0: inflight 41
1: inflight 0
2: inflight 0

With some additional traces I could see requests being at dispatch list
and state == 0, which appears to fit description of problem you've seen:

  blk_mq_sched_insert_requests: blk_mq_sched_insert_requests hctx: ffff000168598000, ctx: fffffdffbff16dc0
  wbt_wait: wbt_wait rqos: ffff00016a5e1358, rqw: ffff00016a5e1388, bio: ffff0000da6bbd00, inflight: 41
  <wbt_wait goes to sleep>

crash> bio.bi_disk ffff0000da6bbd00
  bi_disk = 0xffff000168599800
crash> gendisk.disk_name 0xffff000168599800
  disk_name = "loop0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000" 

crash> blk_mq_hw_ctx.queue 0xffff000168598000
  queue = 0xffff000117c06800
crash> request_queue.rq_qos 0xffff000117c06800
  rq_qos = 0xffff00016a5e1358

crash> blk_mq_hw_ctx.state 0xffff000168598000
    state = 0
crash> list blk_mq_hw_ctx.dispatch -h 0xffff000168598000 | wc -l
42

Regards,
Jan

