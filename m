Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E2BC77B7D
	for <linux-block@archiver.kernel.org>; Sun, 14 May 2023 12:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjENMZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 May 2023 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjENMZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 May 2023 08:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D47526BB
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684067093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3UvmbOpQ6skvBeMzOmFe4aUD1J4TH7QDbBT4fBbI/o=;
        b=b+z7gh+RsBTnuDK4q+X77phXX3Nf+cJDUIfSdekjD5T36UvY1trcaUcPPOfivbbMJItkwK
        XB0II6mVyzFGOjDBRMuGsKbkA8VRfXtzb5TuQ1xehfwgaPjQFqJkIaOmKsQq2Nu+rBwUQX
        lkDv35PsXQyVNzp4gOjN8kYiV/fhQfc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-bXbk9cerMA-0jPas9l9fFg-1; Sun, 14 May 2023 08:24:48 -0400
X-MC-Unique: bXbk9cerMA-0jPas9l9fFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 832253C0CD3F;
        Sun, 14 May 2023 12:24:48 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97E0C2026D25;
        Sun, 14 May 2023 12:24:34 +0000 (UTC)
Date:   Sun, 14 May 2023 20:24:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guangwu Zhang <guazhang@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZGDS/uBDufEDrSVw@ovpn-8-17.pek2.redhat.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <CAGS2=YqeDg5CEwFsaHfY84rCw_qhQ4=M0-v=rbdYX=6KvMmvDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS2=YqeDg5CEwFsaHfY84rCw_qhQ4=M0-v=rbdYX=6KvMmvDA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guangwu,

On Sun, May 14, 2023 at 08:11:34PM +0800, Guangwu Zhang wrote:
> Hi.
> Don't reproduce the issue with your patch, but hit other issue, please
> have a look.

Can you share your test case a bit so that we can see if the warning on
qla2xxx is related this patch?


Thanks,
Ming

