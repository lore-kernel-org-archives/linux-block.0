Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B3CCDB465
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 07:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjJSHLO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 03:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjJSHLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 03:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53881123
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697699421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jaIDociwPi0biv0GwgN4RLcwAH/6H4qEBY/7UhYwGOk=;
        b=h5G4gRRnsaYhoYjmeE5zuuwAwEp7eUIR5KpUjtAeKzWFIdDdGpIDE58a85M8yXRWG7ufvo
        U+IhbElCH5ML4dE5sXjhUADKoO9LYLJ6WTWqogKDttXpnAPixDooH7PPOA2B2Bh7sRCFOG
        TIky7ElHW7MqjcUA3MjzuLbYR19x09U=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ePZZfuZ4MTqxx-2SZ7wvUQ-1; Thu, 19 Oct 2023 03:10:04 -0400
X-MC-Unique: ePZZfuZ4MTqxx-2SZ7wvUQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-457cd8cf4e6so2210354137.3
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 00:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699404; x=1698304204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaIDociwPi0biv0GwgN4RLcwAH/6H4qEBY/7UhYwGOk=;
        b=kxjlHuyrfU8HXRvknBYQETjGj4I1cCUKDyFO0nL13r1BujKO0QfZ85d8Awjsadc6c/
         M4cpcqeddUAZgc5HfyzCSzDpe7/PSekIRaDTKjrW/HUfvDL6JSBaTNX300Cew9gwNpS8
         ngdHwOF/xmvDJNkTU6C00rCy8l/BlzCAQUNENguZMNcFr32D2H+rLRY96J1rxJ3s2sIM
         eHLLXErJWvFnwWEBQNQa+Z+0EtkF+iJe3lLz4R5PvBh3AQUS1b9VnP7pcWu+NYaFpGNy
         pna8PgOz/eHrgJhSqvr9BRiAkGB4MIJvJ/LS4LgH13OKexAP/oWOHBuWxWLeRmYZ2NRf
         00SQ==
X-Gm-Message-State: AOJu0YxawsbW9ugJeUT5MmYT1+Mdhvm8fGf1Iz6bV7s7ah33LAytAsiZ
        3uR6Vp+TQtUnTSD5aI69pJqpp9Ek7Xtisc7MMzJyf2nj+0QmKyupSmYgKx3tBCY/P7J8+TI1bPb
        PnRCXNVkXxuNYSi9I5p5f0Pm1uXai9p1DG7HIKNg=
X-Received: by 2002:a67:cc1b:0:b0:457:e862:8bc1 with SMTP id q27-20020a67cc1b000000b00457e8628bc1mr1097645vsl.2.1697699404034;
        Thu, 19 Oct 2023 00:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiznte4nV3Qz5eLEjzHTAX0XxQ1Z/pH24A9aFObBXkDWSwWhMqdMFsK7Z60rk7nBpeChy7ZvXXKSggSm963NU=
X-Received: by 2002:a67:cc1b:0:b0:457:e862:8bc1 with SMTP id
 q27-20020a67cc1b000000b00457e8628bc1mr1097636vsl.2.1697699403769; Thu, 19 Oct
 2023 00:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_Lprbh1zWsJ2yT6+qhNoqjrGDrBgx+XOYvU9SLpmLTtw@mail.gmail.com>
 <ZS_wgTeyndh1WjTI@kbusch-mbp> <CAHj4cs_FiGXKySrgv-DvGTr3AFLwE-TgWzMCn+v3mgSUfhQYxg@mail.gmail.com>
In-Reply-To: <CAHj4cs_FiGXKySrgv-DvGTr3AFLwE-TgWzMCn+v3mgSUfhQYxg@mail.gmail.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Thu, 19 Oct 2023 09:09:52 +0200
Message-ID: <CAFL455kTFgx++rYHoUda_rXY2f12MOMwKsB75NewZukH7E3ceg@mail.gmail.com>
Subject: Re: [bug report][bisected] blktests nvme/tcp failed on the latest linux-block/for-next
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

=C4=8Dt 19. 10. 2023 v 7:29 odes=C3=ADlatel Yi Zhang <yi.zhang@redhat.com> =
napsal:
>
> Hi Hannes
> Bisect shows it was introduced from this commit:
>
> commit 675b453e024154dd547921c6e6d5b58747ba7e0e
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Thu Aug 24 16:39:23 2023 +0200
>
>     nvmet-tcp: enable TLS handshake upcall

st 18. 10. 2023 v 16:08 odes=C3=ADlatel Yi Zhang <yi.zhang@redhat.com> naps=
al:
>
> [ 5161.405594] ODEBUG: assert_init not available (active state 0)
> [ 5161.521808] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tc=
p]
> [ 5161.697797]  __timer_delete+0x70/0x170
> [ 5161.701550]  ? __pfx___timer_delete+0x10/0x10
> [ 5161.705907]  ? __mutex_lock+0x741/0x14b0
> [ 5161.709833]  ? try_to_grab_pending+0x70/0x80
> [ 5161.714105]  ? rcu_is_watching+0x11/0xb0
> [ 5161.718032]  try_to_grab_pending+0x46/0x80
> [ 5161.722132]  __cancel_work_timer+0xa0/0x460
> [ 5161.726318]  ? mutex_lock_io_nested+0x1273/0x1310
> [ 5161.731024]  ? __pfx___cancel_work_timer+0x10/0x10
> [ 5161.735816]  ? do_raw_write_trylock+0xb5/0x190
> [ 5161.740260]  ? __pfx_do_raw_write_trylock+0x10/0x10
> [ 5161.745141]  ? rcu_is_watching+0x11/0xb0
> [ 5161.749066]  ? trace_irq_enable.constprop.0+0x13d/0x180
> [ 5161.754292]  ? __pfx_sk_stream_write_space+0x10/0x10
> [ 5161.759258]  nvmet_tcp_release_queue_work+0x2db/0x1350 [nvmet_tcp]

Maybe the problem is that nvmet_tcp_release_queue_work() always calls
cancel_delayed_work_sync() against the tls_handshake_tmo_work timer,
but the latter is initialized only if
CONFIG_NVME_TARGET_TCP_TLS is defined.

Maurizio

