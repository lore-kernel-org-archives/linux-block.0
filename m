Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99FCC4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 09:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90A460F9E
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 09:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhG1JOS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235558AbhG1JOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 05:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627463652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qM2pY3QQZ75N8NGvyWod3aePv3OhL3iSnbWaTNcX1vQ=;
        b=gx/ubLe+S5NdMkemIaKlIy47tVdmI9CfJXaFIcVjt7py3jxlEcJEJVi+tR3GGV9jLjk8Zu
        dKDTZUKPL5RZACApYNuwf8zfHxtGfcbfurVbqYLgd4KvGC8HEC2S85zyg/t/tt34CXAedg
        dyW6aFJ5q2RkOft8pY+AmN7tpbpfHhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-koeJ_VBtMm6s37DXcy3xsA-1; Wed, 28 Jul 2021 05:14:10 -0400
X-MC-Unique: koeJ_VBtMm6s37DXcy3xsA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 442978010F4;
        Wed, 28 Jul 2021 09:14:09 +0000 (UTC)
Received: from ws.net.home (ovpn-113-182.ams2.redhat.com [10.36.113.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFF5C60854;
        Wed, 28 Jul 2021 09:14:07 +0000 (UTC)
Date:   Wed, 28 Jul 2021 11:14:05 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Sinan Kaya <sinan.kaya@microsoft.com>,
        util-linux@vger.kernel.org, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit d5fd456c88aba4fcf77d35fe38024a8d5c814686 - "loopdev: use
 LOOP_CONFIG ioctl" broke loop on x86-64 w/ 32 bit userspace
Message-ID: <20210728091405.cqvkgv6c2vvsmacb@ws.net.home>
References: <a797f527-4599-e986-a326-4bb141487f2c@ans.pl>
 <e7f64d43-2a26-e386-b208-5c35d6a56ed4@ans.pl>
 <7de1bd0b-b8ea-daf0-b677-f92db1c1cdff@ans.pl>
 <c1c9d728-c4d9-eaf4-63c3-d13b99da3a3d@kernel.dk>
 <72947cba-6a12-d54f-c9c8-588729631306@ans.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72947cba-6a12-d54f-c9c8-588729631306@ans.pl>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27, 2021 at 10:46:06PM -0700, Krzysztof Olędzki wrote:
> So, to confirm - checking for both EINVAL and ENOTTY after LOOP_CONFIGURE is
> the proper way of taking care this?
> 
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/lib/loopdev.c?id=d4423cce9b9001c9de7ebc6f64f6cc2bb854944c#n1362

We need both to make losetup/mount robust for already released kernels.
Fixed: https://github.com/karelzak/util-linux/commit/583990d25b5d65a9a9771a39d112de0ee16a1f3a

Thanks for your report!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

