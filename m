Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AA5C433ED
	for <linux-block@archiver.kernel.org>; Sat,  8 May 2021 04:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D53161432
	for <linux-block@archiver.kernel.org>; Sat,  8 May 2021 04:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhEHEus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 May 2021 00:50:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:41333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhEHEuk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 May 2021 00:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620449376;
        bh=KzuuQYXMRN9pGQUEfYDu1hLgq9anV9jI1ipQxWyUX6s=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Mg6EP/zhpgZmIQKoDOAe2fNlc4H3kR3RpT++oTLMbpqT+2Qynz9nRCVpyDg0bSh8w
         chFjUkOdpuypbGrX/MYIluPDr+W/pNFTYgufw+FP94hmuQcYwh0WD+a/4skWpyQVgj
         QXNV9jUrQgUJhjbOah9JPNvtEuwOJ8CgJJTu/cQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.35]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1m0ECK2tVc-00W0du; Sat, 08
 May 2021 06:49:36 +0200
Message-ID: <abe6426476d4e87bd3977079380bc7c3f508328d.camel@gmx.de>
Subject: Re: block, bfq: NULL pointer dereference in bfq_rq_pos_tree_lookup()
From:   Mike Galbraith <efault@gmx.de>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Date:   Sat, 08 May 2021 06:49:36 +0200
In-Reply-To: <e0ece2e6349e92adc3da6d8c2ae6ff8a4172e4ad.camel@gmx.de>
References: <8c38408d27f1032f2a664838e523376c5da09a80.camel@gmx.de>
         <9732EA9F-E15B-48E1-9B92-2D74F75C6331@linaro.org>
         <e0ece2e6349e92adc3da6d8c2ae6ff8a4172e4ad.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hiulkvk5AR0k+cntRjFfaxlhKy6nafnzwfNg8bhenzOedJVougr
 84p/ewm2NIT59zJ0gqaKVaED71Blg19ueNsFb63k5IQOoftlO7/A/ZSGzFbSr1Tt6uPh+E2
 nAfDlUFieerjJIQBlSRolzsWBdCGB9ib1dk1NpyyyeJvmIqGFHFC93QDd9iIygYgUgC02xe
 tULcC6aM/SwgOFXTruWiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tQ6UyAdQFSE=:FX1DpQyzbaXkyLfHVt4l4h
 RULzuWDWj4Gldg2+/AohMjdABSAboLCtC88xN5//gaLO6/BCjHraAM4pbduV1GzHHsTzZm1Sg
 ZCczDYzhTc/rd3407dneoTEBGzxVtlaF6DqBPtAMiVVscdwpFwQ70B06mBfrCa8dAPUY512nc
 dpHSphYi3+m2kzraVvsp7o2mlp5k0933FP0ecld/8vRmeWRV7tISwsRISUagb6xhnN5YUWTWt
 nXU3OJUpgxgqcmqCHCHlhAObClea6B3h2/RBiGfyfz01qKmnSfRdmvbX/9kZ5oTJozDhQg/6g
 npP3Nvba0iwblvHwkobA+M5K7ocGuVOfj304CH5ScpUqBhHnW1z1KSMss/0W2CIJjT12YKN8A
 ScYxccQRHdbr0keBs/uVfADjHn+MlASMJy91c4Ca1GF4IrCbNhJjRXN33rYRftoDU1r6xKhzC
 7UJKpUqKUt56MU9quB0xf7R74hbhnJ8EVs4ipKlwFJvl4YnKtACeex1agHrqlSHmno4h/Iqrx
 NkhJlRCC1hDRxtGI8yTQgr+ClxH4It4i227+efbzxiEBjcLZiSLpXFNvRl8OGdoCTMlBcNo8X
 l+lm+Nh8obgrnE+IxMTy1qioBhvazTpWlnp1niif+p9gE1/siWIaaENkHq1y2PiW1jIh9430O
 jtAVL/CBHDrFM78Hp5HjqF9NqDFmrf3CxU1Uc9s2Ol8reBYj+zrcEw68r3FdznlVvrsVqMfOg
 zUzEAWa6naQ4qFVtEsM0bemvUfHYKJsAtd+M2HGipP1XZcSYt7TPHcfrAMJz6GL3i1dSvR9Bj
 5Ee6gR0YFQLLC/aWOPXl4TpOdT0f26TjbLE3ioalbRkw2Q66PAWWAZ+GJdRwy5fGSPOR3PyWK
 BiyK0Wb6YPSwVfpNLYdH+CWnmn9cTHxnT+XNxODnFkN7ehIs5/Ia7MIQW42pLhNC6ZXLTSb7s
 tdGbaAbPNxSGrduN+kVLN8QGdRdXO6l/w/0Herf1fDp9HV5mP/Nyh2vD1008wYvifbhg6+W4L
 0WEcFrhsD7aYsYjOm7OlVaSUI7wlzgIu03eBtpHK1Ick62zWdyaRYW55OQ2U4tX9fKWLFvkmw
 4l0E3M6U09fSXNAI8g42h8lN9xF0UkZg4d40BW4BEfLvdVhhnNvCIGniLqY7W4t1CIvxRtPhI
 Ezy1tNRqEfiRz9vyu20tHnOlDv14pUhCf4TSapkOJaGSk8kWRAxDg0pZbwHNQ9KssHo8c=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2021-05-03 at 14:41 +0200, Mike Galbraith wrote:
> On Mon, 2021-05-03 at 11:52 +0200, Paolo Valente wrote:
> > Hi Mike,
> > I've waited a little bit before replying, because I've worked on a dev
> > patch series, for debugging another crash. I'd like to use
> > this series for your failure too, as the OOPS you report
> > unfortunately does not ring any bell :(
> >
> > So, could you please try to apply this patch series?  If it doesn't
> > apply, I'll rebase it.
>
> This bug isn't deterministic, but I can wedge your set into my devel
> trees, and see if anything falls out.

What fell out was not the least bit useful.  After days of box working
just fine despite bug being given ample enticement, it didn't take the
bait.  I then build master sans patch set, which exploded on its very
first distro build, after which bug (snickered mightily and) went back
to into hiding.

	-Mike

