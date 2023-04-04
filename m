Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9CC761A6
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjDDP0U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjDDP0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:26:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F314493
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z+sqNuZiZRKdugqq1P3d797x07j2w307em8166ZGxNc=; b=eiO6XEBDTQV6HGsEz2CUq3Zo0a
        +G9H87voU1LsikIfRC3ZTe/ZZrmMjZUXIojaafGl6oT8TtkMkH7fL2IbjpMu09BoHMpWt9wqbMqgJ
        fRcQ+OQi4ogFcksuLlGgWXqsGnmOHgXG5cnal87/EuYuD2ZTN+IMzRDTkKP+l2TLQjvsHy1wQqlTk
        8pqKlaI5ecfKty6LW5hxAZ/2P7elB/aiz7dKUVL7Z0HUKFOHqn6n4AnvdHNuY/t9XNXemVaqfGz5W
        Xa+dUN21crrEwNYhSS5BXEoAYyKtT0VYEZJGSHAl0+JJgPgYb9SskWS5lX+1Lh+XOQh9MkDgYGT3v
        UoQ66iuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiY7-00209J-0e;
        Tue, 04 Apr 2023 15:26:19 +0000
Date:   Tue, 4 Apr 2023 08:26:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, brauner@kernel.org,
        rafael.antognolli@intel.com
Subject: Re: [PATCH 3/5] sed-opal: allow user authority to get locking range
 attributes.
Message-ID: <ZCxBm3sUuW+kYRS4@infradead.org>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-4-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-4-okozina@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 04:16:02PM +0100, Ondrej Kozina wrote:
> +{
> +	int err;
> +	struct opal_lock_unlock *lkul = data;
> +	const u8 users[] = {
> +		OPAL_ADMIN1,
> +		lkul->session.who
> +	};
> +
> +	err = set_lr_boolean_ace(dev, OPAL_LOCKINGRANGE_ACE_START_TO_KEY,
> +				 lkul->session.opal_key.lr, users, ARRAY_SIZE(users));

Please avoid the overly long line here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
