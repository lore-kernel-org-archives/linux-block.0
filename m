Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CB5C433EF
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 19:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiEOTNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiEOTNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 15:13:06 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6079EE0CB
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 12:13:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CC5A85C010B;
        Sun, 15 May 2022 15:13:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 15 May 2022 15:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652641981; x=
        1652728381; bh=hcwAwHWJv37O0uvl6sn3uNTEUqKpJFRzkJgGbg7Vdck=; b=t
        Vri2g43DHLUigI+MUe2+Y2bRgMxNsymcYdmK/egdynDKkUfSLb+kPwcUEhFQV8Qz
        6357pFPzvrnHfWzDxK/zj/vKVExaWz9Man7IOQWFbxjG1gXI5Q5CFpMg+1qiw/gt
        JfmWRxKmqdIrxWhcpP7buh92T3MLb1GMDtG0+t600Ig2OMeKYPAJD7cJ0mE+yUE3
        CvuNnWJXulXk/gyHgb8CUA0kGOJ5vIgryHKhjzS7yqkmYSA61/dyK/0X2srJG7kC
        X4BWEOiLTDw14P6r0a4/XUo01+VX28m5JdE8aH+mxlnzvluKmk2rUtokShAaAGJs
        mZWajpyN2xttT83L3MyAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652641981; x=1652728381; bh=hcwAwHWJv37O0
        uvl6sn3uNTEUqKpJFRzkJgGbg7Vdck=; b=boHPFuMzOcy35en11yMGjCVH5XVtG
        m1aDD+gOB0b9Mn299zv7VkqoR8vB9Q5v1fa+7+1HR3v69FnjjfRyimOL7buwgt+W
        SpOj5wUfeYwIrsaMi+ouV9NZtQBrqYTNxSFxhSjT/ZQJnVCbOCicFnTmHLvj3Orr
        1gcsVSAtfTfRHag9HZ7WiPpdaxJH8DWVa5Z8eze7ncC1/IoPmBtWFSz9RzLWyrs4
        +lATHKWrY/axwp53ZiobTGTC7PK8iMnjsv3gBK9MlGvorBhhZDb5lHdCBQx8jLF7
        UKom5p0+ReFIrRjrxfOW7bFE/2M3JPzmiuLeptbNCfMYdTU482F05CkcA==
X-ME-Sender: <xms:vVCBYizsO5aLRinkTWo0ZgKKOHXyixWHaBor3yE4wjsTo6RawMe2cw>
    <xme:vVCBYuQyOfYS3JYaK0x9XYzzSneQW0i4XcwBb3LwFioO55K2UogEoYoq5kjjmR6t0
    FIDbyQqJwLI8-SL>
X-ME-Received: <xmr:vVCBYkXbo9Nuq7jITDBaN33VuBtL_MnVdLt46DuSfStVfABVXKc2zfFloYOMxpEa_BTtxArk6eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheefgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepudevieelteevffetieetgfelkeetgfeugeegieeiffeuieeljeelleei
    geevudefnecuffhomhgrihhnpehrrghthhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:vVCBYojGQ5L4E5SnKVQH3IPobpHblcaNQ6QI9oZDJ1JL_5Dy500YVA>
    <xmx:vVCBYkB83VyQ3xIq2GSbAIvVLDN7RwoGg9F6UGZOrMANXf33WrfYyw>
    <xmx:vVCBYpID1hPPbyYNasJzSRcEc-jJBEEs6r41TNOuPEXhHlRb_vln7A>
    <xmx:vVCBYj7xnjdnEt0r23n5v8LvsuFQEaTchtwCeLXUL_kh8JDcQLa5hw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 May 2022 15:13:01 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 06BA59FD;
        Sun, 15 May 2022 19:13:00 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 522E8701B9; Sun, 15 May 2022 20:12:59 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     libguestfs@redhat.com, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [Libguestfs] Communication issues between NBD driver and NBDKit
 server
References: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
        <20220515180525.GF8021@redhat.com>
Mail-Copies-To: never
Mail-Followup-To: "Richard W.M. Jones" <rjones@redhat.com>,
        libguestfs@redhat.com, linux-block@vger.kernel.org, Josef Bacik
        <josef@toxicpanda.com>
Date:   Sun, 15 May 2022 20:12:59 +0100
In-Reply-To: <20220515180525.GF8021@redhat.com> (Richard W. M. Jones's message
        of "Sun, 15 May 2022 19:05:25 +0100")
Message-ID: <87czgelidg.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 15 2022, "Richard W.M. Jones" <rjones@redhat.com> wrote:
> On Sun, May 15, 2022 at 04:45:11PM +0100, Nikolaus Rath wrote:
>> Hi,
>>=20
>> I am observing some strange errors when using the Kernel's NBD driver wi=
th
>> NBDkit.
>>=20
>> On the kernel side, I see:
>>=20
>> May 15 16:16:11 vostro.rath.org kernel: nbd0: detected capacity change f=
rom 0
>> to 104857600
>> May 15 16:16:11 vostro.rath.org kernel: nbd1: detected capacity change f=
rom 0
>> to 104857600
>> May 15 16:18:23 vostro.rath.org kernel: block nbd0: Possible stuck reque=
st
>> 00000000ae5feee7: control (write@4836316160,32768B). Runtime 30 seconds
>> May 15 16:18:25 vostro.rath.org kernel: block nbd0: Possible stuck reque=
st
>> 000000007094eddc: control (write@5372947456,10240B). Runtime 30 seconds
>> May 15 16:18:27 vostro.rath.org kernel: block nbd0: Suspicious reply 89 =
(status
>> 0 flags 0)
>> May 15 16:18:31 vostro.rath.org kernel: block nbd0: Possible stuck reque=
st
>> 0000000075f8b9bc: control (write@8057764864,32768B). Runtime 30 seconds
>> May 15 16:18:41 vostro.rath.org kernel: block nbd0: Possible stuck reque=
st
>> 000000002d1b3e8b: control (write@14499979264,32768B). Runtime 30 seconds
>> [...]
>
> Does it really take over 30 seconds for nbdkit to respond?  You might
> want to insert some debugging into the S3 plugin to see what stage of
> the request cycle is taking so long, although I'm going to guess it's
> the remote Amazon server itself.

It seems unlikely, but it is possible - especially since I'm serializing
requests for debugging.


> It seems like you can adjust this timeout using the nbd-client -t flag
> (it calls ioctl(NBD_SET_TIMEOUT) in the kernel).  If I understand the
> logic correctly, the nbd timeout is currently set to 0, which causes
> the default socket timeout to be used.  Using the -t flag overrides this.
> So I guess try setting it larger and see if the problem goes away.

Well, my concern is more about the "suspicious reply" message which -
according to Josef - means that NBDkit replied twice to the same
request. If that is the case, that might explain why another request
seemingly remained unanswered.

Do you see any way for this to happen?


Best,
Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
