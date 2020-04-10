Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECDC2BB85
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658E12084D
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 09:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgDJJc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:32:57 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34476 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgDJJc4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 05:32:56 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03A9WrBG014543;
        Fri, 10 Apr 2020 11:32:53 +0200
Date:   Fri, 10 Apr 2020 11:32:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/23] floppy: cleanup: do not iterate on current_fdc in
 DMA grab/release functions
Message-ID: <20200410093253.GF14199@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
 <20200331094054.24441-23-w@1wt.eu>
 <f5fb363f-8c2c-3aca-6b71-4a45544d067a@linux.com>
 <20200410084516.GD14199@1wt.eu>
 <0bfa0ee0-e2f5-ff9e-b407-bb81d620df20@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bfa0ee0-e2f5-ff9e-b407-bb81d620df20@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 10, 2020 at 11:48:21AM +0300, Denis Efremov wrote:
> On 4/10/20 11:45 AM, Willy Tarreau wrote:
> > Ah thanks, I missed these ones! Do you want me to respin this patch ?
> 
> I think you can resend only this patch, or send an additional one 24/23.

OK, now done as 24/23. Apparently we can now get rid of the code dealing
with drive==-1 in lock_fdc()/set_fdc() etc. It's only used by
user_reset_fdc() and the last call place is in floppy_resume() which
even forgets to set the fdc number, so it only resets the current FDC,
as many times as there are FDCs in the system. I'm going to fix this
one and see make sure we drop this special case of -1.

Willy
