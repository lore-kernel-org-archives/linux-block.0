Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C7EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 13:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjFUNiv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjFUNir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 09:38:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8C1BE1
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 06:38:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b693afe799so1293725ad.1
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687354723; x=1689946723;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wjySKlFfVJ4j68/mqlZtrLJlc1cQIp4NWX5JkHqvsg=;
        b=H/IeBSu7Mm4WlNaGHALwaWvGOnYsXOJtiwXNe/vN4ICFGfIZliFkvnIXp/QmegX+UP
         Ogo7PTbW5mNHz4FV0PdTmjEdGQzXPa2JZn2YTYVnvm0ZJ0uHiw7b2eStW1E5gsixI4Mc
         K+bGPvogSjeaPlcJHTWf2Erz+SBPMKaZeyjWYrUM8h9wl2+CTftTserdq9h2/+OW4qv0
         pDsaTu6K39aMvK1BZ2JOwuItdrabzHR/Thaq/gnZ88mDfRPIOmpRBwxI1NbEvwTv8mQJ
         1wslXzrqsAuz0FZf0bpfMP/ZF4voIhdYJ1VqzIGL/ApeRN2TIS1xrx8zCm1Th/aeqijs
         X8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354723; x=1689946723;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wjySKlFfVJ4j68/mqlZtrLJlc1cQIp4NWX5JkHqvsg=;
        b=ijdsdoE3H9HgxK+rb/Cv5tL5cT+qf0WLIYsZrjCdAb2y4LAIiGT7CBIqzqUrzrI/RR
         Vqi7/MW3vHWbVS52i8eDh8PEL6LPYvsi5/s1hvVxdhzZ8+8uuC5WDqAXNBsJ0YaxgIJ6
         V1NmEVOse7Vm/eI+O+FDrhykOxlCxZk1uK7fVczRWN5UQa3hyjMdlO7nK9hlMRyn0tgH
         FViXBS7oqUFlzBpWNgk38TS6vB4XNr/8oQWXJcJYL8/cp2AkaWenSEa+nZZRN8WzDoxA
         lDCrHf5wUKi6IL25/90J40Hu7/xFYooE2wJDI8RuBFmn2ipR3I3+KzIoplEmMJc3MNDp
         o2GQ==
X-Gm-Message-State: AC+VfDxuhp0Uy2xn5GVXEH2IOKUPJ7mb0FM8pk5RZQlTIDBZidkCL0aJ
        ls2Fla0KEYWK1ECxl2GxaedZzQ==
X-Google-Smtp-Source: ACHHUZ7ThMtRGq4tIXOK31B1RtAYmA1ePRcGvT+jkw23NK8rvGX4WSiR96M2dguUDtZe2PIHZs8lvw==
X-Received: by 2002:a17:903:2451:b0:1b0:34c6:3bf2 with SMTP id l17-20020a170903245100b001b034c63bf2mr18686385pls.5.1687354722939;
        Wed, 21 Jun 2023 06:38:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001b682336f83sm3223317plw.42.2023.06.21.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:38:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230621124914.185992-1-hch@lst.de>
References: <20230621124914.185992-1-hch@lst.de>
Subject: Re: [PATCH] block: fix the exclusive open mask in
 disk_scan_partitions
Message-Id: <168735472195.3891175.10053392756131792888.b4-ty@kernel.dk>
Date:   Wed, 21 Jun 2023 07:38:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 21 Jun 2023 14:49:14 +0200, Christoph Hellwig wrote:
> FMODE_EXEC has nothing to do with exclusive opens, and even is of
> the wrong type.  We need to check for BLK_OPEN_EXCL here.
> 
> 

Applied, thanks!

[1/1] block: fix the exclusive open mask in disk_scan_partitions
      commit: 56e71bdf324d6ab263eba1fc3fa1f3fd8bb5678e

Best regards,
-- 
Jens Axboe



