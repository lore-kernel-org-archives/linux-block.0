Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B1C433FE
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 11:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhKYL6C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:58:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51536 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbhKYL4C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 06:56:02 -0500
Date:   Thu, 25 Nov 2021 12:52:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637841170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0sl4XhoGsdqPmI+mBCUx18M6VFp1rb/XjKk4Zsrc0Do=;
        b=nJa2DzhvqOKOdfoEmLIaxXzJ/1R+F+kc1FYChBfx5bgY+vOJ1PtSeKFYyPkTe+EZHy+EyS
        zFWeJkYJEFUmUEX99w7AG/Dor8OKtK0WfnUR3m/awwTv5JqJ1JvmydkV7e1XTom0CqPLzs
        QJj1xz8Vi4GAkb2Rc0wTWPYbK0tkpKHLXls+tmQnqRKvBfT2ddtiC21Cg+e2pg4yFXSLCU
        O7aPcaXfxnWz4oFXAnyIO4BeB6u2J0yCa0bQb6Dnz19e+Yopb/+BmB0R2o+v2V2HTrvhUy
        vDsL5e+smKmihAd/fx/HY0rGFIEuNsi405PhhZ+fo9lt0sP7XovtDd4KY3JOig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637841170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0sl4XhoGsdqPmI+mBCUx18M6VFp1rb/XjKk4Zsrc0Do=;
        b=kThuf3/kO2GRpyl1LrEUI2LiyBgFSdkRbrZyHaOBcgzLf97xe9Yj4vR/+cbfxHsP7Os8qw
        YwirXswSOA0h4iBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 0/2] blk-mq: Allow to complete requests directly
Message-ID: <20211125115249.fb6g522pl54nulp3@linutronix.de>
References: <20211025070658.1565848-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211025070658.1565848-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-10-25 09:06:56 [+0200], To linux-block@vger.kernel.org wrote:
> v2=E2=80=A6v3:
>  - Align arguments with the begin of the function name
>    (blk_mq_complete_request_direct).
>=20
> v1=E2=80=A6v2:
>  - Drop the SCSI patch for now.
>  - Make blk_mq_complete_request_direct() call the completion handler
>    directly instead going through struct chain (Jens and hch might had
>    the same in mind).
>=20
> This series converts a part from the MMC layer which completes the
> requests from kworker/ preemptible context. Its intention is to avoid
> going through the softirq stack in preemptible context which would
> involve the ksoftirqd in this case.

Ping :)

This still applies on-top on top of -next. No need to repost, right?

Sebastian
