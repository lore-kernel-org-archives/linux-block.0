Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EC2C77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 03:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjDYDcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 23:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYDcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 23:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0168CA8
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 20:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682393473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NSewKnzlbDf5MOTTABMwxlGdQJV3rNWC5+Ep8bYXvPc=;
        b=YnuCEz7PwYNrJI7Mtd0TkVQ23z4OhLNjbhtezXqsMFNHHwY4krrGdmmNCWV9EUSvYC+1e+
        AAhG/9y7Dk2M0gHp8sAP8y/51YHB6iHwfAaQ6eU1tJ3L8ZYG2YGU4wLkKt1TqGsrrlbwhM
        gZgrraKahsmc51y09pJVoVc3X7ipH/M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-gKP4XCQxNcGaF2kenk7H6g-1; Mon, 24 Apr 2023 23:31:11 -0400
X-MC-Unique: gKP4XCQxNcGaF2kenk7H6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 561FF38041C8
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 03:31:11 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 200C2492C14;
        Tue, 25 Apr 2023 03:31:07 +0000 (UTC)
Date:   Tue, 25 Apr 2023 11:31:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changhui Zhong <czhong@redhat.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [bug report] WARNING: CPU: 7 PID: 4059 at fs/proc/generic.c:718
 remove_proc_entry+0x192/0x1a0
Message-ID: <ZEdJYotr4ynP8we6@ovpn-8-24.pek2.redhat.com>
References: <CAGVVp+Xk025Sv-GJDRKcnhaQe0e2TonDK9zwGhWxX2KWd017+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVVp+Xk025Sv-GJDRKcnhaQe0e2TonDK9zwGhWxX2KWd017+g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Changhui,

On Tue, Apr 25, 2023 at 11:15:49AM +0800, Changhui Zhong wrote:
> Hello,
> 
> Below issue was triggered in blktests/001 test,please help check it.
> branch: for-6.4/block
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> [  304.049316] ------------[ cut here ]------------
> [  304.050033] remove_proc_entry: removing non-empty directory
> 'scsi/scsi_debug', leaking at least '12'
> [  304.050569] WARNING: CPU: 7 PID: 4059 at fs/proc/generic.c:718
> remove_proc_entry+0x192/0x1a0

This one should have been fixed by Bart's patch:

https://lore.kernel.org/linux-scsi/20230307214428.3703498-1-bvanassche@acm.org/


Thanks,
Ming

