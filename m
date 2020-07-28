Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA866C433E1
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6862078E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 16:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgG1QPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:15:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:46574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbgG1QPG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 12:15:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDBD7B5BF;
        Tue, 28 Jul 2020 16:15:15 +0000 (UTC)
Date:   Tue, 28 Jul 2020 18:15:03 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Remove callback typedefs for blk_mq_ops
Message-ID: <20200728161503.657ch75lxbky4tvb@beryllium.lan>
References: <20200728160506.92926-1-dwagner@suse.de>
 <7a26c550-934b-a188-b910-3d21d006df41@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a26c550-934b-a188-b910-3d21d006df41@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 10:13:06AM -0600, Jens Axboe wrote:
> On 7/28/20 10:05 AM, Daniel Wagner wrote:
> > No need to define typedefs for the callbacks, because there is not a
> > single user except blk_mq_ops.
> 
> Concept looks fine to me, but you're mixing indentations a bit. Just
> remove the indentation bits, we don't need them here.

Ok, in fact I was not sure about the indentation. Let me respin it.
