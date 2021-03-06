Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D79DC433E0
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 02:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268AE65011
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 02:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCFCxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 21:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhCFCxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 21:53:12 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E85C06175F
        for <linux-block@vger.kernel.org>; Fri,  5 Mar 2021 18:53:05 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id f124so4097249qkj.5
        for <linux-block@vger.kernel.org>; Fri, 05 Mar 2021 18:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+YCL/IyIuK1NeKJH3MDV8vrtJRaU1BXYq0SRzFaHFQ=;
        b=NAPjS6p6uFmhxnv93faL3kvzWHSRSQt1qokfnVEazvdCO7i8FU//usO0BNP5WZj/+W
         Oioi7uZz8pXsYeE9mCppDD6RTgrQqXc/kdwLRT4tJuK/f4g/VeppLBlzgi4Xdiuc1xuM
         +JUrON6zinWyzAjVY48fpOwtnaElkaUFr8KTPrviCEhhM8ebRq1isZSZVTGolD/+DimE
         gm/vjlQlYCC0XzmBsYDuLuhN0xhOPw4k1+1FzOyZ6y6au6uL99ac/JIbvDtAa1itBHoW
         f/iLpFCv5RAnWKeV0D9ze0Fnj023Lqpwg+XeWfD34omY8FcjD9OG/CTOQj99HQMubFKD
         YvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+YCL/IyIuK1NeKJH3MDV8vrtJRaU1BXYq0SRzFaHFQ=;
        b=VMHcfuDCISKI18S9j8zsVgzHd398Fy5wbB5C5YPxK705uBPKUNln00yhLAqOoU9AEG
         if/s8UEESjGlsfwr9yVqqrW85b6E5jcPVj3chRB/KlFCySdjY8VcMq0mzT/kI4row157
         xb7fxesMDFj0dMG0Gaq6A5jSKkOrgP9GaQhmmvYvqe0XiKW0fZkJqAnrMfp5qn08FDJy
         KSFDcQ0KaHeLXNVEZ+7j7bU59fvMlR3QlG5xbRLjsB5+6eabLf7QBHeMnvEKG1yGKNFC
         dut+OPib3lTWyQzWaquYuEgeEN4iRcNTBejnC/8jeAE6RQKc0I1eeHyZC21MX8WAIjQY
         ZIIw==
X-Gm-Message-State: AOAM532A7KabgBhEg5RWD4lAlCpcQRygOKFEix4kAcvFUmIQavps6G/Y
        seedIZgpQ9WMozAg1XT0mLSli0UBz5t8tm0PL2PXcQ==
X-Google-Smtp-Source: ABdhPJzYBwiaQNBAKnZ8nLw6CQcMDxTnugmhc1fHi+vsy50PArwEFZdPY10xorkg+82823h2HgImdM2Yk9GYOdkgSpI=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr11739808qkx.501.1614999184492;
 Fri, 05 Mar 2021 18:53:04 -0800 (PST)
MIME-Version: 1.0
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com> <1614957294-188540-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1614957294-188540-2-git-send-email-john.garry@huawei.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Fri, 5 Mar 2021 18:52:53 -0800
Message-ID: <CACGdZY+Qft=55Si5Lmjh1RmVb5Roe-KTsrJHJLz0opSXuesTBg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] blk-mq: Clean up references to old requests
 when freeing rqs
To:     John Garry <john.garry@huawei.com>
Cc:     hare@suse.de, Bart Van Assche <bvanassche@acm.org>,
        ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>, hch@lst.de,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bb490f05bcd54c4c"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000bb490f05bcd54c4c
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 5, 2021 at 7:20 AM John Garry <john.garry@huawei.com> wrote:
>
> It has been reported many times that a use-after-free can be intermittently
> found when iterating busy requests:
>
> - https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/
> - https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14daf@acm.org/T/#m6c1ac11540522716f645d004e2a5a13c9f218908
> - https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk/
>
> The issue is that when we switch scheduler or change queue depth, there may
> be references in the driver tagset to the stale requests.
>
> As a solution, clean up any references to those requests in the driver
> tagset. This is done with a cmpxchg to make safe any race with setting the
> driver tagset request from another queue.

I noticed this crash recently when running blktests on a "debug"
config on a 4.15 based kernel (it would always crash), and backporting
this change fixes it. (testing on linus's latest tree also confirmed
the fix, with the same config). I realize I'm late to the
conversation, but appreciate the investigation and fixes :)

--000000000000bb490f05bcd54c4c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmAYJKoZIhvcNAQcCoIIPiTCCD4UCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzyMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
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
MEvaI7F4ZN2DM20wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADCBmgYIKwYBBQUHAQEE
gY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRsYXNy
M3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2Nh
Y2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvRzV2V
b4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAIKZMQsUIWBTlSa6tHLU5L8W
YVOXfTkEXU6aeq8JjYjcj1fQD+1K0EQhvwz6SB5I0NhqfMLyQBUZHJXChsLGygbCqXbmBF143+sK
xsY5En+KQ03HHHn8pmLHFMAgvO2f8cJyJD3cBi8nMNRia/ZMy2jayQPOiiK34RpcoyXr80KWUZQh
iqPea7dSkHy8G0Vjeo4vj+RQBse+NKpyEzJilDUVpd5x307jeFjYBp2fLWt0UAZ8P2nUeSPjC2fF
kGXeiYWeVPpQCSzowcRluUVFrKApZDZpm3Ly7a5pMVFQ23m2Waaup/DHnJkgxlRQRbcxDhqLKrJj
tATPzBYapBLXne4xggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjACEAH+
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINPhOn/hZ9KP
h/1bcG39a7myQp9gt6wb2eMaPOdXEFRSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDMwNjAyNTMwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB0VK8nQRQmzoV28HJOzpNGgXgReMmB
fOjNH/ctVGY6535M7p031O0fzesI/D2ZKVaS4mppDPYMghNw8jXgVzmTjTzfXYwORghvGoH0MgCG
OVci9rgGcBOHMTs46CX2qRIkypVWGe6kwZCPeGdhh462aZ5nB4qt9B3JJZk4PGt7qESIhiCpKosr
7d/wGWRn+3vncz3FD4pstVPK9c/0YhpDU2kGSm/sCUSQM81jiVUyeqfbmjbIVgAIOnaryTY3R34v
4NeVyMP0taXL9ausv0+VLFnuzSq3WSbzoCbyFfmxKErDorE/D1GcxfxefTJO8y0E6ip2s+a1rM4O
GR41HARR
--000000000000bb490f05bcd54c4c--
