Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE1C433E3
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 00:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BB5206FA
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 00:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/AOeUU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHUAfU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHUAfO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 20:35:14 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46248C061385
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2020 17:35:14 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x69so94097qkb.1
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2020 17:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bLrY6xpmW37o+FMUlgUC9DaBqI/R9wAv1nWNNbV/IJ8=;
        b=a/AOeUU8gqPpT6ThxDydWvy2zOOmVpDq7oL4LTHHnPpNVRbdaTDZk5eDO49QVn+wQ2
         GuQI8d7B6k5fwJgjg/VVpCL1Bi4a63jSk4NstFiOl6p48D0xmyUtyaK3OMddUMn9/D3Q
         D2AFn5aWimO+KPNwee2FF5qKagNICkgVqUO8doG+pR3M6/X52Y9hsm5ViMaODXiv1waJ
         qpS3vkUMSd+s1MQ5WE6fE0qmb+XDjI53ng6Kui9/PyVXMo+xNmxZUC3qAzuxCPCy+kZ0
         7iX4pfW8tC49wzCowD8MoX+faG5NTNC7eazoCyBYyIYk7vHmzsdKgK8dUIn4ByA8L6Uh
         0JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bLrY6xpmW37o+FMUlgUC9DaBqI/R9wAv1nWNNbV/IJ8=;
        b=F1O0GnSb4UbmYYH6oWG+8UJYoR69f07229e+75Zu+fUABfPdoc7CiMYvGgwmoEW+GM
         No5JlC3vuAq98Z3dkWqdUkm6Gbx2wQKoLbEDMvsw9Eej0i/h5U8r5sKkphCWGA4PE7k/
         GnjjxwVqk0LWIqBR7+Faoaw29nhAD+lqLDByoUwSxM2fl92+JvAPVqoFrAGNlSlYv3Vz
         oDf0g+58XxPbDWI4ZhIbzVdQFy1DF9ttqeUc8NL7zlnhxsYdmrKAoeEYTkYkFkzT9JcI
         9RvP+neV8zwKzvPSFFbEDnv8zp16JyB6kHblGGhHmoSjKy8AGsUrhgdRzTJUZWrir9co
         JrZA==
X-Gm-Message-State: AOAM532qSKsU+Td/yzCu+N7+8Q2kU3pGs3MXoTKA/M3eN2D2tPw0TUDn
        MeIrvWKhfjt2HjRuBvIHvS2no5CdLKRQZ3U29V4eZzrXwI8=
X-Google-Smtp-Source: ABdhPJxNILk13uKbE3axHKjZWq7XP7T4FbSoxKmBZhYTdWk2fXYLERX3F0Dq0cL5Fe/GdHRpC1UqxGs4/1UDIO6jjTs=
X-Received: by 2002:a05:620a:4ed:: with SMTP id b13mr529054qkh.493.1597970112174;
 Thu, 20 Aug 2020 17:35:12 -0700 (PDT)
MIME-Version: 1.0
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Thu, 20 Aug 2020 17:35:01 -0700
Message-ID: <CACGdZYL_bE2bamw_1uanwWByrCteNF=hmWYLH=VEVm9=R987ew@mail.gmail.com>
Subject: IOPRIO_CLASS_RT without CAP_SYS_ADMIN?
To:     axboe@kernel.dk, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ede9ce05ad586830"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000ede9ce05ad586830
Content-Type: text/plain; charset="UTF-8"

It'd be nice to allow a process to send RT requests without granting
it the wide capabilities of CAP_SYS_ADMIN, and we already have a
capability which seems to almost fit this priority idea -
CAP_SYS_NICE? Would this fit there?

Being capable of setting IO priorities on per request or per thread
basis (be it async submission or w/ thread ioprio_set) is useful
especially when the userspace has its own prioritization/scheduling
before hitting the kernel, allowing us to signal to the kernel how to
order certain IOs, and it'd be nice to separate this from ADMIN for
non-root processes, in a way that's less error prone than e.g. having
a trusted launcher ionice the process and then drop priorities for
everything but prio requests.

khazhy

--000000000000ede9ce05ad586830
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
MC8GCSqGSIb3DQEJBDEiBCDnseVTKTN10MYt+vqMlyi23xSzetDwZKNqlcm1MaIvIjAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MjEwMDM1MTJaMGkGCSqGSIb3
DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcN
AwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAE
ggEAHyiTdF9JO8eSB3IUpEX+Bv4XJkigWbhTKBAVza9RVYKjgs7vxxojajL9USfZ4YTmcjjNcoHc
XaAYpqmVBSZDn8jUG7UlSHriQJs5RFTSchBVoYfXI4K2984oqeBFSZlFAih7fTxPyqqDMN3ihg2W
EXglC9yCcyWQ5UppfOmPlj07ri0Vj7tnLQXfwzSro+SodzE/G0hBOkAVYhTvj+dtV5SEau9XrMrJ
4DsDU7TaYjIQPNRgq+zGOvdDm7MOLQGWj/yhUjtTbAUGBn8EugXDP7RAX/l5qyedKz+l8mdiinA9
qOTtM3E4zNfyGtgQNnuGyohFGr4aWzjADBvNgBDyFA==
--000000000000ede9ce05ad586830--
