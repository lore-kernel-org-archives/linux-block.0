Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66152C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 17:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350DC22CE9
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 17:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9AeUW9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfHSRFq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:05:46 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36419 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHSRFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 13:05:46 -0400
Received: by mail-wr1-f47.google.com with SMTP id r3so9502600wrt.3
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T5VhYwI+JVg+l8Fnzt6fdVPoQKXlgd6aKGwjMKzrxc0=;
        b=J9AeUW9bvg1lH5UiDZFTYowHrfVMEXnjCh1HFovpzBVS+YDBHD6q1nosZPzjErjkr1
         NDPOSGLl8VtxgweMFiNkLd/wFQsRD5brEtWaxncc+PTH6tGptLZNE4XJnCHLm8WEqI7L
         kxB/JS5KAcC1lfPwMe2VJG5COGN+f0Zz5Ypuxc0GLjzs7smrT4xDbix53/cw3b/ux39X
         i+UHtyxq72m9MRA4aN3daVrFAMyizpYqzMYNU03ObUir4IFgwOisQCKaafvhGoasDwoy
         RfhCGByjfMvApQF3LMmBElSjKzaFOeLFSP3SWrtv5x01dsCED6kMK5pJqSxCwtq8N3SL
         puqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T5VhYwI+JVg+l8Fnzt6fdVPoQKXlgd6aKGwjMKzrxc0=;
        b=a3vaRHrorVEMqGzLdFqzLtJ1+tAdqCABeh+di+XX5JJfXFERAPNY+JmE5QzO5ORuOF
         uNFvg6l+dw3LXHpbxBJhcH7JMwt5MXiNXQQt+jve6fiZpdrxqJ4p2A1qRSgMxqHbNEaQ
         Dxh3+KFRbZOQc550BXfm5D0iRpyoDha4lHI2dT0BXMJ0dmnUirmjoSY4FD6G4rERMWsv
         DOo6pbvvqDsEfthv/bEDFp2kEFMeb4ytFNoYWYXtQ/Ivq9rNcd/Sfghb3Gqoqh2iSO8S
         65lPPy931KF5HUxBSzbuIvj3gmSIPQ0PTjM5URQa7pU1ALQy4hzjM2gQCdj9klRdioKq
         7S5A==
X-Gm-Message-State: APjAAAU7jbKTS3NESLd6HdacDhS40FzI/CNf7R8lhcS6l4UVUlFEedoF
        j86rQ4YwaTyE+sWxJex7mBtIlBscCNs=
X-Google-Smtp-Source: APXvYqxngBvp7obA4ceNEGmKj4A+6Lt6tWc2dHfT18HSkzC5U1FOjjm7jwkYUHDNYRjsQT6SLftScA==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr29069098wrl.163.1566234344566;
        Mon, 19 Aug 2019 10:05:44 -0700 (PDT)
Received: from [192.168.0.101] (88-147-64-56.dyn.eolo.it. [88.147.64.56])
        by smtp.gmail.com with ESMTPSA id l14sm22969691wrn.42.2019.08.19.10.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 10:05:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on
 top of Perc 5/i raid0/jbod
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190819164053.GF5431@merlins.org>
Date:   Mon, 19 Aug 2019 19:05:42 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-raid@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <68ADE81A-2A48-4E95-91F6-60826FFDAF6F@linaro.org>
References: <20190819070823.GH12521@merlins.org>
 <5DCAD3D8-07B6-4A5D-A3C1-A1DF4055C5BD@linaro.org>
 <20190819164053.GF5431@merlins.org>
To:     Marc MERLIN <marc@merlins.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 19 ago 2019, alle ore 18:40, Marc MERLIN <marc@merlins.org> =
ha scritto:
>=20
> On Mon, Aug 19, 2019 at 11:18:13AM +0200, Paolo Valente wrote:
>> Solving this kind of problem is one of the goals of the BFQ I/O =
scheduler [1].
>> Have you tried?  If you want to, then start by swathing to BFQ in =
both the
>> physical and the virtual block devices in your stack.
>=20
> I sure was not aware of it, thank you for pointing it out.
>=20
>> Thanks,
>> Paolo
>>=20
>> [1] https://algo.ing.unimo.it/people/paolo/BFQ/
>=20
> I did the following below and when the swraid is rebuilding, I'm still
> getting terrible overall throughput:
> newmagic:~# hdparm -t /dev/md2
> /dev/md2:
> HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
>  Timing buffered disk reads:   2 MB in  5.76 seconds =3D 355.42 kB/sec
>=20
> I think things hang a bit less, which I suppose it good, but the =
system is
> still unusable overall.
>=20

Ok, I'm sorry it didn't help.  Unless someone spots the problem
somewhere outside BFQ, I'm willing to analyze this apparently tough
scenario, as an opportunity to improve BFQ.  If fine for you, just
contact me offline.

Good luck!
Paolo


>=20
> newmagic:~# modprobe bfq
> newmagic:~# for i in /sys/block/*/queue/scheduler; do echo $i; echo =
bfq > $i; cat $i; done
> /sys/block/bcache0/queue/scheduler
> none
> /sys/block/md0/queue/scheduler
> none
> /sys/block/md1/queue/scheduler
> none
> /sys/block/md2/queue/scheduler
> none
> /sys/block/md3/queue/scheduler
> none                    =20
> /sys/block/sda/queue/scheduler
> [bfq] none
> /sys/block/sdb/queue/scheduler
> [bfq] none
> /sys/block/sdc/queue/scheduler
> [bfq] none
> /sys/block/sdd/queue/scheduler
> [bfq] none
> /sys/block/sde/queue/scheduler
> [bfq] none
> /sys/block/sdf/queue/scheduler
> [bfq] none
> /sys/block/sdg/queue/scheduler
> [bfq] none
> /sys/block/sdh/queue/scheduler
> [bfq] none
> /sys/block/sdi/queue/scheduler
> [bfq] none
> /sys/block/sr0/queue/scheduler
> [bfq] none
>=20
>=20
> Thanks,
> Marc
> --=20
> "A mouse is a device used to point at the xterm you want to type in" - =
A.S.R.
> Microsoft is to operating systems ....
>                                      .... what McDonalds is to gourmet =
cooking
> Home page: http://marc.merlins.org/ =20

