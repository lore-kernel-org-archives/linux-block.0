Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C95C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 10:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E01C2082F
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 10:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgG7nSae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfHTKsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:48:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43221 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfHTKsO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 06:48:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8so11867948wrn.10
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8YhdYjqe+CTt77YsPRFesv990RDPmX6UdhabR8/j8l8=;
        b=dgG7nSaegDa/f34PzKpV/NDTRDbAf4Tn8ESgBGCCvyBUctxq98sGkgyEW3giHSJqxI
         yUlLAH58TbPebsNICnhxbv2FhjuVdm71H1yyw5DTYaHXUr2mcxTajrDMX8YQgXP6K59l
         KMlqgNId7X/0kUtpLyRyUbCvjdArWdQ99nv9N56pBQaxb3fB9btAbzRfZfUnDKcyc653
         FieTVsewJyyWcgh+hruCD2sviZgKsiiLWf5EamLzSfUSXhw0pHGE0djlhbWl5DfBK/qL
         x+kZDh5BOO4jY2T8+YBs/0azHTKHddDMvZO7kBrbJSv/Sg/eUgpzfCZxDVIdodTyN4C4
         JChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8YhdYjqe+CTt77YsPRFesv990RDPmX6UdhabR8/j8l8=;
        b=CwtSzL0+ue5Mreu9acSw5FL2QqnwGo+Y91ecov72fDKVeX84Z/rgyhffeWVEUQ20pP
         isVCNY6o73dXq/f9bJDeOYIqon7hB9a9XLpIqixF/ji1TWcZkGuq0iuP6NBStfvP+Ghr
         1mMRj3+3R8xJro2phr9dOTtbfhEpJpGWLQ6qHYEEULscWacm/GUU0DNOBbsyXERsEM45
         meu1fGSxtxMD973k6LgqLztgZ4n6vYHa7yaX6iDnTlOTzdaJ8t+jS8U1ys9fcoCN5OZq
         1IlplrVAVQbo5eVvosDl8i6qcrrOvIXl47bXHvIMlq5SV5QH+VTz696E+08qgLJwupXx
         QLCw==
X-Gm-Message-State: APjAAAWkS/Op8r35sWXS308B/eqx7mi5pbkc9NBjsabF3ysJJKoJulu6
        gneVA96dZepJ9zXb1rOdi7Q2nQ==
X-Google-Smtp-Source: APXvYqwc3MstBJr5Jkxt0X3//Ms1r9i69Vio0VuTKiCfoKN0uTDQcpIcE5vYcPNH7zQIlsf1GoelnQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr20045745wrv.174.1566298092001;
        Tue, 20 Aug 2019 03:48:12 -0700 (PDT)
Received: from [192.168.0.101] (88-147-37-138.dyn.eolo.it. [88.147.37.138])
        by smtp.gmail.com with ESMTPSA id c11sm14244247wrs.86.2019.08.20.03.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 03:48:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190614175642.GA657710@devbig004.ftw2.facebook.com>
Date:   Tue, 20 Aug 2019 12:48:09 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 14 giu 2019, alle ore 19:56, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> On Thu, Jun 13, 2019 at 06:56:10PM -0700, Tejun Heo wrote:
> ...
>> The patchset is also available in the following git branch.
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
review-iow
>=20
> Updated patchset available in the following branch.  Just build fixes
> and cosmetic changes for now.
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
review-iow-v2
>=20

Hi Tejun,
I'm running the kernel in your tree above, in an Ubuntu 18.04.

After unmounting the v1 blkio controller that gets mounted at startup
I have created v2 root as follows

$ mount -t cgroup2 none /cgroup

Then I have:
$ ls /cgroup
cgroup.controllers  cgroup.max.descendants  cgroup.stat             =
cgroup.threads  io.weight.cost_model  system.slice
cgroup.max.depth    cgroup.procs            cgroup.subtree_control  =
init.scope      io.weight.qos         user.slice

But the following command gives no output:
$ cat /cgroup/io.weight.qos=20

And, above all,
$ echo 1 > /cgroup/io.weight.qos=20
bash: echo: write error: Invalid argument

No complain in the kernel log.

What am I doing wrong? How can I make the controller work?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

