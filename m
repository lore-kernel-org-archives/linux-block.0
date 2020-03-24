Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BDC10DCE
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 03:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDA120637
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 03:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0PNqETg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgCXDT7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:19:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25410 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbgCXDT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 23:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585019998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=uCYFsohqM1O2VZ9+dq354HtzNQ7NHh7s1ahw4d3IXhU=;
        b=c0PNqETgCM8gAbP6U54ghAVnPiryaEHmBZ5WnronmoblCi+owB6gwCMFm8dv6zNglbhSbz
        N24DuoKyLM/rj5/J2jm2KMdkEF3FrXcHv0xLouDG/0Su++STuxt8BTBNVdRLvrAddJ7Bc9
        g91y5OJO7xHQZSHixUYgqZOZJz/WBR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-6NI2o51bM4OsxR5T6yj6tw-1; Mon, 23 Mar 2020 23:19:56 -0400
X-MC-Unique: 6NI2o51bM4OsxR5T6yj6tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6C9F107ACC7;
        Tue, 24 Mar 2020 03:19:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0DA97E32E;
        Tue, 24 Mar 2020 03:19:47 +0000 (UTC)
Date:   Tue, 24 Mar 2020 11:19:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, mpatocka@redhat.com
Subject: [regression] very inaccurate %util of iostat
Message-ID: <20200324031942.GA3060@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guys,

Commit 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
changes calculation of 'io_ticks' a lot.

In theory, io_ticks counts the time when there is any IO in-flight or in-queue,
so it has to rely on in-flight counting of IO.

However, commit 5b18b5a73760 changes io_ticks's accounting into the
following way:

	stamp = READ_ONCE(part->stamp);
	if (unlikely(stamp != now)) {
		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
			__part_stat_add(part, io_ticks, 1);
	}

So this way doesn't use any in-flight IO's info, simply adding 1 if stamp
changes compared with previous stamp, no matter if there is any in-flight
IO or not.

Now when there is very heavy IO on disks, %util is still much less than
100%, especially on HDD, the reason could be that IO latency can be much more
than 1ms in case of 1000HZ, so the above calculation is very inaccurate.

Another extreme example is that if IOs take long time to complete, such
as IO stall, %util may show 0% utilization, instead of 100%.

Thanks, 
Ming

