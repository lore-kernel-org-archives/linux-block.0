Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F6C282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D602073A
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 12:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="G/PyWGGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAHMzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:55:43 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39805 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgAHMzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 07:55:43 -0500
Received: by mail-il1-f196.google.com with SMTP id x5so2559764ila.6
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2020 04:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+b+8uoqmDNLdb7NpY/ylmrSBRhxXRp5uOtfvXbiX9A=;
        b=G/PyWGGtb+Py0dClzGP/KAya6c/8oIqrjxKFXtN70jFJvM0rcUdBmLTTpunOVdiv+N
         0NR13jD1Z0uk8Y9PbSfcu2I4EnlLWg3Tf3f20B81oHbKSPQbQQ33ea8mQhKa7Gd66LgY
         WMLY1jYYOdQoyhmhru3EUMkVDxPVy96srkmO7YVp4DT2S5N/r7qouP20FvtZvy5uSs+g
         qXpi4Wgz6a8C+9LTzMTPPZSp5eouvZ0uP+qDROkAXlWskLTDrvQcqLcvK7aqTRmTNfDS
         ume5IrCoIZp+YvdrBGZuwXDNGNnyFPNw8Xt0IfxdCdgsdSbuIdaL/wsa1/WJ2+QXRkEI
         lmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+b+8uoqmDNLdb7NpY/ylmrSBRhxXRp5uOtfvXbiX9A=;
        b=tXRfMwTuWmWizvuZIByRMK+jhXFx6myb3/tROeQS8sj7j27iriHDGH8mSmn/ZxjDLg
         let6BvRnn8xU9afos581V1RogtQE1+uaBmd0eGJirYAlrG2o7X8lxfLyaVb00bF6jmk8
         CbwYmibPisTz+0QYw5/aA8ElcmL2X9dAMHpNxlSZ6UCL8pjqsm2NNHpzKM1UY9aNz5Vd
         TgFwAKuJp+dhRL3/FLQlH0xjntTjITQrnsz5LsSrx1Klg/BFT2myHfARTIT3iLPEOKEH
         Kf7Wcx4d/ojF47m9sy/GDSTvASP6iRpFnvY36TiMZXXLlgiqhQIghCxzChuTk8XssVXt
         66oA==
X-Gm-Message-State: APjAAAWsiWWBtXJv0qpEt7pWt48SIy4qY+uIzlq/Ge3Zcs9t4Z6mdWqr
        ThNl7TQHJFtLcJPipG90QkKTT01iXkKAAsqH36hJtA==
X-Google-Smtp-Source: APXvYqxjWz5Zu/qB+Fax140bVTtEwJQWBCp+FkDPXFvvURppEcOqP3v9PXN2vHxa++l6XhOxpc/uSNaj8M76EP3Rft0=
X-Received: by 2002:a92:1090:: with SMTP id 16mr3578708ilq.298.1578488142467;
 Wed, 08 Jan 2020 04:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-12-jinpuwang@gmail.com>
 <15c76744-8ce8-e70a-506a-1a28c2518de0@acm.org>
In-Reply-To: <15c76744-8ce8-e70a-506a-1a28c2518de0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 8 Jan 2020 13:55:31 +0100
Message-ID: <CAMGffEmdHcoefDAOxGAaKwC05YFXFj6+9rM7MwnYnJ4a2t5hdQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/25] rtrs: server: statistics functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 11:02 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
> > +{
> > +     if (enable) {
> > +             struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > +
> > +             memset(r, 0, sizeof(*r));
> > +             return 0;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
>
> I think the traditional kernel coding style is "if (!enable) return ...".
This can be changed.
>
> > +ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
> > +                                 char *page, size_t len)
> > +{
> > +     struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > +     struct rtrs_srv_sess *sess;
> > +
> > +     sess = container_of(stats, typeof(*sess), stats);
> > +
> > +     return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> > +                      (s64)atomic64_read(&r->dir[READ].cnt),
> > +                      (s64)atomic64_read(&r->dir[READ].size_total),
> > +                      (s64)atomic64_read(&r->dir[WRITE].cnt),
> > +                      (s64)atomic64_read(&r->dir[WRITE].size_total),
> > +                      atomic_read(&sess->ids_inflight));
> > +}
>
> Does this follow the sysfs one-value-per-file rule?
We have user space tools already depend on it.
On the other side one-value-per-file rule is never really enforced,
see https://lwn.net/Articles/378884/
I think it doesn't really make sense for the use case.
>
> > +int rtrs_srv_stats_wc_completion_to_str(struct rtrs_srv_stats *stats,
> > +                                      char *buf, size_t len)
> > +{
> > +     return snprintf(buf, len, "%lld %lld\n",
> > +                     (s64)atomic64_read(&stats->wc_comp.total_wc_cnt),
> > +                     (s64)atomic64_read(&stats->wc_comp.calls));
> > +}
>
> Same comment here.
See comment above.
>
> Thanks,
>
> Bart.
Thanks Bart
