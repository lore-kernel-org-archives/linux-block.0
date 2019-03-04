Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A247EC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715232075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="QNLzp5Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCDNsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:48:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40211 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDNsO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:48:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id 10so4282635eds.7
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pCdpkWBhJD7USuv0YPS+EyZBn4tPeR14FbeRag9RjGs=;
        b=QNLzp5Ix9pAdpS+uJTX90qxXeNTnJ7uJBnO6E4CzgQKg0+23omlOBbhMwz8TtfVDH9
         1SHNOJz8jHAZ3RimyOUXa00q23j2i9FiVxh1QASO4gM5O7i0EF9LTglGHDNPftfQB4+W
         PWthOx86bRCOp5bnbjI/LRh1JvotLZyIuRGCK4cPye/rFaHF1tWtsqY5skqwNoD0fJAb
         ++vGxpimkGIlQR1h5lJleNKDY57LhWENfN/x5knfyxJc42DwvlgNhcqyEL8sz7RnyuAq
         2Hwr5Dnnh9viyJ7BHSS5vK+EbDEl1rffNIQ7eQVvO3Ig2PVS2tDCqN2KLGEi0H0RmNUK
         NFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pCdpkWBhJD7USuv0YPS+EyZBn4tPeR14FbeRag9RjGs=;
        b=Ui8skPv/h7zBBG/Uj4ybzohX7brL6qsJ3VIyAHwXUGSTJ9ojDOg8UHox5u/bHDXiCW
         TsYnxZdy8DNwzP8n9qtWK5SEAO1yCQFGYLiAJOvBTdeunv/eiwAnTl1sCpZ7sb2hYl5Q
         h09SfuHOVqWLBS6hzV2HpDekefj6hfxmfkBFwLPWRFDCFBPMZFx5spsBQq4K1ord8c0a
         Qo5OZI3lYo5jP8ysToKExGID0fR4599CtZ/5+iGWgbC0xPGRh2zg7GrM05zwSbRjvvgK
         nZi6F1kwvRsZiU0L/pME5qTdsuWPJ6C7Vfb8V2OlYomCX75SD1NDvY4d5HonBPUTWzr4
         ONUw==
X-Gm-Message-State: APjAAAWFSEwWwmwcXdKQnZsgfd5nGspOI0MjdCMhkAYKWJI5isfzJH5+
        4JNXWXs4GujeFQwbXvWtRIQcZA==
X-Google-Smtp-Source: APXvYqx0KrNAOO/HmIOjqeX7OBM70JOxrZrttVKJ/w5P2L5SbJktbUyQRD0+nork7+cZNT2GAelQog==
X-Received: by 2002:aa7:d445:: with SMTP id q5mr15134352edr.294.1551707292421;
        Mon, 04 Mar 2019 05:48:12 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id e27sm2111322eda.52.2019.03.04.05.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:48:11 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <8B6E8B6B-1C23-4D17-8822-0A9F3E2E8932@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5AA853C6-74E7-4ABA-BAC6-C7EB4FFD7B1A";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 12/13] lightnvm: pblk: close opened chunks
Date:   Mon, 4 Mar 2019 14:48:11 +0100
In-Reply-To: <0ee7b3e6-f471-1996-0c89-457c96f950c5@lightnvm.io>
Cc:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-13-igor.j.konopko@intel.com>
 <C2286529-B0FE-4DFE-8CD1-5BB6591549A4@javigon.com>
 <CANr-nt1kkQ1H4TgF9-3yR-_S+-HkNwEnGu_t5Z607jAV30cpqw@mail.gmail.com>
 <0ee7b3e6-f471-1996-0c89-457c96f950c5@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_5AA853C6-74E7-4ABA-BAC6-C7EB4FFD7B1A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Mar 2019, at 14.19, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
>> + Klaus whom I discussed this with.
>> Yeah, i think that "early reset" is a nice feature. It would be nice
>> to extend the OCSSD spec with a new capabilities bit indicating if
>> this is indeed supported or not.
>> Matias: what do you think?
>=20
> I don't mind as long as it is gated by a feature bit. An ECN can be
> made to fix that up and then software can be updated to read that bit
> for what to do.

Works for me.

Javier

--Apple-Mail=_5AA853C6-74E7-4ABA-BAC6-C7EB4FFD7B1A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9LJsACgkQPEYBfS0l
eOB4hQ/9HIGsxuajWla1JcEXRCUuEjadlEIPYamGfOY4ye+MqEiWhprDrHbPKjTp
nZMlsLqcT3QcSUZ75sMkc3eYpxiY7Ki84TLok/2XZJBB8cUz/sAEJcgIKqDPnlfo
f3rqFFo/OsxBzaW9WR+folL25Bi89bYV37d4PcmatoTDwvnO11otIJJzhTjV81D1
Tmwu5Q2x/85HZieaZJh4I1bo1YVoUOOn9y0vUTDHIWX6J3HSaHeTOACaRgZ9av4N
d9U8tMV0mUFqPeUSAIIzBFp9xDM8xJNdxI/ffhRPfK7YFAL4GOEuG5UaUeYgW0aw
jOTJQvZVOsnU2HPs1x+Mv8R154wZv9CKL17KfUaGRVf6SV4mXKMxVk/NEFVlpzbJ
WLi66F/SubgdlVIxcmMIGE91/e2jjaBZSFfSsFY5ROl66SFo48bdcS9iiagc0XLf
TEF1LwHY9hXrN42ulRUiH6K2s6DscMP4fgJXdZ/92cJLSTJgY2MUjG4gCxbVcsdK
gtXdbAiqmshgJ4LgRxgBLQ13E7f/DEi/YsjXxFpUYUkUa+AuSKant1pBSBhpjNhl
H8DvPSfcQ3eZRKV5sqscofQ0ien6dRQBOqoDyOlXHdX42y78fUx8fc5dpUfNRkBV
facMYw7Dk2r7P6jNbNc04+iNBqTDTIFf1kLaR1ZL5bFmo+VFhVo=
=xvwb
-----END PGP SIGNATURE-----

--Apple-Mail=_5AA853C6-74E7-4ABA-BAC6-C7EB4FFD7B1A--
