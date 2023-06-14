Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E144AEB64D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 00:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjFNAGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFNAGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 20:06:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62869E5;
        Tue, 13 Jun 2023 17:06:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 182A65C00C2;
        Tue, 13 Jun 2023 20:06:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 13 Jun 2023 20:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686701191; x=1686787591; bh=3jwieRd2LEorM
        GSmCiQs/xqxVu0PzhKpx7LgWdkiTIM=; b=A5OX2JPTxm69jL3zjzHdLj0hVtHw/
        lb/xgj/R/gbzS0atFKrSKx49eClAYa7wAghu8yoqLSk13ohsGHdZxlJjci+p//c8
        qWdEOpm/m1o1ynTWTbREY1v17OsnIRnYl5K6Cv9MvL/OWMc7KZM+PacHCssEIZaL
        txX5ToSaZ475l532T9kXl3DCCSTy+dQuPpXzWKS0/UI3KSpaCdlsHlL08w0n1q8q
        Re7jWKN3xEXUGn7b9E+qoh4Y4KOhVrOE+9fqONyxz/ewmKOw0W6SpZAmCZVM2Z1p
        3fdUZLpgplnsRVDEolXUAA12h/hXIJznvlUw3pV3Kk+ooIsUfEHVnMsSA==
X-ME-Sender: <xms:hgSJZJaaihDlaAYbVxbs8Z9LyvyDas8mR6yq8D-wDar4Umq-7CL3kg>
    <xme:hgSJZAayJHDip23TJab5Y8w4Uv4LHzuikNiXzfMQS5EXj4cBOtnW9NXka-hBWKXQn
    b2zfUJ8-US_Xc-Enqk>
X-ME-Received: <xmr:hgSJZL-IeQAnO1sOL3cvZoQgU8gYkz9Qz3dcPPaBSJyIQDXnGNBeDQtIcz29fZflmJ0E1omI23RErvi3ItA15_pqo0BtqGLiDSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedukedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefieehjedvtefgiedtudethfekieelhfevhefgvddtkeekvdekhefftdek
    vedvueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieek
    khdrohhrgh
X-ME-Proxy: <xmx:hgSJZHo_kls4__93sxiOzkZNKeMQZqf9ozJgkVIfVqj0eBaMB_Z0Nw>
    <xmx:hgSJZEpnCO9XBz0CTZ7czMrBQQr0UyPA_sfMhLw1zyVys6kgEZvMbw>
    <xmx:hgSJZNQSfzjvwD9ggAb_ijezyOa0VNPvt2PXKBAMn7bvTK6RcYzFcg>
    <xmx:hwSJZNnLKGAi4RG9qzigjTBxM9pDZWray6WrA2j7X_vCf-xtkHj7jQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 20:06:27 -0400 (EDT)
Date:   Wed, 14 Jun 2023 10:07:04 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
In-Reply-To: <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
Message-ID: <437adeb4-160c-38a9-68af-ff4ec7454f5c@linux-m68k.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com> <4814181.GXAFRqVoOG@lichtvoll.de> <12241273-9403-426e-58ed-f3f597fe331b@gmail.com> <3748744.kQq0lBPeGt@lichtvoll.de> <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 14 Jun 2023, Michael Schmitz wrote:

> My last version (v9) still applies, but that one still threw a sparse 
> warning for patch 2:
> 
> Link:https://lore.kernel.org/all/202208231319.Ng5RTzzg-lkp@intel.com
> 
> Not sure how to treat that one - rdb_CylBlocks is not declared as big 
> endian so the warning is correct, but as far as I can see, for all 
> practical purposes rdb_CylBlocks would be expected to be in big endian 
> order (partition usually prepared on a big endian system)?
> 
> I can drop the be32_to_cpu conversion (and would expect to see a warning 
> printed on little endian systems), or force the cast to __be32. Or 
> rather drop that consistency check outright...
> 

The new warning comes from this new code:

		if (cylblk > be32_to_cpu((__be32)rdb->rdb_CylBlocks)) {
			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
				state->disk->disk_name, cylblk,
				be32_to_cpu(rdb->rdb_CylBlocks));
		}

The __be32 cast appears in the first line but not the fourth, which is an 
inconsistency you might want to tidy up. However, both lines produce the 
same sparse warning here.

The inconsistent use of big-endian and native-endian members in struct 
RigidDiskBlock looks like the root cause to me but I know nothing about 
Amiga partition maps so I'm not going to guess.
