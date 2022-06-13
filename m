Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F50CCA47D
	for <linux-block@archiver.kernel.org>; Mon, 13 Jun 2022 17:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiFMRlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jun 2022 13:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbiFMRjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 13:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAD75150B41
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655125705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCwDNbIJ8kduERV20ub2ZHLvRkCfyvkBygTT361RRuo=;
        b=LNvy3TP1K8aSek0LXWec6Bkkwm8VStQ1GcGQwBxUHM4jPubk559ys1V4yWW499tw85thFp
        Q9Y+AZ0CAqbBcCtmwDyEZh3/6YNRPsq/P/NfsoD1VPTBuUds9wNgKI1HICZWC1hfVzIjz7
        gF0YiU/ZNzjHDaFubN45eRez+pqvYLo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-79svgQlLPZWJhqdtFdgQAA-1; Mon, 13 Jun 2022 09:08:24 -0400
X-MC-Unique: 79svgQlLPZWJhqdtFdgQAA-1
Received: by mail-pj1-f71.google.com with SMTP id t11-20020a17090a2f8b00b001ea6a226d21so2856143pjd.8
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 06:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCwDNbIJ8kduERV20ub2ZHLvRkCfyvkBygTT361RRuo=;
        b=uziZc2ABanwFOmgHm7Tyh3z6CPd/1qk2U+eHQ7d7d2azHVLB69XMfiaZGp8boKkcv3
         VsjzT+XeW9tNi4Nir13qTDWS/MLBpLKK0xGZjkMwNFrx80sgaow8SVjsBRQC2Bu1bgXA
         1vDupC4FAV3oyHe9l6RTg+1V/S1OWFuLDbuO284LIIBDbKZfGx9pWE8TMzPAe9WBnmTD
         b3uk58dpGblElYOSJUzWRN/mFitsOUZ5v99vvvndefqeFC1CmJL5XAN6Zp3Soa29b84S
         cx5dfgVYVtlF8so6tsiDZB9+jm7tQ2VIvzUQSnn3Zsow+UXgWkg1bsclaRaL8RM0up5j
         v4eg==
X-Gm-Message-State: AOAM532NW7Ua3UjR78DvY7g8JEzNiS34qzcHLD/MqiMh7Ivpe4VwcV50
        0jjdIZDmjZGyTxMS6Xgmlm/5ycDfM0t6JrobZu/D8EcrnZ0BSt4Vwp3prFQ0HtXAcy6b98evizf
        uIeSq8tq8WZ8IB2rFASlX3gmUP6suhrf8Zjq67pw=
X-Received: by 2002:a17:90b:1e4e:b0:1e3:47e4:92b6 with SMTP id pi14-20020a17090b1e4e00b001e347e492b6mr15752966pjb.47.1655125702904;
        Mon, 13 Jun 2022 06:08:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQBdObeMUEvnV9CUhT/2F4EdhlBx4fD6IL4du2dLBEN31X8f+/3GhAmKwSr/txMOT3efTT4SpXN12gISJSVZ8=
X-Received: by 2002:a17:90b:1e4e:b0:1e3:47e4:92b6 with SMTP id
 pi14-20020a17090b1e4e00b001e347e492b6mr15752941pjb.47.1655125702596; Mon, 13
 Jun 2022 06:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
 <YqavC8hwLXwPVnor@T590>
In-Reply-To: <YqavC8hwLXwPVnor@T590>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 13 Jun 2022 21:08:11 +0800
Message-ID: <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed from blktests on latest linux-block/for-next
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

The kmemleak also can be reproduced on 5.19.0-rc2, pls try to enable
nvme_core multipath and retest.

# cat /sys/module/nvme_core/parameters/multipath
Y

[ 7924.010585] run blktests nvme/013 at 2022-06-13 08:22:46
[ 8184.561412] kmemleak: 6 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[ 8325.411833] run blktests nvme/014 at 2022-06-13 08:29:27
[ 8346.540549] run blktests nvme/015 at 2022-06-13 08:29:48
[ 8370.369628] run blktests nvme/016 at 2022-06-13 08:30:12
[ 8415.649177] run blktests nvme/017 at 2022-06-13 08:30:57
[ 8752.325270] run blktests nvme/018 at 2022-06-13 08:36:34
[ 8755.591067] run blktests nvme/019 at 2022-06-13 08:36:37
[ 8758.549365] run blktests nvme/020 at 2022-06-13 08:36:40
[ 8761.768996] run blktests nvme/021 at 2022-06-13 08:36:43
[ 8765.001197] run blktests nvme/022 at 2022-06-13 08:36:47
[ 8768.416640] run blktests nvme/023 at 2022-06-13 08:36:50
[ 8771.390804] run blktests nvme/024 at 2022-06-13 08:36:53
[ 8774.600581] run blktests nvme/025 at 2022-06-13 08:36:56
[ 8777.796734] run blktests nvme/026 at 2022-06-13 08:36:59
[ 8780.996435] run blktests nvme/027 at 2022-06-13 08:37:03
[ 8784.198718] run blktests nvme/028 at 2022-06-13 08:37:06
[ 8787.433885] run blktests nvme/029 at 2022-06-13 08:37:09
[ 8791.489253] run blktests nvme/030 at 2022-06-13 08:37:13
[ 8794.647937] run blktests nvme/031 at 2022-06-13 08:37:16
[ 8830.344625] run blktests nvme/032 at 2022-06-13 08:37:52
[ 8836.335828] run blktests nvme/032 at 2022-06-13 08:37:58
[ 8838.544409] kmemleak: 1 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[ 8843.460926] run blktests nvme/032 at 2022-06-13 08:38:05
[ 8854.927287] run blktests nvme/038 at 2022-06-13 08:38:17
[ 8856.009771] run blktests nvme/039 at 2022-06-13 08:38:18
[ 8857.073699] run blktests nvme/039 at 2022-06-13 08:38:19
[ 8858.186741] run blktests nvme/039 at 2022-06-13 08:38:20
[ 8859.671329] run blktests scsi/004 at 2022-06-13 08:38:21
[ 8861.887756] run blktests scsi/005 at 2022-06-13 08:38:23
[ 8868.325999] run blktests scsi/007 at 2022-06-13 08:38:30
[ 8879.486812] run blktests zbd/002 at 2022-06-13 08:38:41
[ 8880.266536] run blktests zbd/003 at 2022-06-13 08:38:42
[ 8881.237849] run blktests zbd/004 at 2022-06-13 08:38:43
[ 8883.809750] run blktests zbd/005 at 2022-06-13 08:38:45
[ 8885.738364] run blktests zbd/006 at 2022-06-13 08:38:47
[ 8887.247449] run blktests zbd/008 at 2022-06-13 08:38:49
[ 9480.025760] kmemleak: 22 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[10337.012629] run blktests nvme/039 at 2022-06-13 09:02:59
[10337.808560] run blktests nvme/039 at 2022-06-13 09:02:59
[10338.729114] run blktests nvme/039 at 2022-06-13 09:03:00

On Mon, Jun 13, 2022 at 11:29 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Sun, Jun 12, 2022 at 03:23:36PM +0800, Yi Zhang wrote:
> > Hello
> > I found below kmemleak with the latest linux-block/for-next[1], pls
> > help check it, thanks.
> >
> > [1]
> > 75d6654eb3ab (origin/for-next) Merge branch 'for-5.19/block' into for-next
>
> Hi Yi,
>
> for-5.19/block should be stale, and seems not see such issue when running blktests
> on v5.19-rc2.
>
>
> Thanks,
> Ming
>


-- 
Best Regards,
  Yi Zhang

