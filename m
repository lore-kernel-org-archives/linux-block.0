Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EF0C07E9D
	for <linux-block@archiver.kernel.org>; Sat, 24 Sep 2022 01:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiIXBCx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 21:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiIXBCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 21:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22210124C09
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 18:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663981370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6h7ahkgH3oZ8yUGMt1JuU5Bc7gd3yRGFoO+sQHOHhUs=;
        b=dyyPk0O7gPW8+0DGLoiqDrCrdmtmm1rLh0wEnaRpt1/etXopTJaQQu0pBOtRPEfZ9pz6/S
        CCIOVr4O3cCpbCAthYikTOjroAvhqUVkiZUfADUvNkc3+65TwXp4NSzVnDQJaba1WoRwD2
        OZpaupjAVky57mwcRXKR72gID3cTMEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-Q2ncmA88OL-grLEDwxQZFA-1; Fri, 23 Sep 2022 21:02:39 -0400
X-MC-Unique: Q2ncmA88OL-grLEDwxQZFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16953101A528;
        Sat, 24 Sep 2022 01:02:39 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD3D840C2064;
        Sat, 24 Sep 2022 01:02:33 +0000 (UTC)
Date:   Sat, 24 Sep 2022 09:02:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V6 7/7] Documentation: document ublk user recovery feature
Message-ID: <Yy5XJOuvFH+2dXfP@T590>
References: <20220923153919.44078-1-ZiyangZhang@linux.alibaba.com>
 <20220923153919.44078-8-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923153919.44078-8-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 23, 2022 at 11:39:19PM +0800, ZiyangZhang wrote:
> Add documentation for user recovery feature of ublk subsystem.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

