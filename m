Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169FDC43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 13:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiFNNQG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243990AbiFNNQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 09:16:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F536E14
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 06:16:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5EBFD21B3C;
        Tue, 14 Jun 2022 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655212559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SHtw3Ou51NqimLAHY3kx282e8j9v7oS4wJt2Bcy9vVk=;
        b=iFYFfD79R3hu+4PnD6wQvEgOKGJDcvVw/ncQGIKX+aEFqdeO3Ll3Nlt+BJ+sy5pHlpzy0O
        cb4NQw2jTXn/IXtzhvJcLJ4hxUX3IQ5gPJOuOupOApQdiqNMGYgId6rbzvQYGkv2EZSY+5
        hTPYmXKNFVV2PA9nQJZWw3P4wSCFgNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655212559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SHtw3Ou51NqimLAHY3kx282e8j9v7oS4wJt2Bcy9vVk=;
        b=XFqqzKgp+1FFxuHyEpPs5i7XBLJfslftbf5mfaHp72iD0HWK5dl6lLgWJr14xOkIFM2G33
        eiXVsnBgBLAAW3AQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 293CB2C142;
        Tue, 14 Jun 2022 13:15:59 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D108DA062E; Tue, 14 Jun 2022 15:15:58 +0200 (CEST)
Date:   Tue, 14 Jun 2022 15:15:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] blktests: Ignore errors from wait(1)
Message-ID: <20220614131558.nzxkqgqlwzjnksda@quack3.lan>
References: <20220613151721.18664-1-jack@suse.cz>
 <0b0ec2ce-9d96-2324-c10c-ad2b0c6d688e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0ec2ce-9d96-2324-c10c-ad2b0c6d688e@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 13-06-22 22:48:20, Chaitanya Kulkarni wrote:
> On 6/13/22 08:17, Jan Kara wrote:
> > Multiple blktests use wait(1) to wait for background tasks. However in
> > some cases tasks can exit before wait(1) is called and in that case
> > wait(1) complains which breaks expected output. Make sure we ignore
> > output from wait(1) to avoid this breakage.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Please note that Shinichiro (CC'd here) is a new blktests
> maintainer and not Omar.

Thanks for review and notifying me. Maybe CONTRIBUTING.md should be updated
to speak about Shinichiro and not Omar?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
