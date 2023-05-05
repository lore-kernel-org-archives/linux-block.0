Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E75C77B7F
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 15:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjEEPk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjEEPk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 11:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B301490D
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683301181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpYNTETJg0Gdwy3sK/T9/IUeZZpYaq3vxFkxBeJ7rFY=;
        b=NLtVr7GPQlvjCoSS8EQTYT9cicUQKUAttyuykHbG4lyfm7AMbTamCE2vN7+wHWgAVzr9At
        3RccVanX330NgGRPXpN/u7Q6Xdwpm2cp19Zn0xj11/cii6ZP8HpEg+EyH5E3aTXEoVJ5ms
        B0v/92jJaqDcTYFUhbxkZgB2QlULK74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-2yCcpy35N_eMcTr-fdeRbQ-1; Fri, 05 May 2023 11:39:37 -0400
X-MC-Unique: 2yCcpy35N_eMcTr-fdeRbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DFF0185A7A4;
        Fri,  5 May 2023 15:39:37 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B0FC1603B;
        Fri,  5 May 2023 15:39:34 +0000 (UTC)
Date:   Fri, 5 May 2023 23:39:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Subject: Re: [PATCH V2 blktests 1/2] src/miniublk: add user recovery
Message-ID: <ZFUjMRe+hs69JZb3@ovpn-8-16.pek2.redhat.com>
References: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
 <20230505032808.356768-2-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505032808.356768-2-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 05, 2023 at 11:28:07AM +0800, Ziyang Zhang wrote:
> We are going to test ublk's user recovery feature so add support in
> miniublk.
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

