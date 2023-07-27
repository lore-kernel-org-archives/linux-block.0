Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391CBC001E0
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 13:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjG0NSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjG0NR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 09:17:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA00B4
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 06:17:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-682ae5d4184so220743b3a.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690463877; x=1691068677;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT6LxetfYEc8fhEZaGO1LxXI/NJPqS+YgI0TwK158rM=;
        b=kX0QhmFPtUCStg9oAAi10ad5B+gjRVy8u3/uz420o9PwXOJSvR7QX1qdlkk90XgVKc
         RRCEqk4cm346m0SYyKX0wfvE4Q+n2Cb6y5H3tn4MAJ8ZZbdnAsAnvQyb1YKP++HvKi5A
         FeAF+6xtbiUYJhhasdOBQH511LSIPaj0ViZD4G1BQISExatjHerMXyGPVYc4XZdbIvra
         hYOFLSnvTO00NwTuCaT74i0PLxUj63L+SgqQw1SyF4mG/vul8ciGDYT25ZawdpPIPPOq
         o0XWUmAxUggOt+DIO9YwxytwTswVWxWRyBv+gv6ip8D1fR1kfAF5H0MA4pqzVhhzy/03
         l3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463877; x=1691068677;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT6LxetfYEc8fhEZaGO1LxXI/NJPqS+YgI0TwK158rM=;
        b=ZceDU5YVsqam7JgHl/WzyJNZzgMSoFXlbXSwknFMTW+RKyXg/20dx0ik3RoPdhEcBU
         kB8NznjmkVea9PkmIvRvoTDP3LRcV8R4yEBjznQvRzPr3rc8YBy2vobRmVo3dUF4saE/
         0CV1dyYm0uyMj3O1b7X9wF9mkqV5f/tJp0HLkBDODXA3yld7wjBUJlszsyGd8bISc26o
         VX8W0/C/cl7XMmhZf7cJrdcVIv6iAxHRxHm6ahwQwbEQNO/LyR/p39Uebb1cQJ4MGZ1E
         XNRmiwD0H6V3h5WYRABxEnpQGwxwt9efgIYR3r58tws5UVpNasSMdUmBaSUWW7ZWstpg
         MheQ==
X-Gm-Message-State: ABy/qLa9Z/kVNZXLrSu8hIu9EuHpai4R9J9AlvU+a3pXndTNXnrYPLOz
        obquk1iD9lpYQoZR+EF2jz4evw9Aoxs3bnFojUs=
X-Google-Smtp-Source: APBJJlEEMGYbfAaju8GSm9xSvrwAOIn6bkfNUyEpedwzg1yaEuwamWb19v/wSGbRptenjXSGKWvQCw==
X-Received: by 2002:a05:6a20:9381:b0:137:8f19:1de7 with SMTP id x1-20020a056a20938100b001378f191de7mr7077911pzh.0.1690463877536;
        Thu, 27 Jul 2023 06:17:57 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 35-20020a630b23000000b00551df489590sm1437858pgl.12.2023.07.27.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:17:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        German Maglione <gmaglione@redhat.com>
In-Reply-To: <20230726144502.566785-1-ming.lei@redhat.com>
References: <20230726144502.566785-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/3] ublk: fail to start/recover/del device if
 interrupted by signal
Message-Id: <169046387676.1133181.14024028793575929659.b4-ty@kernel.dk>
Date:   Thu, 27 Jul 2023 07:17:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 26 Jul 2023 22:44:59 +0800, Ming Lei wrote:
> The 1st & 2nd patch fixes kernel oops if user interrupts the current
> ublk task.
> 
> The 3rd patch returns -EINTR if user interrupts the device deletion.
> 
> V2:
> 	- add patch 2&3, as reported by Stefano
> 
> [...]

Applied, thanks!

[1/3] ublk: fail to start device if queue setup is interrupted
      commit: 53e7d08f6d6e214c40db1f51291bb2975c789dc2
[2/3] ublk: fail to recover device if queue setup is interrupted
      commit: 0c0cbd4ebc375ceebc75c89df04b74f215fab23a
[3/3] ublk: return -EINTR if breaking from waiting for existed users in DEL_DEV
      commit: 3e9dce80dbf91972aed972c743f539c396a34312

Best regards,
-- 
Jens Axboe



