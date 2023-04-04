Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57312C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 18:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjDDSpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjDDSpl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 14:45:41 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D64448F
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 11:45:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E6015C0218;
        Tue,  4 Apr 2023 14:45:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Apr 2023 14:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680633938; x=1680720338; bh=kr
        FeNNOsYObGFmIS85mJvh+EIehXxf+JYgAjScxHhkI=; b=RhZUC5frKQFi+Wk2Kg
        8FeuZS8UiCOGtImvwYlvDbz0TssptcInxN46bTDj0m+EC+QpG3J4sGDk8qKsx+0U
        Vif8Mw4uNIYrZZCLL0OXGrUJHv2bsmNLHzC6RVTEVjaYyH7mNeSzLyuaWOf4EY75
        hY9ZxFcuR18WoGtmQWDR1mRBumhtAKVnV25qmrfCZuV0cMowdLnfBeX7cycg+Mpq
        Ekf3K0mi2McTIhHdhIS8IS7myULynIAFbe05FgZgfC8PExAOHlFJdfA9zyRyyNWS
        zvP1HMteFq8dl6gvCflBG1eLIgaufEDoiRHn+TEqdBLHUwmY0c8q8fxIrxlDq5wx
        Zp8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680633938; x=1680720338; bh=krFeNNOsYObGF
        mIS85mJvh+EIehXxf+JYgAjScxHhkI=; b=L+bdivR+tMKlaaIMqF6koqZrTlKtW
        8cvQ8OOqbbP+EIPMPjsGvALI1WlDlkdezNQaZpwQ2tzmlPI8K8AplgjTgW85zy8J
        bmkamaC4av5WkJxNQWfPVjwPq1j+ZWRi5/aWTZBVHMb5jkD8tXVBbZcM5tNkyWRg
        kw3qID9lFz00RUi/+nFXUSDRJcn0Qeju5agq8LiiEB2KKRnafKMTYavvb/kyqMyb
        +h4NU8tNnxqH4rZjD8r0jnt6p0S0aNN/dsxsXbuneGoWU/lT2o5OKCq8+UuFNDzg
        HoRmP7J/pAamYSRym0avGEfewEX1DZUp5yDvJ4LV7DBSEqEp89izAUKDg==
X-ME-Sender: <xms:UXAsZC9r-z2Ib-a7b4q6tfaOh5l8DIAePZ48NhuL5V4Ged3xuvArZA>
    <xme:UXAsZCv5oh-IORQfmavuyg3HL-OlyezcsRcnn7VDzYBQWzMYczY6LycFlfa9cJHq2
    9AQjaHksJgFKgS-Rw>
X-ME-Received: <xmr:UXAsZIARRdnOIjeSjmjWXIK-HzpLKgXMFLm0YghCLsScJuUNR4VaK9RG1INPR-jjR9lccg6hGCtfhorH_0-LXZGio7o1lTrDRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeetlhih
    shhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpe
    dvjeefueehuddtgfelheekudfghffggeektdfhhfdvteeltdeuieevjedukeduieenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:UXAsZKffBPfMLQIzCEH7zotPQxcqZ2qvwLXW_lwwGiIwdosXokeIbg>
    <xmx:UXAsZHMIO8rtihWOyqIHg91jNziKhg_2XHepKScAezFzxG7H-tq4RA>
    <xmx:UXAsZEmHpCl7VINYWk7u9pkftqMqfZFoeRWe5FBkGfMhS6aH3ycv8A>
    <xmx:UnAsZAotcVgsz86zu_WcW79xxjFnQVNeOchw-PF5xAeL--xrj6MJwA>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 14:45:36 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id BCB1426AE; Tue,  4 Apr 2023 18:45:34 +0000 (UTC)
Date:   Tue, 4 Apr 2023 18:45:34 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] loop/009: add test for loop partition uvents
Message-ID: <20230404184534.t22goewekxb5yds6@x220>
References: <21c2861f-9b7d-636e-74e1-27bd7bbb1a4f@nvidia.com>
 <20230330160247.16030-1-hi@alyssa.is>
 <517f4449-ffef-f1e8-78cf-bae8c2cdf665@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="64s75twqblaffulm"
Content-Disposition: inline
In-Reply-To: <517f4449-ffef-f1e8-78cf-bae8c2cdf665@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--64s75twqblaffulm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 06:29:00PM +0000, Chaitanya Kulkarni wrote:
> On 3/30/2023 9:02 AM, Alyssa Ross wrote:
> > Link: https://lore.kernel.org/r/20230320125430.55367-1-hch@lst.de/
> > Suggested-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
> > Signed-off-by: Alyssa Ross <hi@alyssa.is>
>
> Thanks a lot for this, overall this looks good to me.
>
> This does exactly the testing for loop configure that your patch
> is for, let's just make sure to apply this patch once your kernel
> patch is merged.

The kernel patch was included in v6.3-rc5. :)

> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

--64s75twqblaffulm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmQscD4ACgkQ+dvtSFmy
ccDLbBAAl0hQSPzAliQE0VWqZXaXSBRzaO7rIfd5rABBr2RBSL01NteHGOMpHb9A
7daNKIlbiMaakMPcIpG3i9vYjgT7ZRrT7YvXpt4VSj1HN7JdfxoINOcgkm7AHrev
B/UN3IAOllI+YT4/dR1OWhSoj8DQq91KcddTEberazrYB2vzT9nf0CWJLcmvk+hN
10AjCRjVUJbbhKRO/JWuEUmXGL2rGqtH2rm7TRCTJOSW6jVZsNBUC+Bhj9NZVSGf
A8HyWN47OHwBYLWpYOJ6uOLAbh81VrDpZUMXKl3umv9lW4LdaxCeo3yz938B8h/0
nlefCxOcYzIuvqYp9EW7IBoEXg9avb5VcAvHke/378CAVCzsHKhKBOLr+2m9zpNB
usSqC/VjstEssLcFSgg4mQ23xUKzVW5U6xX+y/eFIK+uyFOY31eL7IlSKdoCvrpx
WvVpwCC3YRPB14JC7dfQdrx+3tzZWtXNQ8u2xp0l99/5hX2uMtHmSXeEZFOYN0l0
/MhCZuzWfISCJbEdyTuISew2vlPv9TIE6c+1JLoQ5tuuoPsyTL860fMM1cMf8e1K
SKGOXVLTAuyW06N6/8Bkb4uanFDodYeG5RUY4etHu5RNxnx5sjTWPlGYk4AQVTi8
etzDhxVkPudHDPfjyBluHrWjP/9LR3FCe7wTya6+ZKfyrGU9iBk=
=sHRb
-----END PGP SIGNATURE-----

--64s75twqblaffulm--
