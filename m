Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ACEC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 08:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiCBI0s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiCBI0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 03:26:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 897A8B82D9
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646209562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtrInDoeeooDXLH4/ASDNuBM89b2Da/ya3ncv+m8FWA=;
        b=Dj0qUGBEBdb1PyFKVrQHSAuZA1MHlK1p0CbLFzB+2giIG8HTPLn5pPcq5Hm7H2fH1zqWXf
        HU+XpXYodwSpy/j/VMFnnz/30qrtRFA2gA7A304QjS5miZhpXyk8j2DimJ57+0pLQRcHxM
        RZYctjoV/+fkvP+JLeERzvTMOd1A/I4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-sAHRB3rVNm6CEswhqULziw-1; Wed, 02 Mar 2022 03:25:57 -0500
X-MC-Unique: sAHRB3rVNm6CEswhqULziw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F944824FA7;
        Wed,  2 Mar 2022 08:25:55 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 629027FCE4;
        Wed,  2 Mar 2022 08:25:49 +0000 (UTC)
Date:   Wed, 2 Mar 2022 16:25:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>, yukuai3@huawei.com,
        linux-next <linux-next@vger.kernel.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [next-20220225][Oops][ppc] lvm snapshot merge results kernel
 panics (throtl_pending_timer_fn)
Message-ID: <Yh8qCS5JM8ZbtqY4@T590>
References: <d583adf0-2d98-60b6-620c-722912c05852@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d583adf0-2d98-60b6-620c-722912c05852@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 01:31:39PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> Linux next kernel 5.17.0-rc5-next-20220225 crashed on my power 10 LPAR when
> merge lvm snapshot on nvme disk

Please try next-20220301, in which the "bad" patch of 'block: cancel all
throttled bios in del_gendisk()' is dropped.


Thanks,
Ming

