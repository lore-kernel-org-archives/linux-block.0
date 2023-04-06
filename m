Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1191C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 05:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDFFgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFFgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 01:36:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9DE65AD
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 22:36:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z19so36564212plo.2
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 22:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680759368; x=1683351368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPlt48QE9Y5oTi/121y1naFzzLJGGJ3uLY0SGe6tDr4=;
        b=mEZcrYxso5GccKLg4IbrQ1j4pMjGZ+5LrPdwL+UxIHBFNPEg1hKbOMh5necoC+HEvS
         8eKOk8yV8ozVDixlOZOGEhx7yqF23SEBRx7POD0C4kDc2LOU7GhjCDVHZ1pEAc7eMUVp
         HJ7CnSGD9LvEwCVqJIWHLGIYTy25Ml6e/E8I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680759368; x=1683351368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPlt48QE9Y5oTi/121y1naFzzLJGGJ3uLY0SGe6tDr4=;
        b=WUWw0cSLe7J/vvfg50eL5SmcHs2EVT49cFCy428HcFGMUJ94zwxdiDzz1CyYjdv/eG
         TjbI2Yh7fI9AfInfK8SLtWVfj+8PBalJekl237ak6F7qmIUo6P32ptNFGFf14+QFFAyk
         wOg1RKOpxgWT6CckSBSvCIy2cNsarKx+qPOaUwtm4qf0xnZcPf2ylTImHqPXgUhmVrWw
         NBt0Ul52QKCEPKS/3dZtJbS/FZ+r02rn25gyAKHUXdMy8gG4jlBZ85UIu3R1YoH0YAmI
         IoyBJREwU18UP6PVduCZeP+P0o4Gs45GfL/Hs4qw7UKEo+qv7eVrbkIvZUHVuZwb3Hl5
         KVZw==
X-Gm-Message-State: AAQBX9c6TdPzv//YK9gqsR4PLj3aG7P5OcAXLnYIGOTFKeGVjr7HdQaA
        jH8+2b6a+JlwdmXzO6IxqhFmlA==
X-Google-Smtp-Source: AKy350agt2iUiZQLRcR05oC7UOuLlvsYwSfmWaNhFOaj5pKe01cy8l7Fggq4EltHXgZ5mjafo8Cy3g==
X-Received: by 2002:a17:902:e0c5:b0:1a2:57c4:2a7a with SMTP id e5-20020a170902e0c500b001a257c42a7amr7924771pla.29.1680759368161;
        Wed, 05 Apr 2023 22:36:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id a10-20020a631a4a000000b0050fb4181e8bsm318972pgm.40.2023.04.05.22.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 22:36:07 -0700 (PDT)
Date:   Thu, 6 Apr 2023 14:36:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 16/16] zram: return errors from read_from_bdev_sync
Message-ID: <20230406053603.GE10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-17-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> Propagate read errors to the caller instead of dropping them on
> the floor, and stop returning the somewhat dangerous 1 on success
> from read_from_bdev*.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
