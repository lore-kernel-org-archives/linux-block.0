Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F906C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjDDP1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDP1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:27:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C304205
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gTi7R122n61Wk8F/kUz6Pv6bAq0U0Qhg0nHChSF1pz4=; b=JvEdBwnQfOK2gkv3oAx+XIicVG
        732Gh6zf5tAm9+yUd1n3LAI2RYg6Vj6CiCqBDBAcT5GkyIZKFr9qxTHBFMTVYmA5Ei0HQ46NB1QlI
        UQq82gvJtM6TQRUWKwCuqZRFovaLAFNzGUKCdQwyDU2nGSdcF/488bSZWlz3G5wd3Rs8hW15/c1BR
        a5uUKdLPe8O9UEOkfC7n2P0iWS8BE5qrKWNStEIZ6MVW7cltdIEZzkI0t406pwPBBM0qS7nUwyi1j
        2VlqAtgcBJxjFINqIvPlm8t7bbvTUp5cExrabguVpu9mnphVY9RLP/QRaNhwa7rAgFoB2sAne2k5q
        RSXGpTDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiZJ-0020O6-1c;
        Tue, 04 Apr 2023 15:27:33 +0000
Date:   Tue, 4 Apr 2023 08:27:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, brauner@kernel.org,
        rafael.antognolli@intel.com
Subject: Re: [PATCH 5/5] sed-opal: Add command to read locking range
 parameters.
Message-ID: <ZCxB5cSkbksDsJPA@infradead.org>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-6-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-6-okozina@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 04:16:04PM +0100, Ondrej Kozina wrote:
> +static int response_get_column(const struct parsed_resp *resp, int *iter, u8 column, u64 *value)

Please avoid the overly long line (plus a few more later).

Otherwise this looks good to me.
