Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FE0C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 18:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0144721872
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 18:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="zS6vC+In"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfAWS1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:27:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37078 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWS1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 13:27:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so2495821edb.4
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=E417q/WkzjCoDcoMVn2h9uaBLaMupnwB0puvi86MCgw=;
        b=zS6vC+In4GIpE8x29d3W4kh0ZXWG1KMeXX5IB33GoLXQpf5Bsb6SFMWElH4v21Qafy
         UzUHQudRucC3BNNuTkco/fIRYofPX7SzqTb0kXaT+NZ45Tcgp1qCloCHGXuAUJD3V0eW
         V6ay6CQaNXy03Drd4IkBbRjeSVpQOORYVEOtoyH5wdfknWua4Xj9MxfJ+IjHkMYptBad
         9WIq9DweWtlVmgmMo96VJ4zj6zna1YI10l5bvtZ6SuTIZtQCM74+Ga4aIDDnI1bGkgk/
         DXxJYx0F6kadzTWJZlNtd3jg+DwawGwUqSrecweXKKTHRsRDeZRNx8vgnLv7HOJvS8+W
         wDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=E417q/WkzjCoDcoMVn2h9uaBLaMupnwB0puvi86MCgw=;
        b=PsgNekopEejiGHsi4lup1hdS0md7EJLv24YrryWGas4hBZxQ5uwyCV5KEXp2D1nh2H
         5pi6dv2AVEL76b97JCUdBV7g8q6wMaF1QMz3btvSrInijo9k1Upss8WqWIBMjPtGjWsu
         WM9qzgX1Jgv4ezta7YTJFcIkS+UXTwGb6yO/9ms+naBjSmcWnyCQVXNVwC5feVtb+NmA
         IVPVRjB1uOZMsoo/ELdkOrvTK6tgg4BB+lgo0NIJeC/8KcompopQ1/XzYcbNRL+Jp6yr
         wwxYxpmMrtz1hJYbI8qntj16iHfrjf49gn2+6u7qmWDTS5wgTScjPLrOJkCLABpesmrF
         faFQ==
X-Gm-Message-State: AJcUukevO/Pc9vmu2ntIJ0bjtwQ6vdWLXhwu0xpVZqLF1rQhoQZzyMjx
        QDqdQFl1vwBn6X79hRpQM+1DtQ==
X-Google-Smtp-Source: ALg8bN76USpNR7h5SYJTRsLbh35Fsp6YM446i9pcoJTqTFJMMS/WPF8OIkjHQXaPQawGuEGORQqZsQ==
X-Received: by 2002:a50:bf02:: with SMTP id f2mr3642779edk.157.1548268037131;
        Wed, 23 Jan 2019 10:27:17 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id m44sm10962346edm.54.2019.01.23.10.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 10:27:16 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <B4980620-2CFF-41C1-8EE7-C33F1FE431C0@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6C7901A7-5D20-4C9C-B665-8EEA100B55D5";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 2/4] introduce four macros for in-kernel hints
Date:   Wed, 23 Jan 2019 19:27:12 +0100
In-Reply-To: <1547047861-7271-3-git-send-email-joshi.k@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
        jack@suse.com, david@fromorbit.com, tytso@mit.edu,
        prakash.v@samsung.com
To:     Kanchan Joshi <joshi.k@samsung.com>
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
 <CGME20190109153336epcas2p29b3275b6c545e483a3f43b92268f08bf@epcas2p2.samsung.com>
 <1547047861-7271-3-git-send-email-joshi.k@samsung.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_6C7901A7-5D20-4C9C-B665-8EEA100B55D5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 9 Jan 2019, at 16.30, Kanchan Joshi <joshi.k@samsung.com> wrote:
> 
> Exiting write-hints are exposed to user-mode. There is a possiblity
> of conflict if kernel happens to use those. This patch introduces four
> write-hints for exclusive kernel-mode use.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
> include/linux/fs.h | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 811c777..e8548eb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -291,6 +291,11 @@ enum rw_hint {
> 	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
> 	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
> 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
> +/* below ones are meant for in-kernel use */
> +	KERN_WRITE_LIFE_SHORT,
> +	KERN_WRITE_LIFE_MEDIUM,
> +	KERN_WRITE_LIFE_LONG,
> +	KERN_WRITE_LIFE_EXTREME
> };
> 

I think Jens and Dave meant kernel hints to go top down. This would also
give space for supporting more hints / streams from both ends for user
and kernel.

Javier

--Apple-Mail=_6C7901A7-5D20-4C9C-B665-8EEA100B55D5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxIsgAACgkQPEYBfS0l
eODI9g//dR040m0StXwBm+NOgmUh3cPN5zgCnWTJq1ZEQDwkRwrlqT7deA9se6Dw
cuI1L1XlPzA7vKgqzmPou6WFcE/EwxzyLNXHILMXZAxZI53OHtTDuC0HD5p1KghI
+NV/IpSunToiOmKXuzCwAz08i5TeoXvZXX4ytoYpTTKfwt7H+OgR439haKzb0xqI
Hr8Ftu5Wbt6Bg54r3AfxPMqiKYL0XxTbeMocyQc+d/zR+UhSZUTPyCPaaXKY6T9x
Ud5mflJWS+t5eiztVi+yDQEQb5V+8NaIrU8+lM1pCpmK2snDCy4pq2R6fOia16yq
u3fknZzU4uV/QTWzwQQ24hdimsqNbm2aOAuD1f1lOEJDAziiH+S7J5d2NnLjZzAc
18Xvqemq2w7Z/3aq+PwNXHAK1i8pbmLQImEmWfQAZqKeEVwjYxKzDkUP3uCt4DVf
9/jAHRd+EAaioNyevpQ128DO6jtuGHZ2x7fekVqCzhN/Mwh1NSL/NLtCe1o5U1sM
U9yCaJparFCsb2GV69XhqlZaSwuHPnpdU+x+zUHdUAJRFj4TLtSmQm5Sp5pSYLQP
Fv2RoYAQTJ0jjc1WDXf+a0Pry7t65DHagRG/mmkebXKZDyH3bqV/YKvS40X9jGR1
nNwdSp8ShN71zFahUoNuijSAzMTrjODTMC2wPKVcrmeRXvI+/pY=
=+41p
-----END PGP SIGNATURE-----

--Apple-Mail=_6C7901A7-5D20-4C9C-B665-8EEA100B55D5--
