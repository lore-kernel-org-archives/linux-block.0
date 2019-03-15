Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC78AC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 12:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E8621871
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 12:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfCOMlR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfCOMlR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 08:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B8993005FCA;
        Fri, 15 Mar 2019 12:41:17 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E0F05C223;
        Fri, 15 Mar 2019 12:41:14 +0000 (UTC)
Date:   Fri, 15 Mar 2019 13:41:12 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Message-ID: <20190315134112.7d63348c.cohuck@redhat.com>
In-Reply-To: <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
        <20190312183351.74764f4f.cohuck@redhat.com>
        <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
        <20190313103900.1ea7f996.cohuck@redhat.com>
        <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
        <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 15 Mar 2019 12:41:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 15 Mar 2019 12:50:11 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Or something like I proposed several years ago? 
> https://do-db2.lkml.org/lkml/2014/12/25/169
> 
> Btw, for virtio-net, I think we actually want to go for having a maximum 
> number of supported queues like what hardware did. This would be useful 
> for e.g cpu hotplug or XDP (requires per cpu TX queue). But the current 
> vector allocation doesn't support this which will results all virtqueues 
> to share a single vector. We may indeed need more flexible policy here.

I think it should be possible for the driver to give the transport
hints how to set up their queues/interrupt structures. (The driver
probably knows best about its requirements.) Perhaps whether a queue is
high or low frequency, or whether it should be low latency, or even
whether two queues could share a notification mechanism without
drawbacks. It's up to the transport to make use of that information, if
possible.
