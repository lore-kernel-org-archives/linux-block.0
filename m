Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAAAC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57C02075B
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57C02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeLMIgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:36:05 -0500
Received: from verein.lst.de ([213.95.11.211]:39380 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMIgE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 03:36:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B1DC168D8D; Thu, 13 Dec 2018 09:36:03 +0100 (CET)
Date:   Thu, 13 Dec 2018 09:36:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: provide fallback for discard alloc failure
Message-ID: <20181213083603.GA1219@lst.de>
References: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks, applied to nvme-4.21.
