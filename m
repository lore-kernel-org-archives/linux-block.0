Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3CEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 21:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiEQVQL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 17:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbiEQVQK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 17:16:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E676B1CE
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 14:16:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B85F85C0180;
        Tue, 17 May 2022 17:16:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 17 May 2022 17:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652822163; x=
        1652908563; bh=cnAzkdmvoPxdDd20e9pP5gA4i8RocZR9hT0QrY+6HuQ=; b=1
        Dn5xOoHBQvyvW7nXPVGeL/KVkXHkrmxLfyfxUuYsJIRdXMf/rA0ScrGeXcuq9OGC
        M6Wo5Ox6mukbQg8beB3Gozg8UsOeYBPL5S9Ifs7D0WYW4gJJhPTXJOw6aqbZ43gJ
        Bre4DVx1Scx8X0b0RBNoJxERH19lDbviDtvP8R4qc/rI2dnMJdyrwnF9HFSwEm7r
        z8GnNi0zx2sw2e/aU+sWI+nBdiLewWcSEBYBtYcVIt7iXqnptT2t8zm1iENlKDhb
        /sry9p4Nye1JH2GsLBQPBdsodwTH2NXgmuhdo9pMXWstRkOFBvIq+FPZlWdmeFl+
        MvzsexE9isdy9f8DRcCxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652822163; x=
        1652908563; bh=cnAzkdmvoPxdDd20e9pP5gA4i8RocZR9hT0QrY+6HuQ=; b=s
        RjPk4vg9l96heB3HzXwGekO/mGoTqsb4s5dUMAUSdHw+Bs05ku/m2RvVV5YV4Zxn
        2SDnwfs58iraCY5t/lDE7t5TMuYRXTdp+CB6g7ua2jYYJRydGmG3FxxuT33b0ZGl
        ddwdnRjR432QlVzWbl4YI3/G5yxcvwdaoGhuhQtDlaFq6xU+8ezetN2tkKawCV4Y
        klz/H5Ry+WVXInKd3yiZawsQvfbIcI76KeT0aTKQbLck6FXI/o2snxH0/14Qhi/U
        5m2AqbMrIcYh3PsuisEMlQuZQAS3kCjMGB9VQDXCmnPgDSfqj/TlUTcCa9JWt0hA
        BOOxHerNJGm9+sSSc0PnA==
X-ME-Sender: <xms:kxCEYntm-de4S7EFoRean5UDWirUKJ1AlzNNTqncOFem5Il6SU42lw>
    <xme:kxCEYodAnXLGoX57loMW2BCDVrDhI4y88jGGmPtfHCtYoh3mXzUSbCV39T63DMhil
    vRvWZ9HElZwfSeE>
X-ME-Received: <xmr:kxCEYqwbwppse8Y3AJHb925zGG4a9QfED3xuZueXQetqGtjFbhp-jK1k9vcsIda1MHOWZj85TEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheejgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepvddujeffvdevfeduhfeiueffgfehgfekieeuffelieeijeegieevudeh
    feekhfehnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpuggvsghirghnrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheppfhikhho
    lhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:kxCEYmO89TgDc3g-qKygo7aahGRofWVJFxdZ-pbslbFqSn2GzGThPg>
    <xmx:kxCEYn_saclnwvZ4xPVSykNPV0622VsAa4icyun19_5s74Z319vO2A>
    <xmx:kxCEYmVojpTXaarg8BwZ96anU7L9vo0F4MX7lgi6kOJFwlQaYwuRfQ>
    <xmx:kxCEYnxgSQQY728WJEAe7qMcAnndBWxy3tWBt8pY7Wa6wgimg9RWYg>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 May 2022 17:16:02 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 66FA576E;
        Tue, 17 May 2022 21:16:01 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 0EFC472A20; Tue, 17 May 2022 22:16:01 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>, <libguestfs@redhat.com>,
        <linux-block@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [Libguestfs] Communication issues between NBD driver and NBDKit
 server
References: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
        <20220515180525.GF8021@redhat.com> <87czgelidg.fsf@vostro.rath.org>
        <20220515192505.GJ1127@redhat.com>
        <1f37a75a-83b5-af8e-0dd3-6475652ab218@huawei.com>
Mail-Copies-To: never
Mail-Followup-To: "yukuai (C)" <yukuai3@huawei.com>, "Richard W.M. Jones"
        <rjones@redhat.com>, <libguestfs@redhat.com>,
        <linux-block@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 17 May 2022 22:16:01 +0100
In-Reply-To: <1f37a75a-83b5-af8e-0dd3-6475652ab218@huawei.com> (yukuai's
        message of "Mon, 16 May 2022 09:08:08 +0800")
Message-ID: <87a6bflv1q.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 16 2022, "yukuai (C)" <yukuai3@huawei.com> wrote:
> On 2022/05/16 3:25, Richard W.M. Jones wrote:
>> On Sun, May 15, 2022 at 08:12:59PM +0100, Nikolaus Rath wrote:
>>> Do you see any way for this to happen?
>> I think it's impossible.  A more likely explanation follows.
>> If you look at the kernel code, the NBD_CMD_INFLIGHT command flag is
>> cleared when a command times out:
>>    https://github.com/torvalds/linux/blob/0cdd776ec92c0fec768c7079331804=
d3e52d4b27/drivers/block/nbd.c#L407
>> That's the place where it would have printed the "Possible stuck
>> request" message.
>> Some time later, nbdkit actually replies to the message (for the first
>> and only time) and in that code the flag is checked and found to be
>> clear already, causing the "Suspicious reply" message to be printed:
> Hi,
>
> You are right, can you try the following patch?
>
> https://lists.debian.org/nbd/2022/04/msg00212.html

Ah, I guess that makes sense. I thought that not specifying a timeout
meant "never time out".

I'll set this to a large value and report back if the problem recurs.

Thanks!
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
