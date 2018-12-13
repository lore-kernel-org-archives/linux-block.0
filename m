Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38301C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002AB20851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TnrtjidR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002AB20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeLMR5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:05 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52655 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbeLMR5D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:03 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so4985838itg.2
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=TnrtjidRUEfDoaX3NHtxwJ+ekBSJaBAUWPL873XW4BjBi7dI0F1Kr/UgjFp5nz82se
         MtVGSE+zUfQEPgR9TO9Vj8A64ZUBT6hLbLWhaJHxX4WRN8UAMr9I9INnNbqz7dagS/I+
         9G99WwGzsE/3d6a4ns81MX1Icdri/nEpzYX0QhZGMvFtu2deibktm+KuSKLU74oLPJM9
         d5d7P4nASxNgBDocDtXgAucw4KcvXh0logATb6bzwUOMNGX7OTE3wxxUsJBRWlWsE/da
         Rq0yxyzCytIhRdOgJh1gooVOMD5KAMDJNfQ7nYonu9c2nvGzLY28gikSL3ll7JVScCRb
         JQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=B5H89Lk+j03A1ODl+apB2d+QTGuqVJwP44eU929FL9jeqNaaIJAMzKQhH+hkvHoDiQ
         cyTG9EaLAxkhxiqVvzqeO6qZzX1ssP7tLJU8rAkC0Vp4GgsFyTE2rWfGDd+VDN/p6ba2
         3qLrxfpEeRJgvnX+YSg/BPRcXVx1onxFard1iI2Ls+E2UoOPlDqrV1XLIPSLFDQCWc12
         E8UuLarCay7wN6qp3Y/gsmm7ec4qJxmeZT73yuBi5BfB5BrmIlthUXgmohfRGzdEGCwa
         6JmahYH1tOan0M10ylfhaFeaXknWY1sxmAO1O5xowWftjdyGw1VojMTSC+5x86Wd6EiI
         3lOA==
X-Gm-Message-State: AA+aEWbD1tJrrtePeMKakfkQ7zTlYC0ZYHcmk9frK4TObEG7lNEhAZhw
        ray1GHJQ0g+++IYAFjP9NMkZ+kQdJCpo+w==
X-Google-Smtp-Source: AFSGD/VTDlf+t34bYTzKfPcUGwzJRzGqaopMmzVJ930etZdMTXM7tXMD8AD0KTc0XDnCPaMlE5AVDA==
X-Received: by 2002:a05:660c:b12:: with SMTP id f18mr301356itk.118.1544723822383;
        Thu, 13 Dec 2018 09:57:02 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/26] aio: use assigned completion handler
Date:   Thu, 13 Dec 2018 10:56:25 -0700
Message-Id: <20181213175645.22181-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We know this is a read/write request, but in preparation for
having different kinds of those, ensure that we call the assigned
handler instead of assuming it's aio_complete_rq().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 05647d352bf3..cf0de61743e8 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1490,7 +1490,7 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 		ret = -EINTR;
 		/*FALLTHRU*/
 	default:
-		aio_complete_rw(req, ret, 0);
+		req->ki_complete(req, ret, 0);
 	}
 }
 
-- 
2.17.1

