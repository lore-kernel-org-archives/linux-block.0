Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714A3C001DB
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 10:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjHJKfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjHJKft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 06:35:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2712CE6B
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 03:35:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so6515495e9.0
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663747; x=1692268547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRClu8OKbCccK+GpVjNM1rBXRMSXaT4uZih+XyUZcUM=;
        b=ydlNjKSA6ZQkdPYzNf3bwG0IUVOcqkw8lH9yA25W4d1bstSOk1456597VDBsXwbxOd
         zvYLglxAf7kjViw+2fB98c34g8o+EOGoEKO3f5ya6VZV0KTs8gZG76NjdnC6X3jhtruC
         iXkVQeocwN48VtpvGVeS+M3lP9ued6VD1gRt8hr02Rr0OVMIBTwuIidhzTbhbtWWRMwX
         s146xsLu1rx9WSE3R2lRYqB2/cUrr95lxTEbp2+GtB4DYPuCskgzvU9GW/CYs4uAySRS
         UNZAS6RHYnAMTtJdh1wH5+bwGfw1QorzPk3KhSII9bicYOlMGFrFHdTD/oY8VLCzprag
         HITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663747; x=1692268547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRClu8OKbCccK+GpVjNM1rBXRMSXaT4uZih+XyUZcUM=;
        b=APe2Q0nj98yb/AfvcWugWEz1nufTSt98lyRJ0xVm1L/8sZdAYjod3y/WYmTnhVu43w
         28F6X1cZaE/Y8oOSICs/n2RrV5R7sqyzhXkcP/nbX12l8EzRKMtp14otBDwD4UbrwXwT
         q3nL/M42F6b3LSZsa/30YsuqRxv75ZleSdPTpWYwTLqgHE2r/ycvE9MgeIYp/F2EW/1A
         CnReTFn6nOcy8AZZDbsWBqoGBffiqjxyJFuMVUvC9SIUKsn2ZSUnf6pZWYmIxaffmGVr
         prg7nDKRbK6gw+KmUrG47qouXfNeK/4+rlpwpG7J99r1WkXeZq3LcgX3Yoflhra5IxGA
         BfuQ==
X-Gm-Message-State: AOJu0YytwJBbl0sgnpVQbrj5rShBRz8dkL3X+ec9oJd6OtvuVuzVYsnq
        qj8gm4YWwoCyrNgaselURTDZGQ==
X-Google-Smtp-Source: AGHT+IGn42OkTxCreENUDG1eZEjFZjr/1puXM7aIIicE3k5SY+MeZfPRTgEkrqysv99Y1Uem9qSl5w==
X-Received: by 2002:a05:600c:290a:b0:3fe:2219:9052 with SMTP id i10-20020a05600c290a00b003fe22199052mr1712516wmd.18.1691663747607;
        Thu, 10 Aug 2023 03:35:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n12-20020a7bcbcc000000b003fe557829ccsm4567309wmi.28.2023.08.10.03.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:35:47 -0700 (PDT)
Date:   Thu, 10 Aug 2023 13:35:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     a.hindborg@samsung.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] ublk: enable zoned storage support
Message-ID: <d74153a0-6b0c-4416-8190-c845c89d8b5c@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Andreas Hindborg,

This is a semi-automatic email about new static checker warnings.

The patch 29802d7ca33b: "ublk: enable zoned storage support" from Aug
4, 2023, leads to the following Smatch complaint:

    drivers/block/ublk_drv.c:1404 ublk_commit_completion()
    warn: variable dereferenced before check 'req' (see line 1401)

drivers/block/ublk_drv.c
  1398          /* find the io request and complete */
  1399          req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
  1400  
  1401          if (req_op(req) == REQ_OP_ZONE_APPEND)
                           ^^^
The patch adds an unchecked dereference

  1402                  req->__sector = ub_cmd->zone_append_lba;
  1403  
  1404          if (req && likely(!blk_should_fake_timeout(req->q)))
                    ^^^
The existing code assumes req can be NULL

  1405                  ublk_put_req_ref(ubq, req);
  1406  }

regards,
dan carpenter
