Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF6C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837766143B
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhDWBLr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 21:11:47 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:44810 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhDWBLq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 21:11:46 -0400
Received: by mail-pg1-f174.google.com with SMTP id y32so34085786pga.11;
        Thu, 22 Apr 2021 18:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hsVCUJUwLnnNlg8WRB1gcFa4e19AOL85P8SGD4x+aM=;
        b=ujGaZHWYjY/60cggqJUnt84SM90EJTHz4PprOuBRE33VJ8kzKaDj6VkROLesoKIqaa
         znqKtErUOsxGKvTLBfFFI9fOBJp1UzfPUThnd8Gd3m08NGJShxoF4p7l+/YRtsGPBuEj
         sHRwI4oFsXG5a9W27u89DaaeIMwqCGf9OACMrMVoQJchj94kDKD5yPr4qU2IE67Yatg2
         jMKQdPGy9eb5MAwXpOCINQRjwWT0pk3HcPPEeu8L41/N+fRc7fL3zV2PUJvpqIfx3Ps7
         TeqNztUtHSf8x2EgY1vF972wi4sJvqEsMWboTQax3cOZkRM56GrD36fW8Yd9RQ3tc38u
         wWkg==
X-Gm-Message-State: AOAM531bUT+4+YI8BpILLQ6DM2piHuBUXJAZycSX/DHoywUMhoBUzWK8
        CwvLXHJK8qjA0PznXx44qIA=
X-Google-Smtp-Source: ABdhPJw1P+ejA5p8H7oaDyqty2fQJ8Dv8hp6MDhxXOmFkAnV+T9r6wtM2aS17u7ps6fM2MgfwT8Hjg==
X-Received: by 2002:aa7:800a:0:b029:250:c8c5:64b3 with SMTP id j10-20020aa7800a0000b0290250c8c564b3mr1247072pfi.23.1619140270977;
        Thu, 22 Apr 2021 18:11:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id fw24sm3103439pjb.21.2021.04.22.18.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:11:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 49DE7403AB; Fri, 23 Apr 2021 01:11:09 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] zram: fix few sysfs races
Date:   Fri, 23 Apr 2021 01:11:04 +0000
Message-Id: <20210423011108.11988-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This 2nd series documents the fixes better and includes a bdgrab() fix
for the issue noted by Minchan. A general fix has been proposed for two
of these issues however they are not yet deemed required upstream and so
we just open code individual solutions on the driver.

Luis Chamberlain (4):
  zram: fix crashes due to use of cpu hotplug multistate
  zram: avoid disksize setting when device is being claimed
  zram: fix deadlock with sysfs attribute usage and driver removal
  zram: fix possible races between sysfs use and bdev access

 drivers/block/zram/zram_drv.c | 473 +++++++++++++++++++++++++++++-----
 1 file changed, 414 insertions(+), 59 deletions(-)

-- 
2.27.0

