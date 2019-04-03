Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBA5C10F06
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBF1206DD
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfDCPaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:30:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33827 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 11:30:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so8335539pfd.1;
        Wed, 03 Apr 2019 08:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e80FEICx9abJBygCcRq3LP2wwezRKJU09Q1ghjdKEmc=;
        b=Pf5BnAvdHt2g7yrgsbtvl+MCGfvdING3z3AtXls/SR9Fk5I+7+jucgjHhyWj+R8g2l
         DC44+R3uB+saS7VqrnrRkggGLtK2JN6F/aunchVOuaZvpZYuiNM+dX8RNam0xfQpSZX3
         EGLkY82l19UzxWd63LF0P/UaAYI84Xh5bzhrccYlD8+PjMBeV+G2o9b7fi4Ey5DAWEgp
         ouU9aKP0J9pwsD2O0vE7SAArcLwggloocrufO9rnWvKFbxxIwP+R7VTeD3P+HITlAIIR
         MDVxCLgMx3OTZE3Wrwg4jDD8r3mfuvMTF47/F/b34W7p/0wzf5Ea2/hrbbSF2KJQJ4jc
         ePXA==
X-Gm-Message-State: APjAAAVTfpCfnd//KGxt22EHKXDuHuFvXcswMpkziuZbpkTlXkIJObYu
        Fpv8qrn+YeyJCRDkJWq45WKV47kDhfk=
X-Google-Smtp-Source: APXvYqxw9Kr1Z+3m/QcdtazqEZ7tpflZyMGrQrvBj9HA8O/V6UZznQqdncZ7X4iIctffFreM/NF5Mw==
X-Received: by 2002:a63:465b:: with SMTP id v27mr249259pgk.165.1554305423720;
        Wed, 03 Apr 2019 08:30:23 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 18sm19056701pfp.18.2019.04.03.08.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:30:22 -0700 (PDT)
Message-ID: <1554305421.118779.187.camel@acm.org>
Subject: Re: [PATCH] block: Fix a race between tag iteration and hardware
 queue changes
From:   Bart Van Assche <bvanassche@acm.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Wed, 03 Apr 2019 08:30:21 -0700
In-Reply-To: <9d74985d-969c-b68d-fa05-2707ed27e013@oracle.com>
References: <20190402223202.30752-1-bvanassche@acm.org>
         <9d74985d-969c-b68d-fa05-2707ed27e013@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 11:26 +-0800, jianchao.wang wrote:
+AD4 percpu+AF8-ref+AF8-tryget should be enough here.

Having thought further about this, I think you are right. I will drop this
patch.

Thanks,

Bart.
