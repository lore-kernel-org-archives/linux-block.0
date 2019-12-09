Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B600C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394BF2080D
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 17:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=warpmail.net header.i=@warpmail.net header.b="rChYbxSk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKxWTsqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIRaZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:30:25 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56797 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbfLIRaZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Dec 2019 12:30:25 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B973FD77;
        Mon,  9 Dec 2019 12:30:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 09 Dec 2019 12:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warpmail.net; h=
        from:to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type; s=fm2; bh=VxSk0kTeowdly7fXn1T+bkV6s+
        34rC3j1VX5t2hOPBs=; b=rChYbxSkkwzz6Dd7x8jQ9HDYu7oC81Q3AyaZvNsoqY
        +K8t92AYKsQgcNOZfkp5fnmZemuVkpOWmooRrwBcfqkXqnuQzGkeJfOMrCPGfMjO
        2SWLJrFTgOVxBATZvHNbZqiRH0LGHZpCqz+FkEF/AgmNXmB5TNOS4gnJRCOVG6bD
        WLKA/f93fUtsqzG4Ar/thTF0CJh633vOXGucRMKVHc1ifF1ia4B1eAUdMa+cjmwO
        Dyzdhq+5OU+UzflEHx7CNoVVhdC0cbVDHBnMwaWEH4Lt9fd0bxwl1MMOd/hu3XgN
        KaebUjuRw7WXEPPk19shMY1ZtciMUPmJwuRJbA3zeesQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VxSk0k
        Teowdly7fXn1T+bkV6s+34rC3j1VX5t2hOPBs=; b=pKxWTsqn1PQxuxfI6p3qCj
        KQ3+AWwaViFnLNaUG7oLEE4QbHaLcoN4rlGxGKMkLHkmie/6DSXSmAXnwa9xk54N
        J9W4nKa80XSZYz/MSKwbFLHr0fVyQNu7FirT5BkdM9lONWQt8hE9E8biCzIFeAvo
        DQHWoi81wAq8hYwfLiBwXKf17b876UrTy0cygNx3UPsfU1qsZGHMq7u68BdrNNLj
        zv21dpCVAKSxFJ4YazApzq8czVxpUoVzWIctZOnyL/CcQL/0WrQVUBCY14lmFeSr
        TCJQPWVKNiI6KPqJIJl6PuUSHZyaPG0bxV0L0qsifmMerNAz89kKdSXOD+wVyj4A
        ==
X-ME-Sender: <xms:roTuXc1Kf3vMPA9kv5zf9d3AY17FQ4CuuJgxKHgWz6o0gBVBZnu1_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufhffjgfkfgggtgesghdtreertdertdenucfhrhhomhepphhhihhl
    ihhpseifrghrphhmrghilhdrnhgvthculdfrhhhilhhiphcumfdrmdenucfkphepjeelrd
    dvudelrdduleefrdelieenucfrrghrrghmpehmrghilhhfrhhomhepphhhihhlihhpseif
    rghrphhmrghilhdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:roTuXSxACSGWVpHtjnBkVgVR6zFSXwvDUZuQ5-1QEUoWwfsshH4htA>
    <xmx:roTuXRXcnOHOBb03UHnagPVvWByN6WDenjuahG5avS_lcY8CbYThaQ>
    <xmx:roTuXe9q_nLuiWtpP90WwxZzy4vIyhitLh0Zj0xzyoF4qqOuGOfnvw>
    <xmx:r4TuXR4MvW8YLVtS5O-6JbOy6aIXm_aLHbZP9d0Xi6llatl1lcdsaQ>
Received: from localhost (p4fdbc160.dip0.t-ipconnect.de [79.219.193.96])
        by mail.messagingengine.com (Postfix) with ESMTPA id 012F930600E0;
        Mon,  9 Dec 2019 12:30:21 -0500 (EST)
From:   philip@warpmail.net (Philip K.)
To:     Denis Efremov <efremov@linux.com>
Cc:     moritzm.mueller@posteo.de, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH] floppy: hide invalid floppy disk types
References: <20191208194534.32270-1-moritzm.mueller@posteo.de>
        <d3f0613c-6c3a-8efc-1c27-a6b75c34972f@gmail.com> <87h82ajzqd.fsf@bulbul>
        <04f0dfb9-d25a-d9a3-74cd-538165a8bfa2@linux.com>
Date:   Mon, 09 Dec 2019 18:30:18 +0100
In-Reply-To: <04f0dfb9-d25a-d9a3-74cd-538165a8bfa2@linux.com> (Denis Efremov's
        message of "Mon, 9 Dec 2019 20:04:32 +0300")
Message-ID: <878snle79x.fsf@bulbul>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Hmm, I would say that driver blacklisting is a more proper solution in
> this case. I doubt there are people with this issue and real floppy drives
> in their setup. Altering the default driver's initialization scheme seems
> superfluous to me.

As long as major distributions like Ubuntu ship the floppy module, there
are enough people who could be affected by this peculiar behaviour.
While I agree that blacklisting the module would be more elegant, I
still think that a patch that goes in this direction could help more
people, especially those who don't want or cannot solve kernel-related
issues.

> This will force users (if there are ones) who depends on this behavior
> to rebuild the kernel. blacklisting doesn't require kernel rebuild.

Are there floppy disks of unknown types? Our patch is intentionally
conservative: We won't hide false negatives. If the motherboard reports
an non-existent disk

If you're ready to think about it, we could consider extending the patch
to un-register the device if it can recognise that it's (probably) not
real. In our case, for example, fdisk reported that fd0 had a size of
4k, something think is a strong indicator that something's not right.

Alternatively, we could look into what the comment

	/* FIXME: additional physical CMOS drive detection should go here */

would imply. This particular bug can only affect fd0 and fd1, so if we
spent some more time, we could find something.

=2D-=20
	With kind regards,
	Philip K.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEXEVvqaSeWykH0GvsTLppj2Aa7OEFAl3uhKoACgkQTLppj2Aa
7OF9pAgAqWP2tVIcoQy/Ulcz7yj53sm5Owk+EhQWE3AvheRX6y0GKgoISKw3PDHG
D+EluFH2strIYikcsEkWzvEGNnafcvHhfT+qNVwg5uj5aN2MfaMHHBzkHsgYYV1n
AIYU62vaY2Wvrh2QxGEojUNL8YHBHWLihVxmUPVzztP8KJ7MnPhYhJDi9jZwPZzM
bsZzavZL/E8YS4FprpXJ2bLMMHgdn/uG2M0VXQ4ZWowtqKv4Md5wwILpukA0JdpD
C8UzNE49oFIGb/WHGLj/fZCM002in9hcsTOBVM5Cl20KbHGUU0M2+S1R3gu0cLR0
spfepi0i9PEPa6b/KB8mmltBvuCQ/A==
=bMz4
-----END PGP SIGNATURE-----
--=-=-=--
