Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB65C433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 23:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiCAXZL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 18:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiCAXZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 18:25:11 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A807232071
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 15:24:29 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b13so14225657qkj.12
        for <linux-block@vger.kernel.org>; Tue, 01 Mar 2022 15:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpRjb/PBbJp9xBWpXcgVzGGQA7rNM3h9KoahHshtY0I=;
        b=o5/zWWj5Owdrx3UqP2Kt4ZD/AsQ3ClKOGGZbawmdutdtWnOdS3bffNJQmCLAH/jZJt
         MmxJFg2x1+ydx9IG/fzXNpGmlbhkzm/bC0Ukl2bSriVYpZtus0+IB5KL8Qio3NQw4wap
         0nX8ZISvqi5st7M8m0pPqK6vxZPwq7lg0xJTMGsJWOArjX/Y6+HuyOGIFv9Qi1s67t9K
         Jej06t6s9q3EJRCmyw8QDYYZfCYQD4iaEo9Vuknjqb2j1Q+F4xO2v2c3QTUFSrYLgFhj
         prf2RSf/D1hsNxqUCkTZfH07OelB2rBiVLVik9thoLeyJ3HAG4dvszk/Vt3/lH+oWzie
         AlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpRjb/PBbJp9xBWpXcgVzGGQA7rNM3h9KoahHshtY0I=;
        b=ZubaS9dKR8lXeJChwf6Hm3jGbbe3SJUsPeor1tNuUjWI+1QNghTXAH7fuDjnapfz8T
         QAP649lTswUgZyKA6jyFxKvpiT7X8913GxKN9RN4is5zHalDZNi6Sj8xcs6blFSnw24M
         TC3mDQQ5GpPr9Ipz0LcTW0WyvtiyAshbzSGgLEk0zL3gFCOUgiYM6rIU4nLn9FOTzfMd
         IEVI+bbG1GENrgUqMIl5wZtr2gUng678L+DPl775oUPtalvjTtCsLuW6+DxDfzghJcp5
         +1SbW0HlbdaBya/Uu4JKiu5j038KjuKz7JP1gE3qg6UqWKaMVn1Gaffc1CoWf10Huhev
         WZOg==
X-Gm-Message-State: AOAM533jsygQHQSggals7rww8WYmkq7rec5ZacOEA/TMZNsMJ7LyVPMN
        3BIYo2QMjQlW9nAqqtCt0cWhIUAy+oCXYEMRetUl0w==
X-Google-Smtp-Source: ABdhPJyowAYBsiW1nV0gvghyDAQppbEL7pR3M+QeI9qLpoD0lAYSyaNMtF6EqEG+uknySajKy/D0kFavTMFDW2gxVAQ=
X-Received: by 2002:a37:9f84:0:b0:5e9:6c34:620f with SMTP id
 i126-20020a379f84000000b005e96c34620fmr14642137qke.648.1646177068516; Tue, 01
 Mar 2022 15:24:28 -0800 (PST)
MIME-Version: 1.0
References: <87tucsf0sr.fsf@collabora.com> <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me> <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
In-Reply-To: <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Tue, 1 Mar 2022 15:24:17 -0800
Message-ID: <CACGdZY+SLWETvAxH6M+BhipB1KV=W+kS7cxFWgaiK=en4sqDPQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006fec4a05d9307758"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000006fec4a05d9307758
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 24, 2022 at 2:12 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>> Actually, I'd rather have something like an 'inverse io_uring', where
> >>> an application creates a memory region separated into several 'ring'
> >>> for submission and completion.
> >>> Then the kernel could write/map the incoming data onto the rings, and
> >>> application can read from there.
> >>> Maybe it'll be worthwhile to look at virtio here.

Another advantage that comes to mind, especially the userspace target
needs to operate on the data anyways, is if we're forwarding to
io_uring based networking, or user based networking, reading a direct
mapping may be quicker than opening a file & reading it.

(I think an idea for parallel/out-of-order processing was
fd-per-request, if this is too much overhead / too limited due to fd
count, perhaps mapping is just the way to go)

> >>
> >> There is lio loopback backed by tcmu... I'm assuming that nvmet can
> >> hook into the same/similar interface. nvmet is pretty lean, and we
> >> can probably help tcmu/equivalent scale better if that is a concern...
> >
> > Sagi,
> >
> > I looked at tcmu prior to starting this work.  Other than the tcmu
> > overhead, one concern was the complexity of a scsi device interface
> > versus sending block requests to userspace.
>
> The complexity is understandable, though it can be viewed as a
> capability as well. Note I do not have any desire to promote tcmu here,
> just trying to understand if we need a brand new interface rather than
> making the existing one better.
>
> > What would be the advantage of doing it as a nvme target over delivering
> > directly to userspace as a block driver?
>
> Well, for starters you gain the features and tools that are extensively
> used with nvme. Plus you get the ecosystem support (development,
> features, capabilities and testing). There are clear advantages of
> plugging into an established ecosystem.

I recall when discussing an nvme style approach, another advantage was
the nvme target impl could be re-used if exposing the same interface
via this user space block device interface, or e.g. presenting as nvme
device to a VM, etc.

That said, for a device that just needs to support read/write &
forward data to some userspace networked storage, the overhead in
implementation and interface should be considered. If there's a rich
set of tooling here already to create a custom nvme target, perhaps
that could be leveraged?

Maybe there's a middle ground? If we do a "inverse io_uring" -
forwarding the block interface into userspace, and allowing those who
choose to implement passthrough commands (to get the extra
"capability")? Providing an efficient mechanism to forward block
requests to userspace, then allowing the target to implement their
favorite flavor.

Khazhy

--0000000000006fec4a05d9307758
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
ILTGVY3VZAH79IEwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADCBmgYIKwYBBQUHAQEE
gY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRsYXNy
M3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2Nh
Y2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvRzV2V
b4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAJ4mUVcBAENL0YI+c7NV9lED
+LdJalqdzPSczf76Imu8iFqQLRJE2f/oXC6rRCd4Re9dQWFTJrdG7FP8DvNo5gRcOY0cSQWeyh7x
kRxliZ1eOu4hjoH+JtrIIJBm40vHwDWc51MV1LuQJ6kA1/n5PyJsfYyPw4h5lInk3ZYVpkh6f4Oh
a1pUuyFRuqCOJ0r2IJcYVXrreMNOZfcjKtzZ290l5UZJtlKXS0qfeVdndP8ld3kdTYr4EcWiSI5l
qohmI3eIH5GaIMsagonJlBy+HTzwO5RW54p4DjsVMwcYB+82QFGOT2AZoIBeCYFXU2XB6t0Q8RoU
8Jg6o35bh+CWZ2UxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjACEAEO
OfOqtlFUhIfo3Q6pjqUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKuSAQ8SxUA1
+HESbhCwrwRuIKc3eFP44Z7ADI4vW7LwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIyMDMwMTIzMjQyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAk2dgGIEZYilmPV1agqbILKZwCSXNt
XljzNvkVx3med2ZOOcb5DABxby6CDsCkO2fRz+o+ayvE/CONwf+p27tqF2tHStl/+VjchnsGZZqH
60KVv6NpzunNJUvFMH6uPWXiM3lnR8LkENXYGrjtoTg8BAZL0kPddAKQ9C4sQ8iKFGtXalKM2AQ0
1XeXwK31LYf72Te8Eb9tvE/IgsJUjSTpSwb1h037xgoMbKvm/7T8rccQdt8FaiJJ1ppyIR9L7xv9
cBcv9pyB/1DRL5+LcnCHFpTQGvOITKKB2Ni1W0BG7Bn+uJct9diCcaJ/UljtMFIP9Ac05lCvmZLZ
vedfZaGo
--0000000000006fec4a05d9307758--
