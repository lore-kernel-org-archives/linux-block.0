Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C236CC00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 21:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiHBVdf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiHBVde (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 17:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD569B1E5
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 14:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 699FF6150C
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 21:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F3AC433D6;
        Tue,  2 Aug 2022 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659476012;
        bh=aNQjE5MHk4wHIQN1+rjxh1O82xx+/v50O0iZcxkPCTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBRDec2cwFuaQ6Q7ecszKCgnoWoDS3XYE4SfMkmn+hvRPPy5otUwtUIp+3D7tr/gU
         +1O1T7faxAa61jc+KVXrmIv8AVwGttTrSwhMYsohCJFMFc9NDfChWVV7Xhf71rzNEs
         G9/kJDfMmVWFK8LFSm2a+mpt0r1pKIFTmvS0TaMA5hFPnPZLMjREmGJWwIlhFKhdeR
         Lzt+clY9V7yxpgAzgtp9G2RIm3bAWUwTv1u19QCy51fe65I4EF+UvzPjsrcRwJa4Ey
         E9zMaMJfpjpweeDWPMK7d7Buq55djYEQsf/1s5ts04iviWOyW8t9Uu24WMs0hA6dZs
         ajuI0AC+n2sug==
Date:   Tue, 2 Aug 2022 15:33:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Message-ID: <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 02, 2022 at 02:18:57PM -0700, Linus Torvalds wrote:
> And no, I don't want some "fix up broken code after the fact" commit
> on top. I want that code excised, and I don't want to see another pull
> request before it's (a) gone and (b) somebody has looked at where the
> testing of this COMPLETELY failed.

This issue was fixed more than 2 weeks ago, but wasn't included in this pull
request. It's in the current block drivers-post tree, though:

  https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.20/drivers-post&id=4dfbd5418763018f33acded0871fbbc22c8e4695

Do you want us to rebase the nvme pull request with the above squashed into the
original commit instead?
