Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E1C7618E
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 12:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbjDZMN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjDZMNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 08:13:25 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE3135AD
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 05:13:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5C12D58233B;
        Wed, 26 Apr 2023 08:13:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Apr 2023 08:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1682511201; x=1682514801; bh=jHMnHL/zKY5eCRZKsgqOg1uachNO1mhyA1e
        S591L7xY=; b=fLtHa2gDNxbCf8c7mn8v0H9jju/2xn1G24kZ/3SsDlschdg+J2/
        D33fwpLc3Kbb2FZIPtl4PSMp2h0cRU5HTEHzSx1UrpkzcIYYVzC9kLR3CHMhl+PR
        sJhi0KzWuaHqDN6xBAs22LMlg07e9q+ijgAYMjfnTCr3gaa4lfK6KLLSi4pZJSbW
        QdyxZXywCO6fc6nGq2393MeWN+ncxmFA3AaSN3DU0WlgzvSzIvXXn/hfGC35iT9/
        Hg1HFH2tkAHv4JxaKNnqxhYS9ZzWternR0R4eB3Tk/RkPZXFWB11mn7Qbz2z8jlA
        Qzv4m2g2KqeDkoNV8Z5yHJqR9G4IkTmoG7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682511201; x=1682514801; bh=jHMnHL/zKY5eCRZKsgqOg1uachNO1mhyA1e
        S591L7xY=; b=hVZYzTkwkjVyVnFi5hMYrJF6RH6ghCC/oj7ghBklaZYtz9eEVuT
        E6hos3qkE8GLbJ+ZCP3xIV5RHUsyHnuwIKmLVjcUlXyJasAl6VAS9Zf4zc7i8WWl
        fmMWHdfha0PMBSxkiYaBcKUP9tw5eDiKXoCv1wHxb3N1lCZuRVIHMZd7UiG35ZXG
        XXXI7l3o05Dph2lSRgWxKaRI7ul2C3CJrkO5bNZZl4P8Pr8UP3vTr8vZI73ytU+2
        Jo58/ZHYcmHaINOdaww6v6j+rJNsaUX2HAQwRdelwJqwG2Xzc1Lr9ko3hqgsTu0C
        W9G/wfSIZ3sEV39XiXGnQmsARuMNn8ihkwQ==
X-ME-Sender: <xms:YBVJZBZmym39ZaHxDbi03oR7kW33DOgftCjtn333_xgZRIa888VtSA>
    <xme:YBVJZIZXIw9dhLo0QHGG44HNIi4k3_4rV4z-eWhqPqKkruCcP8Tx4cnSmDWbMC8jW
    UUPzj3zr-KzSIkqJyU>
X-ME-Received: <xmr:YBVJZD8Alw3i6vp4YMKYdtaM4wF3CNVtiBfbBaWVnjJZk5XM7NiaqB9gp1Y2mVK0NgZdn_cs4b_QWm0K-ixcnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpefuhhhi
    nhdkihgthhhirhhoucfmrgifrghsrghkihcuoehshhhinhhitghhihhrohesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeutefhheeulefgleegjefgiedthfef
    keffgfdvvedufeekheejueejtdfhteetudenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehshhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YBVJZPoge5T2BQrc15xhbT_J0WXzfKzQu7wQ_dePm1YXwZa2t7qLLg>
    <xmx:YBVJZMpqyUaxxgJZe-68lQYAr9iAsRbnik0DY31X5PFjzdica2zffQ>
    <xmx:YBVJZFSQ0jj4eHUPQCk2sjjOXKPybkXV5dWCUA5uPiY8R8Os1wjudg>
    <xmx:YRVJZJhD6D9RJISmFEnc-d2mtIxSbPUj_JhgH0XHqXa-OC8KTkckNg>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Apr 2023 08:13:17 -0400 (EDT)
Date:   Wed, 26 Apr 2023 21:13:14 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Mike Snitzer <snitzer@kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Joe Thornber <ejt@redhat.com>
Subject: Re: [PATCH blktests] dm: add a regression test
Message-ID: <s4h5gehehwrto4h4vzs3cgfbeibtvrusgo5u5zus7afs3qzaio@nyy4xmikwyyo>
References: <20221230065424.19998-1-yukuai1@huaweicloud.com>
 <20230112010554.qmjuqtjoai3qqaj7@shindev>
 <6ccff2ec-b4bd-a1a6-5340-b9380adc1fff@huaweicloud.com>
 <oklvotdaxnncrugr2v7yqadzyfa5vvzrumrfv46vrzowjw3njo@tlvhd4eo5spl>
 <ZEgMuvNCud3fNdl4@redhat.com>
 <a8f2ca5c-0ae8-47af-d6c8-f9430c19ff64@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8f2ca5c-0ae8-47af-d6c8-f9430c19ff64@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 26, 2023 / 08:42, Chaitanya Kulkarni wrote:
> On 4/25/23 10:24, Mike Snitzer wrote:
> > On Tue, Apr 25 2023 at  8:15P -0400,
> > Shin'ichiro Kawasaki <shinichiro@fastmail.com> wrote:
> >
> >> On Apr 25, 2023 / 16:22, Yu Kuai wrote:
> >>> Hi,
> >>>
> >>> 在 2023/01/12 9:05, Shinichiro Kawasaki 写道:
> >>>> Hello Yu, thanks for the patch. I think it is good to have this test case to
> >>>> avoid repeating the same regression. Please find my comments in line.
> >>>>
> >>>> CC+: Mike, dm-devel,
> >>>>
> >>>> Mike, could you take a look in this new test case? It adds "dm" test group to
> >>>> blktests. If you have thoughts on how to add device-mapper related test cases
> >>>> to blktests, please share (Or we may be able to discuss later at LSF 2023).
> >>> Can we add "dm" test group to blktests? I'll send a new version if we
> >>> can.
> >> I suggest to wait for LSF discussion in May, which could be a good chance to
> >> hear opinions of dm experts. I think your new test case is valuable, so IMO it
> >> should be added to the new "dm" group, or at least to the existing "block"
> >> group. Let's decide the target group after LSF.
> >>
> > It's obviously fine to add a new "dm" test group to blktests.

Mike, thanks for the positive comment. Now I know that there are various
testsuites related to dm as you noted below. I think the new dm test group in
blktests can have different coverage from other dm related testsuites: tests to
confirm fixes for failures related to block layer and device-mapper. The new
test Yu Kuai suggests will fit into it.

Yu, could you post the new version of your patch? Let's add the dm group and the
first test case.

> >
> > But just so others are aware: more elaborate dm testing is currently
> > spread across multiple testsuites (e.g. lvm2, cryptsetup, mptest,
> > device-mapper-test-suite, etc).

Thanks. Good to know that dm test has wide varieties. I found the testsuites on
the net. Will try to look into them.

[1] lvm2: https://github.com/lvmteam/lvm2/tree/master/test
[2] cryptsetup: https://gitlab.com/cryptsetup/cryptsetup/-/tree/main/tests
[3] mptest: https://github.com/snitm/mptest
[4] device-mapper-test-suite: https://github.com/jthornber/device-mapper-test-suite

> >
> > There is new effort to port device-mapper-test-suite tests (which use
> > ruby) to a new python harness currently named "dmtest-python", Joe
> > Thornber is leading this effort (with the assistance of
> > ChatGPT.. apparently it has been wonderful in helping Joe glue python
> > code together to accomplish anything he's needed):
> > https://github.com/jthornber/dmtest-python
> >
> > (we've discussed renaming "dmtest-python" to "dmtests")
> >
> > I've also discussed with Joe the plan to wrap the other disparate
> > testsuites with DM coverage in terms of the new dmtest-python.

It sounds a valuable action to gather the various testsuites so that the dm
maintainer or dm developers can run them all easily.

I also think that the list of testsuites will help developers to tell what kind
of test goes to which testsuite. When an developer adds a test case related to
dm, the developer needs to choose which testsuite to add it. As an example, I
wonder about dm-zoned. In case we would add test cases to exercise dm-zoned, is
there any good testsuite to add them? (Can we set up dm-zoned with dmtest-
python?)

> > blktests can be made to be one of the testsuites we add support for
> > (so that all blktests run on various types of DM targets).
> >
> > Really all we need is a means to:
> > 1) list all tests in a testsuite
> > 2) initiate running each test individually

IIUC, the dmtest-python takes the role to prepare the various DM targets for
test, and each testsuite runs test cases on the targets, right? From blktests
point of view, the "block" group of blktests can be run with the various DM
targets. Also the "zbd" group of blktests can be run with DM targets with
DM_TARGET_ZONED_HM feature. Other test groups such as "nvme" or "scsi" won't
run with DM targets. I think it is not difficult for dmtest-python to prepare
blktests config files to specify DM targets and the block/zbd test group. If
blktests side change is desired, we can discuss.

> >
> > Mike
> 
> Thanks Mike for the detailed information, we did talk about DM testcases
> in last LSFMM, this is really important piece of blktest that is missing
> and need to be discussed this year's LSFMM so we can integrate above
> work in blktests as right now we are not able to establish complete
> stability due to lack of of the dm tests as we are doing it for block
> layer code or nvme for example.
> 
> -ck
> 
> 
