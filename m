Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA4C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838E8230F2
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 15:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1wwfXpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfHTPEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:04:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38662 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfHTPEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 11:04:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so2959751wmm.3
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b/1w5LvL+fBJM0aA0+n6sQkDfXDbUnJO+MNoklWJK6k=;
        b=s1wwfXpp3IIu5zYLuh/BcfPpG9+/3h93ZL8srfWtCF6/V4AgZTQd88PQVUUcIIceg3
         iSId+Jf/SelQiNRkah6dq2I28zAviqQCMMKXSS+Xiq3oPHj6m6EgZaG51LEYGQoBnQon
         G5r+to80gAgDsdFn3J9Kfbq0B/bgkyctwrG6pxNOikJmnb0tEmRvAZqt7d+KRolHHXm7
         TwWegXMdH5f5PRHcQnm6Izew+8dZ7IHI8eGNOXbrLyLpI01vth6grw8bR/FXPEVPSkrb
         /Ne4lqEnKF4FHaTQ7a8RZpQ+5N9qvYCSvDIJl5JnoEnpsJiBH737i+GLHjhNBHlYpBlF
         jP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b/1w5LvL+fBJM0aA0+n6sQkDfXDbUnJO+MNoklWJK6k=;
        b=C/vTIGakIvg1tqYvgL+799odK81nOBtBIgeSSVDx4E0UMgZV3cfA3Ja0vJjJuNeZ7b
         zxYaOInsTzNAGK9eMLs51nTBAFTAMJL+93/ww/AQ9szEH1R8VYXiQBn1EeBXaTIT40yM
         4MKrZ36EWHBD7G5/9lCihsMQJV68pryycc+49jNbG+p/WOUD8qF349bzoO5zRrzb3oHY
         oVKdny6Ul8CjWeA2nzBNfLnrYL+KjMXoPqVLJwhQIIzWdE82AEoFMxoMjeDpK6Ht3pbL
         /zpbwHS1CtaSYfidT7pl5dvFdmSTtIGry2hEUIgHTucGboHUPFPskR5fm4eD4L8KnK3G
         0MFA==
X-Gm-Message-State: APjAAAX6b4p5H35dp9WHAMt4oBU+hxsIv3Dfk68Fhkf+F8TJm3vE6Eqs
        Rhhcpd6O6bj2DWQG2gWgHej71g==
X-Google-Smtp-Source: APXvYqxD2lete8UEuvPIbzlRuBI6fHCtkpp45v8YWanLLfdGYOXLCH+A4P7NECo2rhTeuiIc8MSXJw==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr498870wmi.16.1566313468179;
        Tue, 20 Aug 2019 08:04:28 -0700 (PDT)
Received: from [192.168.0.101] (88-147-37-138.dyn.eolo.it. [88.147.37.138])
        by smtp.gmail.com with ESMTPSA id f7sm25906746wrf.8.2019.08.20.08.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:04:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
Date:   Tue, 20 Aug 2019 17:04:25 +0200
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
Message-Id: <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 20 ago 2019, alle ore 12:48, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 14 giu 2019, alle ore 19:56, Tejun Heo <tj@kernel.org> ha =
scritto:
>>=20
>> On Thu, Jun 13, 2019 at 06:56:10PM -0700, Tejun Heo wrote:
>> ...
>>> The patchset is also available in the following git branch.
>>>=20
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
review-iow
>>=20
>> Updated patchset available in the following branch.  Just build fixes
>> and cosmetic changes for now.
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
review-iow-v2
>>=20
>=20
> Hi Tejun,
> I'm running the kernel in your tree above, in an Ubuntu 18.04.
>=20
> After unmounting the v1 blkio controller that gets mounted at startup
> I have created v2 root as follows
>=20
> $ mount -t cgroup2 none /cgroup
>=20
> Then I have:
> $ ls /cgroup
> cgroup.controllers  cgroup.max.descendants  cgroup.stat             =
cgroup.threads  io.weight.cost_model  system.slice
> cgroup.max.depth    cgroup.procs            cgroup.subtree_control  =
init.scope      io.weight.qos         user.slice
>=20
> But the following command gives no output:
> $ cat /cgroup/io.weight.qos=20
>=20
> And, above all,
> $ echo 1 > /cgroup/io.weight.qos=20
> bash: echo: write error: Invalid argument
>=20
> No complain in the kernel log.
>=20
> What am I doing wrong? How can I make the controller work?
>=20

I made it, sorry for my usual silly questions (for some reason, I
thought the controller could be enabled globally by just passing a 1).

The problem now is that the controller doesn't seem to work.  I've
emulated 16 clients doing I/O on a SATA SSD.  One client, the target,
does random reads, while the remaining 15 clients, the interferers, do
sequential reads.

Each client is encapsulated in a separate group, but whatever weight
is assigned to the target group, the latter gets the same, extremely
low bandwidth.  I have tried with even the maximum weight ratio, i.e.,
1000 for the target and only 1 for each interferer.  Here are the
results, compared with BFQ (bandwidth in MB/s):

io.weight   BFQ
0.2         3.7

I ran this test with the script S/bandwidth-latency/bandwidth-latency.sh
of the S benchmark suite [1], invoked as follows:
sudo ./bandwidth-latency.sh -t randread -s none -b weight -n 15 -w 1000 =
-W 1

The above command simply creates groups, assigns weights as follows

echo 1 > /cgroup/InterfererGroup0/io.weight
echo 1 > /cgroup/InterfererGroup1/io.weight
...
echo 1 > /cgroup/InterfererGroup14/io.weight
echo 1000 > /cgroup/interfered/io.weight

and makes one fio instance generate I/O for each group.  The bandwidth
reported above is that reported by the fio instance emulating the
target client.

Am I missing something?

Thanks,
Paolo

[1] https://github.com/Algodev-github/S


> Thanks,
> Paolo
>=20
>> Thanks.
>>=20
>> --=20
>> tejun
>=20

