Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E16C77B72
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 08:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDLIvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjDLIvk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 04:51:40 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EA083D8
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 01:51:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3FB235827D4;
        Wed, 12 Apr 2023 04:49:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 04:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681289375; x=1681289975; bh=L1bUxmnPnot7VZQQ0IvZZqFCOVoFzAgQzBX
        CZAaxKFA=; b=Bsq9CHMHGKdtEsIFN9SZcCIL2q5xM24wwgMYMJSqvYMzewJ0BhF
        6V2aubLTUFAj7nCJ/Bk8G1YZIIgSWQJc9waEqngh56UIGP61XZ2112P4NK4f/aDl
        DVi/ktEGp0tNSyv7tPOF8enuhyyGC9PS+Oa9zIoO/SIpulfEiUsNWqVE/nGGyVdg
        SGw8329+h5NNuS9iRffhSeq8PMeUKKlM9WUFTJQk95BsGe4ZwoHZLR8YGfNKXJsh
        GE6Syex6G7rYUy+HcP99Z2eaT9CzjT80eR5pPhPR0V2rEIyIAhRtouFJ+F0Bt+et
        CYwpbdTMnvaDqxMXnkgxOOGsPeFVKaPrvBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=ie1e949a3.fm3;
         t=1681289375; x=1681289975; bh=L1bUxmnPnot7VZQQ0IvZZqFCOVoFzAgQ
        zBXCZAaxKFA=; b=cIeFS5YiLlvIyWgodBzs7JYLst5s2FarQlRrT9vutwdLrhli
        xOLfARXKChtgBzFO1oYOi7Tu5E7RbT8t82VIXGaPmaTPj0vKm3YA/014xLinRtQN
        u8mxIsx8uWg9eGSEwzByhIAhB9k1e4ohp1kxajo42y9rgw0L+l+aCMy5SSjf+Jae
        F3URgCGepKbMCsqSitkDpiMEYBqeyHeReoDIYOgyfeqi5gtGHoS/DBolCrY1bqQR
        9cevyA2rHkj7W1WEbCn/ptTQpFmWvNUnUsmvQIf866gYCcVfJPQenYuN/y6pVkBI
        UoKabKgk4y9QfB7pIscQs3AZSccE1AY8YL0/kw==
X-ME-Sender: <xms:nnA2ZHqfHezRB7f0OBTZ2gt1J8hOFHeDlbqfl9eRTUBp3DoTlzdlDg>
    <xme:nnA2ZBqfUj5MxuiD0SmVYoENMphhU4HuZvqm9YEvOd1yvM3X-KdoMZP4skUOiY-es
    iIVJnZxEjv--FuPNOc>
X-ME-Received: <xmr:nnA2ZENyd_P9Jw3lseuorJasc-9lNr8_zYwY3fkkHfcsoTZqHuiQcqaSnJnXwTN1v1wdTRzrpTGAwmX7J4hDkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    eksfdttddtudenucfhrhhomhepufhhihhnkdhitghhihhrohcumfgrfigrshgrkhhiuceo
    shhhihhnihgthhhirhhosehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    ephfekkeeuueekfeeiueegtdehheegfeektdegtdfgudffvdeuvdeljeekteetgeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhihhnih
    gthhhirhhosehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:n3A2ZK5EK6_kihuUW5SffezWnMLdogSpK7_MiYjNz9L5_AA3zPdC6Q>
    <xmx:n3A2ZG5WzOXNZmTFZQXK25dF3k0ULlnquYqwCdRn4A0Rt_vwpMpkmA>
    <xmx:n3A2ZCg99v9o5mph2r2T4vknf_MvB-eswDZWAHM5hf6-Tql2am2fVQ>
    <xmx:n3A2ZMT3uI5M2V0N5NkdQbW6SXZv3mH-3pLc3CLvMghbM-72F52PhnB-taU>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 04:49:33 -0400 (EDT)
Date:   Wed, 12 Apr 2023 17:49:30 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     alan.adamson@oracle.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: blktests nvme/039 failure
Message-ID: <nsulcqpwsrym7sv4ypymxmftdakxsnnly36w5wzw5uyhcfgira@a7hk2cbckbep>
References: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
 <76983b72-b954-5865-1b34-c88161a7dec9@oracle.com>
 <acu2ak5fwyjnsino5i4ilaeh3xawlkygbxwjjm5tu3ntzxmgbh@zawuclpnlwiu>
 <c7e8f14a-6c1f-4e65-f72e-6fb92244f09c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7e8f14a-6c1f-4e65-f72e-6fb92244f09c@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 11, 2023 / 13:55, alan.adamson@oracle.com wrote:
> 
> On 4/10/23 6:27 PM, Shin'ichiro Kawasaki wrote:
> > On Apr 10, 2023 / 16:06, alan.adamson@oracle.com wrote:
> > [...]
> > > I've been able to reproduce it.  The sleep .1 helps but doesn't eliminate
> > > the issue.  I did notice whenever there was a failure, there was also a
> > > "blk_print_req_error: 2 callbacks suppressed" in the log which would break
> > > the parsing the test needs to do.
> > Ah, I see. The error messages were no printed because pr_err_ratelimited()
> > suppressed them. AFAIK, there is no way to disable or relax the rate limit from
> > userland. I think sleep for 5 = DEFAULT_RATE_LIMIT seconds at the beginning of
> > the test will ensure the error message printed. It will also avoid the "x
> > callbacks suppressed" messages.
> > 
> > With the change below, I observe no failure on my system.
> > 
> > diff --git a/tests/nvme/039 b/tests/nvme/039
> > index 11d6d24..5d76297 100755
> > --- a/tests/nvme/039
> > +++ b/tests/nvme/039
> > @@ -139,6 +139,9 @@ test_device() {
> >   	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
> > +	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed
> > +	sleep 5
> > +
> >   	inject_unrec_read_on_read "${ns_dev}"
> >   	inject_invalid_status_on_read "${ns_dev}"
> >   	inject_write_fault_on_write "${ns_dev}"
> > 
> Looks good.  I tested it with my environment. 

I did further testing, and found the test case still fails... The 5 seconds wait
ensures the expected errors are printed, but still we have the chance of the
"callbacks suppressed" message when previous test cases have printed many
messages. Here's the kernel output I observed with the fix above.

  run blktests nvme/039 at 2023-04-12 13:52:19
  nvme0n1: I/O Cmd(0x2) @ LBA 0, 1 blocks, I/O Error (sct 0x2 / sc 0x81) DNR
  blk_print_req_error: 5804 callbacks suppressed
  critical medium error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 2
  nvme0n1: I/O Cmd(0x2) @ LBA 0, 1 blocks, I/O Error (sct 0x3 / sc 0x75) DNR
  I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 2
  nvme0n1: I/O Cmd(0x1) @ LBA 0, 1 blocks, I/O Error (sct 0x2 / sc 0x80) DNR
  critical medium error, dev nvme0n1, sector 0 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2

I think further modification is required to grep -v the "callbacks suppressed".
Will post a patch with this modification to ask your comment.

> When we get the passthru
> logging in,  I'll be adding more tests here, but I'll have to do another
> sleep 5.

Agreed.
