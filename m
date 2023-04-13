Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8B8C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 00:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDMAUV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 20:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjDMAUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 20:20:20 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BDB6A52
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 17:20:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 4D9DA2B06947;
        Wed, 12 Apr 2023 20:20:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 20:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681345215; x=1681345815; bh=tn4adNlIJQmHh6RHsA9q/OfXlTY2gYA067V
        e5WaA4Dw=; b=UYBbK9QpuOMo/hXqAVFRHNqIxo/X6Wjrojtn1m+L7ZGnCBG/rQs
        OrymwxSsubkxU6WLHfHDQM2WJbQ31mdNmquZp4pVk7AJuyL4asw6Otx8jzawRXA4
        eaRN86YqRDf4kUV4aVRIL0x/kzMj4DJC7S8v68DE18JVJJMbIYITjNRIyBFXpkdh
        fnmHdL6L41krJQIJr3lnp1+g4n7/0Bdkz/rOn3dBStJWW1oEZ15T65ozE5qArq7V
        poLzthTTol0HIU0li5qREc93UehYzUMzgvWr/qmAUq06z2DSODe5fbLedBWnjfCW
        SEldYVxrBr6N6LwulqfHtALLt/uDkXxVgPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=ie1e949a3.fm3;
         t=1681345215; x=1681345815; bh=tn4adNlIJQmHh6RHsA9q/OfXlTY2gYA0
        67Ve5WaA4Dw=; b=jmc05AW1vxhyAN9Lnt1QVtwjIz+1MmG9vvYnIL+QHyzze1C8
        Clyhs3VEOgsfrdtXC294LLbecY7yEi6zKE56F52pHOYlLPR49q4WuA4SRnrFsZV/
        RfNRYGVBFyZOUupxWhuiQ5k3pxrt1wU9SqXcnurUIHi1bytPXkBD44RI7stuyRIi
        1yOC1zVmlSzGDCQQbtkb9RZnA1gKqWZ5DaN1IE31T9PIVO/Nfua6ahTymSJuJtzt
        uN9vZv31BYzLy50mFfVQB39OCesvFQ5f55E7efBR7hpKBClVMGQpQl8XfrsGRyac
        ZfFJfkhK0mIn6ULWUFY6eZ9uXjgwv6Fdw9BimA==
X-ME-Sender: <xms:v0o3ZKbB7S46iO7Y_YwHUuIHKubrL3z-mdqNiVgIPStafmZZzs70Ww>
    <xme:v0o3ZNazNFhATcJwu5_4tfAQZnF_DUN-FdLFLHIFlOqhychAys8motZZEo1tJoPNL
    CF57IDKYO63BDSf98A>
X-ME-Received: <xmr:v0o3ZE8uqzz2tO3pxGY5PfzsXwTIMoVu-fGDsdbZK5LpbgfMvc6ihqHBsYU7zsJFdbK9Qa-4x3KlhkNfDB3f7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekjedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    eksfdttddtudenucfhrhhomhepufhhihhnkdhitghhihhrohcumfgrfigrshgrkhhiuceo
    shhhihhnihgthhhirhhosehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    ephfekkeeuueekfeeiueegtdehheegfeektdegtdfgudffvdeuvdeljeekteetgeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhihhnih
    gthhhirhhosehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:v0o3ZModNRgyd5Z1BnbjxgtE2ViAORoLNMFtcSPm2AXSSH2cHnNiVw>
    <xmx:v0o3ZFrv3OWgXjq1XAoJyjwRP224wft09AWk47qGWWNsl9aE3zjbjw>
    <xmx:v0o3ZKRh-5GEBBGTGt6L6QRI3isGp-9YdG6XfIhyKDAG1t2Aoe40lQ>
    <xmx:v0o3ZM3N8BSdyuH77a16jwnzCCej9G_7U90S8l-TMf69uoASKZY3hltcsolcqi-5>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 20:20:14 -0400 (EDT)
Date:   Thu, 13 Apr 2023 09:20:10 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     alan.adamson@oracle.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] nvme/039: avoid failure by error message rate
 limit
Message-ID: <saejpr554r5sxjhqjps3yqgdwhrgufauki2f5npp2yzu6xtvum@q7oz2nwzic3r>
References: <20230412085923.1616977-1-shinichiro@fastmail.com>
 <34019736-06eb-b5dd-b6a1-101907c38917@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34019736-06eb-b5dd-b6a1-101907c38917@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 12, 2023 / 10:49, alan.adamson@oracle.com wrote:
> 
> On 4/12/23 1:59 AM, Shin'ichiro Kawasaki wrote:
> > From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > 
> > The test case nvme/039 tests that expected error messages are printed
> > for errors injected to the nvme driver. However, the test case fails by
> > chance when previous test cases generate many error messages. In this
> > case, the kernel function pr_err_ratelimited() may suppress the error
> > messages that the test case expects. Also, it may print messages that
> > the test case does not expect, such as "blk_print_req_error: xxxx
> > callbacks suppressed".
> > 
> > To avoid the failure, make two improvements for the test case. Firstly,
> > wait DEFAULT_RATE_LIMIT seconds at the beginning of the test to ensure
> > the expected error messages are not suppressed. Secondly, exclude the
> > unexpected message for the error message check. Introduce a helper
> > function last_dmesg() for the second improvement.
> 
> Why are we seeing the callback messages?  By the time the test starts
> generating errors (after a 5 sec delay) we should be able to log 10 messages
> without any being suppressed.

That is because other test cases before nvme/039 can generate errors. For
instance, block/014 generates many errors. When I ran block/014 and nvme/039 in
sequence, I always observe nvme/039 failure even with the 5 seconds wait in
nvme/039. I suggest to excldue the "callbacks message" to avoid the nvme/038
failure regardless of the errors generated before nvme/039.

