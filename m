Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58986C433ED
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 12:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E269611C9
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 12:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhECMmu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 08:42:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:47431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233683AbhECMmu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 May 2021 08:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620045715;
        bh=MgDjGj9W7AftKzP2PEOO/fWBeRFeC5Rr2QPkxBrpCAo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PsgzlFJ3WJl7vp/jTBhLPwPyFVnpjdbOO3n3URd6Fe2Hf5RvmpAMsS5te9ZH6geaj
         lZFFM1o+/zQCnjzAIzr4FFDoQzkhjPkfDGG6g844D6ciQI9cMZOh0qVrZAj/JANp7A
         mJTBEGgWDMC8jibzMksQhlkhQoF9ifG9+KojGKUA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.135]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1lSITz0ZxI-011xvo; Mon, 03
 May 2021 14:41:55 +0200
Message-ID: <e0ece2e6349e92adc3da6d8c2ae6ff8a4172e4ad.camel@gmx.de>
Subject: Re: block, bfq: NULL pointer dereference in bfq_rq_pos_tree_lookup()
From:   Mike Galbraith <efault@gmx.de>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Date:   Mon, 03 May 2021 14:41:54 +0200
In-Reply-To: <9732EA9F-E15B-48E1-9B92-2D74F75C6331@linaro.org>
References: <8c38408d27f1032f2a664838e523376c5da09a80.camel@gmx.de>
         <9732EA9F-E15B-48E1-9B92-2D74F75C6331@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/imrIJ5eJDQMTerBLZpi1T65wqIRlO7L71vz8GpusocRzO7mcNH
 GuWuLaxhXpgqWAIOblRWf2eG/yBttNO/gRBsIfnr1a2sk3BlcFgNUNwAm/Fbe7qkF/NhXBl
 4youAWSC5tGzrVC3RCBuIfsepY4zHt0XXROZNHFoW7cb5yQlPhWzHs8J+oyNuMQjG//b7qH
 O+WdNpZlNeEqw/6o4w+rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Vzkgk2lTPY=:HGj2eoEPDLNCvYS2Rpc9gN
 yf5sLrpi4v+sFRQkFIH1CeIm6GASGQ0zFFF9zglH+58adZwzNZBa5nGTJEx8Dp3nJLcYZLgfG
 BeHbb6DGSMEd9iryJIUj1TIl+rcMUdQ1g73G9EbeLD+EMT46Wi4moUyzhIVK5CAch/tYES7A+
 nLoS3U9uNa9kVe4TSi+sU5te72D4FH/4euRA5Jq4kecmzq0vPwQzW36G9Cwd9oNmqm56Svo8V
 4sNaQ+xbZeevLqi3bDp0jOUdHk2AIN10/OVXQS5GWpZa/cyBdreLye5OisfDmI5Yc99FO0goq
 cOt5Fn7SCCOSDRfVE7HPQAMccBg0niAPgJIHvs9fLswqz+IJ+02zXzR6pomfnJOryJ2ysFhbf
 m1qCtKM3JXH9FbOeAVUFhlh+WUGQb+eLEitv/C0VKgb4Z/4tlztlTOAu1bH1Gezb+JE/xf1Nf
 5RlOOGSIOM8L5me6Ti4CvRUkC09GqtHZDZrZrVIuCuE5QP3BAGY00GXaOiQvD7oHEY5CYtqYP
 kRof7eU5mhMwoFYwDHelAAGngI04s64Z3lnQPLn6YieUOlTBYQWi+/onfhB06qUOYv+vQMMj1
 cKh4R89TuMg1XY0WL31C5nSWLTuJdonxCvdmUlPtn0n3Z7zJDjwmFUEWPaS8Sz2ROXp7YBl2h
 5/SkZHUkTcNEWcdGrO04XJWsLNyn/Ep0UJ6m+61TyO/z31ehtjairS34AHzCC47rXssCJF/01
 mhA5P67VPgK8QZk+m6AvKrWCWNQMd6H1X9S7bc5XTA+ospY1MZA+RdA9tUE5Qs0SgeQhlu3pt
 Iyfw7K3SXrLJZ9RQ2zNyqLG43s8oG0NLB17HJDbN3D8Ank14xVGbgiPaC21z2tQwLmI8NJPhl
 8a7sdnJFYX1g7Noub600HjqjjctKsMGkVYhcXPUM6Qw3Vta4WdyIrzbBHUAAaXZ/4fF0XxN+P
 WMxzQhcghXKTbuy0oyjvvru4eJrfflMX07TQ1i96P52Bs0xIpUs7FWw2QYv2FbE81j1AP2oxD
 gcWypf524Q2vleJihH9sswhl4af+woVJZxrZJbemdAQyJY7rCxLzkkoJTjTXsNYHMV/nOlgQH
 zT6KSFL6/sHXu+frGyywLhP0OxPTjlrnahrWOsQBXa72UDVagdgahR/6N+8hj6swH0BIpPkcg
 Gb0oly1V8t64PyfYsMwRSDMwSD5GS0bwMtBIrNM752gAdM3BFQYKYy3As/znfex6wWybg=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2021-05-03 at 11:52 +0200, Paolo Valente wrote:
> Hi Mike,
> I've waited a little bit before replying, because I've worked on a dev
> patch series, for debugging another crash. I'd like to use
> this series for your failure too, as the OOPS you report
> unfortunately does not ring any bell :(
>
> So, could you please try to apply this patch series?  If it doesn't
> apply, I'll rebase it.

This bug isn't deterministic, but I can wedge your set into my devel
trees, and see if anything falls out.

	-Mike

