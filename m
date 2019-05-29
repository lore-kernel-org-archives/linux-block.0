Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D41EC04AB3
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 06:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BBA208CB
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 06:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2Gw0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 02:52:26 -0400
Received: from verein.lst.de ([213.95.11.211]:52424 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfE2Gw0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 02:52:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C437C68AFE; Wed, 29 May 2019 08:52:01 +0200 (CEST)
Date:   Wed, 29 May 2019 08:52:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 0/3] block: queue exit cleanup
Message-ID: <20190529065201.GA3728@lst.de>
References: <20190515030310.20393-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515030310.20393-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, do you plan to pick this up (at last patches 1 and 2)?  It
fixes a NULL pointer deref and a md raid issue.
