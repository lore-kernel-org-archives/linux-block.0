Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD6FCCA481
	for <linux-block@archiver.kernel.org>; Sat,  2 Jul 2022 02:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiGBCtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 22:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiGBCtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 22:49:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F8F45792
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 19:49:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i1so5558047wrb.11
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 19:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQ2A0pQkxwbswRLBwfuXDSPudT3Ya5OcsFpLOCQihMo=;
        b=XNm/FCoDghJLTI5Z7U8wY+yYz1SlEoNz7LJSyMSsB4CfMS0yU5eYyzn6X5xBGH5KUM
         /0PeMm0UHC05bDVxI4M028Yn6Ps9u49uditVgH3m1pfj81iDZGzIQ9Kh5voueZ5dRL2c
         cFGat4cfhjoYlwuV9hAPt86issTcMA4vI5RaUu+vCOMLRylIoOmO4EBvPzC8nWpBo7BE
         iiXYbxOCBubrXMNStvzH0Y0ZeZC6v0dq5dfrLrOH17n3MyNokTqAgnfjrGjqCCBC2Bz/
         +EooytnwGrwA7lYM2/XMU/5wwF3yXnsOWxc1WQlMmx5e2VtaDFhQSFfYMB9YYSG5fM+F
         2+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQ2A0pQkxwbswRLBwfuXDSPudT3Ya5OcsFpLOCQihMo=;
        b=vajngNl7o8iEDdfTvvopuiLra2wE7BXsNMM0QgbeN7ySmzVMZd83JVcgzj1O5+1Lxl
         ILqIUsn1pXaCx/IwRjAR8rJd6n70DUuxrslC37Z36BDdIbvhF60dP5OgkAL9wMbuZ1W8
         KjL9dcH/LZgSGzHJM52UITXGGXmc014JhSmiU6IQSeUXaoTK+ucgU1/T95s9llx+5p5S
         Ec/BEOYvTJ4ZX2T0XwzhEiswyNdYScm7idw6ELLSCl8RKecwW+ofcW5yhxBnYRnNxWEK
         NhaCXwTR9ohrSDcu6FlFA9nMfqDw9iAS0mM7L4PmyICakhkVl2ODjGoioCIvwfltW8tJ
         /j6w==
X-Gm-Message-State: AJIora8Cawb/L6yQ8HpYIcRyIoKu1I2xKiuTnEZUvj8Q0nkeb9Xr1X1F
        v4//HhdgIlkOa2GJ9/9hBcGRxwPyW5qNvy4Wz0KY3g==
X-Google-Smtp-Source: AGRyM1vpgBd0gkiBmxBod74w05zDZfVKMGVojwg5PeqI6eibQg0WXUHQ2Vtn0Nq3butyGcgClgNPrB4qsglxUfeyLJs=
X-Received: by 2002:a05:6000:1e0f:b0:21b:b032:6b3d with SMTP id
 bj15-20020a0560001e0f00b0021bb0326b3dmr17031645wrb.337.1656730149655; Fri, 01
 Jul 2022 19:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220701084744.3002019-1-davidgow@google.com> <20220701084744.3002019-2-davidgow@google.com>
 <Yr91dWijROn4gyLl@bombadil.infradead.org>
In-Reply-To: <Yr91dWijROn4gyLl@bombadil.infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Jul 2022 10:48:58 +0800
Message-ID: <CABVgOSm+_YYKxCiVm4ZGVsOh0DBa_+1DegGfy+8op00d_Q9bmA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] module: panic: Taint the kernel when selftest
 modules load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000157f7f05e2c98c15"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000157f7f05e2c98c15
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 2, 2022 at 6:30 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Jul 01, 2022 at 04:47:42PM +0800, David Gow wrote:
> > Taint the kernel with TAINT_TEST whenever a test module loads, by adding
> > a new "TEST" module property, and setting it for all modules in the
> > tools/testing directory. This property can also be set manually, for
> > tests which live outside the tools/testing directory with:
> > MODULE_INFO(test, "Y");
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > This patch is new in v4 of this series.
> >
> > ---
> >  kernel/module/main.c  | 8 ++++++++
> >  scripts/mod/modpost.c | 3 +++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index fed58d30725d..f2ca0a3ee5e6 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -1988,6 +1988,14 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
> >       /* Set up license info based on the info section */
> >       set_license(mod, get_modinfo(info, "license"));
> >
> > +     if (!get_modinfo(info, "test")) {
> > +             if (!test_taint(TAINT_TEST))
> > +                     pr_warn("%s: loading test module taints kernel.\n",
> > +                             mod->name);
>
> That seems pretty chatty, maybe just pr_warn_once() and make indicate
> which is the first one? For kernel builds where their goal is to just
> loop testing this will grow the kernel log without not much need.

Fair enough: while the other taints (intree, staging) do warn on every
module load, it is less likely people will be loading lots of them
(and then possibly looking at the log for test results). I'll change
this in v5.

-- David

--000000000000157f7f05e2c98c15
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGH0uAg+eV8wUdHQOJ7
yfswDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjA2MjAw
MjAzNTNaFw0yMjEyMTcwMjAzNTNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCv9aO5pJtu5ZPHSb99iASzp2mcnJtk
JIh8xsJ+fNj9OOm0B7Rbg2l0+F4c19b1DyIzz/DHXIX9Gc55kfd4TBzhITOJmB+WdbaWS8Lnr9gu
SVO8OISymO6uVA0Lmkfne3zV0TwRtFkEeff0+P+MqdaLutOmOcLQRp8eAzb/TNKToSROBYmBRcuA
hDOMCVZZozIJ7T4nHBjfOrR+nJ4mjBIDRnDucs4dazypyiYiHYLfedCxp8vldywHMsTxl59Ue9Yk
RVewDw3HWvWUIMbc+Y636UXdUn4axP1TXN0khUpexMoc5qCHxpBIE/AyeS4WPASlE8uVY9Qg8dT6
kJmeOT+ZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFDyAvtuc
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAk
ZI6y2DgrxaBoqQfFVWNleJZEsqwhTNEVB7sf5k2BYzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MDIwMjQ5MTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAPm+IJ5CDouKiOTAv4TAG
nEF7J/3bs16wT4N989F/i+vuGdWllU/LZ+5cdw+TYAO4y4DO3UUJ2DrMiBeflLnZU4DP6F49chiI
+9Zl6gY39XGC/DVFOIfZhv7A/OzotFGGaOa2pgPOZ8OJAFtTQA/ZV5p1c9KVjMUfRke1rm9hWKoQ
obOsHhbR9EA87gqnWmzZeJ+GhjlNoru6Xix3s2KvojR8HbnptMLTIalmqbDxv+RKKj8kwCURteEb
CnlFZO3UVbW4MIE2MjRyuhhpunjewpYa4xuYVAK3TzEWIWxJR2P/lyURyTLKC3fwVciwDlngzwjc
eCsfW+eejcJW0Dm1eQ==
--000000000000157f7f05e2c98c15--
