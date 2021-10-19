Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108B4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 00:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A086134F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 00:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJSAQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 20:16:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60021 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhJSAQo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 20:16:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 64F255C0276;
        Mon, 18 Oct 2021 20:14:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Oct 2021 20:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+Ap1jq
        gfpVtDi3jf9yBMD5H1mUkWgpHT9h4jyVoyJz0=; b=Bc4hYSthPgzMgo3KzHoBhA
        5dj8xsAzatX0qUJOwIFSRpeFmFKKftEPo8/mbmqhT7c8xKIDvdZzpYEstNspvFQx
        0T7Yo603noiJihxSHlyp73T5+b1n0nOx3dFMJtlMOdczoSkn2X3x6RiCtQUX2QGm
        ycPIi0VxnCxcXCXKSlbXXpOlDIKpBfizxS585NKxisDBBP+zksjQjxpCxwoYRrrp
        Zmx5OLfsspSTkzfnLv7x+RV1qXCHtqTIKYuIlCsMylL54B0zgv6sJXSD0und41NO
        REfApk0i+thRWRRgD6jte8e7IjLtwhuFqrDFATSxnI3nNK2+KUiVQ5GcHsp1AdcA
        ==
X-ME-Sender: <xms:6A1uYUBSF6Rj3SE6BTKmWftrtoQwlrKsPnC4WhizLwFa482Y6SILqw>
    <xme:6A1uYWihyWzE5u687N_Vd7juj49043AJSyAoyz2Wz7of2Yuxpz55cf1w6LILzHLbe
    TmpTOz84948a76k84c>
X-ME-Received: <xmr:6A1uYXmBHWx2H3_83rv4sHBiSee8rYJtJHqOUFM8Bsv9l0pnIfiu_BgUVW7JUW1S_ggHADzpVhRLSMwjAAbQbV8Qnq0pclXh5DY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvuddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepkeevvedtkeeftdefhfdvgfelleefhfdtfeeiteejjeevgffhudefjeekhefg
    uedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehk
    rdhorhhg
X-ME-Proxy: <xmx:6A1uYaxCUhnA_bCdbvJiUKlVQN526VAfKIgbr9ko4QFtf0DXNuzY8Q>
    <xmx:6A1uYZSvwIr66NYntJ9C578VFovfI7OQJm9TDxd-gn_0jlfREADVuw>
    <xmx:6A1uYVZWIOea32p_Q_fP_J8Goamu7CBiVeH2-Z-dIU60SE3w2rkDYg>
    <xmx:6A1uYbfw4KrqEJyLJEDy_RU_zrwYVflm5cFjG4BLxNR_8zKP1vhWlg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 20:14:29 -0400 (EDT)
Date:   Tue, 19 Oct 2021 11:14:36 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
In-Reply-To: <460a172c-6103-3839-eecc-a193d1cc208f@kernel.dk>
Message-ID: <a4e827c-9163-9fff-dd20-cdd44432fda5@linux-m68k.org>
References: <20211018222157.12238-1-schmitzmic@gmail.com> <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk> <97323ce2-4f5c-3af2-83ac-686edf672aea@linux-m68k.org> <7f64bd89-e0a5-8bc9-e504-add00dc63cf6@kernel.dk> <604778bc-816a-3f2e-d2ad-d39d7f7f230@linux-m68k.org>
 <460a172c-6103-3839-eecc-a193d1cc208f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Oct 2021, Jens Axboe wrote:

> 
> Oh please, can we skip the empty words, this is tiresome and 
> unproductive. Since you apparently have a much better grasp on this than 
> I do, answer me this:
> 
> 1) How many users of ataflop are there?
> 
> 2) How big of a subset of that group are capable of figuring out where
>    to send a bug report?
> 

Both good questions. Here are some more.

3) How many users is sufficient to justify the cost of keeping ataflop 
around?

4) How long is the user count allowed to remain below that threshold, 
before the code is removed?

> By your reasoning, any bug would go unreported for years, no matter how 
> big the user group is. That is patently false.

No, those are your words, not mine.

> It's most commonly a combination of how hard it is to hit, and how many 
> can potentially hit it. Yes, some people will work around a bug, but 
> others will not. Hence a subset of people that hit it will report it. 
> Decades of bug reports have proven this to be true on my end.
> 

I agree that a bug report count can be a proxy for a user count, but there 
is always a confidence level attached to such statistical reasoning, which 
can and should be quantified.

> Nobody has reported the ataflop issue in 3 years. Either these people 
> never upgrade (which may be true), or none of them are using ataflop. 
> It's as simple as that.
> 

It is when you over-simplify. The mere fact that Michael is working on 
this driver publicly will probably increase its user base.

I think you and I both know that code with non-zero user count regularly 
gets removed. I think the main criterion for keeping code around has 
always been the expense.

So I help with API modernization for the drivers I'm responsible for, to 
make them cheaper to keep around. Other people concerned about the cost of 
keeping code in the tree should look at drivers which only work on devices 
with vendor kernels. And they should consider the size of those drivers.

When kernel.org has dropped all the code in that category, then sure, 
let's worry about a few tiny old legacy drivers.
