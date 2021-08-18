Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E5C4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 20:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7E861106
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 20:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhHRUg2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 16:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233909AbhHRUg1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 16:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 250AB610FE;
        Wed, 18 Aug 2021 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629318952;
        bh=E2N2vkn8ZuMRsnKtrBJU26YTePJodaJsogEViSx6S9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aK/JdHcFa4lxdYOnjBBMw+MCoMnSWQ6y9GnbUkETXTFBEDjERJK7Htrx18mE3/i6p
         kUCvZOnIc5rvYdPgZeiNg4ka57oE4uitbvig/0DepfvOKqzWGW9Zp/+T9ZwtXbOfCA
         MLQxizShN7BkvBRrtUa0+CMEZiR8gdyhDk96q72w=
Date:   Wed, 18 Aug 2021 13:35:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
Message-Id: <20210818133551.3287f097f4c70742ab6b762f@linux-foundation.org>
In-Reply-To: <71535d629266751273c15cc05dd7c987cb9c43b6.camel@perches.com>
References: <20210818154646.925351-1-efremov@linux.com>
        <20210818154646.925351-2-efremov@linux.com>
        <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
        <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
        <71535d629266751273c15cc05dd7c987cb9c43b6.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 18 Aug 2021 13:21:16 -0700 Joe Perches <joe@perches.com> wrote:

> Andrew?  Do you still use perl 5.8?  It's almost 20 years old now.

5.26 is the oldest I appear to be using.
