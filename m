Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1928CC77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 11:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbjEYLOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 07:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbjEYLOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 07:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD1719A
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685013198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3JvMIU+W09HH4hSNRujG7GOmkp8Hor3i9UZeLeQADk=;
        b=PgAGP6BXvwgx8DQpUNhbUz9JeJIyVEyLGNCl88JDa5FUSAdtUP4weH+y6ioGEfYjzZnQn7
        us/ai5A5YXUUaxtivy3YYw7fIsTs0GS/MnXoZD+SBh1qvz4tbqjn9cuEjNCBj8U1fAhMi7
        9MrqeS5nizlWIrgZHA+kuyI3Iqp+7Ho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-Ii5j6CeHMESct1rDSTZUwg-1; Thu, 25 May 2023 07:13:15 -0400
X-MC-Unique: Ii5j6CeHMESct1rDSTZUwg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACDBA8032E4;
        Thu, 25 May 2023 11:13:14 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32071492B00;
        Thu, 25 May 2023 11:13:11 +0000 (UTC)
Date:   Thu, 25 May 2023 19:13:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Subject: Re: [PATCH V3 blktests 1/2] src/miniublk: add user recovery
Message-ID: <ZG9Cw3cG/yymswuw@ovpn-8-21.pek2.redhat.com>
References: <20230524085541.20482-1-ZiyangZhang@linux.alibaba.com>
 <20230524085541.20482-2-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524085541.20482-2-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 04:55:40PM +0800, Ziyang Zhang wrote:
> We are going to test ublk's user recovery feature so add support in
> miniublk.
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

