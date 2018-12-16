Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1665BC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2EB206BA
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeLPQeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:34:07 -0500
Received: from verein.lst.de ([213.95.11.211]:57901 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbeLPQeH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:34:07 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D23D968DD3; Sun, 16 Dec 2018 17:34:05 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:34:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de, jmoyer@redhat.com, clm@fb.com
Subject: Re: [PATCHSET v8] Support for polled and buffered aio (and more)
Message-ID: <20181216163405.GA13234@lst.de>
References: <20181213175645.22181-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any chance you could send the series that just optimize the existing
aio code and don't need new interface as an initial prep series?

Batching things up should make it a little easier to review, and with
a little luck those "simple" patches might still make 4.21.  Make
sure to include Al on the series, please.
