Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE3FC433ED
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC3961359
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 18:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhDESIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhDESIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 14:08:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE332C061756
        for <linux-block@vger.kernel.org>; Mon,  5 Apr 2021 11:08:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y5so12328734qkl.9
        for <linux-block@vger.kernel.org>; Mon, 05 Apr 2021 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYBLPNYvydWD/FBwXPgqpUKjjw8hU2ZYA6I5R9FDbC0=;
        b=l6MIEGGcN1avzHJz0lcFkPZ+jdo9ctkK36D8PxTC7wNkvaT2aFpSbWk0wReE+Dohr8
         jha6elDB45iLijOI7/DCJQAl/X2hVmx3If0SJ00Fr3w3HZRVdmgTYzGPyAWVYpiTX2x6
         T+7j65zJ+vGu99S7+2vPHbz24m7YXuKZ9m5ZzGArJkQpgKMoDQuq3wBIS0ZDkOw8gVGZ
         2UaYvixC0JRELN/6OGzLqK46zFG8Xftpk85fKNIVsBil5h/qN3dQQi6mIi8iHjlOYkzP
         t5puR0M7qTBFPR2K9lVtPLXB2m1HNS5Q44+6byHeIGuDLDbw4k67aWKJm/sdivCq9RXm
         CQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYBLPNYvydWD/FBwXPgqpUKjjw8hU2ZYA6I5R9FDbC0=;
        b=Kwtv8V1tedPhz8WK9hNK2u1mvu3EgzYmyFeN00c2lIKjZAQYtyCShAQezgDwn6fdbv
         3MbTVOFjxRYlTTTH1xc4U8VFLyAkwFBXiUTZpimCKj6Jz33t44/TigQsc0z1o2RrABLu
         KZiAFvJ2Fo1KktAv0ZrttNRnZHssX6HZUjZoj0CTJ1OZ58uA07wFo83ltraAfhWJSrFr
         OV3eBVou6rQBofwzvNkXDVlnydRkAD8j67hBc0Md49TJVDmizPl4emdIAMYpHPGHDqF2
         Rt27c1bzNmYq65R/CYuRPp6kmhgn1zWBLGee22ywZuC1qxgLYwdP3Qci/5Lx/kz9Sp2D
         gwXg==
X-Gm-Message-State: AOAM531sOqGH1hbuHN0IxBNZMPhP1+8Tk042O4LnTPkd9KYtQJxJ2k1B
        SOIv3XHnyKgc8ZXQn7KYZ9ClSv/+qchb3tNC6n/IqA==
X-Google-Smtp-Source: ABdhPJwP5AOPvicE5OYqHnzGgrMAvej3ZAf+bvytJ9OrRiCwlPHPGQOFpAk9xtjY8frt5lnvwKTFrJObp6ZYbxgEQwk=
X-Received: by 2002:a37:615:: with SMTP id 21mr25479440qkg.421.1617646107777;
 Mon, 05 Apr 2021 11:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210405002834.32339-1-bvanassche@acm.org> <20210405002834.32339-4-bvanassche@acm.org>
In-Reply-To: <20210405002834.32339-4-bvanassche@acm.org>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Mon, 5 Apr 2021 11:08:16 -0700
Message-ID: <CACGdZYJh6ZvVekC8eBvz3SmN-TH8hTAmMQrvHtLJsKyL3R_fLw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a87b4205bf3d95cd"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000a87b4205bf3d95cd
Content-Type: text/plain; charset="UTF-8"

On Sun, Apr 4, 2021 at 5:28 PM Bart Van Assche <bvanassche@acm.org> wrote:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 116c3691b104..e7a6a114d216 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -209,7 +209,11 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>
>         if (!reserved)
>                 bitnr += tags->nr_reserved_tags;
> -       rq = tags->rqs[bitnr];
> +       /*
> +        * Protected by rq->q->q_usage_counter. See also
> +        * blk_mq_queue_tag_busy_iter().
> +        */
> +       rq = rcu_dereference_check(tags->rqs[bitnr], true);

maybe I'm missing something, but if this tags struct has a shared
sbitmap, what guarantees do we have that while iterating we won't
touch requests from a queue that's tearing down? The check a few lines
below suggests that at the least we may touch requests from a
different queue.

say we enter blk_mq_queue_tag_busy_iter, we're iterating with raised
hctx->q->q_usage_counter, and get to bt_iter

say tagset has 2 shared queues, hctx->q is q1, rq->q is q2
(thread 1)
rq = rcu_deref_check
(rq->q != hctx->q, but we don't know yet)

(thread 2)
elsewhere, blk_cleanup_queue(q2) runs (or elevator_exit), since we
only have raised q_usage_counter on q1, this goes to completion and
frees rq. if we have preempt kernel, thread 1 may be paused before we
read rq->q, so synchonrize_rcu passes happily by

(thread 1)
we check rq && rq->q == hctx->q, use-after-free since rq was freed above

I think John Garry mentioned observing a similar race in patch 2 of
his series, perhaps his test case can verify this?

"Indeed, blk_mq_queue_tag_busy_iter() already does take a reference to its
queue usage counter when called, and the queue cannot be frozen to switch
IO scheduler until all refs are dropped. This ensures no stale references
to IO scheduler requests will be seen by blk_mq_queue_tag_busy_iter().

However, there is nothing to stop blk_mq_queue_tag_busy_iter() being
run for another queue associated with the same tagset, and it seeing
a stale IO scheduler request from the other queue after they are freed."

so, to my understanding, we have a race between reading
tags->rq[bitnr], and verifying that rq->q == hctx->q, where if we
schedule off we might have use-after-free? If that's the case, perhaps
we should rcu_read_lock until we verify the queues match, then we can
release and run fn(), as we verified we no longer need it?

>
>         /*
>          * We can hit rq == NULL here, because the tagging functions
> @@ -254,11 +258,17 @@ struct bt_tags_iter_data {
>         unsigned int flags;
>  };
>

Thanks,
Khazhy

--000000000000a87b4205bf3d95cd
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
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKB8VQZzs9kp
ITt+AqD7t71YjtxnZ1hL8HIA2UAD0RZ0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDQwNTE4MDgyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBsVkejw4XNqkuYrK716i5HTjOVnnyO
UWrVK+iy95MF9abKSXPbuIgfWE4kRcYZjX+cX43R2T2J1601Udi+GSdaeiyAvc1xwaXxl2CjN8Au
+D89Ol9J49zMbQL4O366r1L/Y6zSN3R2CL2DSx5WZPiYokTo8fRdNH72ifnqtiaoMJPKqemDN7vW
qOvlaxEZOcQLCEprALbI3o6/e8fjf+U8bldf5HzY+DjETsd016092rj7nOYskIufBHPo7uv3ePQ5
TUCZxJELh3W0IFBmdEf8lcKzwyN9fkYTANhPX+99e+UeyxmOa6PWRCTIMx8iOuOAvTg2HuwKZ2zi
ZSFy6g6o
--000000000000a87b4205bf3d95cd--
