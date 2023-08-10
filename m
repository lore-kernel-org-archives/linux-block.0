Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D30C001DE
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 09:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjHJJVi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHJJVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 05:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D146A9
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691659086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCpvjGRV9TAD3foyhqRHy9bTJoBNpeC1r6qbYuF0Dlg=;
        b=GNe5kFjoptCmKs+rMU047BLhU4/ALjYYq1Odb1FBcUI+MLjqGdWcVSBobyuPdLeMDVH3Hu
        MmBkqUgShpgltXeoyyfo4IeDG4fYpw7+BZNkNWB4zGCn7yNBj0PabHmoC11JgjaNRA6rse
        8U+KeYJq9NUxbJ/Hg3w5Cx6nsJEVp4I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-14KIsuPWO-an0hPQX6Rzsw-1; Thu, 10 Aug 2023 05:18:02 -0400
X-MC-Unique: 14KIsuPWO-an0hPQX6Rzsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AC4B29DD998;
        Thu, 10 Aug 2023 09:18:02 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32B5740C6F4E;
        Thu, 10 Aug 2023 09:17:58 +0000 (UTC)
Date:   Thu, 10 Aug 2023 17:17:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     axboe@kernel.dk, a.hindborg@samsung.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH -next] ublk: Fix signedness bug returning warning
Message-ID: <ZNSrQp+KT02M+GTZ@fedora>
References: <20230810084836.3535322-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810084836.3535322-1-lizetao1@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 04:48:36PM +0800, Li Zetao wrote:
> There are two warnings reported by smatch:
> 
> drivers/block/ublk_drv.c:445 ublk_setup_iod_zoned() warn:
> 	signedness bug returning '(-95)'
> drivers/block/ublk_drv.c:963 ublk_setup_iod() warn:
> 	signedness bug returning '(-5)'
> 
> The type of "blk_status_t" is either be a u32 or u8, but this two
> functions return a negative value when not supported or failed. Use
> the error code of the blk module to fix these warnings.
> 
> Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202308100201.TCRhgdvN-lkp@intel.com/
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

