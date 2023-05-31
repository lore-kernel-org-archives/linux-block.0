Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E6C77B73
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 13:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjEaNGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjEaNGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 09:06:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA90E60;
        Wed, 31 May 2023 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U9SykjTbl/OmSzNnS/VGmSZL4PA7bSh1J2szdt4a2Pw=; b=LbVnJ7tohLEudtorXqpRDpDZN3
        KXS1escUUdY/DOXE7glxtWC7fv9LCCpxim1GaC10rWst+5gsMqchki8IHRmidw7fP3Yp+eFn94KqR
        Sk3dPh8FTOHJx2C/NuNLtFTFLLg+Fd8C4Yr7YSG/vtsfYoF9ppSAaq2sz008A8aZIJk5eS/zyxQ8v
        XHhHoV4dijEof0Mg945LcJZFOINy4hrdPsD4A7V6Rvu5BcvrgpgHFOemHsIeOS9qELyCYqpg8Dm/9
        /VlSeRJ7BRB3iK335gAVE7bN5LCpjoCYZ6HS0gO8oj60ZKSJ/+BciNQmRVyAgUc4NgSQJYtOl37ba
        /yKTbOYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LWl-00HUSK-1J;
        Wed, 31 May 2023 13:06:11 +0000
Date:   Wed, 31 May 2023 06:06:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 00/16] Diskseq support in loop,
 device-mapper, and blkback
Message-ID: <ZHdGQz/hZJhiShH3@infradead.org>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530203116.2008-1-demi@invisiblethingslab.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 30, 2023 at 04:31:00PM -0400, Demi Marie Obenour wrote:
> This work aims to allow userspace to create and destroy block devices
> in a race-free way, and to allow them to be exposed to other Xen VMs via
> blkback without races.
> 
> Changes since v1:
> 
> - Several device-mapper fixes added.

Let's get these reviewed by the DM maintainers independently.  This
series is mixing up way too many things.
