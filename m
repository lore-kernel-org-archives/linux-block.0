Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9243AC433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A119610FC
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhDHWXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 18:23:16 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D9C061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 15:23:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 30so1723990qva.9
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFBmtEuJNCoTP2IWoqNo9/cjftyJnpJDfn5VVwRl8S0=;
        b=qGXjITZI3Hb+NyBotExKxIpfS42+J2Zm5VLPqYPuYRgC3D0sQUqNS7sq4sUDOjnJFD
         4ELfrCoINC++MxgUoq4v8PHlYm0O//spprpHpc0vWxBEchEGWeIb2eTLruQJ42i8Fos1
         XKCQV+Au1WhNK/RmLJW6BVnSjOkfDiK5nPb7HRzHE8rIB04gXWYAZe2nHlY8J5jQH8EY
         9hkMUdHaIqvlWnGnw6dr+IQ9FOtxwAj1b0ZMfxHiDZR3IH38MYIRHSHpiSCsXaqGwoaX
         STAEvS1tuT0BJiSnX4RkYne7fJRWweI9k61p7I2qJXhJkcvcaCW6L9eMp5ByavGlaEZo
         fk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFBmtEuJNCoTP2IWoqNo9/cjftyJnpJDfn5VVwRl8S0=;
        b=OB2Q7X5/Zy9eCwR/KuW4QQqPsC5PNDOhCe2rObr/IkCgjsU9ilWKGpLWst6MATtZNd
         rj2VAZPM69vZBXpzUzH3eXNnAevSRVylSSyv6OWZAp/2B9KxQI6e4sgjGVhqY14F8jWJ
         ELCxnJmXQae68niCehWbJEnGzC9DVXSVT/UbhyzQb95XqwRWMkcK/xT7HZW+9N6/Rfv2
         ZPYo4vY5DEMUrCxxDuMIYeCNmFaFi/ZEjun07m4SFvEJjQ+oma4DZOWWi0BgmJHhgdBm
         vXEyYRFu+wHyiwPLUM53AL61V8mcMEe3K/bL9lekrEbg3JfjZYKgeuUxky4SeVFcE9EM
         mCnw==
X-Gm-Message-State: AOAM530Dhcj6Qz1JaiFLIuAMEoq+Egt0ANURhxzjVtKjhCEmY5gWa1hm
        JUQllfY2/1ACJLyS/IeKxywh+bqUYLnuBAodkcJ1247pOmw=
X-Google-Smtp-Source: ABdhPJzKohWVfkquDMiHYYabCYK/57ptmMwKpwm095GHEsiGcVZrIwt1YKoNFQdLbe4lRgAe1PJuDwB0QrEyyJsWp3k=
X-Received: by 2002:a0c:f702:: with SMTP id w2mr11205947qvn.0.1617920582426;
 Thu, 08 Apr 2021 15:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210408135840.386076-1-haris.iqbal@ionos.com>
In-Reply-To: <20210408135840.386076-1-haris.iqbal@ionos.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Thu, 8 Apr 2021 15:22:51 -0700
Message-ID: <CACGdZYKiJ3QeXZoJZoDEMizEJ7C3zWroaTeVmqVQxmO9YHXNcA@mail.gmail.com>
Subject: Re: [PATCH V5 0/3] block: add two statistic tables
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        jinpu.wang@ionos.com, danil.kipnis@ionos.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009ef41c05bf7d7d26"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000009ef41c05bf7d7d26
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 8, 2021 at 6:59 AM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
>
> Hi Jens,
>
> This version is rebased against the latest for-next.
>
> Thanks,
> Haris
>
> PATCH V4: https://lore.kernel.org/linux-block/20210203151019.27036-1-guoqing.jiang@cloud.ionos.com/
> * Adds Reviewed-by tag from Johannes.
>
> PATCH V3: https://lore.kernel.org/linux-block/7f78132a-affc-eb03-735a-4da43e143b6e@cloud.ionos.com/T/#t
> * reorgnize the patchset per Johannes's suggestion.
>
> PATCH V2: https://lore.kernel.org/linux-block/20210201012727.28305-1-guoqing.jiang@cloud.ionos.com/T/#t
> *. remove BLK_ADDITIONAL_DISKSTAT option per Christoph's comment.
> *. move blk_queue_io_extra_stat into blk_additional_{latency,sector}
>    per Christoph's comment.
> *. simplify blk_additional_latency by pass duration time directly.
>
> PATCH V1: https://marc.info/?l=linux-block&m=161176000024443&w=2
> * add Jack's reviewed-by.
>
> RFC V4: https://marc.info/?l=linux-block&m=161027198729158&w=2
> * rebase with latest code.
>
> RFC V3: https://marc.info/?l=linux-block&m=159730633416534&w=2
> * Move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT into the function body
>   per Johannes's comment.
> * Tweak the output of two tables to make they are more intuitive
>
> RFC V2: https://marc.info/?l=linux-block&m=159467483514062&w=2
> * don't call ktime_get_ns and drop unnecessary patches.
> * add io_extra_stats to avoid potential overhead.
>
> RFC V1: https://marc.info/?l=linux-block&m=159419516730386&w=2
>
> Guoqing Jiang (3):
>   block: add io_extra_stats node
>   block: add a statistic table for io latency
>   block: add a statistic table for io sector

We've also found it useful to have the kernel export latency
statistics. In particular we've been using a 2d-histogram exporting
latency per iosize (there was a proposal a loong time ago that seemed
to fizzle out https://lwn.net/Articles/383515/)

Do you think having a format like that would be useful?

# cat /sys/block/sda/read_request_histo
rows = bytes columns = ms
        10      20      50      100     200     500     1000    2000
 5000    10000   20000
   2048 33      0       0       0       0       0       0       0
 0       0       0
   4096 51798   1114    1271    11      0       0       0       0
 0       0       0
   8192 8803    81      109     1       0       0       0       0
 0       0       0
  16384 10321   116     150     5       0       0       0       0
 0       0       0
  32768 8341    166     215     6       0       0       0       0
 0       0       0
  65536 7550    248     389     2       0       0       0       0
 0       0       0
 131072 40440   923     1317    10      0       0       0       0
 0       0       0
 262144 357     1       0       0       0       0       0       0
 0       0       0
 524288 13      1       0       0       0       0       0       0
 0       0       0
1048576 7       2       0       0       0       0       0       0
 0       0       0

Khazhy

--0000000000009ef41c05bf7d7d26
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
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDpl/8+50tyX
C5XK0DpwBIOjqXgTYR4Ms7YN+m5Ai12XMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDQwODIyMjMwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAIihPtppIYjj2XXxClma9/VbZohq+M
UvcrtRh+xyMQLRCuUF0IW18nj4sKpbPa40KTKussFGNuLNR8KwY/fLO1l/+rHMicLzznrTF/Vmyw
/Gm25o7Yvm6UFLBFGhHFddLI7ZDlyyJzXnsRy9SPZsMN6xdQWEJggEffAkfEAlxlcIjjIMXfU17o
rCvGv+BTUrXFd3A8+oH8rmc1NP+lDnN4hYs5rbuo5B26NKRGKScx869atRXCN5xZH8NX+f+BQ0Ug
yKn2NEOIX/TvdHacIommBCgC/3GwZJIPjd4tTO3ir74R59AvbPnuDIJIrBiQw6mK6xDobFpqmF/Y
YpBphN+l
--0000000000009ef41c05bf7d7d26--
