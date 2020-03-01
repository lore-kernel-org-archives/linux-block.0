Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB00DC3F2CD
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 20:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9174024697
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 20:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgCAUof (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:44:35 -0500
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:51379 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgCAUoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 15:44:34 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 15:44:34 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id D145718008030
        for <linux-block@vger.kernel.org>; Sun,  1 Mar 2020 20:35:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 647788384365;
        Sun,  1 Mar 2020 20:35:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paste97_832d4b52ef958
X-Filterd-Recvd-Size: 1189
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Mar 2020 20:35:01 +0000 (UTC)
Message-ID: <03a2ea0b91ab61ba9a11230e82f1fb3bdf420a50.camel@perches.com>
Subject: Re: [PATCH v2 0/6] floppy: make use of the local/global fdc explicit
From:   Joe Perches <joe@perches.com>
To:     Willy Tarreau <w@1wt.eu>, Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Date:   Sun, 01 Mar 2020 12:33:25 -0800
In-Reply-To: <20200301195555.11154-1-w@1wt.eu>
References: <20200301195555.11154-1-w@1wt.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2020-03-01 at 20:55 +0100, Willy Tarreau wrote:
> This is an update to the first minimal cleanup of the floppy driver in
> order to make use of the FDC number explicit so as to avoid bugs like
> the one fixed by 2e90ca68 ("floppy: check FDC index for errors before
> assigning it").

Thanks Willy.

trivia: you could style check the patches using checkpatch.


