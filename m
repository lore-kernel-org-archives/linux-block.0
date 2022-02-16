Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B57C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 18:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiBPSgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:36:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbiBPSgi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 13:36:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D12B02185
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645036583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aEnh4v2rUd+a1mRZO11npkIbStQoEjtYz9jOrVTs9y0=;
        b=DJRnMe0VEP9Ur9sVt0dRRMLC3CxmIh9a8LLd8P+xWiGm+eLwJtn6Dmdwqq1iEea+5sBMO5
        GQ4Sl303eXQ+K/fs8w5GTIO88LBRzDTxsGXn3PP1DPstFo3px1X943xz6Us8JdOUlGEEXP
        n408DPG0eG40fJLhROsqAMwPSyL4pkw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-jZdQyvpJNQa_i6wyVHYDAg-1; Wed, 16 Feb 2022 13:36:22 -0500
X-MC-Unique: jZdQyvpJNQa_i6wyVHYDAg-1
Received: by mail-qk1-f200.google.com with SMTP id x16-20020a05620a449000b00508582d0db2so1957470qkp.0
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEnh4v2rUd+a1mRZO11npkIbStQoEjtYz9jOrVTs9y0=;
        b=WHLMkepRHmtkkgX4+ts53/bJQW6YO2WynWv5M1ZKCS6Elf7qf5jybrYOSlGs/5Zab6
         Twt1W55YNwAO1oMSLfOFIrrH/Id7RIiIM34zvQD8yeujzvRQEk1aIgToXURY/I+QLMqd
         2NOydDwL/U0vNs/4G9QxaIkIhpNze891tsgAdxPqmJUshYnj/Cll14ni7moJAZLatZdB
         SGicQyMpSHPg/DNbxwyQbCkSOYxqtkCEnRm8k/LvuBUR/vfRgouLeMNi0hHmTvk+tDr5
         h34AG5l6VG3GPlBCQp4s3l8QyYHy+UJa4F17+lp88NrI1Il8ajnMHvoKz0Z2WwtGuF5P
         N4AQ==
X-Gm-Message-State: AOAM530fwnKDmlWBLQ5WM3N7pVDQN1XWtPIkFteuWuJ7L/bhSO458o3R
        jJl8mZ5MP1ZoYX3zDcs9QI/uz7TzNosN7IMDdSnFIluC1hchHEsdWXEJTH5qI29nWEW5uar5MnM
        ByHh/dRgV4C5wu536yx5IzA==
X-Received: by 2002:a05:620a:1a97:b0:60c:8807:712a with SMTP id bl23-20020a05620a1a9700b0060c8807712amr926157qkb.136.1645036581600;
        Wed, 16 Feb 2022 10:36:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhm0NtOyBgT+M+J0kPaNZXBLv99NvrTO8Ft/L0Gx8719csCia04TnDe9rCguvIwbrKCyb58w==
X-Received: by 2002:a05:620a:1a97:b0:60c:8807:712a with SMTP id bl23-20020a05620a1a9700b0060c8807712amr926144qkb.136.1645036581408;
        Wed, 16 Feb 2022 10:36:21 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y9sm13100691qtx.85.2022.02.16.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:36:21 -0800 (PST)
Date:   Wed, 16 Feb 2022 13:36:20 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: make the blk-mq stacking interface optional
Message-ID: <Yg1EJFq2P4e8+6xn@redhat.com>
References: <20220215100540.3892965-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215100540.3892965-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15 2022 at  5:05P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Hi Jens,
> 
> this series requires an explicit select to use the blk-mq stacking
> interfaces.  This means they don't get build without dm support, and
> thus the buildbot should catch abuses like the one we had in the ufs
> driver more easily.  And while I touched this code I also ended up
> cleaning up various loose ends.

All look good to me, thanks, for series:

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

