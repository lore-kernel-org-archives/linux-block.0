Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D04C47253
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A422073E
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 18:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgEASbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 14:31:32 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:39068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729975AbgEASbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 14:31:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0A7B12C6D;
        Fri,  1 May 2020 18:31:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dogs64_818401b510b47
X-Filterd-Recvd-Size: 1813
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 18:31:29 +0000 (UTC)
Message-ID: <ef9d8e0985364994b23abd0c757715690b18c27c.camel@perches.com>
Subject: Re: [PATCH v3 0/4] floppy: suppress UBSAN warning in
 setup_rw_floppy()
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 May 2020 11:31:28 -0700
In-Reply-To: <2c506547-236e-02e2-53f1-9484ba6ae453@linux.com>
References: <20200501134416.72248-1-efremov@linux.com>
         <c05138cb12f43498299d2b438173d082be2ebf17.camel@perches.com>
         <2c506547-236e-02e2-53f1-9484ba6ae453@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2020-05-01 at 21:22 +0300, Denis Efremov wrote:
> On 5/1/20 9:02 PM, Joe Perches wrote:
> > On Fri, 2020-05-01 at 16:44 +0300, Denis Efremov wrote:
> > > These patches are based on Willy's cleanup patches
> > > https://lkml.org/lkml/2020/3/31/609.
> > 
> > Maybe add pr_fmt and clean up a few messages so
> > all the logging output is prefixed too.
> > 
> 
> Yes, I'm preparing next patchset with almost the same pr_fmt patch in it.
> However, simply adding pr_fmt is not enough. We need to remove DPRINT macro
> from the driver because it uses current_drive and this is wrong after Willy's cleanups.
> 
> #define DPRINT(format, args...) \                                                
>         pr_info("floppy%d: " format, current_drive, ##args)
> 
> I also don't like debug_dcl and how it is used.

great, thanks.


