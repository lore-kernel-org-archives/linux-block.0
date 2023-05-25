Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123CFC77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 11:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjEYLPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 07:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjEYLPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 07:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EF21A6
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685013265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbpysuvAnigwLpQ6a7lIr7FVY+tZljiyWqend9F9Q0E=;
        b=DGLC9kdJv8A3Ef6k8y7x1t2VhGoOImnRIieNR5S5FbGFNJ8UxIvxG149nOzVdUrt7kh9GL
        59Tl2zPULmwQzzV+GDFTqG2u3s/qGiPYmDLoXjxHL2x2M60u4fZDdNRvj5S57Iowlg8WWh
        KycBqU6+n9dOmhTWwV+UQdmv26k4rcI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-yFXFmVzBMRiSrO-OVHQdzw-1; Thu, 25 May 2023 07:14:22 -0400
X-MC-Unique: yFXFmVzBMRiSrO-OVHQdzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 520F085A5A8;
        Thu, 25 May 2023 11:14:22 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6B72C154D1;
        Thu, 25 May 2023 11:14:19 +0000 (UTC)
Date:   Thu, 25 May 2023 19:14:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Subject: Re: [PATCH V3 blktests 2/2] tests: Add ublk tests
Message-ID: <ZG9DBiG7qRyaPdHW@ovpn-8-21.pek2.redhat.com>
References: <20230524085541.20482-1-ZiyangZhang@linux.alibaba.com>
 <20230524085541.20482-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524085541.20482-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 04:55:41PM +0800, Ziyang Zhang wrote:
> It is very important to test ublk crash handling since the userspace
> part is not reliable. Especially we should test removing device, killing
> ublk daemons and user recovery feature.
> 
> Add five new tests for ublk to cover these cases.
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

