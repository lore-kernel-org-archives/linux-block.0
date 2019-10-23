Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339DDCA9EBB
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EB32086D
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 18:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbfJWStO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:49:14 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:57924 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbfJWStN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 14:49:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B81DA1822327E;
        Wed, 23 Oct 2019 18:49:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seed76_500e99da2a55d
X-Filterd-Recvd-Size: 1829
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 23 Oct 2019 18:49:10 +0000 (UTC)
Message-ID: <bff0a1c4fc69b83c763ffbce42a0152e1573499a.camel@perches.com>
Subject: Re: [Kgdb-bugreport] [PATCH] kernel: convert switch/case
 fallthrough comments to fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Wed, 23 Oct 2019 11:49:08 -0700
In-Reply-To: <20191021090909.yjyed4qodjjcioqc@holly.lan>
References: <f31b38b9ad515a138edaecf85701b1e3db064114.camel@perches.com>
         <20191021090909.yjyed4qodjjcioqc@holly.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-10-21 at 10:09 +0100, Daniel Thompson wrote:
> On Fri, Oct 18, 2019 at 09:35:08AM -0700, Joe Perches wrote:
> > Use the new pseudo keyword "fallthrough;" and not the
> > various /* fallthrough */ style comments.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > This is a single patch for the kernel/ source tree,
> > which would otherwise be sent through as separate
> > patches to 19 maintainer sections.
> 
> For the kernel/debug/ files:
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Will you be putting this in an immutable branch once you've collected
> enough acks?

No, I expect Linus will either run the script
or apply this patch one day.


