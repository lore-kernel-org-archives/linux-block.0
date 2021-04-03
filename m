Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3929CC433B4
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 03:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEB5611C9
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 03:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDCDhp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 23:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDCDho (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 23:37:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8151C0613E6
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 20:37:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h7so4913319qtx.3
        for <linux-block@vger.kernel.org>; Fri, 02 Apr 2021 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKugHrg4PLyo3JmAy99zkFlus/49YG73teaJGSiu344=;
        b=ro8/dgnI43tj7Xod3YUU+wEluK5wptHsSMuAW7wR4CJghTZMYv+81+rv9rwKkzPH/O
         t/JtJRHUg/p0DK/7udAKYWQQP/9Wt9akMa8cCBc2XJsTPxsZjxppHI+Gx5oscCKNbMuh
         uTaXWI3YXGDF1dTGHRosW1D+J1ZaoNmoOLzlPGuiavHlW0AGoXyaZBam/l1//3qMooeh
         AYGA+DB4E9bFl2/gR/H7643t9lmueFit5PS9r25vd6WOTc5+/aAncjxzCN2aEqY7ZDxf
         ivYD7ic0rQ54+5dhVw4+h8zUYmPUQqFwwX+qniKdOHR6zrl8nSMuVq9UV2j2MS08IMzu
         5w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKugHrg4PLyo3JmAy99zkFlus/49YG73teaJGSiu344=;
        b=c4FgyDH7aWKrLeiPTWf23PueVh8/x/Ao9XvG/h7+2fQQJ2bwD0o5BSL8V+TPdTyKMC
         lSRo8p5iWKjEhIC/Le9ZLo+fbLMbinQIgi/yeGSr4Fx0+u1ivmQTFatZqNYKINCjxXhl
         HV3RkTVhs/nf+eMgqEB0nfWQV8YhxcQ0tObtJalE7sBiuXS+o4BSCjsH2iZFOnqIWbtc
         slLWnHO/hr6jrHdnwhf7vI1fXCBnMNAotQ4bD+qX3Y1eFBwQIuXz0VK088fi1xIsVfKS
         /kpYp2iF7WLs3a9bueoao7HLygmH+KNa/5FWq9ojLzZTJZuW2c0JB7Gmgp98L5b5I8ft
         Z31A==
X-Gm-Message-State: AOAM530l/wZhK0ulL5bgdTxkErKxKDD9gjVPoI0eSMKKvobdJv6Do6l/
        UG0SwSRP6zOg5dQ79Y4fRtVUV3Vbg1K4SNR1CjMnVob+y6w=
X-Google-Smtp-Source: ABdhPJwDBQDDBSga6CqmW5wksLjLXLH1o5LqeHchmfJwo4RMzBM45qgPq1upe5NS2qI5hH4NoXZhcwdyQ/k32FOONT8=
X-Received: by 2002:aed:2803:: with SMTP id r3mr14476011qtd.142.1617421061686;
 Fri, 02 Apr 2021 20:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210329020028.18241-1-bvanassche@acm.org> <20210329020028.18241-4-bvanassche@acm.org>
 <CACGdZYJb8saxEkkmenPDK=o9r0Av3PNJsGitAgpiXHd4D13TYg@mail.gmail.com> <229d08ec-7ae9-31f2-9f7c-ae340e372c56@acm.org>
In-Reply-To: <229d08ec-7ae9-31f2-9f7c-ae340e372c56@acm.org>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Fri, 2 Apr 2021 20:37:30 -0700
Message-ID: <CACGdZYKbV6QHaPJveUyf34iwgMRV2sDcSmrue23k=EfSWeLgjA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000dd514b05bf092fd0"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000dd514b05bf092fd0
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 2, 2021 at 8:26 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/2/21 4:59 PM, Khazhy Kumykov wrote:
> > On Sun, Mar 28, 2021 at 7:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> @@ -209,7 +209,12 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >>
> >>         if (!reserved)
> >>                 bitnr += tags->nr_reserved_tags;
> >> -       rq = tags->rqs[bitnr];
> >> +       /*
> >> +        * See also the percpu_ref_tryget() and blk_queue_exit() calls in
> >> +        * blk_mq_queue_tag_busy_iter().
> >> +        */
> >> +       rq = rcu_dereference_check(tags->rqs[bitnr],
> >> +                       !percpu_ref_is_zero(&hctx->queue->q_usage_counter));
> >
> > do we need to worry about rq->q != hctx->queue here? i.e., could we
> > run into use-after-free on rq->q == hctx->queue check below, since
> > rq->q->q_usage_counter might not be raised? Once we verify rq->q ==
> > hctx->queue, i agree q_usage_counter is sufficient then
>
> That's a great question. I will change the second
> rcu_dereference_check() argument into 'true' and elaborate the comment
> above rcu_dereference_check().
>
> >> -static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >> +static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
> >> +                          void *data)
> >>  {
> >>         struct bt_tags_iter_data *iter_data = data;
> >>         struct blk_mq_tags *tags = iter_data->tags;
> >> @@ -275,7 +286,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >>         if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
> >>                 rq = tags->static_rqs[bitnr];
> >>         else
> >> -               rq = tags->rqs[bitnr];
> >> +               rq = rcu_dereference_check(tags->rqs[bitnr], true);
> >
> > lockdep_is_held(&tags->iter_rwsem) ?
>
> I will change the second rcu_dereference_check() argument into the
> following:
>
> rcu_read_lock_held() || lockdep_is_held(&tags->iter_rwsem)
rcu_dereference_check() already has a || rcu_read_lock_held(), fwiw
>
> >> +               /*
> >> +                * Freeing tags happens with the request queue frozen so the
> >> +                * srcu dereference below is protected by the request queue
> >
> > s/srcu/rcu
>
> Thanks, will fix.
>
> Bart.

--000000000000dd514b05bf092fd0
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
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJ6WsnWk+x41
dF5TgcxM/iykHBVtqcsAO7ZNwpZC8O4JMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDQwMzAzMzc0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBw+27AAGoZbfzvqYihW7f74nyFuQAv
6+YOyNCnzls/P33ZecqRzKDRYe7lcKwz5VZ978ofDek/a3JQdCt3RX9cOJBlhxBy+MCREnnimvVH
8U0raauS7o4zJpJjN26F9XGbjPa3d6wyOPdIq2yItYI5vFlE4CQ9XkmYE0ihM2BXRYRKlyIjuYGr
ULjEmi/0MHRasK+HW+yKB9rk24jGVmYkUFjuwc3x2y48Yv1jz5b63vIJukPbMovV9zRRErcvkjc5
OfFKtnLA2djgi7bJRCZ7fAQE/+v/q2i196LXcw36RV5aIs3tArT07y3bzl4gigfFl9WGaUBevoOB
dVkbjgwC
--000000000000dd514b05bf092fd0--
