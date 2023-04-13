Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B70CC77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 03:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDMD7E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 23:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMD7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 23:59:03 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E687EC1
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 20:58:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 352802B068F2;
        Wed, 12 Apr 2023 23:56:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 12 Apr 2023 23:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681358212; x=1681358812; bh=VlTzfC+cscJFGzlxyKoBPiCgl+wlqsWxiBK
        qWv0iGAw=; b=Kn43Zq9MiT8+nJ3zDCjWFPfEsPwt59QAvClxNEo9jpVy3iej0zV
        j/IDSwy691s09TU1nPu6bzHhEBtrGt2Ksm/kTQmuGaBTGdyKqA1DlsvJGQbxqOB6
        0yUWz+6OkBpfDUK3rWRUGD/Pq7gdw2Bvumomk67y/hK0A7Luv8lAv4XHm3EtUpWV
        2BGkD2VOfGzVeVtwGzUBFGjHJJOPjd8F+MZA0O72ttcFtezYCxvL1ZOBf/nGjjX+
        ANcL6zBIz1V2QitnwcWwUnwA3c7mA9o6hqjfre1gAHm9d/M23JaYDPdVkfZP9xok
        E5LCVGwHu3T1BpREJXS5oLLaigi4XFlMT5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=ie1e949a3.fm3;
         t=1681358212; x=1681358812; bh=VlTzfC+cscJFGzlxyKoBPiCgl+wlqsWx
        iBKqWv0iGAw=; b=YSzuUA/gWw6Zpw69lq6Tj/TM05zOimlGsn8E6G4mWZCMz65r
        GDis0yO42o6Ht4UgubruU9XxXMKIC7weCVp5/Q/jIb997faHmik6eP5cEZSlc0BW
        lxLxqXWy9oISSmHmDXOOxoTUXYo7aAt60X5UUwL7M0AYeN4u5TdOttIXmJN6TJAs
        7ibPbtPqSH0kl9/PzNb9xBfrm5WD1M4MkXWtRiORqW8Szy+oHGENZI/e1huNovcC
        yYWt49Dc8qzbA7zlByCj7QIo0xD3FUnjiUP1o4OKHmIF3SkYgXou22GGNoC+7aYl
        Bc080HSvigGpTKS4zcxYCOcraVSN3EH6dV64yQ==
X-ME-Sender: <xms:hH03ZNHbLdcNG83hItPB18xXrFD4FdRXhvtl9gLraKhvwkX08iN7AQ>
    <xme:hH03ZCV6pvwRXNtHKiHlOx7tEQgab2WdDFUXbTypnPUkiHrFwGl2jHV_WyLvwTnpk
    ijVx24k5iDz6XCIKns>
X-ME-Received: <xmr:hH03ZPKXG8wwkv35IE-anoctQTSiJiFWe06EXaKwZcF1oyxdU4tK0gp6xJYQPopDkIm-HSZ8PHgHW0znD8b6Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekjedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    eksfdttddtudenucfhrhhomhepufhhihhnkdhitghhihhrohcumfgrfigrshgrkhhiuceo
    shhhihhnihgthhhirhhosehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    ephfekkeeuueekfeeiueegtdehheegfeektdegtdfgudffvdeuvdeljeekteetgeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhihhnih
    gthhhirhhosehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:hH03ZDGKPubGot04rEb0VFXCgm5GDOtRJ7xb9dc3Yuo36gxVMi4-sA>
    <xmx:hH03ZDWhOFhqVNGYIII5RQv4cp8iy7ZukwiMussNwuy0Dmx3rj-8gw>
    <xmx:hH03ZOPdtIRzF7h6y7LOt43YCjOWxJ0jWsBfmhv9IyrW6vQlLG77vA>
    <xmx:hH03ZAjA4H9ehJjQEztGUvu3Un2Ie4dC2hZR69eQl8NKwAfKITj7sZbSZHJi0g1K>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 23:56:51 -0400 (EDT)
Date:   Thu, 13 Apr 2023 12:56:47 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     alan.adamson@oracle.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] nvme/039: avoid failure by error message rate
 limit
Message-ID: <lhy27pg5my4fw7a7lyt5ag6zms4vnnaoab2laylatjqwkckdzv@55ebsbgtgpbs>
References: <20230412085923.1616977-1-shinichiro@fastmail.com>
 <34019736-06eb-b5dd-b6a1-101907c38917@oracle.com>
 <saejpr554r5sxjhqjps3yqgdwhrgufauki2f5npp2yzu6xtvum@q7oz2nwzic3r>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <saejpr554r5sxjhqjps3yqgdwhrgufauki2f5npp2yzu6xtvum@q7oz2nwzic3r>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 13, 2023 / 09:20, Shin'ichiro Kawasaki wrote:
> On Apr 12, 2023 / 10:49, alan.adamson@oracle.com wrote:
> > 
> > On 4/12/23 1:59 AM, Shin'ichiro Kawasaki wrote:
> > > From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > 
> > > The test case nvme/039 tests that expected error messages are printed
> > > for errors injected to the nvme driver. However, the test case fails by
> > > chance when previous test cases generate many error messages. In this
> > > case, the kernel function pr_err_ratelimited() may suppress the error
> > > messages that the test case expects. Also, it may print messages that
> > > the test case does not expect, such as "blk_print_req_error: xxxx
> > > callbacks suppressed".
> > > 
> > > To avoid the failure, make two improvements for the test case. Firstly,
> > > wait DEFAULT_RATE_LIMIT seconds at the beginning of the test to ensure
> > > the expected error messages are not suppressed. Secondly, exclude the
> > > unexpected message for the error message check. Introduce a helper
> > > function last_dmesg() for the second improvement.
> > 
> > Why are we seeing the callback messages?  By the time the test starts
> > generating errors (after a 5 sec delay) we should be able to log 10 messages
> > without any being suppressed.
> 
> That is because other test cases before nvme/039 can generate errors. For
> instance, block/014 generates many errors. When I ran block/014 and nvme/039 in
> sequence, I always observe nvme/039 failure even with the 5 seconds wait in
> nvme/039. I suggest to excldue the "callbacks message" to avoid the nvme/038
> failure regardless of the errors generated before nvme/039.

Reading back my explanation above, I found it may not be clear enough. Let me
ammend it. My understanding is as follows.

The test case block/014 generates many error messages by blk_print_req_error().
The messages are rate limited and some of them are suppressed. At that time,
__ratelimit() calls printk_deferred() to print the "callbacks suppressed"
message, which is deferred and not printed during block/014. When nvme/039
triggers an error message (after the 5 sec delay), the "callbacks suppressed"
message for blk_print_req_error() and block/014 is printed. It makes the
nvme/039 fail, since nvme/039 expects the error message it triggered, but it
finds the "callbacks suppressed" message instead. In theory, not only block/014
but also other workload with rate limited error messages can cause this nvme/039
failure.

The 5 sec delay in nvme/039 ensures that the error messages for nvme/039 are not
suppressed, but it can not avoid the "callbacks suppressed" messages that
deferred before nvme/039.
