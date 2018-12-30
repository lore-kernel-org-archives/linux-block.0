Return-Path: <SRS0=wt6W=PH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFEC43387
	for <linux-block@archiver.kernel.org>; Sun, 30 Dec 2018 19:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7801F2084A
	for <linux-block@archiver.kernel.org>; Sun, 30 Dec 2018 19:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZSkQjCtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeL3TkW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:40:22 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55608 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbeL3TkW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Dec 2018 14:40:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BCA1C8EE23E;
        Sun, 30 Dec 2018 11:40:21 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3kxtxnpwZFj7; Sun, 30 Dec 2018 11:40:21 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 65AB98EE092;
        Sun, 30 Dec 2018 11:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1546198821;
        bh=ABvXGLZxtTJC3+Efc8nSfp+J0EWi9t5PeLm2Pbfbpvg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZSkQjCtDmcqzkkx5TWNgzHw/TiAxlif4geIMcyw8rK5E/MnzklPd4Z/KE7Mw7gSsZ
         yuNi3wbIKT/sLOdEYuEj7F+yb4xcHoiiG+7rjVbUY9FRZw2wWdqWkZEaIaOZLCBHHz
         cAABKRqHYCdfhhG75RH799O7ClpZTywBlzDPc1Z0=
Message-ID: <1546198819.2844.16.camel@HansenPartnership.com>
Subject: Re: [git pull] device mapper changes for 4.21
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Sweet Tea <sweettea@redhat.com>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>,
        linux-arch@vger.kernel.org
Date:   Sun, 30 Dec 2018 11:40:19 -0800
In-Reply-To: <20181230090646.GB1022@infradead.org>
References: <20181227160944.GA12190@redhat.com>
         <20181230090646.GB1022@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2018-12-30 at 01:06 -0800, Christoph Hellwig wrote:
> On Thu, Dec 27, 2018 at 11:09:44AM -0500, Mike Snitzer wrote:
> > - Fix various DM targets to check for device sector overflow if
> >   CONFIG_LBDAF is not set.
> 
> Question to Jens and Linus:
> 
> is there any good reason to keep the CONFIG_LBDAF=n option around?
> Less than 2gig block devices seem to be an absolutele niche, and I
> wonder if it is still worth maintaining the special case just for
> that.

It's really a question for embedded isn't it? since they're the ones
with this set to 'n' in their default configs (linux-arch cc added). 
What LBDAF=n does is make sector_t and blkcnt_t unsigned long instead
of u64.  The maintenance burden to us is we have to use sector_div
instead of do_div in the code and remember that sector_t may be 32 bit
(the current problem in LVM).  The benefit to embedded architectures is
that they don't have to do 64 bit arithmetic for every block
transaction and the price is they can't support block devices larger
than 2TB (not 2GB, although the AF part means we can't support file
sizes bigger than 2GB).

So the first question is: is there an embedded platform where anyone
thinks the cost of the 64 bit arithmetic is important?  and if there is
can they benchmark it so we get an idea of the value of keeping LBDAF
(i.e. if it's just a few percent then likely it's not worth it, if it's
in the tens of percent, it might be).

James

