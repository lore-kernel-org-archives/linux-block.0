Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5FFC67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 06:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E936E20866
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 06:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GH9jvuhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E936E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeLNGiO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:38:14 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34294 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLNGiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 01:38:14 -0500
Received: by mail-wr1-f45.google.com with SMTP id j2so4310795wrw.1
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 22:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YzuoWz9tlWUSvtjsRZzF/IVHFsPtdw56mZa27aCrjzY=;
        b=GH9jvuhVkHkPmMlq/SQXGEfujjmsMqtE/ePkP7/c9Tb+Dm1KknhjpUFq0nTkZoLc/f
         UNW9/lOh3bQEKe5NQia88DDz7kF9o5+9GGlcnyxU+cN5P2PGqTeagqXjlbjSgoMsT8Im
         7VMf4pd5mYkwbULVbid/rBqh11SCLcw4PNdUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YzuoWz9tlWUSvtjsRZzF/IVHFsPtdw56mZa27aCrjzY=;
        b=ivCtKn0tZMh9J0fB/8Gg5m42Aao6wK9ZTscbbkbCK4x++/rrCYt/Y5V+o/yYRAIJ/+
         5zKigv4BiJEe/w1Ynovn+8WEH0G2zm6b6DsKhFTWhXeDeqA70kAyUjCDFUsnIpC46KFn
         1r4WNUTpzPvy6BaFSAmiWyW4q67C5PI71yUETdEFRbodMbc77HQH/NlLlkyCzaCxL9JE
         ZvXuDgTnaHQ/H5JKxyvYDBcTUUov9T+UyuGE6Qq6lznHOugELJd/M68GLkEqCk6r8oTl
         6gb3g+giI4yyICYL85PFYTFwz4vbrKAVqUuvQr3/IndThRDtatavNpDxkQbZWhcVTsSj
         0HFw==
X-Gm-Message-State: AA+aEWZ9fTH55558sYayHP0PVwu1PedeMA8QIi2ihA3pUnOh4w7XKqMV
        9xQMRkCnZhuF0zSuc1fFTwSkyw==
X-Google-Smtp-Source: AFSGD/WIKbSAV2WGPhVXpnbCSlJSVL7H6WCDUUQIbAfkUIjH5wArkHxwj6is4PiKAYr8STzv/buaWQ==
X-Received: by 2002:adf:e1c3:: with SMTP id l3mr1519357wri.36.1544769492037;
        Thu, 13 Dec 2018 22:38:12 -0800 (PST)
Received: from [192.168.0.101] (146-241-145-12.dyn.eolo.it. [146.241.145.12])
        by smtp.gmail.com with ESMTPSA id a1sm2655989wrw.76.2018.12.13.22.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 22:38:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: Unintuitive scheduling results using BFQ
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
Date:   Fri, 14 Dec 2018 07:38:10 +0100
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
To:     Madhav Ancha <mancha@tower-research.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 13 dic 2018, alle ore 21:34, Madhav Ancha =
<mancha@tower-research.com> ha scritto:
>=20
> In our setup, we have a task that writes to a NVMe SSD drive using the
> page cache. (using ::write os calls). This task does application level
> buffering and sends big (large MBs) chunks of data to ::write call.
> Each instance of the task writes upto 10Gbps of data to the NVME SSD.
>=20
> We run two instances of this task as below.
> Instance 1: Using ionice -c1, we run a RT IO instance of this task.
> Instance 2: We run a normal (best-effort) IO instance of this task.
>=20
> Both the write task instances compete for NVMe bandwidth. We observe
> that BFQ allocates equal bandwidth to both the task instances starting
> a few seconds after they start up.
>=20
> What we expected is that Instance1 (IOPRIO_CLASS_RT scheduling class)
> will be granted all the bandwidth it asked for while Instance2 will be
> allowed to consume the remaining bandwidth.
>=20
> Could you please help us understand how we may be able to design to
> get our expected behavior.
>=20

Hi,
if you do async, in-memory writes, then your task instances just dirty
vm pages.  Then different processes, the kworkers, will do the
writeback of dirty pages asynchronously, according to the system
writeback logic and configuration.  kworkers have their own priority,
which is likely to be the same for each such process.  AFAICT this
priority is not related to the priority you give to your processes.

If you want to control I/O bandwidths for writes, go for direct I/O or
use cgroups.  In case of cgroups, consider that there is still the
oddity that bfq interface parameters are non standard.  We have
proposed and are pushing for a solution to this problem [1].

Thanks,
Paolo

[1] https://lkml.org/lkml/2018/11/19/366

> Thanks

