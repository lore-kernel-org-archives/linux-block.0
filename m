Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B62C61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 09:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBPJG0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 04:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBPJGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 04:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAA537B59
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676538340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1bKKb9H/q0dXAMnVduKJ4TX8eanUuaOmqcGerklwFM=;
        b=aln4FYX3bpsADun1WtGVugsxTiNy8CQfyW0rDfCNCqrmLRkG6scp/iMBfRAR5jYBpEspqM
        /hraE1ti11Imfy4refja4atcUZTBjOuIveodHlrHn6Db3hYSVYe1ZR+T1ryYQW9rxTcbq+
        aNgeVE89c2zrJNw4gCHzQdhxcvU57/U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-4UFsiHpyNBmzI_CV5Ckr4A-1; Thu, 16 Feb 2023 04:05:36 -0500
X-MC-Unique: 4UFsiHpyNBmzI_CV5Ckr4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A329B100F90E;
        Thu, 16 Feb 2023 09:05:33 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 954B9C15BA0;
        Thu, 16 Feb 2023 09:05:29 +0000 (UTC)
Date:   Thu, 16 Feb 2023 17:05:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        ming.lei@redhat.com
Subject: Re: [PATCH 0/2] blktests: add mini ublk source and blktests/033
Message-ID: <Y+3x1YrrL/hC9NTN@T590>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
 <20230216083519.w362iawzqweilzes@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216083519.w362iawzqweilzes@shindev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 08:35:20AM +0000, Shinichiro Kawasaki wrote:
> On Feb 16, 2023 / 11:01, Ming Lei wrote:
> > Hello,
> > 
> > The 1st patch adds one mini ublk program, which only supports null &
> > loop targets.
> > 
> > The 2nd patch add blktests/033 for covering gendisk leak issue.
> > 
> > Ming Lei (2):
> >   blktests/src: add mini ublk source code
> >   blktests/033: add test to cover gendisk leak
> 
> Hi Ming, thanks for the patches. Please find my comments on them.
> Also, could you run "make check" for the blktests patches? Shellcheck reported
> some warnings in the changes.
> 
> $ make check
> shellcheck -x -e "" -f gcc check new common/* \
>         tests/*/rc tests/*/[0-9]*[0-9]
> common/ublk:19:52: warning: args is referenced but not assigned. [SC2154]
> tests/block/033:27:8: warning: Declare and assign separately to avoid masking return values. [SC2155]
> tests/block/033:27:17: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
> tests/block/033:28:24: note: Double quote to prevent globbing and word splitting. [SC2086]

Thanks for sharing the check command!

Will run check and fix them all in V2.

Thanks,
Ming

