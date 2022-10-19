Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5249C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 19:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJSTIM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSTIL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 15:08:11 -0400
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 12:08:09 PDT
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D0E61B76FC;
        Wed, 19 Oct 2022 12:08:09 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id DAC3D7A0255;
        Wed, 19 Oct 2022 20:58:39 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Date:   Wed, 19 Oct 2022 20:58:36 +0200
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk> <202203161358.06506.linux@zary.sk> <20221019073431.GA12124@lst.de>
In-Reply-To: <20221019073431.GA12124@lst.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202210192058.36901.linux@zary.sk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry for the delay, I was still busy. IIRC, I was stuck with locking in libata.

On Wednesday 19 October 2022 09:34:31 Christoph Hellwig wrote:
> It's been a while - did you get a chance to make some progress on
> this?  Do you need any help to unblock you?
> 


-- 
Ondrej Zary
