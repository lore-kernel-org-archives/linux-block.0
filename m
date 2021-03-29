Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB27BC433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 05:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DA86192C
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 05:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC2F4F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 01:56:05 -0400
Received: from verein.lst.de ([213.95.11.211]:52104 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhC2Fzm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 01:55:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A3D3568B05; Mon, 29 Mar 2021 07:55:40 +0200 (CEST)
Date:   Mon, 29 Mar 2021 07:55:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: Re: remove ->revalidate_disk (resend)
Message-ID: <20210329055540.GA27177@lst.de>
References: <20210308074550.422714-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308074550.422714-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 08, 2021 at 08:45:47AM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> with the previously merged patches all real users of ->revalidate_disk
> are gone.  This series removes the two remaining not actually required
> instances and the method itself.

Jens,

can you consider this for the 5.13 tree?
