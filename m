Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2896C433DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 20:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFF92067C
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 20:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ot9SSfwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHXUqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHXUqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 16:46:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CEC061755
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 13:46:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so7349603qtg.4
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OudTXsGC8UrNFmAXrd4teM7+91cCbKPSxYFV80ypCd0=;
        b=ot9SSfwrAZSKzxInGVngVCPfNPSEv/2V+vR1K/Hos4xi2HrSwRNCofpHR1oSyoNtoA
         VZ0gj5JdFSE9relSmpFHAUclZQOby1oq+0HhnP1a+8FYSUGeEOAYrgh/CAi8ZMgrM/L8
         BQkNDdHeiECpQV0Ro8MggTINiG8B6JFpZVD6ksR6gJiHrXkAL5EFA5og9LEPZ5CMh379
         p/B6zGAQACsLludXEAemWG0W1OleJbAZ+pL+69yxZQYntPAHNArJcV+6q5uj9eRkoHT1
         OzNDTvLD7kZAwt0aTS4UXOwhq3Z/v2Cn1eb9XwVvukBsBStdXsn95uGQxHTevayv+SFZ
         6nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OudTXsGC8UrNFmAXrd4teM7+91cCbKPSxYFV80ypCd0=;
        b=C+zbnh8XOAPVjK2E5ly9Yb1FQ+exUaQn99Ue4AKLqz3WCoGxCHTsvpWLKJNnnxQ45f
         412KtksCKsF1my8WtL87xF6oBjx2ZCw4PDckwkHvslxHVnK/xN+hw41xWK3kRoprAffY
         Ht5mPxOJ8Xxg6PTp2wnvN/0uPnMKXxL/zZDJbCVs91ks+J9tkypncMpP6Quz97K5IQb7
         goJTbTa+zimA4RBWO0luTs7uzOSWwwEPE81sxD8iRiqExOd+/scDNWfjFac1URdQilQX
         tzUMJssy8/vD3LkNvTeYy3x55RJChfQCMweUIRVh4gaBD5CIG/CKV0+oogTkixqnbSRo
         RXRQ==
X-Gm-Message-State: AOAM531ybPEK24YMa6kObm2eOmvngZoWPkF2Ca0TMosN3IdMFk+4juFO
        U2SBFtGtbsaBPOsoAg4h8EE5DjBFEbm9ervnoMw2rHHR/uc=
X-Google-Smtp-Source: ABdhPJzRolUTn7gzdSjz944oXv3BREgd0xn1TnglIK+xP7wbJAMXq413xvh+KIcMrbO1sZaOCRuZ6WZLKDzZ4ysWeyg=
X-Received: by 2002:ac8:4652:: with SMTP id f18mr6336945qto.142.1598301978791;
 Mon, 24 Aug 2020 13:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <CACGdZYL_bE2bamw_1uanwWByrCteNF=hmWYLH=VEVm9=R987ew@mail.gmail.com>
 <992ed2ed-f644-a5ad-3239-b38ddeafe28b@acm.org> <b138bc8f-0062-3e0e-5838-bf73c09b40f0@kernel.dk>
In-Reply-To: <b138bc8f-0062-3e0e-5838-bf73c09b40f0@kernel.dk>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Mon, 24 Aug 2020 13:46:07 -0700
Message-ID: <CACGdZYJEQnw2XVnOZ9YmdNJax8fOQ6CR5O=OBMca=q=ftPHaNw@mail.gmail.com>
Subject: Re: IOPRIO_CLASS_RT without CAP_SYS_ADMIN?
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, paolo.valente@linaro.org,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ba0ed305ada5adcb"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000ba0ed305ada5adcb
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 22, 2020 at 7:14 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/22/20 7:58 PM, Bart Van Assche wrote:
> > On 2020-08-20 17:35, Khazhismel Kumykov wrote:
> >> It'd be nice to allow a process to send RT requests without granting
> >> it the wide capabilities of CAP_SYS_ADMIN, and we already have a
> >> capability which seems to almost fit this priority idea -
> >> CAP_SYS_NICE? Would this fit there?
> >>
> >> Being capable of setting IO priorities on per request or per thread
> >> basis (be it async submission or w/ thread ioprio_set) is useful
> >> especially when the userspace has its own prioritization/scheduling
> >> before hitting the kernel, allowing us to signal to the kernel how to
> >> order certain IOs, and it'd be nice to separate this from ADMIN for
> >> non-root processes, in a way that's less error prone than e.g. having
> >> a trusted launcher ionice the process and then drop priorities for
> >> everything but prio requests.
> >
> > Hi Khazhy,
> >
> > In include/uapi/linux/capability.h I found the following:
> >
> > /* Allow raising priority and setting priority on other (different
> >    UID) processes */
> > /* Allow use of FIFO and round-robin (realtime) scheduling on own
> >    processes and setting the scheduling algorithm used by another
> >    process. */
> > /* Allow setting cpu affinity on other processes */
> > #define CAP_SYS_NICE         23
> >
> > If it is acceptable that every process that has permission to submit
> > IOPRIO_CLASS_RT I/O also has permission to modify the priority of
> > other processes then extending CAP_SYS_NICE is an option. Another
> > possibility is to extend the block cgroup controller such that the
> > capability to submit IOPRIO_CLASS_RT I/O can be enabled through the
> > cgroup interface. There may be other approaches. I'm not sure what
> > the best approach is.

I think it fits well with CAP_SYS_NICE, especially since that
capability already grants the ability to demote other processes to
IOPRIO_CLASS_IDLE, etc.

>
> I think CAP_SYS_NICE fits pretty nicely, and I was actually planning on
> using that for the io_uring SQPOLL side as well. So there is/will be
> some precedent for tying it into IO related things, too. For this use
> case, I think it's perfect.
>
> --
> Jens Axboe
>

--000000000000ba0ed305ada5adcb
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
MC8GCSqGSIb3DQEJBDEiBCDVWOCcUvnfqiw2yxu4HnC9++TDuITx/ihlcWlIglt76jAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MjQyMDQ2MTlaMGkGCSqGSIb3
DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcN
AwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAE
ggEAoN4EYPKl7UMCQqKvmjJWCCuk3gbmtczqXYmtYQqQzMqyJzucGrKW/wQlY3Nkw/Ohr5mXTvMJ
cOXuIYUpXVJybt7PdEK7eYRaJ8uLgHqqxfN7aLrnAOdtQvBe867HFqcpJ5m9lOs0jZb26pr00WYp
h76WYWH1GfMFs2jWPibBEOKGVmldpYDdzljs3aCYwZHBYxgos1sRFgwITFoq09j9+KyKHKDjOd42
OOfv227+qfCg7gX/lv+OOK6qPsrX47BI+9n/1EORCWoDly/LqjNznOTljGRuJd398smuQyjaL8jC
zW9naTZ5ycy+FIddrKx66K2f3gvTG0Pi1pHSY3zrCg==
--000000000000ba0ed305ada5adcb--
