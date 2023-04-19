Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D55C77B73
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 12:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjDSMpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjDSMpn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 08:45:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7DA3C1F
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 05:45:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b78525ac5so1315884b3a.0
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681908340; x=1684500340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWkATxwUI54Wjf29X1y6InilmbSwGYCaupz7wL2xoYA=;
        b=V/Zcy6Qn3ntP2MHoNED004N6bQmV9wF3ftWYZh6tBptsdhl634WOoMOrhxWZa09I0E
         BhbUDuv3/vLqZQ3/fuC0QJi4YYd6uwouwggm+7jdkzU9qjrzbrWNa2UORInkpFcnVCHg
         xIqXThcvzQMSqo6MOmPMDbyGP2XRWEalPvVi47srhbKaPo3iKAIPhFnkLhPeO9q8LvFb
         CdDM9FLOXiV0XIhZiQOKkbwjfp3Ycbb6kxNdOikLX/rI2yPmTfRO0OBIbLaFAI1ybmvr
         x1JzceTadJIKEShma9KMfX8wo/OeN/RW3l74s5Wl3nxYqBfCwilA6DnJG9f4VeyL0Vzo
         Mx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908340; x=1684500340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWkATxwUI54Wjf29X1y6InilmbSwGYCaupz7wL2xoYA=;
        b=O69Vwey63ZaEyJNlGaa91Ki5FfssRbYQ2M/zsatN/h35YESfecXC7xaMgnrXFFI7Z/
         FX33QzkroWIh6+RSkyw+RIM1oJD719U84DKYG7BwVdvTA6NAxHVsFq2xS3LDGF/N/Phs
         V+WIksuPuJFbtUNtsMMJV3WdxQjDzv+EIOEoa9pmtJrm8TGuppb1ORZYqCyc0onFDNVL
         eBuPQXLbE/3taPS1vki+JSPzOmoW1WcJNA3un9Hrr8cNJtX6024SmS7KgrEVC4Jsb8gy
         NtEF2jLY7BuuXW+yUxqXXqeAryq3JFDt0/Vou9M/wTIdlOxEZGRrIyFW3tyB0skX9Qfc
         fvPw==
X-Gm-Message-State: AAQBX9fd4UDByA6dN7OJJn+5zt+M3yLCCi1W40upoDiBjlBnNw+zaxWX
        F+SfYhr6gGltfe950P6/s/cqh9o4XunDjP7GwFY=
X-Google-Smtp-Source: AKy350YZ068gLQ817k+Ij6jge/IubKk6mC1ANeALBOZN7osif6ym1dK+BGMD9/8chbAcO3bPTjBUtQ==
X-Received: by 2002:a05:6a20:3c92:b0:f1:1ab5:5076 with SMTP id b18-20020a056a203c9200b000f11ab55076mr3391077pzj.2.1681908340445;
        Wed, 19 Apr 2023 05:45:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e17-20020aa78c51000000b0063b79bae907sm7731602pfd.122.2023.04.19.05.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:45:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     David Howells <dhowells@redhat.com>
Cc:     Ayush Jain <ayush.jain3@amd.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1770755.1681894451@warthog.procyon.org.uk>
References: <1770755.1681894451@warthog.procyon.org.uk>
Subject: Re: [PATCH] splice: Fix filemap of a blockdev
Message-Id: <168190833944.417103.14222689199936898089.b4-ty@kernel.dk>
Date:   Wed, 19 Apr 2023 06:45:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 19 Apr 2023 09:54:11 +0100, David Howells wrote:
> Fix the new filemap_splice_read() function to get i_size from
> in->f_mapping->host, not in->f_inode so that it works with block devices
> too (in->f_inode points to the device file, which is typically zero size).
> 
> 

Applied, thanks!

[1/1] splice: Fix filemap of a blockdev
      commit: 5a9515a407d1aec1dd76c24fe99d9981730b74fb

Best regards,
-- 
Jens Axboe



