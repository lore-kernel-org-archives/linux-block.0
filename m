Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE12C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C35F222CF
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 01:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKMBfc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:35:32 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36775 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726977AbfKMBfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 20:35:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ThwHhR._1573608929;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0ThwHhR._1573608929)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 09:35:30 +0800
Date:   Wed, 13 Nov 2019 09:35:29 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     idryomov@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 'current_state' is uninitialized in rbd_object_map_update_finish()
Message-ID: <20191113013529.GA64000@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

There is a warning during compiling driver rbd for uninitialized
'current state' in rbd_object_map_update_finish():
	
drivers/block/rbd.c: In function 'rbd_object_map_callback':
drivers/block/rbd.c:2122:21: warning: ¡®current_state¡¯ may be used uninitialized in this function [-Wmaybe-uninitialized]
      (current_state == OBJECT_EXISTS && state == OBJECT_EXISTS_CLEAN))

drivers/block/rbd.c:2090:23: note: ¡®current_state¡¯ was declared here
  u8 state, new_state, current_state;
                       ^~~~~~~~~~~~~

Cheers.
Tony Lu
