Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FFFC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 01:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDKB1q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 21:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDKB1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 21:27:45 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAA4F9
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 18:27:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 0628C2B066FC;
        Mon, 10 Apr 2023 21:27:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 10 Apr 2023 21:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1681176461; x=1681177061; bh=+djj8E2EfQ1BdgmqIQjeoDHOm1x7gpXZl9v
        OkKv3HaA=; b=onwl2IiDr2QHgPAoZS8WPDPzj60b+GcxtmhqTHhVtIYFIqTD5/p
        CPIMcalX5SOO0ble3ugNPWE2jNE5tCR+z0G6ALTm6ZOs3ACv/3gxbtZqWGt8qBRk
        djdKZoLFr9BXWjTuXglvMt3nvQlx8Je5EVTM6irpQ23Lwy27v2FZex8FRk/Bu5uH
        KaEazKPc5TuQJ/tz2anEmOMYAs6HGDgv1jKCJ8LJOR2ino4oVkX/sbsQAVu1DLIu
        3A0EeXHmcldAq9PNQMpw6zTmqhArnHsZyHx1g+Z3pdw8T/vCYeNGs2KOP2FwG2DG
        Yg7x1gN+CEUCk6wIqeq9l3aCAhjpUxVuivg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=ie1e949a3.fm2;
         t=1681176461; x=1681177061; bh=+djj8E2EfQ1BdgmqIQjeoDHOm1x7gpXZ
        l9vOkKv3HaA=; b=Oqazz89E9PuvNgsMWX6ORBRvEAUwIXSvr8qyEEKF9f1scb9T
        9x49jXw7JeRO0lv+RqL9bTEOoczQjglklSiTNJjum29ZCUWdZSTlLzSAOUmqawNl
        4G/XMxpr6ru0Uc6r6FBvPWEeg+EVYb+esvecYbMhVuhz2ls4RcxD+WtxXlLgJ9aB
        Umv1AX5kHjxt4gORNXrsnhAL0flzRHEQpERaiuEZ9utsC/Tn88P3zJ7KjRax90pG
        6vQVKwHwrGM+5B/Gba0FQ8Y8lQjmYHP9olMIGbByL1uqdGI1D+o2Re7M8M64TZYa
        a+BF/rRhxyA3CUnFCHQAXlS/nPu9NepYkzFeZA==
X-ME-Sender: <xms:jbc0ZNHFZncHYXzatA4qkgI3vFvrGpvU_IZ4rQJKaQtlS1-qAxTtDw>
    <xme:jbc0ZCUcHg_4zqM-MrpYp2FAhgKdkanlt7CC8HZt0CDbQoEiK8L5hbjWLmaUL3jEb
    humMhpgeXUcMrDqihM>
X-ME-Received: <xmr:jbc0ZPKRl3xKds0ye68C8Ul0juUHGVhfK7fY1Sly7Kzhg7b9ACWvnRw9755fgeWvtMZRyRnD-dZ2KcJGjohbJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekfedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    eksfdttddtudenucfhrhhomhepufhhihhnkdhitghhihhrohcumfgrfigrshgrkhhiuceo
    shhhihhnihgthhhirhhosehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    ephfekkeeuueekfeeiueegtdehheegfeektdegtdfgudffvdeuvdeljeekteetgeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhihhnih
    gthhhirhhosehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:jbc0ZDH8o-Wsj8pd0aVJB7F9zuuxLu1e8Q8dJ9e-23SOQYqnqnwmIQ>
    <xmx:jbc0ZDUr1lImSNt4TZYw_SRMJwD1pfeG3Bi6AJjPncE2gMY4Mz4XPQ>
    <xmx:jbc0ZOOfxPvaGsZiQuXNUdyJ2DKz0DdnlgQAGDcVSInAmjB1J4ZKdg>
    <xmx:jbc0ZKf8MXHjmFeHb5MHCYMiKEclbfpqeHGpwqmjX3n1GkriwHSi3aR61zSjVI00>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 21:27:40 -0400 (EDT)
Date:   Tue, 11 Apr 2023 10:27:36 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     alan.adamson@oracle.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: blktests nvme/039 failure
Message-ID: <acu2ak5fwyjnsino5i4ilaeh3xawlkygbxwjjm5tu3ntzxmgbh@zawuclpnlwiu>
References: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
 <76983b72-b954-5865-1b34-c88161a7dec9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76983b72-b954-5865-1b34-c88161a7dec9@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 10, 2023 / 16:06, alan.adamson@oracle.com wrote:
[...]
> I've been able to reproduce it.  The sleep .1 helps but doesn't eliminate
> the issue.  I did notice whenever there was a failure, there was also a
> "blk_print_req_error: 2 callbacks suppressed" in the log which would break
> the parsing the test needs to do.

Ah, I see. The error messages were no printed because pr_err_ratelimited()
suppressed them. AFAIK, there is no way to disable or relax the rate limit from
userland. I think sleep for 5 = DEFAULT_RATE_LIMIT seconds at the beginning of
the test will ensure the error message printed. It will also avoid the "x
callbacks suppressed" messages.

With the change below, I observe no failure on my system.

diff --git a/tests/nvme/039 b/tests/nvme/039
index 11d6d24..5d76297 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -139,6 +139,9 @@ test_device() {
 
 	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
 
+	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed
+	sleep 5
+
 	inject_unrec_read_on_read "${ns_dev}"
 	inject_invalid_status_on_read "${ns_dev}"
 	inject_write_fault_on_write "${ns_dev}"

