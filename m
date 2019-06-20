Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591DDC43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2284C2084A
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 17:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP/RvjE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFTRTP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:19:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35455 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTRTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 13:19:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so3017738lfg.2;
        Thu, 20 Jun 2019 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=zleHwhjAJef9XC91RqDfR/AeowOlzt3YpM6VRVwSrC0=;
        b=BP/RvjE1bvG4wqIP4TxqAexTdG+P55DPUpTj6oVPEU7k4G701CGaEGhdR2k3cwp/n+
         8yTa6pZdeQsvvDT+COtgchhmyIMNtv6QQTp+JWuNlK5CcgV9HnhFHqavh3VG7pNcXiSc
         cJ7sJ1y4+zTdOeynPpMstKUgWBX+jimoRp0ll141QMcHq+x5vBs50Lg+WnilC26WpJlt
         1BrCKlynAQcC6IeELsxxCnoMBMs3tc1Apr42dLS6u3/fMsXGsNvPAWZdXDJm/MdfGC+Q
         U7SYjTad0j4md6OpYd8Cj5IjywGBLKOiDLb6VGqoojYbtsd2tlowoeldup6+s6FLbwlD
         mVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=zleHwhjAJef9XC91RqDfR/AeowOlzt3YpM6VRVwSrC0=;
        b=kWDcOl5Cm8fAcRvWoDzRHldrFimutrdBAsgJN1fkJUtszQaWyeg9vnah6faMkHScBP
         hz3MQJZ9Ir/2pom5C9DXPV3ImTCyGjv013iLjpJnWjkCspdPEJnXl3qnVWJiaiPrUh0Z
         MKb/uuSYxrVV8S/TC8kO+qr2oLaCCJRu03Fgmb8v+i30pKRomvrFZXgy4VSSJI5Ewa1w
         1GBujqil1imcrj86dSu9NrwtNgdrKL6Ernj/dlxnh/xtsSfu7F5HO/FcjGRMqgkiWJWq
         iJhG+fiBgy07Ls3RgKbKknCTxnuy1FxaNNGTotN62Ru/9GobfS5Q4PCgPhDs9AEgvZoD
         0gAA==
X-Gm-Message-State: APjAAAXQu6psotqiaHupwB10x87vlzvlDGQq0VS8P8aysBto7MkHzjB1
        QrLDIt4u33YONs20efsPH8uqht9HsE8=
X-Google-Smtp-Source: APXvYqyzUlDYSDYlJ+5x3Kyr1W+4h5lBHZBPCBgCSqGL0+O6UuLfghEmynRo126GoCY7MvlxoMjr7g==
X-Received: by 2002:a05:6512:15a:: with SMTP id m26mr21927397lfo.71.1561051152342;
        Thu, 20 Jun 2019 10:19:12 -0700 (PDT)
Received: from [192.168.100.202] (mm-56-110-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.110.56])
        by smtp.gmail.com with ESMTPSA id k4sm28489ljj.41.2019.06.20.10.19.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 10:19:11 -0700 (PDT)
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dennis@kernel.org
References: <cover.1560510935.git.asml.silence@gmail.com>
 <20190614134037.ie7zs4rb4oyesifr@MacBook-Pro-91.local>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 0/2] Fix misuse of blk_rq_stats in blk-iolatency
Message-ID: <054f3ab6-0a03-ff0e-ac46-5d0fba012cf0@gmail.com>
Date:   Thu, 20 Jun 2019 20:18:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614134037.ie7zs4rb4oyesifr@MacBook-Pro-91.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8oAFV0E1ewJ3uE29wsSiZ5q8bYzHsRAaB"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8oAFV0E1ewJ3uE29wsSiZ5q8bYzHsRAaB
Content-Type: multipart/mixed; boundary="AI7byX1ETmEcRD42Gao9rPhlZg6IkATsn";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, dennis@kernel.org
Message-ID: <054f3ab6-0a03-ff0e-ac46-5d0fba012cf0@gmail.com>
Subject: Re: [PATCH 0/2] Fix misuse of blk_rq_stats in blk-iolatency
References: <cover.1560510935.git.asml.silence@gmail.com>
 <20190614134037.ie7zs4rb4oyesifr@MacBook-Pro-91.local>
In-Reply-To: <20190614134037.ie7zs4rb4oyesifr@MacBook-Pro-91.local>

--AI7byX1ETmEcRD42Gao9rPhlZg6IkATsn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Josef, thanks for taking a look.


Although, there is nothing critical yet -- just a not working / disabled
optimisation, but changes in stats could sublty break it. E.g. grouping
@batch and @mean into a union will increase estimated average by several
orders of magnitude.

Jens, what do you think?



On 14/06/2019 16:40, Josef Bacik wrote:
> On Fri, Jun 14, 2019 at 02:44:11PM +0300, Pavel Begunkov (Silence) wrot=
e:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> There are implicit assumptions about struct blk_rq_stats, which make
>> it's very easy to misuse. The first patch fixes consequences, and the
>> second employs type-system to prevent recurrences.
>>
>>
>> Pavel Begunkov (2):
>>   blk-iolatency: Fix zero mean in previous stats
>>   blk-stats: Introduce explicit stat staging buffers
>>
>=20
> I don't have a problem with this, but it's up to Jens I suppose
>=20
> Acked-by: Josef Bacik <josef@toxicpanda.com>
>=20
> Thanks,
>=20
> Josef
>=20

--=20
Yours sincerely,
Pavel Begunkov


--AI7byX1ETmEcRD42Gao9rPhlZg6IkATsn--

--8oAFV0E1ewJ3uE29wsSiZ5q8bYzHsRAaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl0Lv/8ACgkQWt5b1Glr
+6XFmRAAksN+T1MR2iqQeiOczxeCkDtiJrRIVJ9DHMi9sLj+uImj9sYlB+s+Wbbt
+gpY1wUPks5kLWcYh4iOrinDCGG+wzmCIVhHQ9FiRQ5en7z7dFzG/hW9CLF3HWA7
c9M201AycyfldERiAwHlIdnKHmW8/d8Ze6XRAzjlIsJVpZXrZ3Wq1DUjW2rj4m0y
miQ598qcsrbEwLQomliX8adVb8KWfrC63MaGSdfo5+WBFv0iG0zfzQJ/v20PstNB
pgPEqziWFmeX2Ym3ZU/qZ95t2rbMCJn6/LFkjK5KlJW/glwpgJCwjA6JjL8ej8YP
Yi5yn3zdfVgRMASLczSy2/sAMpYiSqmFjAbOWqHoJ3F48UGZXzmfFhbR/BXqx8VX
9RRC6YeO/kResjahn9JvvkC8nNy44qDKGmag805hfs7PZNMKiCpJgrSUI75D99tj
qSezEURSbry6wj1MweNSrksdDJ1E1TQ/oBlswJAOm0WJh+UfFzSwNyV0hjNbzy9y
5UdFr/n9HIDg9Fysuc+APBuTHSOARuvhvLlkFc1CQxHeUDZbgkPpruFOVp/TA4uI
FVI1NCBrog0jRJjMjeSmLRUOy/kZkB+94vFgWg6WxkSwm7pz5bpQIOtWZDv8Lbjo
z7yuHQChqTdEnkatInU7uQJ0XoY4rvqd6mh/nNsfL6508PHpoWs=
=866h
-----END PGP SIGNATURE-----

--8oAFV0E1ewJ3uE29wsSiZ5q8bYzHsRAaB--
