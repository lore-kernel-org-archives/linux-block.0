Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65716C77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 12:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjDYMP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjDYMPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 08:15:25 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEB3524B
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 05:15:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8C01D582202;
        Tue, 25 Apr 2023 08:15:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 25 Apr 2023 08:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1682424923; x=1682428523; bh=AGDlUarHq9iBycSXvYZqj3zrgcYj5fpVLWC
        Dovs9yUc=; b=Zm6GJ1ObQAh8M8wjhUBumUR9ezcNAcyJuy9n6fC5s4RxQGI/bE/
        QnDV1cSX7tldwYCyIsu7N6wtDbLpQ3UDpChci8g1KFHVTZQ5WDMyqiNrTiAWAilC
        NbVIdIk5O3A05Wqrol8TzRqZHleS1UmKk/xMq2b37CjIHNXBR2/Ni+yaObL1QzF9
        VU8sVyL6Foxd0Qhbnkyhv4mIw2+7/mCvjCtxzaSi7hs9SGvgGqLHzXCQ/M4LGZPl
        f1GNeGKIfg7Fm5XgE0uWxCzYc0VoWyEjxXV+rYmG4zblNHaPaoKOLJcwGu8157eE
        7UG+QxdOgicN3aLK9Dl0PzRvpZxmOLuXDgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682424923; x=1682428523; bh=AGDlUarHq9iBycSXvYZqj3zrgcYj5fpVLWC
        Dovs9yUc=; b=PTQEqTNcGcBKzhAJO1uJJ5CLZuH3Zh0f6IVWsSckN2WuxGZlWT2
        BdESrr4yqv/ot2/g8hWDR0oZv9I09f6ue7Xqu+9dQDDS8RtCc0yniwSqJaeDDR3P
        YzRnYHOHPsbrOpVBuDxoYJYmDXPOYBiEqS6tOJJE0g95Jr1eD4e/qePQUy5czZIr
        8UwhhAtGQMzbBD8677TJ7Fqt+beZWBundMdoLQaDPICDjjHKZsZIj9lSHzS66A3l
        vXlLVi8yTUB4JvqBB4qRhfnD2s3WctGV5cVNLS866TToZkPp6Qe7BHZB099630GK
        weNrwgswDnUgk89Kh73k4epVtgNsfhnUp7w==
X-ME-Sender: <xms:WsRHZOTqsP9w6nwOp5uem1KMBWLGHej4AgXa7ktNKMEFkaZEr2_sjg>
    <xme:WsRHZDz3gluAmXjJOkm88RXapuOtIepf6dwQ3yejw-pvfO8tlam5QqZxC6fRWhQEF
    bsyY0YNBg-hJwn8Nwg>
X-ME-Received: <xmr:WsRHZL2Ek4valVwcbZKDJjuz0_EV7zndivQDi-G5YAiE_NiY43O3ND7jGpba8QsTEQs8LxSpSoqsHMOex1_1Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpefuhhhi
    nhdkihgthhhirhhoucfmrgifrghsrghkihcuoehshhhinhhitghhihhrohesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegteeljefhveejveefhfetueeugfeg
    gfehffevhfduffeuueekleelteejheejteenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehshhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:WsRHZKC-MICO0ZfidgTF7yTClqzUuqePLJmtbT42Jg2U0mPitG7_Xw>
    <xmx:WsRHZHiuyBcmsVhTqA_g4H2kQXu9nYJEiFTGvhv8N2GWEdvX0tZoqw>
    <xmx:WsRHZGq1uNSTfLRL--TmEpyCt6jlDpRqZ4H7IVzaP7kU_7Ba7Tvi6g>
    <xmx:W8RHZIUW0dS_i6__ei22xzAY2oR1U4U2B5OR-JaUz4WjWp4NDE3S3w>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 08:15:20 -0400 (EDT)
Date:   Tue, 25 Apr 2023 21:15:18 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     shinichiro.kawasaki@wdc.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        Li Lingfeng <lilingfeng3@huawei.com>
Subject: Re: [PATCH blktests] dm: add a regression test
Message-ID: <oklvotdaxnncrugr2v7yqadzyfa5vvzrumrfv46vrzowjw3njo@tlvhd4eo5spl>
References: <20221230065424.19998-1-yukuai1@huaweicloud.com>
 <20230112010554.qmjuqtjoai3qqaj7@shindev>
 <6ccff2ec-b4bd-a1a6-5340-b9380adc1fff@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ccff2ec-b4bd-a1a6-5340-b9380adc1fff@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 25, 2023 / 16:22, Yu Kuai wrote:
> Hi,
> 
> 在 2023/01/12 9:05, Shinichiro Kawasaki 写道:
> > Hello Yu, thanks for the patch. I think it is good to have this test case to
> > avoid repeating the same regression. Please find my comments in line.
> > 
> > CC+: Mike, dm-devel,
> > 
> > Mike, could you take a look in this new test case? It adds "dm" test group to
> > blktests. If you have thoughts on how to add device-mapper related test cases
> > to blktests, please share (Or we may be able to discuss later at LSF 2023).
> 
> Can we add "dm" test group to blktests? I'll send a new version if we
> can.

I suggest to wait for LSF discussion in May, which could be a good chance to
hear opinions of dm experts. I think your new test case is valuable, so IMO it
should be added to the new "dm" group, or at least to the existing "block"
group. Let's decide the target group after LSF.
