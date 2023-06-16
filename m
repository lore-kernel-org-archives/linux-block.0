Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C29EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 16:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjFPQNC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFPQNB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 12:13:01 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA82D6A
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 09:13:00 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-760dff4b701so10303339f.0
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686931979; x=1689523979;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJPRL/5amBMOrAk4tz1IUWWqLcGNFvy3N6xi6eBZgB8=;
        b=TbuYYlHnePGu+Uskg0qvoJzqwZF+Mns8o/z/Aq8MdtYoz2eRW9bvXEVMfqtMMCaJia
         jDcOznAQkzWoQm2tgZK5Wa/fuPpp9jvA8rOLSWNGgv9NGSF99VoRKMH+Sc/miYrQAhZ1
         6hZ1rHrT01V5bHMQLti/WsJf1U+DarVV9c30sJkBRQQjSuadgCk1ev/2RwFTktXA4Vwn
         +A0ExLZf+vSTyluAEFtfijEvi1OWgz4JEhI7gnpLyJ3LGVEhiMS5DoAchDzjybYd6f4h
         yDeJx9+w1OFOfTGlzxGlaziKgL9JAwUD4mDTl2+7SLk0lnEbUw37BzVKNRi8zUYNxJdi
         5MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686931979; x=1689523979;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJPRL/5amBMOrAk4tz1IUWWqLcGNFvy3N6xi6eBZgB8=;
        b=hKSwE28NtfubeL17YILld1oadEOzBWfgNy1hjKWUFB3fxeeeZmYZ2K6Xscq7xtHL9C
         l75vE7oXkfpgsjb0ao86DBfAo/WP+dpOHwgrW1CvAXuUxEnicS4MU117zKjfVM1QUpCk
         NZsym2wA3piwAfcBJPq6ByFk5Z4cPec3lyaOGEDrG8dGLtuqfrhv3staZDOplWiCJOrK
         GXxq/URieFSr4GXBz0tzoVZKVEMvgFlQnU6sdSpbsiwV65zz7L7SGrWqNAfdJOzGg01c
         R2up3KL9az2Us3m75rIHC+KLihHxK2S9bdkkji7hTNWkWyj+70XbZ0iqDVFNDDEZl0KC
         hudg==
X-Gm-Message-State: AC+VfDwx83p+PVXZAJFGyn04Ybm4HhifDQAKds8ZViwhbcVFepyctXXF
        UGGUPrXzZl6FvRty3s9Nou5wvbxqP7S3KvUjuMM=
X-Google-Smtp-Source: ACHHUZ6x5HHBjKxoGj6OgFIVfiiTaEtWdyo98wcaxMDhcdBs42G3S1I5+727AKhU5erijMiHnhRuUg==
X-Received: by 2002:a05:6e02:216f:b0:33b:6751:fc71 with SMTP id s15-20020a056e02216f00b0033b6751fc71mr3497905ilv.2.1686931979621;
        Fri, 16 Jun 2023 09:12:59 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o8-20020a02cc28000000b004186bea7f51sm6333403jap.54.2023.06.16.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 09:12:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>
In-Reply-To: <20230616132354.415109-1-ming.lei@redhat.com>
References: <20230616132354.415109-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: fix NULL dereference on q->elevator in
 blk_mq_elv_switch_none
Message-Id: <168693197863.2454997.502384811256816015.b4-ty@kernel.dk>
Date:   Fri, 16 Jun 2023 10:12:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 16 Jun 2023 21:23:54 +0800, Ming Lei wrote:
> After grabbing q->sysfs_lock, q->elevator may become NULL because of
> elevator switch.
> 
> Fix the NULL dereference on q->elevator by checking it with lock.
> 
> 

Applied, thanks!

[1/1] blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none
      commit: 245165658e1c9f95c0fecfe02b9b1ebd30a1198a

Best regards,
-- 
Jens Axboe



