Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CACC433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 06:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800F8207DA
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 06:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+K4W7Wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHSGhn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:37:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32675 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbgHSGhl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 02:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597819059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYLk6Xw7C3Y3cxhLN8fqGt6Iy+ECSL99W6y05+SGbM4=;
        b=J+K4W7Wm7LoesME4TTeqrN4aHkN4mDJyNmFld23QI+L2vTNO+Ukhd2AdPurqK51sROKzJN
        QjP0iW3i23WMMvr/5qHkXlBYB6MuX8xv1RRVC2HFzUQxZ3ZgRZlE1uY/A177XUTbfGTCcQ
        0/+fEpxkz9iBaIcBK59eY0HK7Yygsfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-8hOdpqjNMQK0pfN9d9oRaw-1; Wed, 19 Aug 2020 02:37:35 -0400
X-MC-Unique: 8hOdpqjNMQK0pfN9d9oRaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4458E1084C85
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 06:37:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DD0A59
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 06:37:34 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2E3A660370;
        Wed, 19 Aug 2020 06:37:34 +0000 (UTC)
Date:   Wed, 19 Aug 2020 02:37:34 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Message-ID: <1053136797.9144539.1597819054047.JavaMail.zimbra@redhat.com>
In-Reply-To: <1382840777.8967687.1597731548544.JavaMail.zimbra@redhat.com>
References: <94883604.6936811.1596720770623.JavaMail.zimbra@redhat.com> <1929570063.6965184.1596736053281.JavaMail.zimbra@redhat.com> <20200818022905.GB2507595@T590> <1382840777.8967687.1597731548544.JavaMail.zimbra@redhat.com>
Subject: Re: [bug] mkfs.ext[23] hangs on loop device (aarch64, 5.8+)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.12, 10.4.195.5]
Thread-Topic: mkfs.ext[23] hangs on loop device (aarch64, 5.8+)
Thread-Index: Jl48YJuhCHipj59WvXfhgmpRaHsfw1tbw9/q
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> 
> 
> ----- Original Message -----
> > I saw this kind io hang in ltp/fs_fill test reliably and the loop is
> > over image in tmpfs:
> > 
> > https://lkml.org/lkml/2020/7/26/77
> > 
> > And I have verified that the following patch can fix the issue:
> > 
> > https://lore.kernel.org/linux-block/bc5fa941-3b7c-f28e-dd46-1a1d6e5c40a8@kernel.dk/T/#t
> 
> Thanks, I'll test your patch with my setup.

I've seen no hangs over past ~24 hours with patch above.

Thanks,
Jan

