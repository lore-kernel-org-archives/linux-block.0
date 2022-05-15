Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF272C433F5
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 11:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiEOLg5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 07:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEOLg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 07:36:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB03B028
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 04:36:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CD3F35C00DA;
        Sun, 15 May 2022 07:36:51 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute4.internal (MEProxy); Sun, 15 May 2022 07:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652614611; x=
        1652701011; bh=OWSgH62OKpb7CfxKDsX54bf7eWBcT6EBl2vviqAII5A=; b=J
        LK25VXs8GM0Uuxz1wZo2+gwUo54EM8F2X7VQWGWuHUdLUGvxJ5saXZwCuvwagTOR
        obYbF85LoRKSz69Hzc7xW6OCMs8bglBtjYqYqLmcu5t0Ix+2RZVegleSYoXhkqwl
        Mx3ix0Et1G04JynkLuK1FFvKemJ0ycIqaLv03oor3YkgBMzyw8qpJdaiMXG6CSk7
        36EP/8lWM8KsnfRdLvNqxmmA7tXSHynySCuZuyHcFv42Yix/3hLjV9YTlNqw5jFc
        AKpB52tZY6iyom6VdRP5H76eOeyik3dyy4Rw40/5UWO8wZaEkOXqCyvIacf8BZgj
        c59mFmywjR/wdgWt86Ygg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652614611; x=1652701011; bh=OWSgH62OKpb7C
        fxKDsX54bf7eWBcT6EBl2vviqAII5A=; b=HqwPurOzpnE+GqHm0chrPoP9/XxZL
        Kxx5dHyYy7WjdNMoWIgUE7RZEQMxIqY2huVUd13WJbPkbsOG0EAcqRQV8SflHj02
        nLxwFevD3EYNWpuemrpU3R0kx6Yt1IfXa12eDwtGjrDe8FZwOJabw9POTrb2JmrE
        Zijha5n7uul9VspkiLBW3VILaHj9C9xvT9Pavvr7KzCUIcVEYDkvDYZoKQB+s6j3
        xoIlKcNjEyazLwInGvqTSX6PNcgaz0+kcRgYuhJiLNIMhW31zBQYdAb40VSFdJFq
        T0jjvaNO9EoPvE7B4k24tyzwNdKns8+gu/okoZ29or3yVziB4C6cIJUpQ==
X-ME-Sender: <xms:0-WAYtP3drXTyeheXtqa6R9--1eJ8ytINSvQywRk5P0-c57RSh8O5w>
    <xme:0-WAYv8yyd6SfnqsXwbxAzdgiVh1FExlVZhTuZWgd-vlPemMUq8RbBH9v8WUy7Ndt
    EgxH0ryMM5eSf4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheefgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfpfhi
    khholhgruhhsucftrghthhdfuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkefgfeefuedvteejgfdvveetvefhtdfgtdejvedvhfejkefhfeek
    feejtedtveetnecuffhomhgrihhnpehrrghthhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdho
    rhhg
X-ME-Proxy: <xmx:0-WAYsQo8Lv_18BH-HANA17Rdf1dpLt07QvQU4PaaWs5AHVOG_sF5w>
    <xmx:0-WAYpvfdJtz17dvdFPO6zPZFvpqV_UF0r7jG8ZHsPWywOzxrYt_xQ>
    <xmx:0-WAYlc70Prqrfqqp4Mlk89YhSE9NSiisLeOS99b7wWC9guh8KKe3A>
    <xmx:0-WAYp5-HgS3R2U-GHiJOi8iSDmmFP7KjI9YU0_4dTOJbOdbj9GHKg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6932B272006B; Sun, 15 May 2022 07:36:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <4295e767-2f3a-476e-b4c5-99814f879b9c@www.fastmail.com>
In-Reply-To: <87o80awgq4.fsf@vostro.rath.org>
References: <87o80awgq4.fsf@vostro.rath.org>
Date:   Sun, 15 May 2022 12:36:30 +0100
From:   "Nikolaus Rath" <Nikolaus@rath.org>
To:     linux-block@vger.kernel.org, "Josef Bacik" <josef@toxicpanda.com>
Cc:     nbd@other.debian.org
Subject: Re: How to safely disconnect NBD device
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Josef,=20

Would you be able to help with the question below?=20

If I understand linux/MAINTAINERS correctly, then you're currently takin=
g core of the NBD kernel-code?

Best,
-Nikolaus

On Fri, 6 May 2022, at 21:25, Nikolaus Rath wrote:
> $ nbd-client localhost /dev/nbd1 && mkfs.ext4 /dev/nbd1 && nbd-client =
-d
> /dev/nbd1
>
> Frequently gives me errors like this:
>
> May 02 15:20:50 vostro.rath.org kernel: nbd1: detected capacity change=20
> from 0 to 52428800
> May 02 15:20:50 vostro.rath.org kernel: block nbd1: NBD_DISCONNECT
> May 02 15:20:50 vostro.rath.org kernel: block nbd1: Disconnected due t=
o=20
> user request.
> May 02 15:20:50 vostro.rath.org kernel: block nbd1: shutting down=20
> sockets
> May 02 15:20:50 vostro.rath.org kernel: I/O error, dev nbd1, sector 77=
6=20
> op 0x0:(READ) flags 0x80700 phys_seg 29 prio class 0
> May 02 15:20:50 vostro.rath.org kernel: I/O error, dev nbd1, sector 77=
6=20
> op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> May 02 15:20:50 vostro.rath.org kernel: Buffer I/O error on dev nbd1,=20
> logical block 97, async page read
> May 02 15:20:50 vostro.rath.org kernel: block nbd1: Attempted send on=20
> invalid socket
> May 02 15:20:50 vostro.rath.org kernel: I/O error, dev nbd1, sector 0=20
> op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> May 02 15:20:50 vostro.rath.org kernel: block nbd1: Attempted send on=20
> invalid socket
> May 02 15:20:50 vostro.rath.org kernel: I/O error, dev nbd1, sector 0=20
> op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
>
> To me, this looks as if the kernel is shutting down the NBD connection
> while there are still active requests and/or while there is still dirty
> data that needs to be flushed.
>
> Is this expected behavior?
>
> If so, what is the recommended way to *safely* disconnect an NBD devic=
e?


Best,
-Nikolaus

--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB
