Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC32C433E7
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 22:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8925206C0
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 22:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlU6sFPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIAWt2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIAWtY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 18:49:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B17C061246
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 15:49:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ef16so1355544qvb.8
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcVwvkFUaARyMcrQa+Dk8YVK7+2sPpqy7tcx1a0fK/4=;
        b=tlU6sFPfWG6adVln77rD9Uq0S6CkzVI9846Tih25X1NRfDwXdTCrxoFga9VxbHnQFO
         05vXaawVtcYTRZRFVufczKJvTlhBDCtXpg68HAdSMsQFRDBhKVrWZdcg7/NXQk+CgY+9
         i680RwKdzKtff8Zw+bLSCv7eOZypc/8Rw7trFn7tgzQWbPfIfMJ3hPZrz8+PsVw6Xyhy
         SISxc2X2sv6s2rOLVVfPCXdlmcHm/yN+mUuP5vvJ1TJb1Sb6eHflDin+nVlFjII99guV
         G/kBzzpdv4D/1LRP2mJ2k7XaZe9nXXi7j1YPy6bMai7n/Z2oQT58sIEKP8Famw7jOb+P
         004w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcVwvkFUaARyMcrQa+Dk8YVK7+2sPpqy7tcx1a0fK/4=;
        b=l8IxljnARd/pl4s/KwwNYSZKcVTQcZ2SjB1RjVSwQUTHZ5hUD/kgd+JrHe/sl9ac2u
         UUpfzLR0SKQkEV2ATKZDv6QazPsiRge2kw3jKuVFIfjSpO6e5kKU7/v+94cNc7VKPloN
         3UCt803wJsABjyFSEG+VdPRXKRzjASrrirDznkbf8XC5iTO1LjyNHKAQuqMGXJN/N6sm
         70ixkdtvdcTsz/fnHPWf9YxGhX353dxfoq5eCIt0HcVYARHYgbnBRku9s/pulM/cu/fu
         7ld6oWu3erDCvo0S/C+ADbwGIJ6gCKpXfu5KDVTro2LYWdkMJoh9sZm3SJ8KlIJRMO+i
         j/QA==
X-Gm-Message-State: AOAM531W3lx0oSfLIt+XcspTA7Ve8aeBVeE4h5JRnkwasjscthL3q1fL
        yXNaw3tWkOrq2zncmm/MhYAUgZ7xvvgjUMwmWTrJ0A==
X-Google-Smtp-Source: ABdhPJzb6iQ2xfAd3GFaoPdmG5TMtcbzW9pWV02FfgMB6CIItnsA19KeXvuCMy7dEmf4Fhbln6H2+lYktJe9ILr5OFY=
X-Received: by 2002:ad4:4e89:: with SMTP id dy9mr4325462qvb.25.1599000563420;
 Tue, 01 Sep 2020 15:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200824221034.2170308-1-khazhy@google.com> <e50a4ff6-39fb-6ba0-40ab-d348fbf5567f@acm.org>
In-Reply-To: <e50a4ff6-39fb-6ba0-40ab-d348fbf5567f@acm.org>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Tue, 1 Sep 2020 15:49:12 -0700
Message-ID: <CACGdZY+6qdymU5cVqu9cVep+P6uNw6muxznZ23XJkxdiihiKFg@mail.gmail.com>
Subject: Re: [PATCH v2] block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge@hallyn.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009b2ba205ae4854b6"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000009b2ba205ae4854b6
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 29, 2020 at 6:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> From https://www.kernel.org/doc/man-pages/linux-api-ml.html:
> "all Linux kernel patches that change userspace interfaces should be CCed
> to linux-api@vger.kernel.org"
>
> So I have added the linux-api mailing list to the Cc-list. Anyway:
Thanks, sorry for missing that!
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Jens, does this change look good?

khazhy

--0000000000009b2ba205ae4854b6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPBgYJKoZIhvcNAQcCoIIO9zCCDvMCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxpMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
BQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEE
RTBDMEEGCCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3Nt
aW1lY2EyMDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2
MDSgMqAwhi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0G
CSqGSIb3DQEBCwUAA4IBAQAzGsyTMuMEs+rU0JhN7+X62InoLA+QLAozxi+mmLGmfS48HalmbNSM
50i9IOpsIW0GqjrLgilzP7b04OWA0eGsQ2PzobSd/6yLpFvdU+R52Iyu6/IVcCoEcWj11PYvmtMp
SZrCvtwvCj+zfJSxNqLmOhITBB1uGneHUHjwTEK87WDqGVcm43pwBMHZ8qMziJdVf8MbKPm4w6a9
1zewg0bTPT33PFWgCFIsqvTcQPEKoL3Kj8e/DBz1DgFhw4WkwfmzmnLamf93T+t9TU+iQdSESxgT
NC8D2u/lHre/+I8qQ3tgofQC+AomdFoGhr+nQj+6O1Sv8BKB1ArDiku4umqVMYICYTCCAl0CAQEw
XzBLMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xv
YmFsU2lnbiBTTUlNRSBDQSAyMDE4AhABBw5QEQ1RT42XN3T1kVOEMA0GCWCGSAFlAwQCAQUAoIHU
MC8GCSqGSIb3DQEJBDEiBCAnyQYq+MYL4m/S31loPtU6Iu/N5TLGFfSXWyC1pKqyTTAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA5MDEyMjQ5MjNaMGkGCSqGSIb3
DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcN
AwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAE
ggEACmfp4bSp4wnZ2CodpF6naxDdrmLlInczvE+Hfw2vLAi38ZfXB46t9Z0kgqII+perJGWaMDrA
5Rnrcp1gU2B/YQCH786HI2545xi+N19H4UBy5E5sv1mk04YylmoRon3RWMnSfIX/ed+O7Gr0XSV5
QimiWWh4vkLbaYQE0LU1aNz6twtdd3pqPxPXl/pyAnr4KqJKMTEpjFyif0SvxywphpV0DNXSWJo3
4uIZn7bPeG2gsOXbud3n2TAXnWTiRpE7DfxFDcQubLUsisAojzZgzmTrYo91uZxj8LMkytA4PH2Q
yV2gelupJXBJdZpgifAJzix30SzB2pc2x2Exqxck8A==
--0000000000009b2ba205ae4854b6--
