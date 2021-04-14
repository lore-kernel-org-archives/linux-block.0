Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED3C433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 18:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B03D61155
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 18:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352901AbhDNSdw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbhDNSdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 14:33:50 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDDC061756
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 11:33:27 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id er3so1892742qvb.6
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0/srBkeFnlcniXPRdlu+FlhEdyBG2hZdPXnbrnqOU0=;
        b=UQYHODYvV2ghLkrsOvXnbzAPzBHh/6Tmj7lxhmSooLB8I/0lrXAImuigkd4ggUu/Gb
         lyw91JRrdlfvxnHJAW2qYMq6r88Lm6lqWRW65uCA+GDBLPZ9naXuo4dlRl4dlQukXZz8
         sTY0crkzbkfNv6Bp+nUtUPv9oZLwNEB/EntBrNlhrynjoXRSQ8e3DlLmzbvNOYOcEajP
         akxp3kQWPe2LjjZ5+dLK8p8rFupuxmbH8xL2R81HFi7cVX2ZdHCaT7PsrrjipDNWMRGD
         gcGse1CE1Ui1CU8mnjCETQUvAkVcCrrUhkwslFOMvhiKLMkF6MssaZZh0iWw1hPxZc58
         LDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0/srBkeFnlcniXPRdlu+FlhEdyBG2hZdPXnbrnqOU0=;
        b=LKjlH2wJiI+axOfmuWIulOUNjEk+Z4ir6E8cpvXH+ntR69T49BHP5XK847hXCDPK7Z
         EiOxumc6UOUAaQ88yuHxG+jBrKNfIwN98ASLpD30Ek2EybmC3TnE9c2LwpASYhI9u9HI
         Sdd2m9YIwcAa+DeAEQ7PO+as6Pf+hipARE+/dEF/jsIYUJwhLNmd9hrpjmxU0dzFBGae
         fuvPllI3uZbWHfDUNK81uFCiuJSqB422Uu654s8ieNl2aPIfRc8z0WlmTvruoGgAbElz
         +kkrS+4sq5fONJt+NKY+W0cj7kvDNb+5nsR8Jc9qLGLpWDZO1ThGcgsN/SMFzfWT5KKa
         0zIQ==
X-Gm-Message-State: AOAM532kHI4Px7SxbTYzIQY29ITN0yOdTNjlc/AlcQZWE0Qgq6FsN6me
        Y78QanzxMikx9R8T+IEWH3U8z+Enuui1ZxfQBAc7Qw==
X-Google-Smtp-Source: ABdhPJxjE6WnIxumqjw7SZ4kmMT+E4GzgyDjzxdFNPkTLuz7vkRvkLJ1pwkhP+zd/glryaiSKrq3g6l9c5R1zNAFTG8=
X-Received: by 2002:ad4:4d0c:: with SMTP id l12mr6353478qvl.54.1618425205946;
 Wed, 14 Apr 2021 11:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210319060015.3979352-1-khazhy@google.com> <20210414095455.GA29760@quack2.suse.cz>
In-Reply-To: <20210414095455.GA29760@quack2.suse.cz>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Wed, 14 Apr 2021 11:33:14 -0700
Message-ID: <CACGdZYJAoTjE3bbXS8ATRT6R3WHdY8P+q989RjKM_z_J7wpvyg@mail.gmail.com>
Subject: Re: [PATCH] bfq: silence lockdep for bfqd/ioc lock inversion
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000885c1f05bff2fb38"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000885c1f05bff2fb38
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 14, 2021 at 2:54 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 18-03-21 23:00:15, Khazhismel Kumykov wrote:
> > lockdep warns of circular locking due to inversion between
> > bfq_insert_requests and bfq_exit_icq. If we end freeing a request when
> > merging, we *may* grab an ioc->lock if that request is the last refcount
> > to that ioc. bfq_bio_merge also potentially could have this ordering.
> > bfq_exit_icq, conversely, grabs bfqd but is always called with ioc->lock
> > held.
> >
> > bfq_exit_icq may either be called from put_io_context_active with ioc
> > refcount raised, ioc_release_fn after the last refcount was already
> > dropped, or ioc_clear_queue, which is only called while queue is
> > quiesced or exiting, so the inverted orderings should never conflict.
> >
> > Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as
> > an extra scheduler")
> >
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
>
> I've just hit the same lockdep complaint. When looking at this another
> option to solve this complaint seemed to be to modify bfq_bio_merge() like:
>
>         ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
>
> +       spin_unlock_irq(&bfqd->lock);
>         if (free)
>                 blk_mq_free_request(free);
> -       spin_unlock_irq(&bfqd->lock);
>
>         return ret;
>
> to release request outside of bfqd->lock. Because AFAICT there's no good
> reason why we are actually freeing the request under bfqd->lock. And it
> would seem a bit safer than annotating-away the lockdep complaint (as much
> as I don't see a problem with your analysis). Paolo?

If we can re-order the locking so we don't need the annotation, that
seems better ("inversion is OK so long as either we're frozen or we
have ioc refcount, and we only grab ioc->lock normally if we drop the
last refcount" is a tad "clever"). Though we still need to deal with
blk_mq_sched_try_insert_merge which can potentially free a request.
(See the first stacktrace). Something simple that I wasn't sure of is:
could we delay bfq_exit_icq work, then avoid the inversion? Simpler to
analyze then.

Khazhy

>
>                                                                 Honza
> > ---
> >  block/bfq-iosched.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > Noticed this lockdep running xfstests (generic/464) on top of a bfq
> > block device. I was also able to tease it out w/ binary trying to issue
> > requests that would end up merging while rapidly swapping the active
> > scheduler. As far as I could see, the deadlock would not actually occur,
> > so this patch opts to change lock class for the inverted case.
> >
> > bfqd -> ioc :
> > [ 2995.524557] __lock_acquire+0x18f5/0x2660
> > [ 2995.524562] lock_acquire+0xb4/0x3a0
> > [ 2995.524565] _raw_spin_lock_irqsave+0x3f/0x60
> > [ 2995.524569] put_io_context+0x33/0x90.  -> ioc->lock grabbed
> > [ 2995.524573] blk_mq_free_request+0x51/0x140
> > [ 2995.524577] blk_put_request+0xe/0x10
> > [ 2995.524580] blk_attempt_req_merge+0x1d/0x30
> > [ 2995.524585] elv_attempt_insert_merge+0x56/0xa0
> > [ 2995.524590] blk_mq_sched_try_insert_merge+0x4b/0x60
> > [ 2995.524595] bfq_insert_requests+0x9e/0x18c0.    -> bfqd->lock grabbed
> > [ 2995.524598] blk_mq_sched_insert_requests+0xd6/0x2b0
> > [ 2995.524602] blk_mq_flush_plug_list+0x154/0x280
> > [ 2995.524606] blk_finish_plug+0x40/0x60
> > [ 2995.524609] ext4_writepages+0x696/0x1320
> > [ 2995.524614] do_writepages+0x1c/0x80
> > [ 2995.524621] __filemap_fdatawrite_range+0xd7/0x120
> > [ 2995.524625] sync_file_range+0xac/0xf0
> > [ 2995.524642] __x64_sys_sync_file_range+0x44/0x70
> > [ 2995.524646] do_syscall_64+0x31/0x40
> > [ 2995.524649] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > ioc -> bfqd
> > [ 2995.524490] _raw_spin_lock_irqsave+0x3f/0x60
> > [ 2995.524498] bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
> > [ 2995.524512] put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
> > [ 2995.524516] exit_io_context+0x48/0x50
> > [ 2995.524519] do_exit+0x7e9/0xdd0
> > [ 2995.524526] do_group_exit+0x54/0xc0
> > [ 2995.524530] __x64_sys_exit_group+0x18/0x20
> > [ 2995.524534] do_syscall_64+0x31/0x40
> > [ 2995.524537] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Another trace where we grab ioc -> bfqd through bfq_exit_icq is when
> > changing elevator
> >                -> #1 (&(&bfqd->lock)->rlock){-.-.}:
> > [  646.890820]        lock_acquire+0x9b/0x140
> > [  646.894868]        _raw_spin_lock_irqsave+0x3b/0x50
> > [  646.899707]        bfq_exit_icq_bfqq+0x47/0x1f0
> > [  646.904196]        bfq_exit_icq+0x21/0x30
> > [  646.908160]        ioc_destroy_icq+0xf3/0x130
> > [  646.912466]        ioc_clear_queue+0xb8/0x140
> > [  646.916771]        elevator_switch_mq+0xa4/0x3c0
> > [  646.921333]        elevator_switch+0x5f/0x340
> >
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index 95586137194e..cb50ac0ffe80 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -5027,7 +5027,14 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
> >       if (bfqq && bfqd) {
> >               unsigned long flags;
> >
> > -             spin_lock_irqsave(&bfqd->lock, flags);
> > +             /* bfq_exit_icq is usually called with ioc->lock held, which is
> > +              * inverse order from elsewhere, which may grab ioc->lock
> > +              * under bfqd->lock if we merge requests and drop the last ioc
> > +              * refcount. Since exit_icq is either called with a refcount,
> > +              * or with queue quiesced, use a differnet lock class to
> > +              * silence lockdep
> > +              */
> > +             spin_lock_irqsave_nested(&bfqd->lock, flags, 1);
> >               bfqq->bic = NULL;
> >               bfq_exit_bfqq(bfqd, bfqq);
> >               bic_set_bfqq(bic, NULL, is_sync);
> > --
> > 2.31.0.rc2.261.g7f71774620-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--000000000000885c1f05bff2fb38
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
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFPxj2ol9WUW
64p+IQW/dZbhc1YsolJUb/MHHJrN7vEyMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDQxNDE4MzMyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBg20neVp4CsOId9l858PpcrNBIiQpj
2YJFJTSuqOVu4KvA+ik/Sqkj4lnnNWge2I3FSXJ9awrUnzmJV0z0xiXqeMJiY8/D3rCiXlaAKZIl
miADJL92ywjEVnlJuYkFe49Edm4N66PYoGdhYyB5ZFWnfrugv+pyqpwFg6Zt6XCuv7nXDPjPi26W
aAuS2fWGZPSj0IImDP5hY/BqxHhKWD9NtH58et1+hf71LuyTFNKq2jcktdodg9lpXQ0gW7Wod87U
Skx1mLy0/w2Hb6co8fsKpZswv3+7nm15kmXM7CMfO1Ly4KWTg0Pi20/tRiWPyI/E/+qTkCIMwx13
aEwOfVKJ
--000000000000885c1f05bff2fb38--
