Return-Path: <SRS0=syOM=DM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D634C4363A
	for <linux-block@archiver.kernel.org>; Mon,  5 Oct 2020 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0072420796
	for <linux-block@archiver.kernel.org>; Mon,  5 Oct 2020 07:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gZ3le+Br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJEH0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgJEH0A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Oct 2020 03:26:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A33C0613CE;
        Mon,  5 Oct 2020 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5sM6+fPAuGy2swhfps1Vh088uPyk+Nclxk6vr8avp4U=; b=gZ3le+BrS/YBFbsfqY9n0gSqSd
        GdTnl+ZXSnKjByjsumxnE3yMQpa4pnT0q+YzM3hDXAmmcLFC4gDTkaQKwOYueuDPDl65KzXOWQCd3
        onUw2Xb3pcYhvLgGNsQSDdzx+rlsE3HisgN0jtBA6l36wUgtWnjF+a6KR3Q8Hqn01z4a0kthN19UV
        3MCG+Oi7SWO8sEgYWdVeK0S3SNXsjMKrI2dwdk1CzR+qf7HmapjOJGOtmLz3q4b/vxb/qUtdTR53A
        BSkJqC/kwPWCXwS5gEyo1qr+6UYJjR3qIOb/t23QdQXqkdnUo7W/8OIRJMQXQ+bH9QlvmQTejpW9B
        X4SuaQgg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPKsf-0004UC-VK; Mon, 05 Oct 2020 07:25:58 +0000
Date:   Mon, 5 Oct 2020 08:25:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] block: scsi_ioctl: Avoid the use of one-element
 arrays
Message-ID: <20201005072557.GB14204@infradead.org>
References: <20201002231033.GA6273@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002231033.GA6273@embeddedor>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 02, 2020 at 06:10:33PM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are being deprecated[1]. Replace the one-element array
> with a simple object of type compat_caddr_t: 'compat_caddr_t unused'[2],
> once it seems this field is actually never used.

They are only deprecated when abused as variable length array.  That is
not the case here.
