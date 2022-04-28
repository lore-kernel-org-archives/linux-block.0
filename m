Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0AEC433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 00:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiD1APb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 20:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiD1APa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 20:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 577D898F75
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 17:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651104736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAQc7Gm+dyu96hrNwE7cz3vln54H3Yj9FxHAHF/ZleE=;
        b=eSvsMB/zpe+bM4DZEHG7E5mXZzrJftmw2Ra9BYhrgJ30RzgSuFDIpyjpq6s1IblWIwx20R
        T6OAmG3sX6FYNPRGw71gH2Rhnb55g/6VowPhtWv/hxkEXHtGOanwRax5UHB+jPcJkI5oTR
        eGl3y9U6m409UfnElaaAXy/NNV83SaU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-AWjJVWpRMuOFwP1sjkGvsQ-1; Wed, 27 Apr 2022 20:12:13 -0400
X-MC-Unique: AWjJVWpRMuOFwP1sjkGvsQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAF2F1C05AA3;
        Thu, 28 Apr 2022 00:12:12 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 631B940336A;
        Thu, 28 Apr 2022 00:12:07 +0000 (UTC)
Date:   Thu, 28 Apr 2022 08:12:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Josh Hunt <johunt@akamai.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Precise disk statistics
Message-ID: <Ymnb0nvUGksjby3y@T590>
References: <1650661324247.40468@akamai.com>
 <1650915337169.63486@akamai.com>
 <87031651-ba75-2b6f-8a5e-b0b4ef41c65f@huawei.com>
 <1651017390610.22782@akamai.com>
 <alpine.LRH.2.02.2204270549490.10147@file01.intranet.prod.int.rdu2.redhat.com>
 <63116fb6-bc11-d551-6734-f5407c8f3af4@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63116fb6-bc11-d551-6734-f5407c8f3af4@akamai.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 27, 2022 at 12:32:25PM -0700, Josh Hunt wrote:
> On 4/27/22 02:57, Mikulas Patocka wrote:
> > > [+ Mikulas and Ming]
> > > 
> > > I see. Thank you for the response, Kuai, appreciate it.
> > > 
> > > The conversation here https://urldefense.com/v3/__https://lkml.org/lkml/2020/3/24/1870__;!!GjvTz_vk!US3LozmCgynsWtz-1LkwhFPTXfY0XZNT7XKAw9GSNjZn0JkehqevMU7StsFKkjsS9b1hfGRsOCu0e1E$  hints at
> > > potential improvements to io_ticks tracking.
> > > 
> > > @Mikulas, Mike, please let us know if you have plans for more accurate
> > > accounting or if there is some idea we can work on and submit a patch.
> > 
> > I know that the accounting is not accurate, but more accurate accounting
> > needed a shared atomic variable and it caused performance degradation. So,
> > we don't plan to improve the accounting.
> 
> Thanks this is all very helpful.
> 
> If we know the accounting is not accurate then is there any reason to keep
> it around? What value is it providing? Also, should we update tools that use
> ioticks like iostat to report that disk utilization is deprecated and should
> not be referred to going forward?


man iostat
...
      %util
             Percentage of elapsed time during which I/O requests were issued to the device (bandwidth utilization
             for the device). Device saturation occurs when this value is close to 100% for  devices  serving  re‐
             quests  serially.  But for devices serving requests in parallel, such as RAID arrays and modern SSDs,
             this number does not reflect their performance limits.
...

As you saw, %util isn't accurate from the beginning. If you want a bit more accurate
accounting before applying 5b18b5a73760 ("block: delete part_round_stats and switch
to less precise counting"), it can be done easily by one simple bcc/bpftrace prog
with extra cost.


Thanks,
Ming

