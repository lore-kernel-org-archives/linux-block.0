Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA493C83020
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 13:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796E120769
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 13:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436971AbgLCNbp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437006AbgLCNbo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 08:31:44 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D5CC061A4E
        for <linux-block@vger.kernel.org>; Thu,  3 Dec 2020 05:31:03 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l7so1262104qtp.8
        for <linux-block@vger.kernel.org>; Thu, 03 Dec 2020 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to;
        bh=W8n29SGa/wanUgv5A5U6IkSabkJ1SNmPKVGcmvpCCGU=;
        b=Ii2PqoanoCex5Qm8kw+PPM55lmHHwnlzZOJCVxxnknpElYjONNZl2THxRpRiCxdQru
         AiR0p3Cot+ZRJhf1FBZmSPyyLCfItLvXDgh5jWKaAX3hrmyfGH74fwq8SL0qeKzJNpRi
         tD3/cVfOo6jFr7HlCzbTXklE04F/Qaky8Fejg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to;
        bh=W8n29SGa/wanUgv5A5U6IkSabkJ1SNmPKVGcmvpCCGU=;
        b=bSKWirE90Cfjoat6hRRT1i/AcId8dwYSsEDf88uhecusVPzEG7R4xJB0OWkBBOnGHl
         /S4x7/2ph/nyppCyBpa7wUmUJYqjHSKWrk4+vJAFDYNEJ02w7gJROEOW7Wxg6IJZldF9
         HSGKrkIc+0gsMBgcHcflid0vJ4zYP9ZKge3UkDNHwxeAJvyFxoZtBWpQyNhGAPmLvrUm
         cb9xUnB3Dn2sLh2JTFmj5UerZDjzZzk6j8GEdw+Y87eVaAb5oBizaZmiHdb2PtwRTvHq
         jhi0d2zlNl4SHvveYGsBDej54nXSPV7Mw7FnSLzTTCVQ8fHzsXVVrAUXLbYKLW4v8gH6
         P6oA==
X-Gm-Message-State: AOAM532j9fO4aWi/VyUDTPNbsSRPXWof3ARZ7f28cD59kRoBtqoMG5fk
        kcagLa3SJo4/IZCqtldBkih9Mk7D/eGZmY8ZXK+yN1aNad0OnA==
X-Google-Smtp-Source: ABdhPJyJ4ANFlyTsb0o+ATRwjL2My1oO7E1uulzmSyxlw5hF6irQdVVIngpXeXq13XS3l3xdStOXV+EmHBhn+y+v4lI=
X-Received: by 2002:ac8:4801:: with SMTP id g1mr3092451qtq.44.1607002262757;
 Thu, 03 Dec 2020 05:31:02 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20201203034100.29716-1-kashyap.desai@broadcom.com>
 <20201203034100.29716-5-kashyap.desai@broadcom.com> <3ee6826b-e010-8874-0447-da8e9b1e8971@huawei.com>
In-Reply-To: <3ee6826b-e010-8874-0447-da8e9b1e8971@huawei.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHOEf3M/0CyAu39AtgNSQNXwBT1dAJyCfA7AXYVKJ2p14uB4A==
Date:   Thu, 3 Dec 2020 19:00:59 +0530
Message-ID: <5d8d57aa81706e44b4e7a25dae606f39@mail.gmail.com>
Subject: RE: [PATCH v2 4/4] scsi: set shost as hctx driver_data
To:     John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000c2b6a05b58f5fd6"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000000c2b6a05b58f5fd6
Content-Type: text/plain; charset="UTF-8"

> -----Original Message-----
> From: John Garry [mailto:john.garry@huawei.com]
> Sent: Thursday, December 3, 2020 6:57 PM
> To: Kashyap Desai <kashyap.desai@broadcom.com>; linux-
> scsi@vger.kernel.org; linux-block@vger.kernel.org
> Subject: Re: [PATCH v2 4/4] scsi: set shost as hctx driver_data
>
> On 03/12/2020 03:41, Kashyap Desai wrote:
> > hctx->driver_data is not set for SCSI currently.
> > Separately set hctx->driver_data = shost.
>
> nit: this looks ok to me, but I would have made as an earlier patch so
> that you
> don't add code and then remove it:

I added later - Just in case someone report issue in " scsi_commit_rqs" due
to this patch, we can revert back easily.
I tested scsi_mq_poll but not scsi_commit_rqs part.

Kashyap

>
>  >   static int scsi_mq_poll(struct blk_mq_hw_ctx *hctx)
>  >   {
>  > -	struct request_queue *q = hctx->queue;
>  > -	struct scsi_device *sdev = q->queuedata;
>  > -	struct Scsi_Host *shost = sdev->host;
>
> Thanks,
> John
>

--0000000000000c2b6a05b58f5fd6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
yfWKfxJx8FcWmsjkSlrwDu+oVuDUa2wqeKBU12HQ4JAVd+LOb5edsbbFQxgGHu+MPuc/1hl9kTkC
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQU4dX1
Yg4eoWXbqyPW/N1ZD/LPIWcwDQYJKoZIhvcNAQELBQADggEBABBuHYKGUwHIhCjd3LieJwKVuJNr
YohEnZzCoNaOj33/j5thiA4cZehCh6SgrIlFBIktLD7jW9Dwl88Gfcy+RrVa7XK5Hyqwr1JlCVsW
pNj4hlSJMNNqxNSqrKaD1cR4/oZVPFVnJJYlB01cLVjGMzta9x27e6XEtseo2s7aoPS2l82koMr7
8S/v9LyyP4X2aRTWOg9RG8D/13rLxFAApfYvCrf0quIUBWw2BXlq3+e3r7pU7j40d6P04VV3Zxws
M+LbYxcXFT2gXvoYd2Ms8zsLrhO2M6pMzeNGWk2HWTof9s7EEHDjis/MRlbYSNaohV23IUzNlBw7
1FmvvW5GKK0xggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDDSdoX7GqonhoE7TszANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgB4B6f0Z5
gelckmsDYIVRi2w8nVodxnglShyDKPoPW9QwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAxMjAzMTMzMTAzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACAeRuDranMriyBXP2X/wQTR3Z5i
4qdp3zcjx3vEA412XQKdbDb1UBhSpHIZ0d3UBGxI4pgtEzMSmP0Rj9cvTL8WgKrE8M/8wZMyCouy
e0ANfkZRGue9hp9xA+sU0k6d5Y5tXDCdj0zjm2wCFfcoVqwDENtD2pI2ilQrEcqt0HaqFgxJJqoz
HFfF4d5sJrc+4EGyV/NYrInLWBrqShTxBhraWL6bx4bHh6aJHYNl6GUFZUpwpCEUdt1VVrUokUgN
s8x4M3KMb+qzC7jDtybPTDjTP85emmg5FmipXiu/LpoTvDd7u4704W0+7hSBo8Z40GR366tLdx1a
iXHUj6pKmVA=
--0000000000000c2b6a05b58f5fd6--
