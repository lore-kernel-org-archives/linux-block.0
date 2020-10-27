Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60010C4363A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 01:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0C22080A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 01:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJra2W5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503718AbgJ0BSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 21:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411311AbgJ0BSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 21:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603761500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SrYT8zX0tHJ+L74DDGK2r1FEkedibAS0AWcoEpa4aY=;
        b=HJra2W5UP7IGKEGxRSxYh2tBGS4yP1hqmshRLAUB3h1sE8tlyiW8U97QzMjsAjboPKiM5y
        MlM0QZpvt+XropVcbn2ScAtHLK1qqtM2GaDX+og7DtQevBWVtTzlBak1PKIUwWebaKM7t2
        zXT+6C0KPK2LafODqCBgq0YkHL5vjwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-OOkJbHEYPKOO7ro1yyiCeg-1; Mon, 26 Oct 2020 21:18:16 -0400
X-MC-Unique: OOkJbHEYPKOO7ro1yyiCeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36CC51009E27;
        Tue, 27 Oct 2020 01:18:14 +0000 (UTC)
Received: from T590 (ovpn-12-132.pek2.redhat.com [10.72.12.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 246455C1BB;
        Tue, 27 Oct 2020 01:18:05 +0000 (UTC)
Date:   Tue, 27 Oct 2020 09:18:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     lining <lining2020x@163.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, yunchuan.wen@kylin-cloud.com,
        ceph-users@ceph.io, donglifekernel@126.com
Subject: Re: [bug report] NBD: rbd-nbd + ext4 stuck after nbd resized
Message-ID: <20201027011801.GA1828887@T590>
References: <AA00244F-0E5A-4E52-B358-4F36A3486EBF@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AA00244F-0E5A-4E52-B358-4F36A3486EBF@163.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 21, 2020 at 09:08:10AM +0800, lining wrote:
> (Sorry for sending this mail again, this one add nbd@other.debian.org)
> 
> Hi kernel、ceph comunity:
> 
> We run into an issue that mainly related to the (kernel) nbd driver and (ceph) rbd-nbd. 
> After some investigations, I found that the root cause of the problem seems to be related to the change in the block size of nbd.
> 
> I am not sure whether it is the nbd driver or rbd-nbd bug, however there is such a problem.
> 
> 
> What happened：
> It will always hang when accessing the mount point of nbd device with ext4 after nbd resized. 
> 
> 
> Environment information:
> - kernel:               v4.19.25 or master
> - rbd-nbd(ceph):  v12.2.0 Luminous or master
> - the fs of nbd:    ext4

Hello lining,

Can you reproduce this issue on v5.9 kernel?


Thanks,
Ming

