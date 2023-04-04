Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C1C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjDDPXH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDDPXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:23:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274940CD
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jwS7sqTV68SUeiseL+m6gdjdqgKOj5zwZ1TyhqYPsc4=; b=y4P1WZYYPl0D03x9AvKb28gzun
        o4P/YTbP/A7PF3jX7BhaASEtVglsCmHbj/NUzN/E2a89ou0K5SNl/1p/KhFd8IhEXIz3xvRAjyiG7
        V43Ku1ixl+PcnDD3VDKOREiL5+Zdf+9CbB+z9Dbrx1O2Q0oTldDjR9zMAGRIlOPqI2tx6+escREAI
        hkXb1fkwZLPgpINKPENHkiFpWKAjIqWX33cQQ+ABKWRa0vumQe0+ULEpnwrzmMjjRe47tBqqU2FIy
        ruxi1Qty/4dQ4Qy6ug6V+kUVxtlSm1/jrGZywOO+Lr/EiEPwpCvDs5LP6TMxCKnud4Vo7MzlrmO1h
        STX/xgCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiUx-001z9N-0I;
        Tue, 04 Apr 2023 15:23:03 +0000
Date:   Tue, 4 Apr 2023 08:23:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, jonathan.derrick@linux.dev
Subject: Re: [PATCH 1/5] sed-opal: do not add user authority twice in boolean
 ace.
Message-ID: <ZCxA18MExlBqqi22@infradead.org>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-2-okozina@redhat.com>
 <20230329-amendment-trodden-75a619120b5e@brauner>
 <a2ce079f-f3de-9bf1-5cd0-ec3045a25168@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ce079f-f3de-9bf1-5cd0-ec3045a25168@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 29, 2023 at 05:20:29PM +0200, Ondrej Kozina wrote:
> It seemed redundant when only single authority is added in the set method
> aka { authority1, authority1, OR }:
> 
> TCG Storage Architecture Core Specification, 5.1.3.3 ACE_expression
> 
> "This is an alternative type where the options are either a uidref to an
> Authority object or one of the boolean_ACE (AND = 0 and OR = 1) options.
> This type is used within the AC_element list to form a postfix Boolean
> expression of Authorities."

Can you add this information to the commit message?

With that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
