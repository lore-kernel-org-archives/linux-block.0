Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228DDCDB474
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 00:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjJMAlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 20:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjJMAlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 20:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136E2C9
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697157624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76ut86ZyWh6juyHS1z5fLHKHaK6xTkGRwDHlm81II5s=;
        b=ZztvGzRGYXeV/CABmAXT30b/C75yS2C5oX/F2STwC+HNIZ13Sa1o3nfg8c/PpW8eIMczAL
        5j+a8fGSXpCrtc5b9AwevN2xP8sXCnHjKBTv8+Z4WXZPaZB4jjR8tUo5knnKB/HvOSa9jI
        a6NkDkvBpH+BW9WJFaZG2kkR2aOspcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-vgSh8j4_MlG7oY9--s78qA-1; Thu, 12 Oct 2023 20:40:15 -0400
X-MC-Unique: vgSh8j4_MlG7oY9--s78qA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32BFE81DA88;
        Fri, 13 Oct 2023 00:40:15 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83492202701E;
        Fri, 13 Oct 2023 00:40:12 +0000 (UTC)
Date:   Fri, 13 Oct 2023 08:40:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 2/2] ublk: Make ublks_max configurable
Message-ID: <ZSiR5uHiDeeB5V1t@fedora>
References: <20231012150600.6198-1-michael.christie@oracle.com>
 <20231012150600.6198-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012150600.6198-3-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 12, 2023 at 10:06:00AM -0500, Mike Christie wrote:
> We are converting tcmu applications to ublk, but have systems with up
> to 1k devices. This patch allows us to configure the ublks_max from
> userspace with the ublks_max modparam.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

