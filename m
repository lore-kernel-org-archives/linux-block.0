Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FF7C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 17:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhLWRgc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:36:32 -0500
Received: from hosting.gsystem.sk ([212.5.213.30]:56588 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbhLWRgc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 12:36:32 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Dec 2021 12:36:32 EST
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 806287A0156;
        Thu, 23 Dec 2021 18:29:28 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] remove the paride driver
Date:   Thu, 23 Dec 2021 18:29:25 +0100
User-Agent: KMail/1.9.10
Cc:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org
References: <20211223113504.1117836-1-hch@lst.de>
In-Reply-To: <20211223113504.1117836-1-hch@lst.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202112231829.25658.linux@zary.sk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thursday 23 December 2021 12:35:03 Christoph Hellwig wrote:
> Hi Jens,
> 
> the paride driver has been unmaintained for a while and is a significant
> maintainance burden, including the fact that it is one of the last
> users of the block layer bounce buffering code.  This patch suggest
> to remove it assuming no users complain loduly.
> 
> Ondrej: you're the last known users, so please speak up if you still
> have a use case!

Looks like I really need to do the libata conversion.

-- 
Ondrej Zary
