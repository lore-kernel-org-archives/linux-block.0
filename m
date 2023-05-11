Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31387C77B7C
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbjEKPgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjEKPf7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 11:35:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DCE55BE;
        Thu, 11 May 2023 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MHscP8JO9a977ifuFmAms77FPjymkVYX028FcGoGDPI=; b=TC8tH+i3jJ9ACSqpipFxuZrJ6j
        6rEraOVNsToWwPk8JihVWkQgJTLx9Ijn8VYLqr2l3z/p8GG9tpZ2ln891Z4ya1vx2VPYUK7uEjMWb
        NzKFFSnrCVnZqbmt7QmXik/3/ZTqMf0qE8LQXa5qOeUz+dFphnqyG5WtnT/mB7klrCCND+SQL77Dr
        uyrqf+2HFbo9BHgQVgFBNaVeD84Beo8SpM5rt+XI3giRUGRZo0GdJOgc3UriyautGBw8wEJ9AUjYZ
        G5iXDH5VmL7RE27rOqm3HApVG9w9dy4YeLA3SZep3w7p7yo10iXtCOlS94GicuEIlMpZYP6+ctjM0
        5uhKqOjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1px8Kj-009E8e-0V;
        Thu, 11 May 2023 15:35:57 +0000
Date:   Thu, 11 May 2023 08:35:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alistair Delva <adelva@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 4/9] block: use new capable_any functionality
Message-ID: <ZF0LXRWZb+xL+pTS@infradead.org>
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230511142535.732324-4-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511142535.732324-4-cgzones@googlemail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 11, 2023 at 04:25:27PM +0200, Christian Göttsche wrote:
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.

What is this new function and why should we using it?

Your also forgot to Cc the block list on the entire series, making this
page completely unreviewable.
