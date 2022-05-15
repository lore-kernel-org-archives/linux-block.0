Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560C0C433EF
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 16:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiEOQjs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEOQjr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 12:39:47 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB356255B2
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 09:39:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 34B335C01C8;
        Sun, 15 May 2022 12:39:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 15 May 2022 12:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652632786; x=
        1652719186; bh=ywcYhafrGvs8dQQmrFYmiUAe9wKvtZ/2ToMLN5bY0tE=; b=i
        lAiDCFhJqd1hnlCxAnHWVBC7iDk1Cm27sHPC4fad1fBOcWkwrCT1UirAJ7WWZdDD
        SXi3MKFhmsyrrZaeA+EJ2nAaZAdPCYuxlWMOGlCB68leByDH3rEhmgra2suTK+fe
        6MmoAgFdMWtTMRQDVBvGeOCSNoVmYdk09rSkzPmQqTC6kNIPuh7CZrb3FdKnu9uD
        rSMPirF3sBTq1SXIKHtOs73NMWPSgqPWaVwI4RSoLP2q+9s8OflC37CYryo9Pg0n
        Sj+3Q4hfU5Gsrsdy/N+dgfLgcYJMoRFKOXQZRVHxxgJpX/mvv7V4UCCZUsYGaa5M
        jgZbP//5lBoZTmQzRdDYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652632786; x=1652719186; bh=ywcYhafrGvs8d
        QQmrFYmiUAe9wKvtZ/2ToMLN5bY0tE=; b=XNsDn2DySHE+QE85DkakyBsaCh43g
        /302RCZyBJDm8UxMq0z2RTm9SCv1zDxSfLUSygxt4knmoW1iOk5MHK/aPU1Gh4PO
        DEizfzCHFs7IRA7E7Lk+a+BeimpPyCbVJcO2fTJ+7MACEYERMm7eUrqV//sIicqx
        wfeIdlwnDs6AmPCOL8vL31an9pVjxW9rOn51B2q7QVGl+FO5jgjc9DeJIny8qNNr
        Wo+W1dAzrE3G2016DHtd22KporDWEtFqLrV5HQBwosT/Fi1Waua90rcRjduTLPLj
        zZS2VsnRARLf4JmugPmssks8W/KODYg6vNMJncj8ANrLwutwnax+dQyuA==
X-ME-Sender: <xms:0iyBYiSSvM61O2HF0Q739sF0ohP-lTRNwpQiYhKIpKRL1b0MoA1eHA>
    <xme:0iyBYnytvKpwLCwiV_tgzL6XhABqZy7GRzf75MOs8noU4Mus0Ajf4ljXs4h2QM7mP
    rEpeKKReYEPFZ-q>
X-ME-Received: <xmr:0iyBYv2d46ODtZGOZO4R6Dj6Dur9WA-tJVothJdBlPRuU9dK3-PcNusYt9J_OSJ5z_WJjhBcEqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepudevieelteevffetieetgfelkeetgfeugeegieeiffeuieeljeelleei
    geevudefnecuffhomhgrihhnpehrrghthhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:0iyBYuD--peyenOaH76WgR2cjRjkUJRR1r-xcF3aK95WQ6_pPTzpHQ>
    <xmx:0iyBYriJn6lAO4wdn2kQ5-kCMDUsrKm4DVuNmvKinnRRBwO74r_Xbg>
    <xmx:0iyBYqqPL5WHRfxJt4QgVGhopxZEU5RwhJ92BTszHxe1lN7cWh280A>
    <xmx:0iyBYrc8SQ42R5wFyt4Wn1zq5J9iW842IKTUBpG1xh0Ks6rY__dgJw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 May 2022 12:39:45 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 9F85561F;
        Sun, 15 May 2022 16:39:44 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 2D82970394; Sun, 15 May 2022 17:39:44 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     libguestfs@redhat.com, linux-block <linux-block@vger.kernel.org>
Subject: Re: Communication issues between NBD driver and NBDKit server
References: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
        <CAEzrpqe0qfhPsCOsUjR4kzFA5oyN52nAjvX8c-0-BDb6tudt3A@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Josef Bacik <josef@toxicpanda.com>, libguestfs@redhat.com,
        linux-block <linux-block@vger.kernel.org>
Date:   Sun, 15 May 2022 17:39:44 +0100
In-Reply-To: <CAEzrpqe0qfhPsCOsUjR4kzFA5oyN52nAjvX8c-0-BDb6tudt3A@mail.gmail.com>
        (Josef Bacik's message of "Sun, 15 May 2022 11:51:59 -0400")
Message-ID: <87h75qu4vj.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 15 2022, Josef Bacik <josef@toxicpanda.com> wrote:
> On Sun, May 15, 2022 at 11:45 AM Nikolaus Rath <nikolaus@rath.org> wrote:
>>
>> Hi,
>>
>> I am observing some strange errors when using the Kernel's NBD driver wi=
th NBDkit.
>>
>> On the kernel side, I see:
>>
>> May 15 16:16:11 vostro.rath.org kernel: nbd0: detected capacity change f=
rom 0 to 104857600
>> May 15 16:16:11 vostro.rath.org kernel: nbd1: detected capacity change f=
rom 0 to 104857600
>> May 15 16:18:23 vostro.rath.org kernel: block nbd0: Possible stuck reque=
st
>> 00000000ae5feee7: control (write@4836316160,32768B). Runtime 30 seconds
>> May 15 16:18:25 vostro.rath.org kernel: block nbd0: Possible stuck reque=
st
>> 000000007094eddc: control (write@5372947456,10240B). Runtime 30 seconds
>
> The server isn't responding to the request fast enough, and you don't
> have a timeout set so it'll just hang until you disconnect.

Are you saying it will continue to hang even after the request has been
responded to? Because NBDkit claims to have sent a response (I'm not
sure if within 30 seconds, but definitely at some point).


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
