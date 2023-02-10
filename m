Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D162C636CD
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 10:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjBJKb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjBJKbY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 05:31:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A686D605
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 02:31:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA483F757;
        Fri, 10 Feb 2023 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676025078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H4+hbX36seFFCpOOkvahd7HC7rXrDBAYOrEO4jZ7T8=;
        b=MrV9LpdpVJ3TZQg2eOg7sz2hdaReOPMgJPpzcRvL8sId+NO+CZcTQYe6K8qrpQ7Fr4aBSa
        9B5Cm9JnVL/L5N8Q5U36MdHUngdvtHXgfB7yvUpJc+mepqUl7BTR1xHvD9zwPY0hdy6NL3
        myr6fCeYWpHS3HIif0hgx2685AMD9jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676025078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H4+hbX36seFFCpOOkvahd7HC7rXrDBAYOrEO4jZ7T8=;
        b=uxdpUg5GQOFV53QxlQG1r2NFB/eSurGZCky6dCozxNzUEh+0B0+WqpZerYfLZv4EXmKrI9
        Eb2kzIME7xsvN8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D7191325E;
        Fri, 10 Feb 2023 10:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k474DvYc5mMpTAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 10 Feb 2023 10:31:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B054CA06D8; Fri, 10 Feb 2023 11:31:17 +0100 (CET)
Date:   Fri, 10 Feb 2023 11:31:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Message-ID: <20230210103117.hpmeqz6373smvchd@quack3>
References: <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
 <20230208120258.64yhqho252gaydmu@quack3>
 <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
 <20230209090439.w2k37tufbbhk6qq3@quack3>
 <1bf91d5c-6130-43de-7995-af09045d4b98@huaweicloud.com>
 <20230209095729.igkpj23afj6nbxxi@quack3>
 <8ca26a55-f48b-5043-7890-03ccbf541ead@huaweicloud.com>
 <20230209135830.a2lhdhnwzbu7uexe@quack3>
 <668bc362-263d-d9bc-a462-d8b851062ebc@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <668bc362-263d-d9bc-a462-d8b851062ebc@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 10-02-23 09:58:36, Yu Kuai wrote:
> Hi,
> 
> 在 2023/02/09 21:58, Jan Kara 写道:
> 
> > Sorry, I'm not sure what your are asking about here :) Can you please
> > elaborate more?
> 
> 
> It's another artificail race that will cause part scan fail in
> device_add_disk().
> 
> bdev_add() -> user can open the device now
> 
> disk_scan_partitions -> will fail is the device is already opened
> exclusively
> 
> I'm thinking about set disk state before bdev_add()...

Oh, right. Yes, that should be a good fix to set GD_NEED_PART_SCAN before
calling bdev_add().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
