Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF6BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 15:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8623121
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 15:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbhASPXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:23:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbhASPXr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 10:23:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5392E22D2A;
        Tue, 19 Jan 2021 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611069786;
        bh=pqyZ0jdGM2NW4JqDQHaY/YHHjqBTFdzRAExrriAwkf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E93roEyk0HlKAwPu8VnBBSpf9m7sK2vnrtivH4G7zrhcNzqWOCv5vJECButDO1tLe
         Km5YMNt5EO3+cnrS7Ydo2Qw32jytvvsI25+W5xRrnTweCo6GYrDDEgiIzcDAdwOBLO
         zWH0R/Qur3RBxtFnIFYxKJorEOZkbYMYssXaC4Lc=
Date:   Tue, 19 Jan 2021 16:23:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arthur Borsboom <arthurborsboom@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] xen-blkfront: allow discard-* nodes to be optional
Message-ID: <YAb5WHSglwumI77O@kroah.com>
References: <20210119105727.95173-1-roger.pau@citrix.com>
 <20210119123622.zweul6uqfg54erj3@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210119123622.zweul6uqfg54erj3@Air-de-Roger>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 19, 2021 at 01:36:22PM +0100, Roger Pau Monné wrote:
> Forgot to Cc stable for the Fixes tag. Doing it now.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
