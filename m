Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330DEC433FE
	for <linux-block@archiver.kernel.org>; Sun, 30 Jan 2022 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356094AbiA3UOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Jan 2022 15:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356090AbiA3UOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Jan 2022 15:14:09 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A71C06173B
        for <linux-block@vger.kernel.org>; Sun, 30 Jan 2022 12:14:09 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p5so34300042ybd.13
        for <linux-block@vger.kernel.org>; Sun, 30 Jan 2022 12:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=B5RDFYVH+TmmOH5uylQQBjq9xZgwfPdMXnc3AvG2YZc=;
        b=VTtCVZ53zZ6UsWVL2KQxOBVSzglYrpVXQ04tWD/kYESSCJ5u8t2oifPVCjUt1+i1Bw
         zb9BrzM1DYsPnDKHMGywMivERJi44+JvyRamX0zj3vi34VYpV+51ZF59s2PDRB5ANrhy
         jkr8I9ezKGAq2A6bapDgIGGn/fExiHVUpGBifjFpV3Bk0kG9cysY8rFzwosUNML5uGKY
         5hn5ddmN28D3rQkmVpO+Y1uMK2LwMTp/z/+5/mAb4m3bu/nTdjASyHTLNC8zxNtZ1UWd
         D9sRZDsvu6oc2SRxtS8hV2cgE5Ltk64rMppMKv22Btb7tf9osiVKsLY+64riCgYbaKdK
         81MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=B5RDFYVH+TmmOH5uylQQBjq9xZgwfPdMXnc3AvG2YZc=;
        b=kQD7y82A+n5JQFY9PuBpIjhbT6i53mEEQMvnTbsDSQaKG6fn4Ve8CFlAaKtBud/MkO
         hsbPtu2omWQDFGdZMrFxWhQbExeRtxNJiIlWs0aypvVw/9zTl8ajBYWA6lB74w3JAQCT
         rk6N1/76s/MCLHngdVMzwaO0rxsQzAMetqv3jr3OT01HrUnldXMxi1tioHd/ehUcMt1d
         dZbzK3cC3rIK4/BZ/raWuXJLrxyfz9sXRdnr+i71co+RIkqsCG9qR865ZqdufQl/ugMI
         6xhFdflpQanEaKRmWBOnf6UHekIuBf5ntXMylU8/ga5weumDzcssVz5OhVKuiZ3brCY1
         w7vg==
X-Gm-Message-State: AOAM530YEVr8AEyYk+clgH5c/4MRMLJCasJ9yNoQZAn75w+vXtBhfdH0
        7SgyjR7P4fMAL9bESYV+/TMNqczWU8j3lhTxGUb+CruMPR9wt4xd
X-Google-Smtp-Source: ABdhPJxhVBgnY32VOHkWK5MbxCF59xVBdXpCSbyl5wQ2u7qGZBnMbxHOmvwZyfuSP9FpLqI56f0ZZWKrSaHBHmJjTXw=
X-Received: by 2002:a25:8e0a:: with SMTP id p10mr23665629ybl.239.1643573648348;
 Sun, 30 Jan 2022 12:14:08 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 30 Jan 2022 13:13:52 -0700
Message-ID: <CAJCQCtRM4Gn_EY_A0Da7qz=MFfmw08+oD=syQEQt=9DrE8_gFw@mail.gmail.com>
Subject: FITRIM minimum block size for weekly usage
To:     linux-block@vger.kernel.org
Cc:     kzak@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

util-linux includes /usr/lib/systemd/system/fstrim.service, which has
an fstrim.timer set to run the service once per week. It's commonly
enabled by default in linux distributions these days.

By default, fstrim uses the file system block size as the minimum
contiguous free block range for discards. On heavily fragmented file
systems, this can take a while. Whether fragmented or not, such
granularity probably provides no meaningful improvement in wear
leveling performance. I'm wondering if something in the range of 1-4
MiB would be sufficient for most cases, and unlikely to be harmful for
any? Or if block devs have any other ideas for the minimum size?

The tentative proposal is to modify /usr/lib/systemd/system/fstrim.service

- ExecStart=/usr/sbin/fstrim --listed-in
/etc/fstab:/proc/self/mountinfo --verbose --quiet-unsupported
+ ExecStart=/usr/sbin/fstrim --listed-in
/etc/fstab:/proc/self/mountinfo --minimum 4M --verbose
--quiet-unsupported

That results in, e.g.

ioctl(3, FITRIM, {start=0, len=18446744073709551615, minlen=4194304}) = 0

instead of

ioctl(3, FITRIM, {start=0, len=18446744073709551615, minlen=0}) = 0


That this will do much less trimming for particularly heavy use file
systems, so much the better, as drives have been getting quite a bit
smarter about managing wear leveling even without the trim hinting.
But I think it's useful for common consumer devices still out there,
but doesn't need to be so thorough at trimming every free block. Fair?

Best,

-- 
Chris Murphy
