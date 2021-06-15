Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED0C48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 11:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAE46145D
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 11:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFOLyv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:54:51 -0400
Received: from verein.lst.de ([213.95.11.211]:48586 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhFOLyu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 07:54:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1530667373; Tue, 15 Jun 2021 13:52:44 +0200 (CEST)
Date:   Tue, 15 Jun 2021 13:52:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     CKI Project <cki-project@redhat.com>, hch@lst.de,
        skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Fine Fan <ffan@redhat.com>,
        Jeff Bastian <jbastian@redhat.com>
Subject: Re: ? PANICKED: Test report for kernel 5.13.0-rc3 (block, 30ec225a)
Message-ID: <20210615115243.GA12378@lst.de>
References: <cki.E3198A727A.0A5WS1XUPX@redhat.com> <CA+QYu4qjrzyjM_zgJ8SSZ-zsodcK=uk8xToAVR3+kmOdNZfgZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4qjrzyjM_zgJ8SSZ-zsodcK=uk8xToAVR3+kmOdNZfgZQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 14, 2021 at 02:40:58PM +0200, Bruno Goncalves wrote:
> Hi,
> 
> We've noticed a kernel oops during the stress-ng test on aarch64 more log
> details on [1]. Christoph, do you think this could be related to the recent
> blk_cleanup_disk changes [2]?

It doesn't really look very related.  Any chance you could bisect it?
