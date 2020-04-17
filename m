Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB4C2BB1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 07:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD66208E4
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 07:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjI6Sp4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgDQHqx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgDQHqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 03:46:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09308C061A0C
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2020 00:46:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id u13so1921706wrp.3
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2020 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FYXkrsrxx9SVeyT0/QU+wmqP2WwUxyKmZ0MIPcuWDFo=;
        b=tjI6Sp4NupR43krI7EQDQSLYKk4NCFEpOCjsf+64HZIbnHgTsO21FquQOTp0oL/JfC
         VQvGOb4YmAOpfhlnJ3tQ3aFwgmdwSauaUj8DX6yVW2ejxAHGhQgs/IYvTKmOqyAsC8U6
         ihpA+6gF8SyoAmLGpUpy7+TYMQ26v0o8rYNqMf0bijVnLCR/x5YYnJh59VLANMq0EHWv
         Fvu5Zge9jr3Sc4A2NCu2mfX431fl4NN6JPiHh/xQ9s1GqcM+uuQNqD7U+O2kWDRag64X
         E0mZkOoihLCwQRNR1fDp4df0zpupIwEn+giX8ovVyV9E4Ni9dofvtfl7OoXaTfNxL7vw
         Hq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FYXkrsrxx9SVeyT0/QU+wmqP2WwUxyKmZ0MIPcuWDFo=;
        b=XcpqSMXUpqGLpcQoIDQ4axT26T1uwWD/95XfNde/+le/teLwq97OIxz6vyYaiPJJqC
         Wc9WEjDm/txb3RZ/L+WpRmS2sOqqw3f6h74Cva4T7NWPF8v0UAlUXGZWHpiYZY4qWF6m
         WJ7JVlU7Tcj1pA3gTeIHtBsCMuWLz/MVNCAGRCMyLdWgbdDcpLZtK+737egiacVbusYD
         PI7lAd3BVHUICm3P2Q6INBbkz3IertJlyE/RPNpp5aYI6cwIlTHLGiXHDLHQsYfSKS7q
         7dFJsyFB8U9AggKkGDrWUEeJC1WzxGdxGamQ2r0trpDYNeWoNLeHD5wgi36SFNwSnNhA
         jdsQ==
X-Gm-Message-State: AGi0PuZajNYlQnNvRhPVvegOfh5B1CScVo6QHO9VtRUkieMjVkZril65
        SiTL+wntNd93D54lhFQpv/YexA==
X-Google-Smtp-Source: APiQypICBWaasEVFs4/rZ/fi7FxYodRqPyC+ANtphDr2+lrjhJOcf+BLqRRkCK1nffrs1pSQuFBElQ==
X-Received: by 2002:adf:9321:: with SMTP id 30mr2329701wro.330.1587109610676;
        Fri, 17 Apr 2020 00:46:50 -0700 (PDT)
Received: from [192.168.0.101] ([84.33.134.191])
        by smtp.gmail.com with ESMTPSA id a7sm6669362wmj.12.2020.04.17.00.46.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 00:46:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/2 RFC] bfq: Waker logic tweaks for dbench performance
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200409170915.30570-1-jack@suse.cz>
Date:   Fri, 17 Apr 2020 09:47:07 +0200
Cc:     linux-block@vger.kernel.org, Andreas Herrmann <aherrmann@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C0E3547-FD20-45A4-B1B0-AAD7B0024999@linaro.org>
References: <20200409170915.30570-1-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,
I'm glad you're addressing these BFQ issues.  Sorry for the delay, but
I happen to be working on similar issues, for other sort of
corner-case workloads.  So I wanted to consolidate my changes before
replying.

Probably, the best first step for me, to check your proposal, is to
merge it with my current changes, and test the outcome.  In this
respect, my problem is that, after our last improvements for dbench,
we cannot reproduce regressions any longer.  So, we would need your
support to test both issues, i.e., to test throughput with dbench (on
your side/machines), and possible other regressions of your and my
changes (on our side/machines).

Would it be ok for you to participate in this little collaboration?
If it is, then I'll contact you privately to kick this off.

Thanks,
Paolo

> Il giorno 9 apr 2020, alle ore 19:09, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Hello,
>=20
> I was investigating why dbench performance (even for single dbench =
client) with
> BFQ is significantly worse than it used to be CFQ. The culprit is the =
idling
> logic in BFQ. The dbench workload is very fsync(2) heavy. In practice =
the time
> to complete fsync(2) calls is what determines the overall performance. =
For
> filesystems with a journal such as xfs or ext4 it is common that =
fsync(2)
> involves writing data from the process runningg fsync(2) - dbench in =
this case
> - and then waiting for the journalling machinery to flush out metadata =
from a
> separate process (jbd2 process in ext4 case, worker thread in xfs =
case).
> CFQ's heuristic was able to determine that it isn't worth to idle =
waiting for
> either dbench or jbd2 IO. BFQ's heuristic is not able to determine =
this and
> thus jbd2 process is often blocked waiting for idle timer of dbench =
queue to
> trigger.
>=20
> The first patch in the series is an obvious bugfix but is not enough =
to improve
> performance. The second patch does improve dbench performance from ~80 =
MB/s
> to ~200 MB/s on my test machine but I'm aware that it is probably way =
too
> aggressive and probably a different solution is needed. So I just =
wrote that
> patch to see the results and spark some discussion :). Any idea how to
> improve the waker logic so that dbench performance doesn't drop so
> dramatically?
>=20
> 								Honza

