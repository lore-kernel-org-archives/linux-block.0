Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D39C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 09:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7404F22419
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 09:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7404F22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeKOTJT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:09:19 -0500
Received: from verein.lst.de ([213.95.11.211]:40645 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbeKOTJT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 14:09:19 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 11B5068D40; Thu, 15 Nov 2018 10:02:23 +0100 (CET)
Date:   Thu, 15 Nov 2018 10:02:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        drbd-dev@lists.linbit.com
Subject: Re: [PATCH 13/16] mmc: simplify queue initialization
Message-ID: <20181115090222.GA14284@lst.de>
References: <20181114160219.28328-1-hch@lst.de> <20181114160219.28328-14-hch@lst.de> <CAPDyKFqq=MiiM7h_GGb3S=+TSD=LayLTefigovuPJAsqMJgOEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqq=MiiM7h_GGb3S=+TSD=LayLTefigovuPJAsqMJgOEg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 06:31:45PM +0100, Ulf Hansson wrote:
> > + * @subname: partition subname
> 
> Drop subname :-)

Fixed.
