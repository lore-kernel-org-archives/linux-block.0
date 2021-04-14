Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB186C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 08:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F02613C1
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 08:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhDNIV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349252AbhDNIVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 04:21:24 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9E8C061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 01:21:04 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o17so12144850qkl.13
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=iaIAZIst1nSblscSWDH1JVygpC8OpjPpLn89LTySB/o=;
        b=M6W6t79oIEpunCvWEDM5/L7spXKmzWZGXYmTDBCqbqQVROTBIgC2tgoOT4GQAsOfvL
         L3Swp504BAgKD+n9QsCqgQmkNtUNutXbjuqk+jOyY4Piv59MYGl7KsqHBcwQCQLUcrvB
         bmw3Zjw1dcO7vzYyEtgNfqkxpjpfH0Bn/uQ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=iaIAZIst1nSblscSWDH1JVygpC8OpjPpLn89LTySB/o=;
        b=ip+YHxJEm7wd2XOV/SL+pbYSblDkRyEpVILrfhm+9J+ii2y9hUSHHnyoJnpKzNffqn
         PiRR63hBN2yQeC/Syjkd/SxHyxBdre9uYOAVQG4lio35GLq6kG8LuCVGtc6+bKUvdYzR
         2L1I7YrnIoYAEJxAunaLYpCQdNH1qT/p8i1F7GiYKMdJTtUs1Lp0hAfGuKiFMuZIcFJs
         pnyF47SM1viWPWbkq95AzuoVZXRDKSrL3wEvPyzg7dM4w5HzHi+IX0eu4LgwNSDg19aH
         Jiy+AaoAWeGq26h/JUExsBzGExPMcrAlMgnG1UKJDjuN2nyXty3pB//TqdqxFg+CiYLS
         VCQw==
X-Gm-Message-State: AOAM530exF8MR5Wz2b76NKxjEpjPZKg2oyeaYy0GP1j1eglxuM/2WYvh
        KCD+WnSWANpTZf3N74ALy8ChbAgSKB6FXJe5KLzpGg==
X-Google-Smtp-Source: ABdhPJyAX+WCRGCLELScTsh2/xUWLap9xJd1w3G28ubI9UhujwrRUZQQsJzyhHA8JWI64w3qbuaw6LYs7jPzxE9lYUg=
X-Received: by 2002:a37:bb42:: with SMTP id l63mr36772221qkf.127.1618388462975;
 Wed, 14 Apr 2021 01:21:02 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20210406031933.767228-1-ming.lei@redhat.com> <d081eb6a-ace7-c9b2-7374-7f05a31551a0@huawei.com>
 <YG0BTVsCNKZHD3/T@T590> <6c346805-a7b1-f66d-af16-b1da03d77fc0@huawei.com> <YG2F9ed33XbY6vZe@T590>
In-Reply-To: <YG2F9ed33XbY6vZe@T590>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHnoxQphVXLFDpwxH/yxagQs0gljQKBzJx3AbuLtKsBbI/eyQGZrhXsqliiBRA=
Date:   Wed, 14 Apr 2021 13:51:01 +0530
Message-ID: <49bb403dc1ecf8ea25eb40c0fb921c65@mail.gmail.com>
Subject: RE: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
To:     Ming Lei <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yanhui Ma <yama@redhat.com>, Hannes Reinecke <hare@suse.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000079977905bfea6df1"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--00000000000079977905bfea6df1
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, Apr 07, 2021 at 09:04:30AM +0100, John Garry wrote:
> > Reviewed-by: John Garry <john.garry@huawei.com>
> >
> >
> > > On Tue, Apr 06, 2021 at 11:25:08PM +0100, John Garry wrote:
> > > > On 06/04/2021 04:19, Ming Lei wrote:
> > > >
> > > > Hi Ming,
> > > >
> > > > > Yanhui found that write performance is degraded a lot after
> > > > > applying hctx shared tagset on one test machine with
> > > > > megaraid_sas. And turns out it is caused by none scheduler which
> > > > > becomes default elevator caused by hctx shared tagset patchset.
> > > > >
> > > > > Given more scsi HBAs will apply hctx shared tagset, and the
> > > > > similar performance exists for them too.
> > > > >
> > > > > So keep previous behavior by still using default mq-deadline for
> > > > > queues which apply hctx shared tagset, just like before.
> > > > I think that there a some SCSI HBAs which have nr_hw_queues > 1
> > > > and don't use shared sbitmap - do you think that they want want
> > > > this as well (without knowing it)?

John - I have noted this and discussing internally.
This patch fixing shared host tag behavior is good (and required to intact
earlier behavior) but for <mpi3mr> which is true multi hardware queue
interface, I will update later.
In general most of the OS vendor recommend <mq-deadline> for rotational
media and <none> for non-rotational media. We would like to go with this
method in <mpi3mr> driver.


> > > I don't know but none has been used for them since the beginning, so
> > > not an regression of shared tagset, but this one is really.
> >
> > It seems fine to revert to previous behavior when host_tagset is set.
> > I didn't check the results for this recently, but for the original
> > shared tagset patchset [0] I had:
> >
> > none sched:		2132K IOPS
> > mq-deadline sched:	2145K IOPS

On my local setup also I did not see much difference.

>
> BTW, Yanhui reported that sequential write on virtio-scsi drops by
40~70% in
> VM, and the virito-scsi is backed by file image on XFS over
megaraid_sas. And
> the disk is actually SSD, instead of HDD. It could be worse in case of
> megaraid_sas HDD.

Ming -  If we have old megaraid_sas driver (without host tag set patch),
and just toggling io-scheduler from <none> to <mq-deadline> (through
sysfs) also gives similar performance drop.  ?

I think performance drop using <none> io scheduler, might be due to bio
merge is missing compare to mq-deadline. It may not be linked to shared
host tag IO path.
Usually bio merge does not help for sequential work load if back-end is
enterprise SSDs/NVME, but it is not always true. It is difficult to have
all setup and workload to get benefit from one io-scheduler.

I may like to reproduce similar drop locally.   I will check with you and
Yanhui about how to reproduce similar drop (for my future reference and
want to have similar test in my performance BST).

Kashyap

>
> Same drop is observed on virtio-blk too.
>
> I didn't figure out one simple reproducer in host side yet, but the
performance
> data is pretty stable in the VM IO workload.
>
>
> Thanks,
> Ming

--00000000000079977905bfea6df1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA5jprI/EhizLWwcDRPszYWL3gJ5
ze33syoWjGPPayLoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQxNDA4MjEwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBkKB0sdfjcPUz9OhgW3BXXDERkzikzzIOWejtpdp0E/v8L
f1WgyQHJkngONK1S1Gkg2/rgnGlRtNDo2qjZoS+pfGdbz9U9/FF/y54i37jNeqhu5WqFN7ul+QC6
2UXMNtf7lxl3QqtchaanCzjY3LIo4S1Z2yYAGMy+kWQRPOUkgb3uJZve3C9SMYM5vcQTP6ckLZr4
V3WQGJ/dr95WKRRfPHndvVkBy4/n0gWbgALIKDrjYt1G0EYiVuD3D+DJRIuwaIt9wJYgI+2KBXt3
IcTR1WXtqB2s+KETgWB0bpLnZajCpTi1B7oDm3ERjtIujx78Z4Z3Q8VFIoy7bkt3Oq35
--00000000000079977905bfea6df1--
