Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6018DC433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 07:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D83620775
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 07:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTf3qyc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgICHYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICHYH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 03:24:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67745C061244;
        Thu,  3 Sep 2020 00:24:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so1556383pfp.11;
        Thu, 03 Sep 2020 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtCcxTYMpjBSX+MDnv73jbCTU3aLiCTczQOMAgWGsmE=;
        b=iTf3qyc48zHHpG2gTxA5HZEc9keVFMo5eH2gF9icUZl1zSpN2ZTRZV7PdUEezjnT+z
         vgTRUTJMcL+QztuWJ60M2bIKT0GQck0D80pD55uvOdS8CC1BzIT5aP8yV1P8WLGq4dDZ
         wkROWgJorCnGpD2Y42FVo58Ps1IRNoYoJZLamkFOIjEcnNbS8FnTgPGupe8whjX4a2Ba
         cii6fWuw5dwmJaRww2XPTT/dCca6jlzVY5Jy3bnizPr9oLXMO2TUTpK8Wcud/0RL4xg9
         5TVVL70AU0WIF9/HGAF6rADMUjm0lCQSRUvw6gUjAMgDPzzKS11/ot+klu9fnxBBaaap
         UA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtCcxTYMpjBSX+MDnv73jbCTU3aLiCTczQOMAgWGsmE=;
        b=a2Y9l5QS88dQgJ33+ETEi2V/Bg7uknUHoHjBcncyEx6+H6iAq+ysSzBOjCjzDRmzR9
         OoLeWKE9zka7LtYpWmEPVF89mVtxoEuAjPSh8xg9mmWhV8qCuQdLHcuB+5H5zhnPomAW
         cIVqIhWfQBzpvskP4teJ5BuusfhIF2qOGDTG5TZkjptcuBkfdqvl8N5ID5FoGLaYwaj3
         41unv63cwS6thNlr6U8+1Y50WBpL+yVn80QLZKJ6IVxo+z9PPof8W52qfqbkeQkYmOyH
         DlLJCAcGRoLMPuXxWjcH5oUh9LAsNwpMcdO8K/ixaJVM7L7RReh5QU4VcI/06xfvOI0t
         2nrQ==
X-Gm-Message-State: AOAM532BXiXZEvK+WwOWV5qkmVU2Q9xEStnB2/J5U/nI/H25zjSnH9e1
        eC8MAnC/75Jmizkgsc2KCQ==
X-Google-Smtp-Source: ABdhPJxyg4RbEhd2Qj9AvXQ7rOsm/jCPegx9vLDmxy5uCZWZR1WITO7Q4SBRzQ9uR8r8nG70ko7icQ==
X-Received: by 2002:a05:6a00:23c5:: with SMTP id g5mr2554151pfc.160.1599117845943;
        Thu, 03 Sep 2020 00:24:05 -0700 (PDT)
Received: from PWN ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id 1sm1841092pfe.70.2020.09.03.00.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 00:24:05 -0700 (PDT)
Date:   Thu, 3 Sep 2020 03:23:57 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] block: Fix use-after-free in
 bdev_del_partition()
Message-ID: <20200903072357.GA623968@PWN>
References: <000000000000520ffc05ae2f4fee@google.com>
 <20200903065534.623691-1-yepeilin.cs@gmail.com>
 <20200903065950.GA19012@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903065950.GA19012@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 03, 2020 at 08:59:50AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 03, 2020 at 02:55:34AM -0400, Peilin Ye wrote:
> > In bdev_del_partition(), `part` is being looked up outside the critical
> > section. This is causing bdev_del_partition() to delete the same partition
> > more than once. Fix it by reverting commit cddae808aeb7.
> 
> We've already fix the problem properly:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.9&id=08fc1ab6d748ab1a690fd483f41e2938984ce353

Ah, I searched linux-kernel but didn't see your patch, sorry about
that. I should have searched linux-block too.

Thank you,
Peilin
