Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E2DC43334
	for <linux-block@archiver.kernel.org>; Mon, 13 Jun 2022 03:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiFMD33 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Jun 2022 23:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiFMD31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jun 2022 23:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD37F1A80B
        for <linux-block@vger.kernel.org>; Sun, 12 Jun 2022 20:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655090965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d7lelOyaghHCGHT5Hdiu5y3UeqylUZluyrjfLETc/UU=;
        b=SDtArnv3aQp69U7hegYnietoI9ZbxKPk2r9u6FEnehA27/bOHGqhz/dXINIDENjvlvPFzl
        CC+2S/NGltBYIgP9mLjYZvqK9ncL9wHtoJ8g4diNLTy29ErR6W8fYw4ETYBXG7FPvxNSKk
        atKtv69BqrInhlIAlpNNDWuM48CZT2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-9GWpwyEyMrmQztOWcRU11A-1; Sun, 12 Jun 2022 23:29:24 -0400
X-MC-Unique: 9GWpwyEyMrmQztOWcRU11A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F4EE801755;
        Mon, 13 Jun 2022 03:29:24 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E78CB1410F34;
        Mon, 13 Jun 2022 03:29:20 +0000 (UTC)
Date:   Mon, 13 Jun 2022 11:29:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed from blktests on latest
 linux-block/for-next
Message-ID: <YqavC8hwLXwPVnor@T590>
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 12, 2022 at 03:23:36PM +0800, Yi Zhang wrote:
> Hello
> I found below kmemleak with the latest linux-block/for-next[1], pls
> help check it, thanks.
> 
> [1]
> 75d6654eb3ab (origin/for-next) Merge branch 'for-5.19/block' into for-next

Hi Yi,

for-5.19/block should be stale, and seems not see such issue when running blktests
on v5.19-rc2.


Thanks,
Ming

