Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A266CC83F2E
	for <linux-block@archiver.kernel.org>; Thu, 31 Aug 2023 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjHaPX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Aug 2023 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjHaPX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 11:23:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7439610CA
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 08:22:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77dcff76e35so5317239f.1
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693495363; x=1694100163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeUnej4i11t4yvLP6817AMepBkb0Ze/qMBeAYEk0yRc=;
        b=MMviiAje9OSQwvl9RrxhYvsf/zYaouRlqqrMdn955iQsVKQCbyTmspMsOWorsEXm0Z
         WxOEVn8xuEEnPZZF49IwGFna+kNHVsL+o+QqVzVGfBlJ5xC3NwcplgSlarqPAh2zwEgm
         0qNhpIUKZSdPAnRSggirQfwdvN1FokZ0zUkwfiu8BZAcaMSWthii23mKi1mUvP9jKpbs
         h9QIFUDVdgY/rg7h60ZRo/ZUfa1smSokOBhfqRI9+h8zY9KIBj5ASBSeXy4XGAYyv7b+
         Gy1wur2nY4hzZdH0UQqtpCBpdxFVTcOIpCY38w12st1pEdGoAbIBW68wwXztt3lhRhuQ
         5oYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495363; x=1694100163;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeUnej4i11t4yvLP6817AMepBkb0Ze/qMBeAYEk0yRc=;
        b=gVMaka+WxiPMRt8TLSxv1+ZLr/EMB/1z35EdSekcIjn6d6iEVsiIYi166jo4uJF1PJ
         SajfSYVVmY9oBkRkzSdEXJfIBRSKLqZbkrwqjfToX0h2cpdoSteKlCXLkF4tyThJludT
         GrZVDPythibZAgm4c3dUIrhg1jNRWg8ZNsj95lDYoWD1ZCod5mBlxRSp2R9FFxSXvEJb
         G6WjCsnwBVinySvN/SFyO+rGKDk/5ADEOjTCYDngwXMDBuCCiNRjTYelKerMPdHkcBw0
         ZonoVlYXucw1jRhjvqQkfneSvYDNfON80O9jVpnckxDwRTPwekiqSfcBC9SJOLGU3E4A
         2Auw==
X-Gm-Message-State: AOJu0YwOMpmk56Jkkc2SOTvd9ifZ8C/NC8hiv0z3Amw8m4AhOLmxkTHe
        cuJaGXlC3GUl/YdC/HRrWO6szcjOX880+hwBkYo=
X-Google-Smtp-Source: AGHT+IFo2yn7s3i7aid7ryGEBzi50U3hqYyA5xbELBVEhv+7tF5+gtzWsVgS0DP++pDdvXELXA1LDg==
X-Received: by 2002:a92:d950:0:b0:345:e438:7381 with SMTP id l16-20020a92d950000000b00345e4387381mr4914940ilq.2.1693495362926;
        Thu, 31 Aug 2023 08:22:42 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y3-20020a92d803000000b0034cc253a78esm472472ilm.51.2023.08.31.08.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:22:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230831121911.280155-1-hch@lst.de>
References: <20230831121911.280155-1-hch@lst.de>
Subject: Re: [PATCH] block: remove the call to file_remove_privs in
 blkdev_write_iter
Message-Id: <169349536177.200662.13616359327161836541.b4-ty@kernel.dk>
Date:   Thu, 31 Aug 2023 09:22:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 31 Aug 2023 14:19:11 +0200, Christoph Hellwig wrote:
> file_remove_privs instantly returns 0 when not called for regular files,
> so don't bother.
> 
> 

Applied, thanks!

[1/1] block: remove the call to file_remove_privs in blkdev_write_iter
      (no commit info)

Best regards,
-- 
Jens Axboe



