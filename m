Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4059C636D7
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 02:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBMCi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Feb 2023 21:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMCi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Feb 2023 21:38:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F51BF3
        for <linux-block@vger.kernel.org>; Sun, 12 Feb 2023 18:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676255869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QuL61XvFmiacFTLyythNDoZAC7AZvsH4GcjyynvJnMY=;
        b=S1r47MH6cWtw0+6I4PMCEvDlYeX6nrRgXtXKTOl11Hu0S89Li46OjaVjB1h02VBbp6CaE9
        uONZtFY184ietVGUNalrjdjkLxZb30hA3COHqmQbl55zo5pKIdJgWCjGrLujajXXK6asCJ
        zjPLP1SSfpqRCsAvJhb/JHjA04Dl5yw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-qdRlb8xTPzGPo5zI2Oc1rQ-1; Sun, 12 Feb 2023 21:37:44 -0500
X-MC-Unique: qdRlb8xTPzGPo5zI2Oc1rQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12FFD101A55E;
        Mon, 13 Feb 2023 02:37:44 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E8A32026D4B;
        Mon, 13 Feb 2023 02:37:38 +0000 (UTC)
Date:   Mon, 13 Feb 2023 10:37:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jim Harris <james.r.harris@intel.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH] block: ublk: check IO buffer based on flag need_get_data
Message-ID: <Y+mibLjCjiDXoPRt@T590>
References: <20230210141356.112321-1-xiaodong.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210141356.112321-1-xiaodong.liu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 10, 2023 at 09:13:56AM -0500, Liu Xiaodong wrote:
> Currently, uring_cmd with UBLK_IO_FETCH_REQ or
> UBLK_IO_COMMIT_AND_FETCH_REQ is always checked whether
> userspace server has provided IO buffer even flag
> UBLK_F_NEED_GET_DATA is configured.
> 
> This is a excessive check. If UBLK_F_NEED_GET_DATA is
> configured, FETCH_RQ doesn't need to provide IO buffer;
> COMMIT_AND_FETCH_REQ also doesn't need to do that if
> the IO type is not READ.
> 
> Check ub_cmd->addr together with ublk_need_get_data()
> and IO type in ublk_ch_uring_cmd().
> 
> With this fix, userspace server doesn't need to preserve
> buffers for every ublk_io when flag UBLK_F_NEED_GET_DATA
> is configured, in order to save memory.
> 
> Signed-off-by: Liu Xiaodong <xiaodong.liu@intel.com>

Good catch!

Fixes: c86019ff75c1 ("ublk_drv: add support for UBLK_IO_NEED_GET_DATA")
Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

