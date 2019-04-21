Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3828C282DD
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 02:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDBE20869
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 02:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfDUCHu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 22:07:50 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17576 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDUCHu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 22:07:50 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Apr 2019 22:07:50 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1555811561; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=LFAvo/g8yMtdg/c1tmtc3shU1vq17jl42qr6s+kjMUda1bad4/Bfu34CqhrEQRFdOacQz4crXX11WjYyyDw0XNmlA+eDJeRkLe8YKNDT2/R3g5mwotJNqAK4XaTdEVhD9JWD4+x3dX+jzF4v2XKNNL2H3ncIjnTC+W/CKCNTCoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1555811561; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=1cYO19RU/sPHgH0HFL9skvTI2uqd3fy4x98xkQk+1pc=; 
        b=KEBPXNMr8lcOpxoLHYzzZFR7zfauSjCm1A4ytj9SjY1PZzQJNH/5ao4wN+aM1RzQBifuu7lnXXe4ijEejVkAcV7xytHVGvAUDs22GRjo42cvx/gpjqB57Gr/obS8G5l82Fh5YZkdZSyRykUiv0ixMCtovHqpiaEz2XVAkknY7EA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from localhost (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1555811560402270.1655520589853; Sat, 20 Apr 2019 18:52:40 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Dan Robertson <dan@dlrobertson.com>
Message-ID: <20190421014245.17652-1-dan@dlrobertson.com>
Subject: [PATCH 0/1] io_uring: fix bad free in io_sqe_files_register
Date:   Sun, 21 Apr 2019 01:42:44 +0000
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If io_sqe_files_register is called but returns EFAULT or EBADF the
io_ring_ctx user_files member is cleaned up, but a following call to
io_sqe_files_unregister will double-free.

Dan Robertson (1):
  io_uring: fix bad free in io_sqe_files_register

 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.21.0



