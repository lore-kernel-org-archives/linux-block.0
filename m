Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3655EC6FD1C
	for <linux-block@archiver.kernel.org>; Sat, 25 Mar 2023 10:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCYKHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Mar 2023 06:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCYKHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Mar 2023 06:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0B126ED
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679738817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=69lBml8M+mJLfCIQU5HEXJ4oWgNApiYlqfbxyOv/0t8=;
        b=bHvDRxkLjrIxx0JsRPz23GrsSEsY1BNYmXzkAPYV4JK5wuXp7AluhUOoti5cCGPaPbBd54
        osuvfkKrw6eIYXjTsfEUuJCBZWRyuNtv9TOFDRelOENJkOsEO8rm71Kg/BDjQpXq4aN3GK
        o+de+bel6Kloqya9UEbNSSFBb92lIQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-UUJSdU9vNKyHxU0S8Ubjzg-1; Sat, 25 Mar 2023 06:06:55 -0400
X-MC-Unique: UUJSdU9vNKyHxU0S8Ubjzg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 187ED101A531
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 10:06:55 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B102492B0A;
        Sat, 25 Mar 2023 10:06:51 +0000 (UTC)
Date:   Sat, 25 Mar 2023 18:06:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guangwu Zhang <guazhang@redhat.com>
Cc:     linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [bug report] kernel panic at _find_next_zero_bit in io_uring
 testing
Message-ID: <ZB7HtcDOwmsKbQtj@ovpn-8-21.pek2.redhat.com>
References: <CAGS2=YohS-+HDNaTfd_0xP249ewTc5ffgY+XB+kQnDQ+c_BwMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS2=YohS-+HDNaTfd_0xP249ewTc5ffgY+XB+kQnDQ+c_BwMg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guang Wu,

On Sat, Mar 25, 2023 at 03:25:34PM +0800, Guangwu Zhang wrote:
> Hello,
> 
> We found this kernel panic issue with upstream kernel 6.3.0-rc3 and
> it's 100% reproduced, let me know if you need more info/testing,
> thanks
> 
> kernel repo : https://github.com/torvalds/linux.git
> reproducer :  run the testing from  git://git.kernel.dk/liburing
> 
> [ 1089.762678] Running test recv-msgall-stream.t:
> [ 1089.922127] Running test recv-multishot.t:
> [ 1090.231772] Running test reg-hint.t:
> [ 1090.282612] general protection fault, probably for non-canonical
> address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [ 1090.294014] KASAN: null-ptr-deref in range

The issue is fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=io_uring-6.3&id=02a4d923e4400a36d340ea12d8058f69ebf3a383

since liburing merges test case quicker than kernel fix, :-)

BTW, please report io_uring issue on io-uring@vger.kernel.org next time.

thanks,
Ming

