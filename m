Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667D6C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290FE2082F
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="TTm/NTem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfCDII3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:08:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43379 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDII3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 03:08:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so3440114ede.10
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 00:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7pHqYyi4r9I7mKxLj+etIymBHzIem2CHnC6pRMXilO8=;
        b=TTm/NTemDPM2XdNbbXfrhnfVqPESSZnaejm4Ewh1W9yebxIEcTUl3zWR/1kYj/G03J
         pBNizngggBSQG5ownisJ2VbPWnencJ6n87sT7uT4ZbNChOFl5PyJKBAZIj3ZSbze0a4I
         QK/xqzqJM0muwlPCDj9HnJld7XAI2z9sna/dteUE1W2RXLf4m7v2TjlvfeFCPwUVCqNx
         e8FBMrR6ZRp05vkV/vAr3xKzVmXR1o/f9KGVnIs1Z/JvMNnj7HE2lovExslWGig5d1Eg
         8roUPD1Pw/3Jb9JlAlPin7ajNOzZ2eNHSRzqy35Lm3xc9QsSksMaJ34yFc5fqsdYB0ii
         ec9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7pHqYyi4r9I7mKxLj+etIymBHzIem2CHnC6pRMXilO8=;
        b=SXdmXEnid1Y16A34PuJWAy7JFOBIIgmYL59zTmktffeQWok5uGrV0fIK3dnJnCqh9V
         yJLCDGe7EedCXgomKua7sWF0UkmU/WUK8vbvyXoJcxD5JgsJArJSDXA81Jeh9nmXlUEh
         M/olIuycuHS6qJXO5Ma3uOKZ5BN/RyDlLTc2wRZog1jHaUk7SKlwiehPzAjhK+jy8TP2
         YrWxGBQY0+8wsw+Fe0RhtMqz45ueDQ3DElbrC9L7GZVVemhM+YmdMSdiO6PgMwlJv4eQ
         olKFxrJPLoyd6ZcuEr023VzmnH/kUMQZwu8oUDfyTIxMbGUPNGmK1b60bdGq/FFVPRt2
         SM6w==
X-Gm-Message-State: APjAAAWvZzJemLcxjs+qaRKHEGyWNfYQvsnCCf3mm/6wZTfnCDHq9HEF
        bSKuhbJy0ggd2EWpVP3lf9Hvwg==
X-Google-Smtp-Source: APXvYqyWPnhnm53yWnm6hy0SsLT4pw/uYxRNc6HVQa/yEQ+ZdAjXDBV3hv9ghSefJQNW85HbQ2R3Pw==
X-Received: by 2002:aa7:c50a:: with SMTP id o10mr692735edq.57.1551686907165;
        Mon, 04 Mar 2019 00:08:27 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id y55sm1891335edc.75.2019.03.04.00.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:08:26 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <453C3B14-BF3A-4463-9137-326C458AB851@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3295BAA4-04A1-4134-8955-14674AB1EA43";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 09/13] lightnvm: pblk: Kick writer for flush requests
Date:   Mon, 4 Mar 2019 09:08:25 +0100
In-Reply-To: <20190227171442.11853-10-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-10-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_3295BAA4-04A1-4134-8955-14674AB1EA43
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
> 
> In case when there is no enough sector available in rwb
> and there is flush request send we should kick write thread
> which is not a case in current implementation. This patch
> fixes that issue.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 78b1eea4ab67..f48f2e77f770 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -375,8 +375,9 @@ void pblk_write_timer_fn(struct timer_list *t)
> void pblk_write_should_kick(struct pblk *pblk)
> {
> 	unsigned int secs_avail = pblk_rb_read_count(&pblk->rwb);
> +	unsigned int secs_to_flush = pblk_rb_flush_point_count(&pblk->rwb);
> 
> -	if (secs_avail >= pblk->min_write_pgs_data)
> +	if (secs_avail >= pblk->min_write_pgs_data || secs_to_flush)
> 		pblk_write_kick(pblk);
> }
> 
> --
> 2.17.1

We already kick the write thread in case of REQ_PREFLUSH in
pblk_write_cache(), so no need to kick again.

Javier

--Apple-Mail=_3295BAA4-04A1-4134-8955-14674AB1EA43
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx83PkACgkQPEYBfS0l
eOC4xQ//SgkVolR9fFzolod49mZzDLFZSp4gB3ljm6rV6ZvWRR/A6bs7r9YBhbu+
jtl87HEHj818pJjkTfIWO+GCWH919odsxSLpJg56XI0SCVkq9i9PDEpMTON0+1e6
IbfH0eKWSg2FV1/5brIN3196DzRNzADO/Jc2ffG5LXSM0Z8lepxhcpzUeG9SC2GB
B5KiCfdgV8hepKfMOcK8N5BTfByeEkixKku1E8MfUN/Pgh3/31gU56UV6rFiIXhl
PO4uPTqS5mcBaN1EPaLB8xiZeMsGT7yP3YUhS1Flh9gL0LLBYe0lynrXh6D7sOl3
BDpt5G33GhWLkbHUcPWaysmg5NTX2nre8NoYj3wR/fGh6DnsTetIjt/SffXh6u2H
RxLr35bDxj9IMEbGteIhzCMGCXRNakSY1ILWPQgUZHZVB4JPPiQVOgNocmdOFc3q
r3aw0c7oUswX3PhG90NW/8oUKDcopMsJTm+SoqHio2ohQgIIXi6MNX5E5Ud0ekFV
K4EjD6n+2ErIT96WAK6s1e/QMEMZ5+hnJS8En0TRLFJABy3GlzM4fPussrl1U7cI
8NDvtRxYzql0YIxH8/QIqAOv8yG7s+ETjPkXjLE44ZjwznU4g3mN6QzriUFCj3WA
ikzafB+qPHRGNl2OxJZDbOPQNx8pLqLMgsiEt5JHpndoriGlq+Y=
=nDCw
-----END PGP SIGNATURE-----

--Apple-Mail=_3295BAA4-04A1-4134-8955-14674AB1EA43--
