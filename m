Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FEFC76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 13:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbjDENhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbjDENhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 09:37:22 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68249F9
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 06:37:21 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-75d1e0ff8ecso740139f.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680701840; x=1683293840;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n3Dd3wLUrv6THF4QasOZFx/ZAjwTDcu8/29+Cnketk=;
        b=EJUwJE2db/kuNms39eohucGNWESj9Vuc1oM/6xGOpmWN7Ai7RQkPCtXGkCyBSaXzMo
         3MXjE4nATna9CJXtjiHk4tUkNrRvZZump40KwkLE3WFaMEzfitslqeWOLKadckqeOH5j
         zCWC41F8tDXx7oIVk6CemSnCe/sKWMMNXl9CNUh6g+xB3KSQ5B1zPAWl9fHgEXWQPAKA
         CDzlqIzZhaVXrGpxAMCPa8Z3JdTWYLeULvoYBy+ZEZexfNy5IqcGcUb+d61H8fL2L+S7
         iNRWGc/pWmGLAS51QeciELoSZeDWhrfMst4dlzwnZQt1ODIAW/p4j8Hy3N7x7g0FL0OD
         TMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680701840; x=1683293840;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7n3Dd3wLUrv6THF4QasOZFx/ZAjwTDcu8/29+Cnketk=;
        b=n4kODbXC85ZNmr1sB/fPVz3hXYYe5iS3ZED5cyFzRP1+MkBkG1wDXU/sG0So4co3gL
         sdBuOf/g/Mt40hVUYNN6JCJASTkZjuLhFmHjVNQ3O4qvWUSLbBFm7+lRZRg+BD2guY2s
         Am2+QLa0W0uxXJXz4AlreVzJAHlJ4QvNWN8BlLukR6IYcdRmkjsssiEOSS3bwIa2ku6L
         N7Q9xRHyeg0GUDy2DD+PVh+/WZaKls98RMFOvuah3Nj7qnIIetOo3piwGd+mVIGmVg2T
         DRKNReAFS7im15UEoXFpAcvZ1mXWuSAabU32XKi21aSBmwpLpelyGrKNcW3v9HXhwRYK
         WfBA==
X-Gm-Message-State: AAQBX9fp1lhgCaJTrGH9lN2IFeH8b9WMkxRjlBe4XTRPR0CR9qScEFFd
        xRLUGyfb2S9fUXT8Bcjipv7wow==
X-Google-Smtp-Source: AKy350bz00fEFRi/9hCOEIHnt3vZTqhFxkc9MqZ0YsNJDytuzyoGRJ58X1C9Cg6KmkPzNWJlKDHvHw==
X-Received: by 2002:a6b:b48f:0:b0:758:5525:860a with SMTP id d137-20020a6bb48f000000b007585525860amr1312027iof.0.1680701840316;
        Wed, 05 Apr 2023 06:37:20 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u19-20020a02b1d3000000b0040b4ac6490dsm680489jah.96.2023.04.05.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:37:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20230403142543.1913749-2-hch@lst.de>
References: <20230403142543.1913749-1-hch@lst.de>
 <20230403142543.1913749-2-hch@lst.de>
Subject: Re: [PATCH 1/3] iov_iter: remove iov_iter_get_pages
Message-Id: <168070183967.176456.4699260871355757122.b4-ty@kernel.dk>
Date:   Wed, 05 Apr 2023 07:37:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 03 Apr 2023 16:25:41 +0200, Christoph Hellwig wrote:
> All previous users have been converted to the FOLL_PIN based interfaces.
> 
> 

Applied, thanks!

[1/3] iov_iter: remove iov_iter_get_pages
      commit: b6eaf73268c819c170266ba1b83e4d08f973aea5
[2/3] iov_iter: remove iov_iter_get_pages_alloc
      commit: ce6b98c2d64bcb9bf4844800ec4e0ebf130ce3df
[3/3] iov_iter: remove the extraction_flags argument to __iov_iter_get_pages_alloc
      commit: 1b8d72fb6bea91d2fbfa487891d2ddbcb85f7eda

Best regards,
-- 
Jens Axboe



