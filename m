Return-Path: <SRS0=12de=XQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF08C4740A
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 18:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A92C2184C
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 18:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569089736;
	bh=twTGq0/ZKKaB7MuhBMbge4Oly6HGwraWRm+5aMfqSjo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D12D2S/xCOZeMnOnFTfGTkeYM56Oi43d3VVqj9NEkxSbXRPemXNzkp7RSGahHhJXE
	 R0MexBH/3nvSl8GDm6Ae5RIjS+e8SfsHsCvJPeDdesPHb6Cu38jHTIwEYqaHCf+h9w
	 F3lY4jPB8RcHqjGxwfOm4T1QB5CnRCERhk8NHJLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfIUSPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731877AbfIUSPf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Sep 2019 14:15:35 -0400
Subject: Re: [git pull] device mapper changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089734;
        bh=twTGq0/ZKKaB7MuhBMbge4Oly6HGwraWRm+5aMfqSjo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YcEoMAqsS/lnAtGLS4qAx1a8ZSn6qONnwvFip8p/WrxbgPEjOIghKAXHzKZuwui/S
         Pp92pVj2sLPVfanyh+N/9+1BW9UvxdKQThBVvByVSb7t/LsfhdCwk8LIrUcq0im+1K
         0gbhWWl7BfRbxfQo8EPryDu9pwNjx9ALOY7q0n/8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919211923.GA16508@redhat.com>
References: <20190919211923.GA16508@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919211923.GA16508@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.4/dm-changes
X-PR-Tracked-Commit-Id: afa179eb603847494aa5061d4f501224a30dd187
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e414b5bd28f965fb39b9e9419d877df0cf3111a
Message-Id: <156908973452.32474.7118884566596438956.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 18:15:34 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 17:19:24 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.4/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e414b5bd28f965fb39b9e9419d877df0cf3111a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
