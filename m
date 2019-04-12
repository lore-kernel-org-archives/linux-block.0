Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4DAC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502E22083E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 15:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDLPDa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:03:30 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:45609 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLPDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 11:03:30 -0400
Received: by mail-pf1-f182.google.com with SMTP id e24so5267801pfi.12
        for <linux-block@vger.kernel.org>; Fri, 12 Apr 2019 08:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjWJz1EWa/Us+N3opMFBnQXYJMVlfQ03bO22urAyqN0=;
        b=ilruv7CzoG3D46bvpCFFKoS/ZCuBMKF3x173BmmGsK0I02C96hJT1inF4PYoj8zXhQ
         jKmGmjQlhfn1dZn5qtDs2q8jjZmIvb2JQcBqo50o397mmNeTuuQRM/ZqkvY6sVn3KWkB
         BIepF/PccLQbWi9RReXjils1cglpUYXYhxVAbfIQcq/Edcw1/lmcfi15ykIHix4N8JxG
         Q7siINZw1Zt98TEX4J7GbeIYDXjJVBceVcndhj5Vff4vL2ArSYmtJQggSvguBfzhTuhV
         yD2UdAkHR7IOCdiy9JilRSgjEmwztJrjmlQpkh2qZi5AfS7/zvnQylMV6xETi4cx/C+6
         JQkA==
X-Gm-Message-State: APjAAAX+bxoiDqOe0Uq8PAkMwHErZhdrkeUhVb+KqPuh1CNtguDQcYAN
        1esErmJ7CjrPKVsDi4nGZ15RNAvt
X-Google-Smtp-Source: APXvYqyhdJSwEIdykrxBAQTOFGiIBS/hb9WyCTlv9eXcAX/CEEQuse2gz6BekGIKz4txngnvgNJs5w==
X-Received: by 2002:a62:415d:: with SMTP id o90mr57247218pfa.236.1555081409288;
        Fri, 12 Apr 2019 08:03:29 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u5sm20768078pfa.169.2019.04.12.08.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:03:28 -0700 (PDT)
Message-ID: <1555081407.161891.80.camel@acm.org>
Subject: Re: [PATCH 3/5] block: don't allow multiple bio_iov_iter_get_pages
 calls per bio
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Date:   Fri, 12 Apr 2019 08:03:27 -0700
In-Reply-To: <20190411062331.27800-4-hch@lst.de>
References: <20190411062331.27800-1-hch@lst.de>
         <20190411062331.27800-4-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-11 at 08:23 +-0200, Christoph Hellwig wrote:
+AD4 No caller uses bio+AF8-iov+AF8-iter+AF8-get+AF8-pages multiple times on a given bio,
+AD4 and that funtionality isn't all that useful.  Removing it will make
+AD4 some future changes a little easier and also simplifies the function
+AD4 a bit.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
