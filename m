Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC05C4363D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 06:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37950221F0
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 06:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIWGln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 02:41:43 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49547 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgIWGln (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 02:41:43 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 480B65802F1;
        Wed, 23 Sep 2020 02:41:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 23 Sep 2020 02:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/z21QK5UQgHyaHjd95pTEuYeZ0q
        rZrcGeZBWeQkKxzE=; b=wMBibIRm68K8SOrN5aQKLf6lvZBwpZpmIvu/UhqpEFu
        A8Gj/b5/wpSOtHnLVc3ZtanSYgQkucnQHkizjPFrAuUt1dKlrSSSJE08b82yI6IX
        kAPMNwcYs2p+a97R7wImfRCo28AiChv2kmMTxzOhcr8SSQzd6U9Mnso5ohrYesDc
        z8+b04iEr4L0e8sA4+u/tTk7A1fHzJOo8GmkD4UvImHzckd+PEw968roQNqUmf0o
        KzrDpu9+Jfe512reZzi0D1OemLiHiL2prs2M8tiu83zoA69F3tZHuPWz6yh1/GCA
        gCoE51Ee5ghvkjNmVhphQHAeIjrCApgUAspsLcOVkTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/z21QK
        5UQgHyaHjd95pTEuYeZ0qrZrcGeZBWeQkKxzE=; b=k5sDuGGt7oeE70dkZB0LN7
        uHzBwFXWb/TfgGlkiMctxXj6FCc6xl03tG9bnZe5Oxt+tgKOObMItSxnS0xmWnP+
        zs6DyHmPqtoQaHXnlTwN0Dq2Xj4rDFa7r/djaG8jgxkBJ/7W8DEoPO4glexYyVuM
        ixi55GCtd1wPraWn73+c6BTftaiflsfqmhU5bN4BI7UWevl8hdfhw/9v/ZFAIMnS
        DxBnPqV6wCTEGchPPNfQ9FYV6UObly08+PijlbRhkcF9vLpEPi3KOZa7G6NO90mf
        oLKC+LKX4jbY9LYNPznIssBq7FJu/HuVNU/seinMLCADdGynDdkTFj8k/9Qz7HUw
        ==
X-ME-Sender: <xms:JO5qX4JtmKWcurBWCjHp-6N0h-O8R2XJ8_FE7QcHyvpqCynpgeYpYw>
    <xme:JO5qX4KIF2zKs7W0jAsTmOOoCVjvcReatPuYKUrJzdlSq0pm1NCUoOQaEoudAAzRV
    aJgsa6ioefffqjEM74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
    ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
    gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
    keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:JO5qX4tD4rV0TzkOLBMAps0nwwZjo3ltvbj59xR3R3Q8q3pAv36mBw>
    <xmx:JO5qX1YQDc3-sTrVVggFVmzFZNWpkof9FL0g2NegzhosCoqsADIwag>
    <xmx:JO5qX_b8yOrgUbMh-2D0Bg5WOWNvR2rVyMltTZIZKutnr_hAaZfpog>
    <xmx:Je5qX7FMPxI2VcYFju1-R_-3VKnottuxtJxkzCH8dapU6nxw0BQo8g>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED0F6306467E;
        Wed, 23 Sep 2020 02:41:39 -0400 (EDT)
Date:   Wed, 23 Sep 2020 08:41:37 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Klaus Jensen <k.jensen@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/011: remove and rescan for evicted device
Message-ID: <20200923064137.GA1473757@apples.localdomain>
References: <20200922080843.1249290-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200922080843.1249290-1-its@irrelevant.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 22 10:08, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Devices that actually honor the Bus Master Enable bit and considers the
> resulting failure to read/write a fatal error, often ends up getting
> disabled by the kernel when running block/011.
>=20
> Remove the device and rescan the pci bus after completing the test to
> make sure we bring the device back up if required.
>=20
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  tests/block/011 | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/block/011 b/tests/block/011
> index 4f331b4a7522..f1306ae3896f 100755
> --- a/tests/block/011
> +++ b/tests/block/011
> @@ -22,6 +22,7 @@ test_device() {
>  	echo "Running ${TEST_NAME}"
> =20
>  	pdev=3D"$(_get_pci_dev_from_blkdev)"
> +	sysfs=3D"/sys/bus/pci/devices/${pdev}"
> =20
>  	if _test_dev_is_rotational; then
>  		size=3D"32m"
> @@ -42,4 +43,8 @@ test_device() {
>  	done
> =20
>  	echo "Test complete"
> +
> +	# bring the device back up if it was disabled by the kernel
> +	echo 1 > "${sysfs}/remove"
> +	echo 1 > /sys/bus/pci/rescan
>  }
> --=20
> 2.28.0
>=20

Hmfh. Looks like this at least needs a wait for TEST_DEV being back or
something. Please disregard this patch for now as I try out some other
work arounds.

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9q7h4ACgkQTeGvMW1P
DemHtQgAw2Qy8Yd7wxa1HqoLWtuQaCXqYhbovsVawnrMvRsRyORU31zBNNXoUoCu
DAznoQ/eE7yNo/z6PHZztPlGPuEHb1CuS9sH6IRGdXOXNd/m4mHzjrLcDIzLhWXV
cTTIQXR90s+hxjqFCItc2UaraJY14LBDD9SUJ82B5EJD9ukw8tkna+R4daLtEK9X
B6tNaRU1uOSErYknetRaVYk+0sm/AOL9lRrwI4kC/mBPWkUBB4EmpbsBsrTunVZg
xODr/EwE1mKEf6ETP4+WBitJ7JS3mk2fOs5+O/tjdr8kG7mF8dsJslZYLIElk8Df
Awj5Qmh0fCt9dDNABup3YHzsu5DcJw==
=pEOX
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
